
FILES=\
	main.d

LLVM_LIBS=`llvm-config --libs | sed 's/-l/-L-l/g'`
LLVM_OBJ=llvmExt.o llvmTarget.o

main: llvmExt.o llvmTarget.o
	dmd2 -ofmain -L-ldl -L-lstdc++ $(FLAGS) -fPIC -gc $(FILES) $(LLVM_LIBS) $(LLVM_OBJ)

llvmExt.o:
	g++ llvm/Ext.cpp -c -I$LLVM_DIR/include -o llvmExt.o -D_GNU_SOURCE -D__STDC_LIMIT_MACROS -D__STDC_CONSTANT_MACROS

llvmTarget.o:
	g++ llvm/Target.cpp -c -I$LLVM_DIR/include -o llvmTarget.o -D_GNU_SOURCE -D__STDC_LIMIT_MACROS -D__STDC_CONSTANT_MACROS
