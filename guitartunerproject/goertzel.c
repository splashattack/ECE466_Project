/*
 * goertzel.c
 *
 *  Created on: Apr 27, 2016
 *      Author: Caleb
 */
#include "math.h"

#include "cirBuffer.h"
#include "coeffs.h"

#define Q_NUM 13

// Q5 fixed point implementation
// Fs = 4000Hz
// N = 4000 points
// k = round(0.5+(N*freq/Fs))


#define LOW_FREQ 70
#define HI_FREQ 340

short calculateFrequency(circBuffer* buffer)
{
	double max = 0;
	short freq;
	short freqEstimate;
	for (freq = LOW_FREQ; freq <= HI_FREQ; freq++)
	{
		long Q0,Q1,Q2 = 0;
		long i;
	    for (i = buffer->begin; i < buffer->size; i++)
	    {
	    	Q0 = coeff[freq] * Q1 - Q2 + ((buffer->data[i])<<Q_NUM);
	        Q2 = Q1;
	        Q1 = Q0;
	    }
	    double temp = Q1 * Q1 + Q2 * Q2 - Q1 * Q2 * coeff[freq];
	    double magnitude = sqrt(temp);
	    if(magnitude > max)
	    {
	    	max = magnitude;
	    	freqEstimate = freq;
	    }
	 }
	 return freqEstimate;
}
