/*
 *      MATTEST3
 *
 *      Simple program that illustrates how to call the MAT-file Library
 *      from a C program.  
 *
 *      The example prints out the row dimensions of all the Matrices in
 *      a MAT-file.
 *      
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "mat.h"

#ifdef __STDC__
void main()
#else
main()
#endif
{
	MATFile *fp;
	Matrix *mp;

	fp = matOpen("foo.mat", "r");
	while ((mp = matGetNextMatrix(fp)) != NULL) {
		printf("Row dimension is %ld\n", (long)mxGetM(mp));
		mxFreeMatrix(mp);
	}
	matClose(fp);
	exit(0);
}
