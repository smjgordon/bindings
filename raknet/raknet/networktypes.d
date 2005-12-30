module raknet.networktypes;

debug import std.stdio; 

/* -*- mode: c++; c-file-style: raknet; tab-always-indent: nil; -*- */
/**
 * @file
 * @brief Unique Player Identifier Class implementation 
 * 
 * This file is part of RakNet Copyright 2003, 2004 Rakkarsoft LLC and
 * Kevin Jenkins.
 * 
 * Usage of Raknet is subject to the appropriate licence agreement.
 * "Shareware" Licensees with Rakkarsoft LLC are subject to the
 * shareware license found at
 * http://www.rakkarsoft.com/shareWareLicense.html which you agreed to
 * upon purchase of a "Shareware license" "Commercial" Licensees with
 * Rakkarsoft LLC are subject to the commercial license found at
 * http://www.rakkarsoft.com/sourceCodeLicense.html which you agreed
 * to upon purchase of a "Commercial license" All other users are
 * subject to the GNU General Public License as published by the Free
 * Software Foundation; either version 2 of the License, or (at your
 * option) any later version.
 *
 * Refer to the appropriate license agreement for distribution,
 * modification, and warranty rights.
 */
//#include "BitStream.h"

/**
* Typename for Network Object Identifier 
*/
alias ushort ObjectID;
/**
* Typename for Unique Id 
*/
alias ubyte UniqueIDType;
/**
* Typename for player index 
*/
alias ushort PlayerIndex;

const PlayerIndex UNASSIGNED_PLAYER_INDEX = 65535;

const PlayerID UNASSIGNED_PLAYER_ID =
{
   binaryAddress:0xFFFFFFFF, port:0xFFFF
};



/**
* @brief Player Identifier 
*
* This define a Player Unique Identifier.
* In fact, it corresponds to the peer address. 
*/

/// Size of PlayerID data
const int PlayerID_Size = 6;


extern(C):

struct PlayerID
{
   /**
   * The peer address from inet_addr.
   */
   uint binaryAddress;
   /**
   * The port number associated to the connexion.
   */
   ushort port;
   /**
   * Copy operator
   * @param input a player ID 
   * @return a reference to the current object 
   */

debug
{
   void print()
   {
      writefln("Binary Address: ", binaryAddress, ", port: ", port);
   }
}

   // handles == and !=
   int opEquals(inout PlayerID pid)
   {
      return ( binaryAddress == pid.binaryAddress && port == pid.port );
   }

   // handles > and <
   int opCmp(inout PlayerID pid)
   {
      return (  ( binaryAddress - pid.binaryAddress ) || ( ( binaryAddress == pid.binaryAddress ) && 
                ( port - pid.port ) )  );
   }
}



/**
* @brief Network Packet 
* 
* This structure store information concerning 
* a packet going throught the network 
*/

struct  Packet
{
   /**
   * Server only - this is the index into the player array that this playerId maps to
   */
   PlayerIndex playerIndex;

   /**
   * The Player Unique Identifier that send this packet. 
   */
   PlayerID playerId;

   /**
   * The length of the data.
   * @deprecated You should use bitSize inplace.
   * 
   */
   uint length;

   /**
   * The number of bits in used.
   * Same as length but represents bits. Length is obsolete and retained for backwards compatibility.
   */
   uint bitSize;

   /**
   * The byte array. 
   * The standard behaviour in RakNet define the first byte of the data array as the packet class. 
   * @see PacketEnumerations.h  
   */
   ubyte* data;
}


