module matrix::benchmarks::matrix2x2 @benchmark @if($$BENCHMARKING);
import matrix::mat_type;
import std;
import matrix;

Matrix2x2 mat = {{ 3, 5, 5, 2}};
Matrix2x2 mat2 = {{ 4, 7, 2, 8 }};
Matrix2x2 res;

fn void matrix_mul()
{
	res = mat2.mul(mat);
}

fn void matrix_mul_inline()
{
	res = mat2.mul_inline(mat);
}




