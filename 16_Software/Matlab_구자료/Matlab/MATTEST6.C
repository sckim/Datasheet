/*
 *	MATTEST6
 *
 *	Simple program that illustrates how to call the MAT-file Library
 *	from a C program.  
 *
 *	The example writes the string, "Hello, world", into a MAT-file.
 *	The matrix is named, "A", and the MAT-file is named, "foo.mat".
 *	
 */
#include "mat.h"

#ifdef __STDC__
int exit(int);

void main()
#else
main()
#endif
{
	MATFile *fp;

	fp = matOpen("foo.mat", "w");
	matPutString(fp, "A", "Hello, world");
	matClose(fp);
	exit(0);
}
