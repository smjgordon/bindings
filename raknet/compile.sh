make -f Makefile.linux
build lineserver.d -L-ldl -CFPATH/etc/ -g -Rn -full -cleanup -debug -Llibrakglue.a -Llibraknet.a -L-lstdc++
build line.d -L-ldl -CFPATH/etc/ -g -Rn -full -cleanup -debug -Llibrakglue.a -Llibraknet.a -L-lstdc++  


