module matrix::benchmarks::matrix64x64 @benchmark @if($$BENCHMARKING &&& $feature(BENCHMARK_64));
import matrix::mat_type;

alias Matrix64x64 = Matrix{64,64, double};

Matrix64x64 mat64_1;
Matrix64x64 mat64_2;

double[<64>] vec64;
double[64] array64;

import std::io;
import std::collections::tuple;

fn void equality()
{
	mat64_1 == mat64_2;
}
fn void unequality()
{
	mat64_1 != mat64_2;
}
fn void addition()
{
	mat64_1 + mat64_2;
}
fn void negation()
{
	-mat64_1;
}
fn void subtraction()
{
	mat64_1 - mat64_2;
}
fn void scalar_mul()
{
	mat64_1 * 2;
}
fn void scalar_div()
{
	mat64_1 / 2;
}
fn void vector_mul()
{
	mat64_1 * vec64;
}
fn void list_mul()
{
	mat64_1 * array64;
}
fn void matrix_mul()
{
	matrix::@mul(mat64_1, mat64_2);
}
fn void determinant()
{
	mat64_1.@determinant();
}
fn void minor()
{
	mat64_1.@minor(1, 2);
}
fn void cofactor()
{
	mat64_1.@cofactor(1, 2);
}
fn void comatrix()
{
	mat64_1.@comatrix();
}
fn void adjugate()
{
	matrix::adjugate(mat64_1);
}
fn void trace()
{
	mat64_1.trace();
}
fn void swap_col()
{
	Matrix64x64 test_mat = mat64_1;
	test_mat.swap_col(0, 1);
}
fn void swap_row()
{
	Matrix64x64 test_mat = mat64_1;
	test_mat.swap_row(0, 1);
}
fn void lu_decomp()
{
	mat64_1.lu_decomp();
}
fn void resize()
{
	matrix::@resize(mat64_1, 4,4);
}
fn void transpose()
{
	matrix::@transpose(mat64_1);
}
fn void row_slice()
{
	matrix::@row_slice(mat64_1, 0);
}
fn void col_slice()
{
	matrix::@col_slice(mat64_1, 0);
}
fn void identity()
{
	matrix::@identity(4);
}
fn void inverted()
{
	matrix::inverse(mat64_1)!!;
}

module matrix::benchmarks::matrix64x64 @if($feature(BENCHMARK_64));
fn void init_mats() @init
{
	mat64_1 = benchmarks::@rand_mat(64);
	mat64_2 = benchmarks::@rand_mat(64);

	vec64 = benchmarks::@rand_vec(64);
	array64 = benchmarks::@rand_array(64);
	set_benchmark_warmup_iterations(0);
	set_benchmark_max_iterations(2);
}
