
#include <stdio.h> // Printf and gets
#include <string.h> // strcpy
#include "RakClientInterface.h"
#include "RakNetworkFactory.h"
#include "RakServerInterface.h"
#include "PacketEnumerations.h"
#include <cassert> 

#ifndef _RAKCLIENT_
#define _RAKCLIENT_


extern "C" {

bool isRakClientInterface();

void rakClientInterface_Initialize();

bool rakClientInterface_Connect(char *host, unsigned short serverPort, unsigned short clientPort, unsigned long connectionValidationInteger, int threadSleepTimer);

bool rakClientInterface_RPC(char *uniqueID, char *data, unsigned long bitLength, PacketPriority priority, PacketReliability reliability, char orderingChannel, bool shiftTimestamp);

void rakClientInterface_DeallocatePacket(Packet *);

Packet* rakClientInterface_ReceivePacket();

void RakClientInterface_Destroy();

void rakClientInterface_REG_AS_RPC(char* uniqueID, void ( *functionName ) ( char *input, int numberOfBitsOfData, PlayerID sender ));

void rakClientInterface_Disconnect (unsigned blockDuration);
bool rakClientInterface_SendBitstream(PacketPriority priority, PacketReliability reliability, char orderingChannel);

PlayerID  rakClientInterface_GetPlayerID(); 

}

#endif

