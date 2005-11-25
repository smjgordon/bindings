
#include <stdio.h> // Printf and gets
#include <string.h> // strcpy
#include "RakClientInterface.h"
#include "RakNetworkFactory.h"
#include "BitStream.h"
#include "RakServerInterface.h"
#include "PacketEnumerations.h"
#include <cassert> 

#ifndef _RAKBITSTREAM_
#define _RAKBITSTREAM_

extern "C" 
{
// start and end using the bitstream
void rakBitstream_start1();
void rakBitstream_start2(int initialBytes);
void rakBitstream_start3(char *_data, unsigned lengthInBytes, bool _copyData);
void rakBitstream_end();

// write 
void  rakBitstream_Write1 (bool input);
void  rakBitstream_Write2 (unsigned char input);
void  rakBitstream_Write3 (char input);
void  rakBitstream_Write4 (unsigned short input);
void  rakBitstream_Write5 (short input);
void  rakBitstream_Write6 (unsigned int input);
void  rakBitstream_Write7 (int input);
void  rakBitstream_Write8 (float input);
void  rakBitstream_Write9 (double input);
void  rakBitstream_Write10 (char *input, int numberOfBytes);


// read 
bool  rakBitstream_Read1 (bool &output);
bool  rakBitstream_Read2 (unsigned char &output);
bool  rakBitstream_Read3 (char &output);
bool  rakBitstream_Read4 (unsigned short &output);
bool  rakBitstream_Read5 (short &output);
bool  rakBitstream_Read6 (unsigned int &output);
bool  rakBitstream_Read7 (int &output);
bool  rakBitstream_Read8 (float &output);
bool  rakBitstream_Read9 (double &output);
bool  rakBitstream_Read10 (char *output, int numberOfBytes);

}

#endif

