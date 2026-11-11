/*
 *	MATTEST5
 *
 *	Simple program that illustrates how to call the MAT-file Library
 *	from a C program.  
 *
 *	The example writes a simple 3-by-2 real matrix into a MAT-file.
 *	The matrix is named, "A", and the MAT-file is named, "foo.mat".
 *	
 */
#include <stdlib.h>
#include "mat.h"

static double Areal[6] = { 1, 2, 3, 4, 5, 6 };

#ifdef __STDC__
void main()
#else
main()
#endif
{
	MATFile *fp;

	fp = matOpen("foo.mat", "w");
	matPutFull(fp, "A", 3, 2, Areal, NULL);
	matClose(fp);
	exit(0);
}
