#!/bin/sh

g++ llvm/Ext.cpp -c `llvm-config --cxxflags`
g++ llvm/Target.cpp -c `llvm-config --cxxflags`

rm -f libllvm-c-ext.a
ar rc libllvm-c-ext.a Ext.o Target.o
ranlib libllvm-c-ext.a
