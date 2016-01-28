/* $Id: ex13.mc,v 1.1 2007/07/09 16:25:17 hammes Exp $ */

/*
 * Copyright 2005 SRC Computers, Inc.  All Rights Reserved.
 *
 *	Manufactured in the United States of America.
 *
 * SRC Computers, Inc.
 * 4240 N Nevada Avenue
 * Colorado Springs, CO 80907
 * (v) (719) 262-0213
 * (f) (719) 262-0223
 *
 * No permission has been granted to distribute this software
 * without the express permission of SRC Computers, Inc.
 *
 * This program is distributed WITHOUT ANY WARRANTY OF ANY KIND.
 */

#include <libmap.h>


void subr (int32_t In[], int64_t Out[], int num, int *nret, int64_t *time, int mapnum) {

    OBM_BANK_A (AL, int64_t, MAX_OBM_SIZE)
    OBM_BANK_C (CL, int64_t, MAX_OBM_SIZE)
    int64_t t0, t1;
    Stream_64 SIn, SOut, S0, S1;

    read_timer (&t0);

    #pragma src parallel sections
    {
    #pragma src section
	{
	streamed_dma_cpu_64 (&SIn, PORT_TO_STREAM, In, 2*num*sizeof(int32_t));
	}

    #pragma src section
	{
	int i;
	int32_t v0,v1;
	int64_t v64_0,v64_1;
	int64_t i64;

        for (i=0; i<num; i++) {
           get_stream_64 (&SIn, &i64);
           split_64to32 (i64, &v1, &v0);



  // add code to "filter v0 value > 256 and < 512
  // add code to "filter v1 value > 100256 and < 100512
	    }
	}

        #pragma src section
	{
	// This section will perform a stream merge on the filtered streams
    // Do you need a stream_term?

    // Put the merge data in CL to DMA out later
	}

    }

    read_timer (&t1);

    *time = t1 - t0;

    #pragma src parallel sections
    {
    #pragma src section
	{
	    int i;
	    int32_t v0,v1;
	    int64_t i64;

        for (i=0; i<*nret; i++) {
           i64 = CL[i];
           put_stream_64 (&SOut, i64, 1);
         }
    }
    #pragma src section
	{
	streamed_dma_cpu_64 (&SOut, STREAM_TO_PORT, Out, *nret*sizeof(int64_t));
	}
	}

    }

