c
c	MATTEST2
c
c	Simple program that illustrates how to call the MAT-file Library
c	from a Fortran program.  
c
c	The example reads a matrix into a double array.
c	The matrix is named, 'A', and the MAT-file is named, 'foo.mat'.
c
      Program main
      integer mn, stat
      integer*4 fp, a
      double precision Areal(6)
      integer*4 matOpen, matGetMatrix
      integer mxGetM, mxGetn, matClose
c
      fp = matOpen('foo.mat', 'r')
      a = matGetMatrix(fp, 'A')
      mn = mxGetM(a) * mxGetN(a)
      call mxCopyPtrToReal8(mxGetPr(a), Areal, 6)
      stat = matClose(fp)
      call mxFreeMatrix(a)
      write(6,*) 'Row 1: ',Areal(1),' ',Areal(4)
      stop
      end
