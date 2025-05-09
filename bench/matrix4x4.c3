module matrix::benchmarks::matrix4x4 @benchmark @if($$BENCHMARKING);

Matrix4x4 mat7 = {{ -10, 7, -9, -1, -6, -8, -17, -4, -12, -18, 19, 9, -15, 16, -2, 2 }};
Matrix4x4 mat8 = {{ -19, -6, 17, -1, -3, -9, 3, 6, 5, 1, 19, 4, -20, 18, 11, 13 }};

Matrix4x4 result4x4;

import std::io;
import std::collections::tuple;

fn void equality()
{
	mat7 == mat8;
}
fn void unequality()
{
	mat7 != mat8;
}
fn void addition()
{
	mat7 + mat8;
}
fn void negation()
{
	-mat7;
}
fn void subtraction()
{
	mat7 - mat8;
}
fn void scalar_mul()
{
	mat7 * 2;
}
fn void scalar_div()
{
	mat7 / 2;
}
fn void vector_mul()
{
	mat7 * (double[<4>]){ 2, 3, 4, 5 };
}
fn void list_mul()
{
	mat7 * (double[4]){ 2, 3, 4, 5 };
}
fn void matrix_mul()
{
	mat7 * mat8;
}
fn void determinant()
{
	mat7.@determinant();
}
fn void minor()
{
	mat7.@minor(1, 2);
}
fn void cofactor()
{
	mat7.@cofactor(1, 2);
}
fn void comatrix()
{
	result4x4.@comatrix_assign(&mat7);
}
fn void adjugate()
{
	result4x4.adjugate(&mat7);
}
fn void trace()
{
	mat7.trace();
}
fn void swap_col()
{
	result4x4.swap_col(0, 1);
}
fn void swap_row()
{
	result4x4.swap_row(0, 1);
}
fn void lu_decomp()
{
	result4x4.lu_decomp(&mat8);
}
fn void resize()
{
	matrix::@resize(mat7, 4,4);
}
fn void transpose()
{
	mat7.transpose();
}
fn void row_slice()
{
	matrix::@row_slice(mat7, 0);
}
fn void col_slice()
{
	matrix::@col_slice(mat7, 0);
}
fn void identity()
{
	matrix::@identity(4);
}
fn void inverted()
{
	matrix::inverse(&result4x4, &mat7)!!;
}
