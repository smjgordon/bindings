
all: rakserver.o rakclient.o rakbitstream.o 
	ar crv librakglue.a rakserver.o rakclient.o rakbitstream.o 	

rakserver.o: rakglue/rakserver.h rakglue/rakserver.cpp
	g++ -c rakglue/rakserver.cpp

rakclient.o: rakglue/rakclient.h rakglue/rakclient.cpp
	g++ -c rakglue/rakclient.cpp

rakbitstream.o: rakglue/rakbitstream.h rakglue/rakbitstream.cpp	
	g++ -c rakglue/rakbitstream.cpp


clean:
	rm rakserver.o rakclient.o rakbitstream.o

