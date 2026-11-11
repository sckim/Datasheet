/*
 *      MATTEST2
 *
 *      Simple program that illustrates how to call the MAT-file Library
 *      from a C program.  
 *
 *      The example reads a matrix into a double array.
 *      The matrix is named, "A", and the MAT-file is named, "foo.mat".
 *      
 */
#include <stdlib.h>
#include <string.h>
#include "mat.h"

static double Areal[6];

#ifdef __STDC__
void main()
#else
main()
#endif
{
	MATFile *fp;
	Matrix *a;
	int mn;

	fp = matOpen("foo.mat", "r");
	a = matGetMatrix(fp, "A");
	mn = mxGetM(a) * mxGetN(a);
	memcpy((void *) Areal, (void *) mxGetPr(a), (size_t)mn*sizeof(double));
	matClose(fp);
	mxFreeMatrix(a);
	printf("\nRow 1: %g %g\n",Areal[0],Areal[3]);
	exit(0);
}
