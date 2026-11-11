set IS_ATM_MP 0

if {[info exists ::env(SWDBOARD)]} {
    if {$::env(SWDBOARD) eq "APT"} {
	set IS_ATM_MP 1
	puts "Using APT"
    } elseif {$::env(SWDBOARD) eq "DL"} {
	set IS_ATM_MP 1
	puts "Using DL"
    }
} else {
    puts "Using Interface Board"
}

interface ftdi
if {$IS_ATM_MP} {
    ftdi_vid_pid 0x0403 0x6011
    set _FTDI_RESET 0x80
    set _FTDI_BBOOT 0x40
    # Use FT4232HQ ADBUS4 pin as GPIO (GPIOL0)
    set _FTDI_SWD_ENABLE 0x10
} else {
    ftdi_vid_pid 0x0403 0x6010
    set _FTDI_RESET 0x8000
    set _FTDI_BBOOT 0x4000
    # Use FT2232H ACBUS4 pin as GPIO (GPIOH4)
    set _FTDI_SWD_ENABLE 0x1000
}

if {[info exists ::env(SYDNEY_SERIAL)]} {
    set _FTDI_SERIAL [format "%s%s" $::env(SYDNEY_SERIAL) "USB1"]
    puts "FTDI serial $_FTDI_SERIAL"
    ftdi_serial $_FTDI_SERIAL
}

ftdi_channel 0
set _FTDI_OD 0x0000
set _FTDI_OE 0x0003

if {[info exists ::env(FTDI_HARD_RESET)]} {
    set _FTDI_OE [expr {$_FTDI_OE | $_FTDI_RESET}]
    if {$::env(FTDI_HARD_RESET) ne "0"} {
	set _FTDI_OD [expr {$_FTDI_OD | $_FTDI_RESET}]
    }
}

if {[info exists ::env(FTDI_BENIGN_BOOT)]} {
    set _FTDI_OE [expr {$_FTDI_OE | $_FTDI_BBOOT}]
    if {$::env(FTDI_BENIGN_BOOT) ne "0"} {
	set _FTDI_OD [expr {$_FTDI_OD | $_FTDI_BBOOT}]
    }
}

set _FTDI_OE [expr {$_FTDI_OE | $_FTDI_SWD_ENABLE}]
set _FTDI_OD [expr {$_FTDI_OD | $_FTDI_SWD_ENABLE}]

ftdi_layout_init $_FTDI_OD $_FTDI_OE
ftdi_layout_signal SRST -data $_FTDI_RESET -oe $_FTDI_RESET
ftdi_layout_signal BBOOT -data $_FTDI_BBOOT -oe $_FTDI_BBOOT
ftdi_layout_signal SWDENABLE -data $_FTDI_SWD_ENABLE -oe $_FTDI_SWD_ENABLE

transport select swd
ftdi_layout_signal SWD_EN -data 0
ftdi_layout_signal SWDIO_OE -data 0


proc assert_pwd {} {
    ftdi_set_signal SRST 1
}

proc deassert_pwd {} {
    ftdi_set_signal SWDENABLE 0
    ftdi_set_signal SWDENABLE z
    ftdi_set_signal SRST 0
    ftdi_set_signal SRST z
}

proc assert_bboot {} {
    ftdi_set_signal BBOOT 1
}

proc deassert_bboot {} {
    ftdi_set_signal BBOOT 0
    ftdi_set_signal BBOOT z
}
