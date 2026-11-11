/*
 *	MATTEST7
 *
 *	Simple program that illustrates how to call the MAT-file Library
 *	from a C program.  
 *
 *	The example prints out a directory of the Matrix names contained
 *	within a MAT-file.
 *	
 */
#include <stdlib.h>
#include <stdio.h>
#include "mat.h"

#ifdef __STDC__
void main()
#else
main()
#endif
{
	MATFile *fp;
	char    **dir;
	int     ndir, i;

	fp = matOpen("foo.mat", "r");
	if (fp == NULL) {
		printf("Can't open mat file foo.mat for reading\n");
		exit(1);
	}
	dir = matGetDir(fp, &ndir);
	matClose(fp);

	if (dir == NULL) {
		printf("Can't read directory\n");
		exit(1);
	} else {
		printf("Directory of MAT-file:\n");
		for (i=0; i < ndir; i++) {
			printf("%s\n",dir[i]);
		}
	}
	mxFree(dir);
	exit(0);
}
