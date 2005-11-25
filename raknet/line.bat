CFPATH="-CFPATH/etc/"

make -f Makefile.win
build line.d -g -Rn -full rakserverglue.obj rakclientglue.obj rakbitstreamglue.obj raknet.lib C:\dm\lib\WSOCK32.lib 


