#ifndef mex_h
#define mex_h


/*
 * These are needed because the symbols for these functions clash with the
 * FORTRAN ones with the same names.  The VMS linker makes all symbols
 * uppercase in the end.
 */
#ifdef VMS
#define mexFunction		CmexFunction
#define mexGetMatrixPtr		CmexGetMatrixPtr
#define mexCallMATLAB		CmexCallMATLAB
#define mexSetTrapFlag		CmexSetTrapFlag
#define mexErrMsgTxt		CmexErrMsgTxt
#define mexPrintf		CmexPrintf
#define mexAtExit		CmexAtExit
#define mexGetMatrix		CmexGetMatrix
#define mexPutMatrix		CmexPutMatrix
#define mexGetFull		CmexGetFull
#define mexPutFull		CmexPutFull
#define mexEvalString		CmexEvalString
#define mexEvaluateBlock 	CmexEvaluateBlock 
#define __STDC__
#endif /* VMS */

#ifdef __WATCOMC__
#define mxGetScalar	No87mxGetScalar
#define mexGetEps No87mexGetEps
#define mexGetInf No87mexGetInf
#define mexGetNaN No87mexGetNaN
#endif

#include "matrix.h"


/*
 * return pointer to named matrix 
 */
#ifdef __STDC__
extern	Matrix *mexGetMatrixPtr(
    char	*name		/* name of variable in question */
    );
#else
extern	Matrix *mexGetMatrixPtr();
#endif /* __STDC__ */


/*
 * call MATLAB function
 */
#ifdef __STDC__
extern	int mexCallMATLAB(
    int		nlhs,		/* number of expected outputs */
    Matrix	*plhs[],	/* matrix pointer array returning outputs */
    int		nrhs,		/* number of inputs */
    Matrix	*prhs[],	/* matrix pointer array for inputs */
    char	*name		/* name of function */
    );
#else
extern	int mexCallMATLAB();
#endif /* __STDC__ */


/*
 * set or clear mexCallMATLAB trap flag (if set then an error in  
 * mexCallMATLAB is caught and mexCallMATLAB will return a status value, 
 * if not set an error will cause control to revert to MATLAB)
 */
#ifdef __STDC__
extern	void mexSetTrapFlag(
    int		trap_flag	/* trap flag 0 - off, 1 - on) */
    );
#else
extern	mexSetTrapFlag();
#endif /* __STDC__ */


/*
 * error return function
 */
#ifdef __STDC__
extern	void mexErrMsgTxt(
    const char	*error_msg	/* string with error message */
    );
#else
extern	mexErrMsgTxt();
#endif /* __STDC__ */


/*
 * MATLAB pprintf (print to stdout and possibly to diary file)
 */
#ifdef __STDC__
extern	int mexPrintf(
    const char	*format,	/* printf style format */
    ...				/* any additional arguments */
    );
#else
extern	int mexPrintf();
#endif /* __STDC__ */


/*
 * Register a function to be called by MATLAB in the event the Mex-file is to
 * be cleared or MATLAB is about to exit.  A non-zero value is returned if 
 * registeration fails.  Only one function may be registered per Mex-file.
 */
#ifdef __STDC__
extern	int mexAtExit(
    void	(*fcn)(void)
    );
#else
extern	int mexAtExit();
#endif /* __STDC__ */


/*
 * Get a copy of the matrix from the local workspace 
 */
#ifdef __STDC__
extern	Matrix *mexGetMatrix(
    char	*name		/* name of variable in question */
    );
#else
extern	Matrix *mexGetMatrix();
#endif /* __STDC__ */


/*
 * Put a copy of the matrix in the local workspace 
 */
#ifdef __STDC__
extern	int mexPutMatrix(
    Matrix	*pm		/* pointer to matrix */
    );
#else
extern	int mexPutMatrix();
#endif /* __STDC__ */


/*
 * Easy get copy of the matrix from the local workspace
 */
#ifdef __STDC__
extern	int mexGetFull(
    char	*name,		/* name of variable in question */
    int		*m,		/* number of rows */
    int		*n,		/* number of columns */
    Real	**pr,		/* real part */
    Real	**pi		/* imaginary part */
    );
#else
extern	int mexGetFull();
#endif /* __STDC__ */


/*
 * Easy put copy of the matrix in the local workspace
 */
#ifdef __STDC__
extern	int mexPutFull(
    char	*name,		/* name of variable in question */
    int		m,		/* number of rows */
    int		n,		/* number of columns */
    Real	*pr,		/* real part */
    Real	*pi		/* imaginary part */
    );
#else
extern	int mexPutFull();
#endif /* __STDC__ */


/*
 * Execute a matlab command string in the local workspace
 */
#ifdef __STDC__
extern	int mexEvalString(
   char		*str		/* matlab command string */
    );
#else
extern	int mexEvalString();
#endif /* __STDC__ */

#ifdef __STDC__
extern	Matrix *mexGetGlobal(
	const char *
    );
#else
extern	Matrix *mexGetGlobal();
#endif /* __STDC__ */

#ifdef __STDC__
extern	Real mexGetEps(
	void
    );
#else
extern	Real mexGetEps();
#endif /* __STDC__ */

#ifdef __STDC__
extern	Real mexGetInf(
	void
    );
#else
extern	Real mexGetInf();
#endif /* __STDC__ */

#ifdef __STDC__
extern	Real mexGetNaN(
	void
    );
#else
extern	Real mexGetNaN();
#endif /* __STDC__ */

#ifdef __STDC__
extern void mxSetString (
	Matrix *
	);
#else
extern void mxSetString ();
#endif

#ifdef __STDC__
extern int mexIsFinite (
	double
	);
#else
extern int mexIsFinite();
#endif

#ifdef __STDC__
extern int mexIsInf(
	double
	);
#else
extern int mexIsInf();
#endif

#ifdef __STDC__
extern int mexIsNaN(
	double
	);
#else
extern int mexIsNaN();
#endif

/*
 * definitions which may be helpful
 */
#define printf          	mexPrintf

#define create_real_array(N)    (double *) mxCalloc((N),sizeof(double))
#define create_int_array(N)     (int *) mxCalloc((N),sizeof(int))
#define user_fcn                mexFunction
#define free_matrix             mxFreeMatrix
#define mex_calloc              mxCalloc
#define mex_free                mxFree
#define get_global              mexGetMatrixPtr
#define matlab_fcn              mexCallMATLAB
#define matlab_trap             mexSetTrapFlag
#define mex_error               mexErrMsgTxt
#define mex_printf              mexPrintf
#define create_matrix   	mxCreateFull


/*
 * prototype of user-defined function
 */
#ifdef __STDC__
extern	void mexFunction(
    int		nlhs,		/* number of expected outputs */
    Matrix	*plhs[],	/* matrix pointer array returning outputs */
    int		nrhs,		/* number of inputs */
    Matrix	*prhs[]		/* matrix pointer array for inputs */
    );
#else
extern	mexFunction();
#endif /* __STDC__ */

#endif /* mex_h */
