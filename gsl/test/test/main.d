module test.main;

import tango.stdc.stdio;

import gsl.gsl_sf_bessel;
import gsl.gsl_vector;

public int main( char[][] args )
{
	test_bessel();
//	test_vector_error();
	test_vector_write();
	test_vector_read();
	return 0;
}

void test_bessel()
{
	double x = 5.0;
	double y = gsl_sf_bessel_J0( x );
	printf("J0(%g) = %.18e\n", x, y);
}

void test_vector_error()
{
	int i;
	gsl_vector * v = gsl_vector_alloc (3);

	for (i = 0; i < 3; i++)
	{
		gsl_vector_set (v, i, 1.23 + i);
	}

	for (i = 0; i < 100; i++)
	{
		printf ("v_%d = %g\n", i, gsl_vector_get (v, i));
	}
}

void test_vector_write()
{
	int i; 
	gsl_vector * v = gsl_vector_alloc (100);

	for (i = 0; i < 100; i++)
	{
		gsl_vector_set (v, i, 1.23 + i);
	}

	{  
		FILE * f = fopen ("test.dat", "w");
		gsl_vector_fprintf (f, v, "%.5g");
		fclose (f);
	}
}

void test_vector_read()
{
	int i; 
	gsl_vector * v = gsl_vector_alloc (10);

	{  
		FILE * f = fopen ("test.dat", "r");
		gsl_vector_fscanf (f, v);
		fclose (f);
	}

	for (i = 0; i < 10; i++)
	{
		printf ("%g\n", gsl_vector_get(v, i));
	}
}
