module matrix::benchmarks::matrix8x8 @benchmark @if($$BENCHMARKING);
import matrix::mat_type;

alias Matrix8x8 = Matrix{8,8, double};

Matrix8x8 mat1;
Matrix8x8 mat2;

Matrix8x8 result8x8;
Matrix4x4 result4x4;

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
	matrix::@mul(&result8x8, &mat1, &mat2);
}
fn void determinant()
{
	mat1.@determinant();
}
fn void minor()
{
	matrix::@minor(&mat1, 1, 2);
}
fn void cofactor()
{
	mat1.@cofactor(1, 2);
}
fn void comatrix()
{
	result8x8.@comatrix_assign(&mat1);
}
fn void adjugate()
{
	matrix::adjugate(&result8x8, &mat1);
}
fn void trace()
{
	mat1.trace();
}
fn void swap_col()
{
	result8x8.swap_col(0, 1);
}
fn void swap_row()
{
	result8x8.swap_row(0, 1);
}
fn void lu_decomp()
{
	mat1.lu_decomp(&result8x8, &result8x8)!!;
}
fn void resize()
{
	matrix::@resize(&mat1, &result4x4, 4,4);
}
fn void transpose()
{
	matrix::@set_transpose(&result8x8, &mat1);
}
fn void row_slice() => @pool()
{
	Matrix{7,8, double}* tmp = allocator::new_aligned(tmem, Matrix{7,8, double})!!;
	matrix::@row_slice(tmp, &mat1, 0);
	allocator::free_aligned(tmem, tmp);
}
fn void col_slice() => @pool()
{
	Matrix{8,7, double}* tmp = allocator::new_aligned(tmem, Matrix{8,7, double})!!;
	matrix::@col_slice(tmp, &mat1, 0);
	allocator::free_aligned(tmem, tmp);
}
fn void identity()
{
	matrix::@identity(8);
}
fn void inverted()
{
	matrix::inverse(&result8x8, &mat1)!!;
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
