/*  SIMULINK.H - Include file for making MEX-file systems and blocks
 *
 *  This file should be included at the end of a MEX-file system.
 *  It performs an interface to the MEX-file mechanism which allows
 *  blocks and systems to be entered only as their corresponding
 *  mathematical functions.
 *
 *  This template performs all checks for sizes of paramaters.
 *  If you need to pass down variables from the workspace which
 *  cause the system sizes to be variable then use the
 *  define NCOEFFS.  (For example, see stspace.c).
 *
 *
 *      Syntax  of MEX-file S-function:
 *
 *     [sys, x0] = filename(t,x,u,flag)

 *  Andrew Grace  Oct 11, 1990
 *  Revised ACWG 1-10-91
 *  Copyright (c) 1990-93 The Mathworks, Inc.
 *  All Rights Reserved
 */

#include <math.h>    /* needed for floor() prototyping */
#include "matrix.h"  /* needed for prototyping of access funcions */
#include "mex.h"

/* Input arguments */
#define T_IN    prhs[0]
#define X_IN    prhs[1]
#define U_IN    prhs[2]
#define FLAG_IN prhs[3]

    /* Output Arguments */

#define SYS_OUT plhs[0]
#define X0_OUT  plhs[1]

    /* If continuous states are not defined set them to zero */
#ifdef NSTATES
#define DNSTATES	NSTATES
#else
#define DNSTATES 	0
#endif

    /* If discrete states are not defined set them to zero */
#ifdef NDSTATES
#define DNDSTATES	NDSTATES
#else
#define DNDSTATES 	0
#endif


    /* If outputs are not defined set them to zero */
#ifdef NOUTPUTS
#define DNOUTPUTS	NOUTPUTS
#else
#define DNOUTPUTS	0
#endif

    /* If inputs states are not defined set them to zero */
#ifdef NINPUTS
#define DNINPUTS	NINPUTS
#else
#define DNINPUTS	0
#endif

    /* If singularities are not defined set them to zero */
#ifdef NSING
#define DNSING		NSING
#else
#define DNSING		0
#endif

    /* If need-inputs is not defined set it to 1 */
#ifdef NEEDINPUTS
#define DNEEDINPUTS	NEEDINPUTS
#else
#define DNEEDINPUTS	1
#endif

#ifdef SAMPLE_TIME
#define DSAMPLE_TIME	 SAMPLE_TIME
static double present_hit;
static double next_hit;
#endif

#ifdef OFFSET_TIME
#define DOFFSET_TIME 	OFFSET_TIME
#else
#define DOFFSET_TIME 	0
#endif

#ifdef NCOEFFS
#define DNCOEFFS 	NCOEFFS
#else
#define DNCOEFFS	0
#endif

#ifdef DEBUG
static
#ifdef __STDC__
    void db_matrix(char *name, Matrix *mat)
#else
db_matrix(name, mat)
    char *name;Matrix *mat;
#endif /* __STDC__ */
{
    int i, j, n;
    Real *pr;

    mexPrintf("%s =\n", name);
    pr = mxGetPr(mat);
    n = mxGetN(mat);
    for (i=mxGetM(mat); i>0; i--) {
	for (j=n; j>0; j--) {
	    mexPrintf("%8.6g ", *pr++);
	}
	mexPrintf("\n");
    }
}
static
#ifdef __STDC__
    void db_vector(char *name, double* vec, int n)
#else
db_vector(name, vec,n)
    char *name; double *vec; int n;
#endif /* __STDC__ */
{
    mexPrintf("%s = [", name);
    for (; n>0; n--) {
	mexPrintf("%6.6g ",*vec++);
    }
    mexPrintf("]\n");
}
#else
#define db_matrix(name,mat)
#define db_vector(name,vec,n)
#endif /* DEBUG */

#ifdef SAMPLE_TIME

static
#ifdef __STDC__
    double next_hit_ftn(double ts, double offset, double t)
#else
double next_hit_ftn(ts, offset, t)
    double ts, offset, t;
#endif /* __STDC__ */
{
    double nosamples, tnext;

    nosamples = (t-offset)/ts;
    tnext =  offset  + (1 + floor(nosamples + 1e-13*(1 + nosamples))) * ts;
    return(tnext);
}
static
#ifdef __STDC__
    void tnext_ftn(double t, double *x, double *u, double *tnext)
#else
tnext_ftn(t,x,u,tnext)
    double t, *x, *u;       /* Input variables */
    double *tnext;          /* Output variable*/
#endif /* __STDC__ */

{

    if (present_hit == -1e30) {
	/* First update */
	present_hit = next_hit_ftn(DSAMPLE_TIME, DOFFSET_TIME, t - DSAMPLE_TIME);
    } else {
	present_hit = next_hit;
    }
    next_hit = next_hit_ftn(DSAMPLE_TIME, DOFFSET_TIME, t);
    tnext[0] = next_hit;
}

#endif /* SAMPLE_TIME */

#ifdef NSAMPLE

static
#ifdef __STDC__
    double next_hit_ftn(double ts, double offset, double t)
#else
double next_hit_ftn(ts, offset, t)
    double ts, offset, t;
#endif /* __STDC__ */
{
    double nosamples, tnext;

    nosamples = (t-offset)/ts;
    tnext =  offset  + (1 + floor(nosamples + 1e-13*(1 + nosamples))) * ts;
    return(tnext);
}

/*--------------------------------------------------------------------*/
/* code_tnext_ftn    - works out the next sample hits for             */
/*                     sampled data blocks.                           */
/*--------------------------------------------------------------------*/
static
#ifdef __STDC__
    void code_tnext_ftn(double t,double *OffsetTimes,double *SampleTimes,double *SampleHit,double *NextHit,double *tnext)
#else
code_tnext_ftn(t, OffsetTimes, SampleTimes, SampleHit, NextHit, tnext)
    double t, *OffsetTimes, *SampleTimes;            /* Input variables */
    double *SampleHit, *NextHit, *tnext;          /* Output variables */
#endif /* __STDC__ */
{

    int i;
    static double Neareps = 1e-13;
    double nearest_next_hit, b_next;

    /*  Loop through sample times working out when the next sample hit is for
	all of the sample times store this in the vector 'next_hit' and return
	the nearest one to the present time, t. */
    for (i = 0; i < NSAMPLE; i++) {

	/* On the first iteration the sample times are set to -1e30 */
	if (SampleHit[i]  == -1e30) {
	    /* First update */
	    SampleHit[i] = next_hit_ftn(SampleTimes[i], OffsetTimes[i], t - SampleTimes[i]);
	    b_next = next_hit_ftn(SampleTimes[i], OffsetTimes[i], t);

	} else {

	    /* Next scheduled sample hit is stored in next_hit */
	    b_next = NextHit[i];
	    SampleHit[i] = b_next;

	    /* If the next hit has been overtaken then calculate another one */
	    if (b_next <= t)
		b_next = next_hit_ftn(SampleTimes[i], OffsetTimes[i], t);
	}

	/* Calculate nearest hit to the present time */

	/* On the first iteration set this to be the first one */
	if (i == 0)
	    nearest_next_hit = b_next;

	else if (fabs(nearest_next_hit - b_next) < Neareps) {

	    /* Attempt to correct sample clash problem for clashing sample hits
	       i.e. set near sample hits to the same time */
	    b_next = nearest_next_hit;

	} else {
	    if (b_next < nearest_next_hit)
		nearest_next_hit = b_next;
	}
	NextHit[i] = b_next;
    }
    tnext[0] = nearest_next_hit;
}

#endif /* NSAMPLE */

/*
  ***********************************************************************************************************
  *
  *    m e x F u n c t i o n
  *
  ***********************************************************************************************************
  */

#ifdef __STDC__
void mexFunction(int nlhs, Matrix *plhs[], int nrhs, Matrix *prhs[])
#else
    mexFunction(nlhs, plhs, nrhs, prhs)
    int nlhs, nrhs; Matrix *plhs[], *prhs[];
#endif /* __STDC__ */
{
    int flag;
    int i;
    Real *pr;
    
    /* Check validity of arguments */
    
    if (nrhs == 4 + DNCOEFFS) {
	
	/* Load coeffiencts into global matrix structure */
#if DNCOEFFS != 0
	for (i = 0; i < DNCOEFFS; i++) {
	    Coeffs[i] = prhs[4+i];
	}
#endif
	
	/* Negative nlhs is a special case used for optimum speed by integrators */
	if (nlhs >= 0) {
	    
	    if (mxGetM(FLAG_IN) != 1 || mxGetN(FLAG_IN) != 1) {
		mexErrMsgTxt("FLAG must be a scalar in System MEX file.");
	    }
	    
	    flag = mxGetPr(FLAG_IN)[0];
	    
	    /*
	     * Error checking - ommitted for speed  by integrators
	     * after a number of calls
	     */
	    
	    if (flag > 0 && flag < 6) {
		if (nlhs > 1) {
		    mexErrMsgTxt("System MEX file called with wrong number of output arguments. ");
		}
		if (mxGetM(X_IN)*mxGetN(X_IN) != DNSTATES + DNDSTATES) {
		    mexErrMsgTxt("State vector X wrong size in System MEX file.");
		}
		if (mxGetM(U_IN)*mxGetN(U_IN) != DNINPUTS) {
		    mexErrMsgTxt("Input vector U wrong size in System MEX file.");
		}
		if (mxGetM(T_IN) != 1 || mxGetN(T_IN) != 1) {
		    mexErrMsgTxt("T must be a scalar in System MEX file.");
		}
	    }
	    
	    switch (flag) {
	      case 1:
	      case -1:
		SYS_OUT = mxCreateFull(DNSTATES, 1, REAL);
		break;
		
	      case 2:
	      case -2:
		SYS_OUT = mxCreateFull(DNDSTATES, 1, REAL);
		break;
		
	      case 3:
		SYS_OUT = mxCreateFull(DNOUTPUTS, 1, REAL);
		break;
		
	      case 4:
		SYS_OUT = mxCreateFull(1, 1, REAL);
		break;
		
	      case 5:
		SYS_OUT = mxCreateFull(DNSING, 1, REAL);
		break;
		
	      default:
		SYS_OUT = mxCreateFull(0, 0, REAL);
		break;
	    }
	} else {
	    flag = mxGetPr(FLAG_IN)[0];
	}
	
	db_vector("T",mxGetPr(T_IN), mxGetM(T_IN)*mxGetN(T_IN));
	db_vector("X",mxGetPr(X_IN), mxGetM(X_IN)*mxGetN(X_IN));
	db_vector("U",mxGetPr(U_IN), mxGetM(U_IN)*mxGetN(U_IN));
	db_vector("FLAG",mxGetPr(FLAG_IN), mxGetM(FLAG_IN)*mxGetN(FLAG_IN));
	
	switch (flag) {
	  case 1:
	  case -1:
#if DNSTATES != 0
	    derivatives(*mxGetPr(T_IN), mxGetPr(X_IN), mxGetPr(U_IN), mxGetPr(SYS_OUT));
#endif
	    
	    db_vector("Derivitives",mxGetPr(SYS_OUT), DNSTATES);
	    break;
	    
	  case 2:
	  case -2:
#if DNDSTATES != 0
	    memcpy((char *)mxGetPr(SYS_OUT), (char *)&mxGetPr(X_IN)[DNSTATES],
		   sizeof(double)*DNDSTATES);
#ifdef SAMPLE_TIME
	    if (SAMPLE_TIME != 0.0 && *mxGetPr(T_IN) == present_hit)
#endif
		dstates(*mxGetPr(T_IN), mxGetPr(X_IN), mxGetPr(U_IN), mxGetPr(SYS_OUT));
	    
	    /*
	     * Since the discrete state vector doesn't get copied anymore do the
	     * copy here directly.
	     */
	    
	    memcpy((char *)&mxGetPr(X_IN)[DNSTATES], (char *)mxGetPr(SYS_OUT),
		   sizeof(double)*DNDSTATES);
#endif /* DNDSTATES */
	    db_vector("Dstates", mxGetPr(SYS_OUT), DNDSTATES);
	    break;
	    
	  case 3:
#if DNOUTPUTS != 0
#ifdef SAMPLE_TIME
	    if (DSAMPLE_TIME !=0 && *mxGetPr(T_IN) == present_hit)
		doutputs(*mxGetPr(T_IN), mxGetPr(X_IN), mxGetPr(U_IN), mxGetPr(SYS_OUT));
#endif
	    outputs(*mxGetPr(T_IN), mxGetPr(X_IN), mxGetPr(U_IN), mxGetPr(SYS_OUT));
#endif /* DNOUTPUTS */
	    
	    db_vector("Outputs",mxGetPr(SYS_OUT), DNOUTPUTS);
	    break;
	    
	  case 4:
	    *mxGetPr(SYS_OUT) = 1e30;  /* Defaults to very large number */
#ifdef SAMPLE_TIME
	    if (DSAMPLE_TIME != 0.0)
		tnext_ftn(*mxGetPr(T_IN), mxGetPr(X_IN), mxGetPr(U_IN), mxGetPr(SYS_OUT));
#endif
#ifdef NSAMPLE
	    code_tnext_ftn(*mxGetPr(T_IN), offset_times, sample_times, sample_hit, next_hit,
			   mxGetPr(SYS_OUT));
#endif
	    db_vector("Tnext",mxGetPr(SYS_OUT), 1);
	    break;
	    
	  case 5:
#ifdef NSING
	    singularity(*mxGetPr(T_IN), mxGetPr(X_IN), mxGetPr(U_IN), mxGetPr(SYS_OUT));
#endif
	    break;
	    
	  case 0:
	    
	    X0_OUT = mxCreateFull(DNSTATES + DNDSTATES, 1, REAL);
	    init_conditions(mxGetPr(X0_OUT));
	    if (nlhs < 2) mxFreeMatrix(X0_OUT);
	    
	    SYS_OUT = mxCreateFull(6, 1, REAL);
	    
	    pr = mxGetPr(SYS_OUT);
	    
	    pr[0] = DNSTATES;
	    pr[1] = DNDSTATES;
	    pr[2] = DNOUTPUTS;
	    pr[3] = DNINPUTS;
	    pr[4] = DNSING;
	    pr[5] = DNEEDINPUTS;
	    
#ifdef OFFSET_TIME
	    next_hit = 1e30;
	    present_hit = -1e30;
#endif
#ifdef NSAMPLE
	    for (i=0; i<NSAMPLE; i++)
		sample_hit[i] = -1e30;
#endif
	    
	    /* Set state strings to empty matrices */
	    if (nlhs > 2)
		plhs[2]  = mxCreateFull(0,0, REAL);
	    if (nlhs > 3) {
#ifdef NSAMPLE
		plhs[3]  = mxCreateFull(NSAMPLE,2, REAL);
		pr = mxGetPr(plhs[3]);
		memcpy((char *)pr, (char *)sample_times, sizeof(double)*NSAMPLE);
		memcpy((char *)&pr[NSAMPLE], (char *)offset_times, sizeof(double)*NSAMPLE);
#else
		plhs[3]  = mxCreateFull(0,0, REAL);
#endif /* NSAMPLE */
	    }
	    
	    /* Set other left hand sides to empty matrices */
	    for (i=4; i < nlhs; i++)
		plhs[i] = mxCreateFull(0,0, REAL);
	    
	    break;

	  case 9:
	    break;
	    
	  default:
	    mexPrintf("Not a valid flag number for MEX System.\n");
	    break;
	}
    } else if (nrhs == 0) {
#if DNCOEFFS != 0
	mexErrMsgTxt("System MEX file called with wrong number of right hand arguments.");
#endif
	
	/* No left hand arguments  */
	if (nlhs > 2)
	    mexErrMsgTxt("System MEX file returns 1 or 2 output arguments.");
	
	X0_OUT = mxCreateFull(DNSTATES+DNDSTATES, 1, REAL);
	init_conditions(mxGetPr(X0_OUT));
	if (nlhs < 2) mxFreeMatrix(X0_OUT);
	
	SYS_OUT = mxCreateFull(6, 1, REAL);
	pr = mxGetPr(SYS_OUT);
	pr[0] = DNSTATES;
	pr[1] = DNDSTATES;
	pr[2] = DNOUTPUTS;
	pr[3] = DNINPUTS;
	pr[4] = DNSING;
	pr[5] = DNEEDINPUTS;
	
	/* Set state strings to empty matrices */
	if (nlhs > 2)
	    plhs[2]  = mxCreateFull(0,0, REAL);
	if (nlhs > 3) {
#ifdef NSAMPLE
	    plhs[3]  = mxCreateFull(NSAMPLE,2, REAL);
	    pr = mxGetPr(plhs[3]);
	    memcpy((char *)pr, (char *)sample_times, sizeof(double)*NSAMPLE);
	    memcpy((char *)&pr[NSAMPLE], (char *)offset_times, sizeof(double)*NSAMPLE);
#else
	    plhs[3]  = mxCreateFull(0,0, REAL);
#endif
	}
	
	/* Set other left hand sides to empty matrices */
	for(i=4; i < nlhs; i++)
	    plhs[i]  = mxCreateFull(0,0, REAL);
	
    } else {
	mexErrMsgTxt("System MEX file called with wrong number of right hand arguments.");
    }
}
