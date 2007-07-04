module test.matrix;

import tango.stdc.stdio;
import tango.math.Math;

import gsl.gsl_matrix;
import gsl.gsl_blas;

public
{

void test_matrix()
{
	int i, j; 
	gsl_matrix * m = gsl_matrix_alloc (10, 3);

	for (i = 0; i < 10; i++)
		for (j = 0; j < 3; j++)
			gsl_matrix_set (m, i, j, 0.23 + 100*i + j);

	for (i = 0; i < 100; i++)  /* OUT OF RANGE ERROR */
		for (j = 0; j < 3; j++)
			printf ("m(%d,%d) = %g\n", i, j, 
					gsl_matrix_get (m, i, j));

	gsl_matrix_free (m);
}

void test_matrix_read_write()
{
	int i, j, k = 0; 
	gsl_matrix * m = gsl_matrix_alloc (100, 100);
	gsl_matrix * a = gsl_matrix_alloc (100, 100);

	for (i = 0; i < 100; i++)
		for (j = 0; j < 100; j++)
			gsl_matrix_set (m, i, j, 0.23 + i + j);

	{  
		FILE * f = fopen ("test.dat", "wb");
		gsl_matrix_fwrite (f, m);
		fclose (f);
	}

	{  
		FILE * f = fopen ("test.dat", "rb");
		gsl_matrix_fread (f, a);
		fclose (f);
	}

	for (i = 0; i < 100; i++)
		for (j = 0; j < 100; j++)
		{
			double mij = gsl_matrix_get (m, i, j);
			double aij = gsl_matrix_get (a, i, j);
			if (mij != aij) k++;
		}

	gsl_matrix_free (m);
	gsl_matrix_free (a);

	printf ("differences = %d (should be zero)\n", k);
	return (k > 0);
}

void test_matrix_vector_views()
{
	size_t i,j;

	gsl_matrix *m = gsl_matrix_alloc (10, 10);

	for (i = 0; i < 10; i++)
		for (j = 0; j < 10; j++)
			gsl_matrix_set (m, i, j, sin (i) + cos (j));

	for (j = 0; j < 10; j++)
	{
		gsl_vector_view column = gsl_matrix_column (m, j);
		double d;

		d = gsl_blas_dnrm2 (&column.vector);

		printf ("matrix column %d, norm = %g\n", j, d);
	}

	gsl_matrix_free (m);
}

}
