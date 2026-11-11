/*
 * Mat-file test program
 */

#include <stdio.h>
#include "mat.h"

#ifdef __STDC__
int exit(int);

void main()
#else
main()
#endif
{
	MATFile	*ph;
	MATFile	*ph1;
	char		**dir;
	int			ndir;
	int			i;
	Matrix		*pmat;


	/*
	 * open "matlab.mat"
	 */
	ph = matOpen("matlab.mat", "u");

	if (ph == NULL) {
		printf("No matlab.mat file.\n");
		exit(0);
	}

	/*
	 * copy matlab.mat to temp.mat by using matGetNextMatrix
	 */
	ph1 = matOpen("temp.mat", "w");

	if (ph1 == NULL) {
		printf("Not able to make temp.mat.\n");
		exit(0);
	}

	for (;;) {
		pmat = matGetNextMatrix(ph);
		if (pmat == NULL) {
			if (ferror(matGetFp(ph))) {
				printf("Read error using matGetNextMatrix on matlab.mat.\n");
				exit(0);
			} else {
				break;
			}
		}
		if (matPutMatrix(ph1,pmat)) {
			printf("Error writing matrix to temp.mat.\n");
			exit(0);
		}
		mxFreeMatrix(pmat);
	}

	matClose(ph1);

	/*
	 * get directory of matlab.mat
	 */
	dir = matGetDir(ph, &ndir);

	if (dir == NULL) {
		printf("Directory reading problem.\n");
		exit(0);
	} else {
		printf("Directory of matlab.mat\n");
		for (i=0; i < ndir; i++)
			printf("%s\n",dir[i]);
	}

	ph1 = matOpen("temp1.mat", "w");

	if (ph1 == NULL) {
		printf("Not able to make temp1.mat.\n");
		exit(0);
	}

	/*
	 * copy matlab.mat to temp1.mat using matGetMatrix
	 */
	for (i=0; i < ndir; i++) {
		pmat = matGetMatrix(ph, dir[i]);
		if (pmat == NULL) {
			if (feof(matGetFp(ph))) {
				printf("Read error using matGetMatrix on matlab.mat.\n");
				exit(0);
			} else {
				printf("Could not find matrix %s even though it is in the \
directory.\n",dir[i]);
			}
		}
		if (matPutMatrix(ph1,pmat)) {
			printf("Error writing matrix to temp1.mat.\n");
			exit(0);
		}
		mxFreeMatrix(pmat);
	}

	matClose(ph1);

	exit(0);
}

