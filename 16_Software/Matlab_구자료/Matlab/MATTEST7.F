c
c	MATTEST7
c
c	Simple program that illustrates how to call the MAT-file Library
c	from a Fortran program.  
c
c	The example prints out a directory of the Matrix names contained
c	within a MAT-file.
c
      program main
      integer*4 matOpen, matGetDir, fp, dir, adir(100)
      integer*4 ndir, i, stat
      character*20 names(100)

      fp = matOpen('foo.mat', 'r')
      dir = matGetDir(fp, ndir)
      stat = matClose(fp)
      if (dir .eq. 0) then
         write(6,*) 'Can''t read directory.'
         stop
      endif

c Copy pointer into an array of pointers
      call mxCopyPtrToPtrArray(dir, adir, ndir)

c Copy pointer to character string
      do 20 i=1,ndir
         call mxCopyPtrToCharacter(adir(i), names(i), 20)
   20 continue

      write(6,*) 'Directory of Mat-file:'
      do 30 i=1,ndir
         write(6,*) names(i)
   30 continue
      stop
      end
