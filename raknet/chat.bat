CFPATH="-CFPATH/etc/"

make -f Makefile.win
build chat.d -g -Rn -full rakserverglue.obj rakclientglue.obj rakbitstreamglue.obj lib\raknet.lib C:\dm\lib\WSOCK32.lib 

