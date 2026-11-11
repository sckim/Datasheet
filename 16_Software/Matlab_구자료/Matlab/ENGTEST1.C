/*
 *	ENGTEST1
 *
 *	Simple program that illustrates how to call the Engine Library
 *	from a C program.  
 *
 *	The example starts a MATLAB engine process,
 *	sends a 3-by-2 real matrix to it, computes the eigen values of
 *	the matrix multiplied by its transpose, gets the matrix back 
 *	to the C program, and prints out the second eigenvalue.
 */
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "engine.h"

static double Areal[6] = { 1, 2, 3, 4, 5, 6 };

#ifdef WINVER /* If this is a Windows program */
#if defined(__WATCOMC__)
int NEAR PASCAL WinMain (HANDLE hInstance,
				 		 HANDLE hPrevInstance,
						 LPSTR  lpszCmdLine,
						 int    nCmdShow)
#else
int WINAPI WinMain (HANDLE hInstance,
				 	HANDLE hPrevInstance,
					LPSTR  lpszCmdLine,
					int    nCmdShow)
#endif /* Watcom compiler */
{
	Engine *ep;
	Matrix *a, *d;
	double *Dreal, *Dimag;
	char	buff[256];

	a = mxCreateFull(3, 2, 0);
	memcpy((char *) mxGetPr(a), (char *) Areal, 6*sizeof(double));
	mxSetName(a, "A");

	engWinInit (hInstance);
	if (!(ep = engOpen(lpszCmdLine))) {
		MessageBox ((HWND)NULL, (LPSTR)"Can't start MATLAB engine", 
			(LPSTR) "Engtest1.c", MB_OK);
	}
	else {
		engPutMatrix(ep, a);
		engEvalString(ep, "d = eig(A*A')");
		d = engGetMatrix(ep, "d");
		engClose(ep);
		
		Dreal = mxGetPr(d);
		Dimag = mxGetPi(d);
		
		if (Dimag)
			sprintf(buff,"Eigenval 2: %g+%gi",Dreal[1],Dimag[1]);
		else
			sprintf(buff,"Eigenval 2: %g",Dreal[1]);
		MessageBox ((HWND)NULL, (LPSTR)buff, (LPSTR)"Engtest1.c", MB_OK);
		
		mxFreeMatrix(d);
	}
	mxFreeMatrix(a);
	return TRUE;
}
#else /* not Windows */
#ifdef __STDC__
void main()
#else
main()
#endif
{
	Engine *ep;
	Matrix *a, *d;
	double *Dreal, *Dimag;

	a = mxCreateFull(3, 2, REAL);
	memcpy((char *) mxGetPr(a), (char *) Areal, 6*sizeof(double));
	mxSetName(a, "A");

	if (!(ep = engOpen("matlab "))) {
		fprintf(stderr, "\nCan't start MATLAB engine\n");
		exit(-1);
	}

	engPutMatrix(ep, a);
	engEvalString(ep, "d = eig(A*A')");
	d = engGetMatrix(ep, "d");
	engClose(ep);

	Dreal = mxGetPr(d);
	Dimag = mxGetPi(d);

	if (Dimag)
		printf("Eigenval 2: %g+%gi\n",Dreal[1],Dimag[1]);
	else
		printf("Eigenval 2: %g\n",Dreal[1]);

	mxFreeMatrix(a);
	mxFreeMatrix(d);
	exit(0);
}
#endif /* Windows */
