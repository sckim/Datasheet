c
c	MATTEST4
c
c	Simple program that illustrates how to call the MAT-file Library
c	from a Fortran program.  
c
c	The example reads the Matrix 'A' from one MAT-file and writes it 
c	out to another.
c
      program main
      integer*4 matOpen 
      integer matClose, matPutFull, matGetFull
      integer*4 fp1, fp2
      integer stat
      integer m, n
      integer*4 pr, pi
c
      fp1 = matOpen('foo.mat', 'r')
      fp2 = matOpen('foo1.mat', 'w')
      stat = matGetFull(fp1, 'A', m, n, pr, pi)
      stat = matPutFull(fp2, 'A', m, n, pr, pi)
      stat = matClose(fp1)
      stat = matClose(fp2)
c
      stop
      end
