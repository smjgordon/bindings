module test.main;

import tango.stdc.stdio;
import gsl.gsl_sf_bessel;

import test.vector;
import test.matrix;
import test.linalg;

public int main( char[][] args )
{
//	test_bessel();
//	test_vector_error();
//	test_vector_write();
//	test_vector_read();
	
//	test_matrix();
//	test_matrix_read_write();
//	test_matrix_vector_views();

	test_linalg_ludecomp();

	return 0;
}

void test_bessel()
{
	double x = 5.0;
	double y = gsl_sf_bessel_J0( x );
	printf("J0(%g) = %.18e\n", x, y);
}


