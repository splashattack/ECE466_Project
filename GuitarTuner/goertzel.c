/*
 * goertzel.c
 *
 *  Created on: Apr 27, 2016
 *      Author: Caleb
 */
#include "math.h"



short calculateFrequency(circBuffer* buffer, short Fs, short lowerFreq, short upperFreq)
{

	 for (short freq =  lowerFreq; freq <= upperFreq; freq++)
	 {
		 short k = round(0.5+(N*freq/Fs));
	     w = (2*pi/N)*k;
	     cosine = cos(w);
	     sine = sin(w);
	     coeff = 2*cosine;
	     short Q0,Q1,Q2 = 0;
	     for (short i = buffer->begin; i < buffer->size; i++)
	     {
	    	 Q0 = coeff * Q1 - Q2 + buffer->data[i];
	         Q2 = Q1;
	         Q1 = Q0;
	     }
	     short magnitude = sqrt(Q1 * Q1 + Q2 * Q2 - Q1 * Q2 * coeff);
	     if(magnitude > freqEstimate)
	     {
	    	 freqEstimate = magnitude;
	     }
	 }
	 return freqEstimate;
}
