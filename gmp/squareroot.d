/* ========================================================================== */
/*                                                                            */
/*   Filename.c                                                               */
/*   (c) 2001 Author                                                          */
/*                                                                            */
/*   Description                                                              */
/*                                                                            */
/* ========================================================================== */

import std.c.stdio,std.c.math,std.c.stdlib,gmp,
std.c.time,std.c.string;

const BITS_PER_DIGIT =3.32192809488736234787;

int main()
{
  alias double t;
  t x;
  x = 1;
  t a;
  a = 2;
  double divby = 2 ;
  
  int i = 20;
  printf("%f\n", x);
  while (i-->0)
  {
    x = (x + a / x) / 2;
// x= x;
    printf("formula %.16f\n", x);
  }
  printf("math.sqrt %.16f\n", sqrt(2.0));
 /*big number calculation*/
 time_t t1=time(null);
 printf("high precision calculation");
  mpf_t biga;
  mpf_t bigx,bigpx;
  mpf_t temp;
  mpf_init(&biga);
  mpf_init(&bigx);
  mpf_init(&bigpx);
  mpf_init(&temp);
  const int pres=300;
  int bitpres=cast(int)(BITS_PER_DIGIT*cast(double)pres);
   printf("bitres %d\n ",bitpres);
  mpf_init2 (&bigx, bitpres); 
  mpf_init2 (&bigpx,bitpres);
  mpf_init2 (&temp, bitpres); 
  mpf_set_ui (&biga, 2);
  mpf_set_ui (&bigx, 1);
  mpf_set_ui (&bigpx, 0);
  i = 50;
  printf("%f\n", x);
  int st=1;
  //char * curres=NULL;
  //char * prevres=NULL;
  mp_exp_t expptr;
  char *curres;//="";
  char *prevres;//="x";
  curres=cast(char*)malloc(pres+10000);
  prevres=cast(char*)malloc(pres+10000);
  strcpy(curres,"");
  strcpy(prevres,"x");
  //expptr=(mp_exp_t*)malloc(100);
  while (i-->0 && strcmp(curres,prevres)!=0/*mpf_cmp(bigx,bigpx)!=0*/)
  {
   printf("comparison %d\n ",mpf_cmp(&bigx,&bigpx));
    mpf_set(&bigpx,&bigx);
    mpf_div (&temp, &biga, &bigx);
    mpf_add (&temp, &bigx, &temp);
    mpf_div_ui(&bigx,&temp,2);
  //  x = (x + a / x) / 2;
// x= x;
 // printf("formula st.%d ",st++);
 /* if (prevres!=NULL)
  {
   free(prevres);
  }*/
 /* if (expptr!=NULL)
  {
   free(expptr);
  }*/
  strcpy(prevres,curres);
  //curres=NULL;
 // expptr=NULL;
  mpf_get_str (curres, &expptr, 10, 0, &bigx);
   
  //mpf_out_str (stdout, 10, 0, bigx);
  
 // printf("%s\n",curres);
    //printf("formula %.16f\n", x);
    st++;
  }
  time_t t2=time(null);
  printf("formula st.%d ",st-1);
   printf("%s\n",curres);
    printf("length:%d\n",strlen(curres));
   //  printf("time:%ds\n",timediff(t2,t1));
   free(curres);
   free(prevres);
  return 0;
}
