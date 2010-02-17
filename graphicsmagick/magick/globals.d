module magick.globals;

align(1):

const MagickSignature = 0xabacadabU;
//C     #define MagickPassFail unsigned int
alias uint MagickPassFail;
//C     #define MagickPass     1
//C     #define MagickFail     0
const MagickPass = 1;

const MagickFail = 0;
//C     #define MagickBool     unsigned int
alias uint MagickBool;
//C     #define MagickTrue     1
//C     #define MagickFalse    0
const MagickTrue = 1;

const MagickFalse = 0;


const MaxTextExtent = 2053;

