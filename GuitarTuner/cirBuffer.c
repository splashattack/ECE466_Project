#include "cirBuffer.h"
#include "stdbool.h"
#include <stdlib.h>

circBuffer* cbuff_init(short bufferSize)
{
	circBuffer* buffer = (circBuffer*) malloc(sizeof(circBuffer) + bufferSize*sizeof(short));
	buffer->begin = 0;
	buffer->end = 0;
	buffer->index = 0;
	buffer->size = bufferSize;
	buffer->data = (short*) calloc(bufferSize, sizeof(short));
	return buffer;
}

_Bool cbuff_isEmpty(circBuffer* self)
{
	short it;
	for(it = self->begin; it < self->end; it++)
	{
		if (self->data[it] != 0)
			return FALSE;
	}
	return TRUE;
}

void cbuff_push(circBuffer* self, short input)
{
	self->data[self->index] = input;

	if (self->end != self->size - 1)
	{
		self->end++;
	}

	if(self->index == self->end)
	{
		self->index = self->begin;
	}
	else
	{
		self->index++;
	}
}
