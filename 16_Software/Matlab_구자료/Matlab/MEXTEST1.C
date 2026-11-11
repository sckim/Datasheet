#include <math.h>
#include "mex.h"

/*
 * MATLAB's MEX-file facility lets you call your own C routines
 * directly from MATLAB.   Conversely, it is also possible to call
 * internal MATLAB routines from your C routines, using the special
 * 'mexCallMATLAB' utility routine.  In the way of an example, we've put
 * together this routine, EIGS.C.
 *
 * This routine first forms and displays the matrix (in MATLAB notation):
 *
 *      hankel(1:4,4:-1:1) + sqrt(-1)*toeplitz(1:4,1:4)
 *
 * Next it finds the eigenvalues and eigenvectors (using the MATLAB
 * function EIG), and displays the eigenvalue matrix.  Then it
 * calculates the inverse of the eigenvalues to demonstrate manipulation
 * of MATLAB results and how to deal with complex arithemetic.  Finally,
 * the program displays the inverse values.
 *
 * Author: L. Shure 3-15-88
 * Copyright 1988, The MathWorks, Inc., All rights reserved.
 */

#define XR(i,j) xr[i+4*j]
#define XI(i,j) xi[i+4*j]

static
#ifdef __STDC__
void fill_array(
	double	*xr,
	double	*xi
	)
#else
fill_array(xr,xi)
double *xr, *xi;
#endif
{
	double tmp;
	int i,j,jj;
/*
 * Remember, MATLAB stores matrices in their transposed form,
 * i.e., columnwise, like FORTRAN.
 *
 * Fill real and imaginary parts of array.
 */
	for (j = 0; j < 4; j++) {
		for (i = 0; i <= j; i++) {
			XR(i,j) = 4 + i - j;
			XR(j,i) = XR(i,j);
			XI(i,j) = j - i + 1;
			XI(j,i) = XI(i,j);
		}
	}
/*
 * Reorder columns of xr.
 */
	for (j = 0; j < 2; j++) {
		for (i = 0; i < 4; i++) {
			tmp = XR(i,j);
			jj = 3 - j;
			XR(i,j) = XR(i,jj);
			XR(i,jj) = tmp;
		}
	}
}

/*
 * Invert diagonal elements of complex matrix of order 4
 */
static
#ifdef __STDC__
void invertd(
	double	*xr,
	double	*xi
	)
#else
invertd(xr,xi)
double *xr, *xi;
#endif
{
	double tmp;
	double *rx, *ix;
	int i;

	rx = xr;
	ix = xi;
/*
 * I know diagnonal elements of a 4 X 4 are 1:5:16
 */
	for (i = 0; i < 16; i += 5, rx += 5, ix += 5) {
		tmp = *rx * *rx + *ix * *ix;
		*rx = *rx / tmp;
		*ix = - *ix / tmp;
	}		
}
#ifdef __STDC__
void
mexFunction(
	int		nlhs,
	Matrix	*plhs[],
	int		nrhs,
	Matrix	*prhs[]
	)
#else
mexFunction(nlhs, plhs, nrhs,prhs)
int nlhs, nrhs;
Matrix *plhs[], *prhs[];
#endif
{
	int m, n, mrhs, mlhs;
	Matrix *lhs[2], *x;

	m = n = 4;

/*
 * allocate x matrix
 */
	x =  mxCreateFull(m, n, COMPLEX);
/*
 * create values in some arrays -- remember, MATLAB stores
 * matrices column-wise
 */
	fill_array(mxGetPr(x), mxGetPi(x));
/*
 * print out initial matrix
 */
	mrhs = 1;
	mlhs = 0;
 	if (!nlhs)
		mexCallMATLAB(mlhs,lhs, mrhs, &x, "disp");
/*
 * calculate eigenvalues and eigenvectors
 */
	mlhs = 2;
	mexCallMATLAB(mlhs, lhs, mrhs, &x, "eig");
/*
 * print out eigenvalue matrix
 */
	mlhs = 0;
 	if (!nlhs)
		mexCallMATLAB(mlhs, lhs, mrhs, &lhs[1], "disp");
/*
 * take inverse of complex eigenvalues, just on diagonal
 */
	invertd(mxGetPr(lhs[1]), mxGetPi(lhs[1]));
/*
 * and print these out
 */
 	if (!nlhs)
		mexCallMATLAB(mlhs, lhs, mrhs, &lhs[1], "disp");
/*
 * Free allocated matrices
 */
	mxFreeMatrix(x);
	mxFreeMatrix(lhs[1]);
	if (nlhs)
		plhs[0] = lhs[0];
	else
		mxFreeMatrix(lhs[0]);
}
