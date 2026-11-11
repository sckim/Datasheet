c
c	MATTEST5
c
c	Simple program that illustrates how to call the MAT-file Library
c	from a Fortran program.  
c
c	The example writes a simple 3-by-2 real matrix into a MAT-file.
c	The matrix is named, 'A', and the MAT-file is named, 'foo.mat'.
c	
      program main
      integer*4 matOpen, mf
      integer matClose, matPutFull, stat
      double precision Areal(6)
      double precision Aimag(6)
      data Areal / 1.0, 2.0, 3.0, 4.0, 5.0, 6.0 /
      data Aimag / 0.0, 0.0, 0.0, 0.0, 0.0, 0.0 /
c
      mf = matOpen('foo.mat', 'w')
      stat = matPutFull(mf, 'A', 3, 2, Areal, Aimag)
      stat = matClose(mf)
c
      stop
      end
