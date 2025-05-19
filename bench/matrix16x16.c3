module matrix::benchmarks::matrix16x16 @benchmark @if($$BENCHMARKING);
import matrix::mat_type;

alias Matrix16x16 = Matrix{16,16, double};

Matrix16x16 mat1;
Matrix16x16 mat2;

Matrix16x16 result16x16;
Matrix4x4 result4x4;

double[<16>] vec1;
double[16] array1;

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
	matrix::mul(&result16x16, &mat1, &mat2);
}
fn void determinant()
{
	mat1.determinant();
}
fn void minor()
{
	matrix::minor(&mat1, 1, 2);
}
fn void cofactor()
{
	mat1.cofactor(1, 2);
}
fn void comatrix()
{
	result16x16.comatrix_assign(&mat1);
}
fn void adjugate()
{
	matrix::adjugate(&result16x16, &mat1);
}
fn void trace()
{
	mat1.trace();
}
fn void swap_col()
{
	result16x16.swap_col(0, 1);
}
fn void swap_row()
{
	result16x16.swap_row(0, 1);
}
fn void lu_decomp()
{
	mat1.lu_decomp(&result16x16, &result16x16)!!;
}
fn void resize()
{
	matrix::@resize(&mat1, &result4x4, 4,4);
}
fn void transpose()
{
	matrix::transpose_assign(&result16x16, &mat1);
}
fn void row_slice() => @pool()
{
	Matrix{15,16, double}* tmp = allocator::new_aligned(tmem, Matrix{15,16, double})!!;
	matrix::row_slice(tmp, &mat1, 0);
	allocator::free_aligned(tmem, tmp);
}
fn void col_slice() => @pool()
{
	Matrix{16,15, double}* tmp = allocator::new_aligned(tmem, Matrix{16,15, double})!!;
	matrix::col_slice(tmp, &mat1, 0);
	allocator::free_aligned(tmem, tmp);
}
fn void identity()
{
	matrix::@identity(16);
}
fn void inverted()
{
	matrix::inverse(&result16x16, &mat1)!!;
}

module matrix::benchmarks::matrix16x16 @if($$BENCHMARKING);
fn void init_mats() @init
{
	mat1 = benchmarks::@rand_mat(16);
	mat2 = benchmarks::@rand_mat(16);

	vec1 = benchmarks::@rand_vec(16);
	array1 = benchmarks::@rand_array(16);
	set_benchmark_warmup_iterations(1_000);
	set_benchmark_max_iterations(100_000);
}
