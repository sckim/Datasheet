      subroutine EIGS(nlhs, plhs)
	  integer nlhs
	  integer*4 plhs(*)

c MATLAB's MEX-file facility lets you call your own Fortran subroutines
c directly from MATLAB.   Conversely, it is also possible to call
c internal MATLAB routines from your Fortran routines, using the special
c mexCallMATLAB utility routine.  In the way of an example, we've put together 
c this subroutine, MEXTST1.F, together with its gateway routine, MEXTST1G.F.

c This routine first forms and displays the matrix (in MATLAB notation):
c
c      hankel(1:4,4:-1:1) + sqrt(-1)*toeplitz(1:4,1:4)
c
c Next it finds the eigenvalues and eigenvectors (using the
c MATLAB function EIG), and displays the eigenvalue matrix.  Then it
c calculates the inverse of the eigenvalues to demonstrate manipulation
c of MATLAB results and how to deal with complex arithemetic.  Finally,
c the program displays the inverse values.

c Author: L. Shure 3-15-88
c Copyright 1988, The MathWorks, Inc., All rights reserved.

c Dimension arrays
      double precision xreal(4,4), ximag(4,4)

c Declare MEX utility functions (see MATLAB user's guide)
      integer*4 mxCreateFull, mxGetPr, mxGetPi

c Declare all the variables we intend to use for the example.
      integer m, n, imagflag, mlhs, mrhs, mn
      integer*4 x, xr, xi, lhs(2), rhs
      integer*4 evaluer, evaluei

c Fill xreal and ximag arrays with the matrix (in MATLAB notation)
c hankel(1:4,4:-1:1)+sqrt(-1)*toeplitz(1:4,1:4)
      call fill(xreal,ximag)
      m=4
      n=4
      mn = m*n
      imagflag = 1

c Create (allocate) a complex matrix of size m-by-n
      x = MXCREATEFULL(m,n,imagflag)

c Get pointers to the real and imaginary parts of the matrix
      xr = MXGETPR(x)
      xi = MXGETPI(x)

c Copy our arrays xreal and ximag to their corresponding places in
c the matrix structure x.
      call MXCOPYREAL8TOPTR(xreal,xr,mn)
      call MXCOPYREAL8TOPTR(ximag,xi,mn)

c Find eigenvectors and eigenvalues of matrix x using the MATLAB
c function EIG.  We give mexCallMATLAB one right-hand-argument and expect
c two left-hand-side arrays to be returned.
      mrhs = 1
      mlhs = 2
      call MEXCALLMATLAB(mlhs,lhs,mrhs,x,'eig')

c Display original x matrix, therefore there is no left-hand side.
      mlhs = 0
	  if (nlhs .eq. 0) call MEXCALLMATLAB(mlhs,lhs,mrhs,x,'disp')

c Display eigenvalue matrix.
      rhs = lhs(2)
	  if (nlhs .eq. 0) call MEXCALLMATLAB(mlhs,lhs,mrhs,rhs,'disp')

c Invert diagonal elements of the complex matrix by two methods.  The
c first uses auxiliary arrays for performing the inversion, the second
c does the calculations in place.
      evaluer = MXGETPR(lhs(2))
      evaluei = MXGETPI(lhs(2))

c Copy these to new working arrays.
      call MXCOPYPTRTOREAL8(evaluer, xreal, mn)
      call MXCOPYPTRTOREAL8(evaluei, ximag, mn)
      call invertd(xreal, ximag)

c Copy answers back to a matrix array x
      call MXCOPYREAL8TOPTR(xreal,xr,mn)
      call MXCOPYREAL8TOPTR(ximag,xi,mn)
	  if (nlhs .eq. 0) call MEXCALLMATLAB(mlhs,lhs,mrhs,x,'disp')

c Free all allocated matrices
      call MXFREEMATRIX(x)
      call MXFREEMATRIX(lhs(2))
      if (nlhs .ne. 0) goto 1000
      call MXFREEMATRIX(lhs(1))
      goto 1010
 1000 plhs(1) = lhs(1)
 1010 return
      end

      subroutine fill(xr,xi)
      double precision xr(4,4) ,xi(4,4) ,tmp
      integer i ,j

c Form the matrix: hankel(1:4,4:-1:1)+sqrt(-1)*toeplitz(1:4,1:4)
      do 1000 j=1,4
      do 1000 i=1,j
        xr(i,j) = 4+i-j
        xr(j,i) = xr(i,j)
        xi(i,j) = j-i+1
 1000   xi(j,i) = xi(i,j)

c Reorder columns of xr.
      do 1050 j=1,2
      do 1050 i=1,4
        tmp = xr(i,j)
        jj = 5-j
        xr(i,j) = xr(i,jj)
 1050   xr(i,jj) = tmp
      return
      end
                                         
      subroutine invertd(xr,xi)
      double precision xr(*), xi(*), tmp
      integer i
c
c Just invert diagonal elements of a complex matrix of order 4.
c
      do 1000 i=1,16,5
        tmp = xr(i)**2+xi(i)**2
        xr(i) = xr(i)/tmp
 1000   xi(i) = -xi(i)/tmp
      return
      end

      subroutine copyrl(x,y,n)
c
c Copy one length n real array to another
c
      double precision x(*), y(*)
      integer n, i
                             
      do 1000 i=1,n
 1000   y(i) = x(i)
      return
      end
