c
c	MATTEST3
c
c	Simple program that illustrates how to call the MAT-file Library
c	from a Fortran program.  
c
c	The example prints out the row dimensions of all the Matrices in
c	a MAT-file.
c	
      program main
      integer*4 matOpen, matGetNextMatrix
      integer matClose, mxGetM
      integer*4 mp, fp
      integer stat, i
c
      fp = matOpen('foo.mat', 'r')
      do 10 i=1,1000
         mp = matGetNextMatrix(fp)
         if (mp .eq. 0) then
            go to 20
         end if
         write(6,*) 'Row dimension is ',mxGetM(mp)
   10 continue
   20 continue
      stat = matClose(fp)
c
      stop
      end
