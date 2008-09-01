
//import gmpheadertest;
import gmp;
import std.c.stdlib;
import std.stdio;
import std.string;
void main()
{
mpf_t a;	
mpf_init(&a);	
mpf_init2 (&a, 32); 
mpf_set_ui (&a, 4444);
mp_exp_t expptr;
char * curres=cast(char*)  malloc(40);
if (mpf_cmp_ui (&a, 1)>0)
{
	printf(">1 yes");
}	
if (mpf_cmp_ui (&a, 2)>0)
{
	printf(">2 yes");
}	
if (mpf_cmp_ui (&a, 2)==0)
{
	printf("==2 yes");
}
	writefln("xx");
mpf_get_str (curres, &expptr, 10, 0, &a);

		writefln(toString(curres));
}	
