
#include "rakbitstream.h"

extern "C" {

// behind the scenes dataStream that does all the work for us
RakNet::BitStream *dataStream;

// start up bitstream with default params
void rakBitstream_start1()
{
   dataStream = new RakNet::BitStream();
}

void rakBitstream_start2(int initialBytes)
{
   dataStream = new RakNet::BitStream(initialBytes);
}

// start up bitstream with given data
void rakBitstream_start3(char *_data, unsigned lengthInBytes, bool _copyData)
{  
   dataStream = new RakNet::BitStream(_data, lengthInBytes, _copyData);
}

// deallocate bitstream and set to null
void rakBitstream_end()
{
   // if there is something to deallocate, do it
   if (dataStream != NULL)
   {
      delete dataStream;
      dataStream = NULL;
   }
}

// write ////////////////////////////////////////////////////////////////
void  rakBitstream_Write1 (bool input)
{
   dataStream->Write(input);
}

void  rakBitstream_Write2 (unsigned char input)
{
   dataStream->Write(input);
}

void  rakBitstream_Write3 (char input)
{
   dataStream->Write(input);
}

void  rakBitstream_Write4 (unsigned short input)
{
   dataStream->Write(input);
}

void  rakBitstream_Write5 (short input)
{
   dataStream->Write(input);
}

void  rakBitstream_Write6 (unsigned int input)
{
   dataStream->Write(input);
}

void  rakBitstream_Write7 (int input)
{
   dataStream->Write(input);
}

void  rakBitstream_Write8 (float input)
{
   dataStream->Write(input);
}

void  rakBitstream_Write9 (double input)
{
   dataStream->Write(input);
}

void  rakBitstream_Write10 (char *input, int numberOfBytes)
{
   dataStream->Write(input, numberOfBytes);
}


// read ////////////////////////////////////////////////////////////
bool  rakBitstream_Read1 (bool &output)
{
   return dataStream->Read(output);
}

bool  rakBitstream_Read2 (unsigned char &output)
{
   return dataStream->Read(output);
}

bool  rakBitstream_Read3 (char &output)
{
   return dataStream->Read(output);
}

bool  rakBitstream_Read4 (unsigned short &output)
{
   return dataStream->Read(output);
}

bool  rakBitstream_Read5 (short &output)
{
   return dataStream->Read(output);
}

bool  rakBitstream_Read6 (unsigned int &output)
{
   return dataStream->Read(output);
}

bool  rakBitstream_Read7 (int &output)
{
   return dataStream->Read(output);
}

bool  rakBitstream_Read8 (float &output)
{
   return dataStream->Read(output);
}

bool  rakBitstream_Read9 (double &output)
{
   return dataStream->Read(output);
}

bool  rakBitstream_Read10 (char *output, int numberOfBytes)
{
   return dataStream->Read(output, numberOfBytes);
}

}


