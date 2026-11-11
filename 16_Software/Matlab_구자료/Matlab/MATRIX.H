/*  Define DLLMEX if the user forgot when using a 16-bit compiler  */
#ifdef _MSC_VER
#ifndef DLLMEX
#define DLLMEX
#endif
#elif defined(__BORLANDC__)
#ifndef DLLMEX
#define DLLMEX
#endif
#endif

#ifdef DLLMEX
#include "dllmatrx.h"
#else
#include "mx3matrx.h"
#endif
