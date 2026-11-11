/*
 * mexmat.c MEX MAT-File Test Program
 * 
 * To compile, type:
 *
 *     cmex mexmat.c
 *
 */

#include "mat.h"   /* Must include mat.h before mex.h */
#include "mex.h"   /* because mat.h #includes stdio.h */

#ifdef __STDC__
void mexFunction(int nlhs, Matrix *plhs[], int nrhs, Matrix *prhs[])
#else
mexFunction(nlhs, plhs, nrhs, prhs)
    int nlhs;
    Matrix *plhs[];
    int nrhs;
    Matrix *prhs[];
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
		mexErrMsgTxt("No matlab.mat file.\n");
	}

	/*
	 * copy matlab.mat to temp.mat by using matGetNextMatrix
	 */
	ph1 = matOpen("temp.mat", "w");

	if (ph1 == NULL) {
		mexErrMsgTxt("Not able to make temp.mat.\n");
	}

	for (;;) {
		pmat = matGetNextMatrix(ph);
		if (pmat == NULL) {
			if (ferror(matGetFp(ph))) {
				mexErrMsgTxt("Read error using matGetNextMatrix on matlab.mat.\n");
			} else {
				break;
			}
		}
		if (matPutMatrix(ph1,pmat)) {
			mexErrMsgTxt("Error writing matrix to temp.mat.\n");
		}
		mxFreeMatrix(pmat);
	}

	matClose(ph1);

	/*
	 * get directory of matlab.mat
	 */
	dir = matGetDir(ph, &ndir);

	if (dir == NULL) {
		mexErrMsgTxt("Directory reading problem.\n");
	} else {
		printf("Directory of matlab.mat\n");
		for (i=0; i < ndir; i++)
			printf("%s\n",dir[i]);
	}

	ph1 = matOpen("temp1.mat", "w");

	if (ph1 == NULL) {
		mexErrMsgTxt("Not able to make temp1.mat.\n");
	}

	/*
	 * copy matlab.mat to temp1.mat using matGetMatrix
	 */
	for (i=0; i < ndir; i++) {
		pmat = matGetMatrix(ph, dir[i]);
		if (pmat == NULL) {
			if (feof(matGetFp(ph))) {
				mexErrMsgTxt("Read error using matGetMatrix on matlab.mat.\n");
			} else {
				printf("Could not find matrix %s even though it is in the \
directory.\n",dir[i]);
				mexErrMsgTxt("");
			}
		}
		if (matPutMatrix(ph1,pmat)) {
			mexErrMsgTxt("Error writing matrix to temp1.mat.\n");
		}
		mxFreeMatrix(pmat);
	}

	matClose(ph1);
}
