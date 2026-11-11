c
c	MATTEST1
c
c	Simple program that illustrates how to call the MAT-file Library
c	from a Fortran program.  
c
c	The example writes a simple 3-by-2 real matrix into a MAT-file.
c	The matrix is named, 'A', and the MAT-file is named, 'foo.mat'.
c
      program main
      integer*4 matOpen, mxCreateFull, mxGetPr
      integer*4 a, fp
      integer matClose, matPutMatrix
      integer stat
      double precision Areal(6)
      data Areal / 1.0, 2.0, 3.0, 4.0, 5.0, 6.0 /
c
      fp = matOpen('foo.mat', 'w')
      a = mxCreateFull(3, 2, 0)
      call mxCopyReal8ToPtr(Areal, mxGetPr(a), 6)
      call mxSetName(a, 'A')
      stat = matPutMatrix(fp, a)
      stat = matClose(fp)
      call mxFreeMatrix(a)
c
      stop
      end
