/*
 *	MATTEST4
 *
 *	Simple program that illustrates how to call the MAT-file Library
 *	from a C program.  
 *
 *	The example reads the Matrix "A" from one MAT-file and writes it 
 *	out to another.
 *	
 */
#include <stdlib.h>
#include "mat.h"

#ifdef __STDC__
void main()
#else
main()
#endif
{
	MATFile *fp1, *fp2;
#ifdef DLLMEX
	FOUR_BYTE_INT m, n;
#else
	int m, n;
#endif
	double *pr, *pi;

	fp1 = matOpen("foo.mat", "r");
	fp2 = matOpen("foo1.mat", "w");
	matGetFull(fp1, "A", &m, &n, &pr, &pi);
	matPutFull(fp2, "A", m, n, pr, pi);
	matClose(fp1);
	matClose(fp2);
	exit(0);
}
