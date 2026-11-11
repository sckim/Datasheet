c
c	MATTEST6
c
c	Simple program that illustrates how to call the MAT-file Library
c	from a Fortran program.  
c
c	The example writes the string, 'Hello, world', into a MAT-file.
c	The matrix is named, 'A', and the MAT-file is named, 'foo.mat'.
c	
      program main
      integer*4 matOpen, fp
      integer matClose, matPutString, stat
c
      fp = matOpen('foo.mat', 'w')
      stat = matPutString(fp, 'A', 'Hello, world')
      stat = matClose(fp)
c
      stop
      end
