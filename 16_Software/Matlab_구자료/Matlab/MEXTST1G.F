      subroutine MEXFUNCTION(nlhs, plhs, nrhs, prhs)
      integer*4 plhs(*), prhs(*)
      integer nlhs, nrhs

c MATLAB's MEX-file facility lets you call your own Fortran subroutines
c directly from MATLAB.   Conversely, it is also possible to call
c internal MATLAB routines from your Fortran routines, using the special
c mexCallMATLAB  utility routine.  In the way of an example, we've put together 
c the subroutine, MEXTST1.F, together with this gateway routine, MEXTST1G.f.

c This is the gateway subroutine for linking in our EIGS example.  To
c use MATLAB as a subroutine library, a program must be linked in as
c a MEX-file with MATLAB.  For our EIGS example, we would invoke MATLAB
c and execute the command 'EIGS'.  This transfers control to the EIGS
c program, which can then make calls to MATLAB's internal functions.

c Since our program EIGS is stand-alone - it doesn't take arguments from
c MATLAB - the gateway routine doesn't do anything; it just branches to
c the EIG subroutine.

      call EIGS(nlhs, plhs)
      return
      end
