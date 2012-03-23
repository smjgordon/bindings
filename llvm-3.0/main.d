/*
Example for using the llvm-d bindings.
*/

import llvm.c.Core;

void main()
{
    auto theModule = LLVMModuleCreateWithName("The main module"); 
    LLVMDumpModule(theModule); 
} 
