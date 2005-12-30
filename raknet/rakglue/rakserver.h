
#include <stdio.h> // Printf and gets
#include <string.h> // strcpy
#include "RakClientInterface.h"
#include "RakNetworkFactory.h"
#include "RakServerInterface.h"
#include "PacketEnumerations.h"
#include "NetworkTypes.h" 
#include <cassert> 

#ifndef _RAKSERVER_
#define _RAKSERVER_

extern "C" {

bool rakServerInterface_RPC(char *uniqueID, char *data, unsigned long bitLength, PacketPriority priority, PacketReliability reliability, char orderingChannel, PlayerID playerId, bool broadcast, bool shiftTimestamp);

bool rakServerInterface_Start(unsigned short AllowedPlayers, unsigned long connectionValidationInteger, int threadSleepTimer, unsigned short port);

void rakServerInterface_Initialize();

void rakServerInterface_REG_AS_RPC(char* uniqueID, void ( *functionName ) ( char *input, int numberOfBitsOfData, PlayerID sender ));

// C interface to raknet
bool isRakServerInterface();

Packet* rakServerInterface_ReceivePacket();

void rakServerInterface_DeallocatePacket(Packet *);


void RakServerInterface_Destroy();

bool rakServerInterface_SendBitstream(PacketPriority priority, PacketReliability reliability, char orderingChannel, PlayerID playerId, bool broadcast);

void rakServerInterface_Disconnect( unsigned blockDuration );

int rakServerInterface_GetIndexFromPlayerID(PlayerID pid);
}

#endif

