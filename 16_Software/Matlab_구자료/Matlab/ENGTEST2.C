/*
 *	ENGTEST2
 *
 *	Simple program that illustrates how to call the Engine Library
 *	from a C program.  
 *
 *	The example starts a MATLAB engine on a machine that you are
 *	currently logged into.
 */
#include <stdlib.h>
#include <stdio.h>
#include "engine.h"

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

	engWinInit (hInstance);
	if (!(ep = engOpen(lpszCmdLine))) {
		MessageBox ((HWND)NULL, (LPSTR)"Can't start MATLAB engine", 
			(LPSTR) "Engtest2.c", MB_OK);
	}

	engClose(ep);
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

	if (!(ep = engOpen("matlab "))) {
		fprintf(stderr, "\nCan't start MATLAB engine");
		exit(-1);
	}

	engClose(ep);
	exit(0);
}
#endif /* Windows */
