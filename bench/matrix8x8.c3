module matrix::benchmarks::matrix8x8 @benchmark @if($$BENCHMARKING);
import matrix::mat_type;

alias Matrix8x8 = Matrix{8,8, double};

Matrix8x8 mat1;
Matrix8x8 mat2;

double[<8>] vec1;
double[8] array1;

import std::io;
import std::collections::tuple;

fn void equality()
{
	mat1 == mat2;
}
fn void unequality()
{
	mat1 != mat2;
}
fn void addition()
{
	mat1 + mat2;
}
fn void negation()
{
	-mat1;
}
fn void subtraction()
{
	mat1 - mat2;
}
fn void scalar_mul()
{
	mat1 * 2;
}
fn void scalar_div()
{
	mat1 / 2;
}
fn void vector_mul()
{
	mat1 * vec1;
}
fn void list_mul()
{
	mat1 * array1;
}
fn void matrix_mul()
{
	matrix::@mul(mat1, mat2);
}
fn void determinant()
{
	mat1.@determinant();
}
fn void minor()
{
	mat1.@minor(1, 2);
}
fn void cofactor()
{
	mat1.@cofactor(1, 2);
}
fn void comatrix()
{
	mat1.@comatrix();
}
fn void adjugate()
{
	matrix::adjugate(mat1);
}
fn void trace()
{
	mat1.trace();
}
fn void swap_col()
{
	Matrix8x8 test_mat = mat1;
	test_mat.swap_col(0, 1);
}
fn void swap_row()
{
	Matrix8x8 test_mat = mat1;
	test_mat.swap_row(0, 1);
}
fn void lu_decomp()
{
	mat1.lu_decomp();
}
fn void resize()
{
	matrix::@resize(mat1, 4,4);
}
fn void transpose()
{
	matrix::@transpose(mat1);
}
fn void row_slice()
{
	matrix::@row_slice(mat1, 0);
}
fn void col_slice()
{
	matrix::@col_slice(mat1, 0);
}
fn void identity()
{
	matrix::@identity(4);
}
fn void inverted()
{
	matrix::inverse(mat1)!!;
}

module matrix::benchmarks::matrix8x8 @if($$BENCHMARKING);
fn void init_mats() @init
{
	mat1 = benchmarks::@rand_mat(8);
	mat2 = benchmarks::@rand_mat(8);

	vec1 = benchmarks::@rand_vec(8);
	array1 = benchmarks::@rand_array(8);
	set_benchmark_warmup_iterations(1_000);
	set_benchmark_max_iterations(100_000);
}
