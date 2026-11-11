/*
 *	ENGTEST3
 *
 *	Simple program that illustrates how to call the Engine Library
 *	from a C program.  
 *
 *	The example starts a MATLAB engine, sends a simple matrix to 
 *	the engine, computes its eigenvalues, gets back the vector
 *	containing the eigenvalues, and prints the second eigenvalue.
 */
#include <stdlib.h>
#include <stdio.h>
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
	FOUR_BYTE_INT m, n;
	double *Dreal, *Dimag;
	char	buff[256];

	engWinInit (hInstance);
	if (!(ep = engOpen(lpszCmdLine))) {
		MessageBox ((HWND)NULL, (LPSTR)"Can't start MATLAB engine", 
			(LPSTR) "Engtest3.c", MB_OK);
	}
	else {
		engPutFull(ep, "A", 3, 2, Areal, NULL);
		engEvalString(ep, "d = eig(A*A')");
		engGetFull(ep, "d", &m, &n, &Dreal, &Dimag);
		engClose(ep);
		
		if (Dimag)
			sprintf(buff,"Eigenval 2: %g+%gi\n",Dreal[1],Dimag[1]);
		else
			sprintf(buff,"Eigenval 2: %g\n",Dreal[1]);
		MessageBox ((HWND)NULL, (LPSTR)buff, (LPSTR)"Engtest3.c", MB_OK);
		
		mxFree(Dreal);
		if (Dimag)
			mxFree(Dimag);
	}

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
	int m, n;
	double *Dreal, *Dimag;

	if (!(ep = engOpen("matlab "))) {
		fprintf(stderr, "\nCan't start MATLAB engine");
		exit(-1);
	}

	engPutFull(ep, "A", 3, 2, Areal, NULL);
	engEvalString(ep, "d = eig(A*A')");
	engGetFull(ep, "d", &m, &n, &Dreal, &Dimag);
	engClose(ep);

	if (Dimag)
		printf("Eigenval 2: %g+%gi\n",Dreal[1],Dimag[1]);
	else
		printf("Eigenval 2: %g\n",Dreal[1]);

	mxFree(Dreal);
	if (Dimag)
		mxFree(Dimag);
	exit(0);
}
#endif /* Windows */
