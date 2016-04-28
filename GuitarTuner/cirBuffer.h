/*
 * cirBuffer.h
 *
 *  Created on: Apr 6, 2016
 *      Author: Caleb
 */

#include "stdbool.h"

#ifndef CIRBUFFER_H_
#define CIRBUFFER_H_

#define TRUE 1;
#define FALSE 0;


#endif /* CIRBUFFER_H_ */


typedef struct cBuffer
{
	short index;
	short begin;
	short end;
	short size;
	short* data;
} circBuffer;

circBuffer* cbuff_init(short bufferSize);
_Bool cbuff_isEmpty(circBuffer* self);
void cbuff_push(circBuffer* self, short input);
