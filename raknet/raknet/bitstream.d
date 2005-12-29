
module raknet.bitstream;

import raknet.raknet; 


// we won't simply alias these names, rather we'll overload them
// START ////////////////////////////////////////////////////////////
void start()
{
   rakBitstream_start1();
}

// we won't simply alias these names, rather we'll overload them
void start(int initBytes)
{
   rakBitstream_start2(initBytes);
}

void start(char *_data, uint lengthInBytes, bool _copyData)
{
   rakBitstream_start3(_data, lengthInBytes, _copyData);
}

// END ///////////////////////////////////////////////////////////////
void end()
{
   rakBitstream_end();
}

// WRITE /////////////////////////////////////////////////////////////
void  write (bool input)
{
   rakBitstream_Write1(input);
}

void  write (ubyte input)
{
   rakBitstream_Write2(input);
}

void  write (char input)
{
   rakBitstream_Write3(input);
}

void  write (ushort input)
{
   rakBitstream_Write4(input);
}

void  write (short input)
{
   rakBitstream_Write5(input);
}

void  write (uint input)
{
   rakBitstream_Write6(input);
}

void  write (int input)
{
   rakBitstream_Write7(input);
}

void  write (float input)
{
   rakBitstream_Write8(input);
}

void  write (double input)
{
   rakBitstream_Write9(input);
}

void  write (char *input, int numberOfBytes)
{
   rakBitstream_Write10(input, numberOfBytes);
}


// READ ////////////////////////////////////////////////////////////////////////
bool  read (inout bool output)
{
   return rakBitstream_Read1(output);
}

bool  read (inout ubyte output)
{
   return rakBitstream_Read2(output);
}

bool  read (inout char output)
{
   return rakBitstream_Read3(output);
}

bool  read (inout ushort output)
{
   return rakBitstream_Read4(output);
}

bool  read (inout short output)
{
   return rakBitstream_Read5(output);
}

bool  read (inout uint output)
{
   return rakBitstream_Read6(output);
}

bool  read (inout int output)
{
   return rakBitstream_Read7(output);
}

bool  read (inout float output)
{
   return rakBitstream_Read8(output);
}

bool  read (inout double output)
{
   return rakBitstream_Read9(output);
}

bool  read (char *output, int numberOfBytes)
{
   return rakBitstream_Read10(output, numberOfBytes);
}



 extern(C):


private {
// start and end using the bitstream
void rakBitstream_start1();
void rakBitstream_start2(int initialBytes);
void rakBitstream_start3(char *_data, uint lengthInBytes, bool _copyData);
void rakBitstream_end();

// write 
void  rakBitstream_Write1 (bool input);
void  rakBitstream_Write2 (ubyte input);
void  rakBitstream_Write3 (char input);
void  rakBitstream_Write4 (ushort input);
void  rakBitstream_Write5 (short input);
void  rakBitstream_Write6 (uint input);
void  rakBitstream_Write7 (int input);
void  rakBitstream_Write8 (float input);
void  rakBitstream_Write9 (double input);
void  rakBitstream_Write10 (char *input, int numberOfBytes);


// read 
bool  rakBitstream_Read1 (inout bool output);
bool  rakBitstream_Read2 (inout ubyte output);
bool  rakBitstream_Read3 (inout char output);
bool  rakBitstream_Read4 (inout ushort output);
bool  rakBitstream_Read5 (inout short output);
bool  rakBitstream_Read6 (inout uint output);
bool  rakBitstream_Read7 (inout int output);
bool  rakBitstream_Read8 (inout float output);
bool  rakBitstream_Read9 (inout double output);
bool  rakBitstream_Read10 (char *output, int numberOfBytes);
}



