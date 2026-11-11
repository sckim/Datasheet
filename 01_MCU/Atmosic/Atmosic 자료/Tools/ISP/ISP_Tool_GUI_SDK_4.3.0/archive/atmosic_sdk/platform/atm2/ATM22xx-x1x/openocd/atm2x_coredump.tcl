# GDB which comes with gcc-arm-none-eabi-6-2017-q2-update toolchain throws
# "no core file handler recognizes format" error when reading coredumps.
#
# Following patch is required in order for GDB to successfully read coredump
# file generated from script below
# 
# https://patchwork.wildebeest.org/patch/148/
#

#
# CORE FILE GENERATION
#

# Generate section header string
proc generate_section_header {sh_name sh_type sh_flags sh_addr sh_offset sh_size sh_link sh_info sh_addralign sh_entsize } {

    set str [binary format i1 $sh_name]
    append str [binary format i1 $sh_type]
    append str [binary format i1 $sh_flags]
    append str [binary format i1 $sh_addr]
    append str [binary format i1 $sh_offset]
    append str [binary format i1 $sh_size]
    append str [binary format i1 $sh_link]
    append str [binary format i1 $sh_info]
    append str [binary format i1 $sh_addralign]
    append str [binary format i1 $sh_entsize]
 
    return $str
}

# Generate string table
proc generate_string_header { string_tbl_size } {

    upvar $string_tbl_size data_size

    set list {".shstrtab" ".flash" ".nvm" ".rom" ".sram" ".em" }

    set string_str [binary format c1 0x0]
    set data_size 1

    foreach name $list {
	set data_size [expr $data_size + [string length $name] + 1]
  	append string_str $name
        append string_str [binary format c1 0x0]
    }

    return $string_str
}

proc generate_elf_header { elf_header_size program_header_size total_headers section_hdr_size total_sections } {

    set symtbl_section [expr $total_sections - 1]

    # e_ident/EI_MAGIC
    set str [binary format c1a3 0x7f ELF]
    
    # e_ident/EI_CLASS
    append str [binary format c1 0x1] 
    
    # e_ident/EI_DATA (Little Endian)
    append str [binary format c1 0x1] 
    
    # e_ident/EI_VERSION (EV_CURRENT)
    append str [binary format c1 0x1] 

    # e_ident/EI_PAD (9 Bytes)
    append str [binary format c9 {0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0}] 

    # e_type (Core File)
    append str [binary format s1 0x4] 

    # e_machine (EM_ARM)
    append str [binary format s1 40] 
    
    # e_version (0x1)
    append str [binary format i1 0x1] 
    
    # e_entry (0x0)
    append str [binary format i1 0x0] 
    
    # e_phoff (0x0)
    append str [binary format i1 $elf_header_size] 
    
    # e_shoff
    set e_shoff [expr $program_header_size * $total_headers]
    set e_shoff [expr $elf_header_size + $e_shoff]
    append str [binary format i1 $e_shoff] 
    
    # e_flags (0x0)
    append str [binary format i1 0x0] 
    
    # e_ehsize
    append str [binary format s1 $elf_header_size] 
    
    # e_phentsize
    append str [binary format s1 $program_header_size] 
	
    # e_phnum
    append str [binary format s1 $total_headers] 
    
    # e_shentsize
    append str [binary format s1 $section_hdr_size] 
    
    # e_shnum
    append str [binary format s1 $total_sections] 
    
    # e_shstrndx (6th section is symbol table)
    append str [binary format s1 $symtbl_section] 
    
    return $str
}

proc generate_program_header { p_type p_offset p_vaddr p_paddr p_filesz } {
    set str [binary format i1 $p_type] 
    append str [binary format i1 $p_offset] 
    append str [binary format i1 $p_vaddr] 
    append str [binary format i1 $p_paddr] 
    #filesz
    append str [binary format i1 $p_filesz] 
    #memsz
    append str [binary format i1 0x0] 
    #flags
    append str [binary format i1 0x0] 
    #align
    append str [binary format i1 0x0] 
    
    return $str
}

proc copy_tempfile { temp_file coredump_file } {
    if { $::tcl_platform(os) == "Windows NT" || $::tcl_platform(os) == "mingw" } {
	exec cmd /c copy /b $coredump_file + $temp_file
    } else {
	exec cat $temp_file >> $coredump_file
    }

}

proc reg_dump {} {
    set index { 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 }

    # First 18 ints are 0s
    set str [string repeat "\u0000" 72]
    foreach x $index {
	append str [binary format i1 [ lindex [reg $x] 2]]
    }
    append str [binary format i1 0x0]
    return $str
}

# Return list of active sections based on override flag
proc active_sections {bank_start_addr bank_size no_of_banks override} {
    set act_sec_list {}
    for {set i 0} {$i < $no_of_banks} {incr i} {
	set start [expr $bank_start_addr + ($i * $bank_size)]
	if { !($override & [expr {1<<(12+$i) | 1<<$i}]) } {
	    lappend act_sec_list $start
	}
    }
    return $act_sec_list
}

proc get_coredump { {CoreDumpFile "Coredump"} } {

#  CoreFile Layout Details:
#  +++++++++++++++++++++++++++++++++++++++++++++++++++
#  +                 ELF header			     +
#  +++++++++++++++++++++++++++++++++++++++++++++++++++
#  +                 Program Header #1       	     +
#  +++++++++++++++++++++++++++++++++++++++++++++++++++
#  +                 Program Header #2     	     +
#  +++++++++++++++++++++++++++++++++++++++++++++++++++
#  ...
#  +                 Program Header #n        	     +
#  +++++++++++++++++++++++++++++++++++++++++++++++++++
#  +                 Section Header #1        	     +
#  +++++++++++++++++++++++++++++++++++++++++++++++++++
#  +                 Section Header #2      	     +
#  +++++++++++++++++++++++++++++++++++++++++++++++++++
#  ...
#  +                 Section Header #n       	     +
#  +++++++++++++++++++++++++++++++++++++++++++++++++++
#  +         PT_NOTE/RegDump section data    	     +
#  +++++++++++++++++++++++++++++++++++++++++++++++++++
#  +         shstrtab/String table data              +
#  +++++++++++++++++++++++++++++++++++++++++++++++++++
#  +         shstrtab/String table data              +
#  +++++++++++++++++++++++++++++++++++++++++++++++++++
#  +                  ROM data                       +
#  +++++++++++++++++++++++++++++++++++++++++++++++++++
#  +                 SRAM data                       +
#  +++++++++++++++++++++++++++++++++++++++++++++++++++
#  +                   EM data                       +
#  +++++++++++++++++++++++++++++++++++++++++++++++++++
#  +                FLASH data                       +
#  +++++++++++++++++++++++++++++++++++++++++++++++++++
#
    halt
    set saved_reg_dump [reg_dump]

    global CMSDK_ROM_BASE
    global CMSDK_FLASH_BASE
    global CMSDK_RAM_BASE
    global CMSDK_EM_BASE
    global CMSDK_PSEQ_SYSRAM_OVERRIDES
    global CMSDK_PSEQ_EMRAM_OVERRIDES

    set fp [open $CoreDumpFile w+]
    fconfigure $fp -translation binary

    set oss $::tcl_platform(os)
    puts "Operating System: $oss"

    enable_pseq
    set sram_override [mrw $CMSDK_PSEQ_SYSRAM_OVERRIDES]
    set emram_override [mrw $CMSDK_PSEQ_EMRAM_OVERRIDES]
    disable_pseq

    set elf_header_size 	52
    set total_sections 	4
    set string_tbl_size 	0
    set file_offset 	0
    set section_hdr_size 	40
    set program_header_size 32
    set program_headers	3
    set ptnote_size		168

    set sram_start_addr $CMSDK_RAM_BASE
    set sram_banks 6
    set sram_bank_size 0x4000

    set em_start_addr $CMSDK_EM_BASE
    set em_banks 2
    set em_bank_size 0x4000

    set sram_active_sections [active_sections $sram_start_addr $sram_bank_size $sram_banks $sram_override]
    set em_active_sections [active_sections $em_start_addr $em_bank_size $em_banks $emram_override]

    set sram_seccnt [llength $sram_active_sections]
    incr program_headers $sram_seccnt
    incr total_sections $sram_seccnt

    set emram_seccnt [llength $em_active_sections]
    incr program_headers $emram_seccnt
    incr total_sections $emram_seccnt

    # Total SRAM and EM size
    set sram_sec_size [expr $sram_seccnt * $sram_bank_size]
    set em_sec_size [expr $emram_seccnt * $em_bank_size]

    set program_total_size    [expr $program_header_size * $program_headers]

    set rom_start_addr $CMSDK_ROM_BASE
    set rom_size  0x40000

    set flash_start_addr $CMSDK_FLASH_BASE
    set flash_size [sydney_flash_size]

    #set nvm_start_addr $CMSDK_NVM_BASE
    #set nvm_size 0x1000

    set string_tbl [generate_string_header string_tbl_size]

    # Offset and size calculations 
    set rom_string_offset [string first ".rom" $string_tbl]
    set flash_string_offset [string first ".flash" $string_tbl]
    set sram_string_offset [string first ".sram" $string_tbl]
    set em_string_offset [string first ".em" $string_tbl]
    #set nvm_string_offset [string first ".nvm" $string_tbl]

    set rom_section_offset [expr $total_sections * $section_hdr_size ]
    set rom_section_offset [expr $rom_section_offset + $string_tbl_size + $elf_header_size + $program_total_size + $ptnote_size]
    set sram_section_offset [expr $rom_section_offset + $rom_size ]
    set em_section_offset [expr $sram_section_offset + $sram_sec_size ]
    #set nvm_section_offset [expr $em_section_offset + $em_sec_size ]
    set flash_section_offset [expr $em_section_offset + $em_sec_size ]

    # Genrate ELF header
    puts -nonewline $fp [generate_elf_header $elf_header_size $program_header_size $program_headers $section_hdr_size $total_sections]
    set file_offset [expr $file_offset + $elf_header_size ]

    # Generate Program header SRAM
    set offset $sram_section_offset
    foreach start $sram_active_sections {
	puts -nonewline $fp [generate_program_header 0x1 $offset $start 0x0 $sram_bank_size]
	incr offset $sram_bank_size
	incr file_offset $program_header_size
    }

    # Generate Program header EM
    set offset $em_section_offset
    foreach start $em_active_sections {
	puts -nonewline $fp [generate_program_header 0x1 $offset $start 0x0 $em_bank_size]
	incr offset $em_bank_size
	incr file_offset $program_header_size
    }

    # Generate Program header ROM
    puts -nonewline $fp [generate_program_header 0x1 $rom_section_offset $rom_start_addr 0x0 $rom_size ]
    set file_offset [expr $file_offset + $program_header_size ]

    # Generate Program header FLASH
    puts -nonewline $fp [generate_program_header 0x1 $flash_section_offset $flash_start_addr 0x0 $flash_size ]
    set file_offset [expr $file_offset + $program_header_size ]

    # Generate Program header for holding registers in PT_NOTE section
    set pt_offset [expr $total_sections * $section_hdr_size ]
    set pt_offset [expr $pt_offset + $elf_header_size + $program_total_size]
	
    puts -nonewline $fp [generate_program_header 0x4 $pt_offset 0x0 0x0 $ptnote_size]
    set file_offset [expr $file_offset + $program_header_size ]

    # EMPTY section header
    puts -nonewline $fp [generate_section_header 0 0 0 0 $file_offset 0 0 0 0 0]
    set file_offset [expr $file_offset + $section_hdr_size ]

    # ROM section header
    puts -nonewline $fp [generate_section_header $rom_string_offset 1 4 $rom_start_addr $rom_section_offset $rom_size 0 0 1 0]
    set file_offset [expr $file_offset + $section_hdr_size ]

    # SRAM section header
    set offset $sram_section_offset
    foreach start $sram_active_sections {
	puts -nonewline $fp [generate_section_header $sram_string_offset 1 4 $start $offset $sram_bank_size 0 0 1 0]
	incr offset $sram_bank_size
	incr file_offset $section_hdr_size
    }

    # EM section header
    set offset $em_section_offset
    foreach start $em_active_sections {
	puts -nonewline $fp [generate_section_header $em_string_offset 0 4 $start $offset $em_bank_size 0 0 1 0]
	incr offset $em_bank_size
	incr file_offset $section_hdr_size
    }

    # NVM section header
    #puts -nonewline $fp [generate_section_header $nvm_string_offset 0 4 $nvm_start_addr $nvm_section_offset $nvm_size 0 0 1 0]
    #set file_offset [expr $file_offset + $section_hdr_size ]

    # FLASH section header
    puts -nonewline $fp [generate_section_header $flash_string_offset 1 4 $flash_start_addr  $flash_section_offset $flash_size 0 0 1 0]
    set file_offset [expr $file_offset + $section_hdr_size ]

    # String Table section header
    set file_offset [expr $file_offset + $section_hdr_size ]
    set file_offset [expr $file_offset + $ptnote_size]
    puts -nonewline $fp [generate_section_header 1 3 0x20 0x0 $file_offset $string_tbl_size 0 0 1 0]
	
    # Save register dump
    puts -nonewline $fp [ binary format i1 0x5]

    puts -nonewline $fp [ binary format i1 148]

    # NT_PRSTATUS 1
    puts -nonewline $fp [ binary format i1 0x1]

    puts -nonewline $fp "CORE"
    puts -nonewline $fp [string repeat "\u0000" 4]

    puts -nonewline $fp $saved_reg_dump
	
    # Save String Table
    puts -nonewline $fp [generate_string_header string_tbl_size]

    close $fp

    set temp_file  "tmpfile"

    # Read ROM
    dump_image $temp_file $CMSDK_ROM_BASE $rom_size
    copy_tempfile $temp_file $CoreDumpFile

    # Read SRAM
    foreach sram_base $sram_active_sections {
	dump_image $temp_file $sram_base $sram_bank_size
	copy_tempfile $temp_file $CoreDumpFile
    }

    # Read EM
    foreach em_base $em_active_sections {
	dump_image $temp_file $em_base $em_bank_size
	copy_tempfile $temp_file $CoreDumpFile
    }

    # Read NVM

    # Read FLASH
    sydney_dump_flash $temp_file $flash_size
    copy_tempfile $temp_file $CoreDumpFile


    puts ""
    puts "##########################################################"
    puts " Dump saved to file: $CoreDumpFile"
    puts "##########################################################"
    puts ""
    puts "##########################################################"
    puts " In order to do offline Coredump analysis, please use gdb "
    puts " from toolchain version gcc-arm-none-eabi-9-2019-q4-major "
    puts " or later.                                                "
    puts " https://developer.arm.com/tools-and-software/            "
    puts " open-source-software/developer-tools/gnu-toolchain/      "
    puts " gnu-rm/downloads                                         "
    puts "##########################################################"
    puts ""

}

