module c3math::matrix::benchmarks::matrix8x8 @benchmark @if($$BENCHMARKING);
import c3math::matrix::mat_type;
import std::math @norecurse;
import c3math::matrix;

alias Matrix8x8 = Matrix{8,8, double};

Matrix8x8 l8;
Matrix8x8 u8;
Matrix8x8 p8;
Matrix8x8 m8;
Matrix2x2 m4;
Matrix{7,8, double} m7x8;
Matrix{8,7, double} m8x7;
double[7] v7 = { 1, 3, -2, 4, 5, 6, -4 };
double[7] a7 = { 1, 3, -2, 4, 5, 6, -4 };
double[8] v8 = { 1, 3, -2, 4, 5, 6, -4, 3 };
double[8] a8 = { 1, 3, -2, 4, 5, 6, -4, 3 };
Matrix8x8 mat8x8_1 = {{ 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, }};
Matrix8x8 mat8x8_2 = {{ 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, }};

fn void cols() => mat8x8_1.cols();
fn void rows() => mat8x8_1.rows();
fn void type() => mat8x8_1.type();
fn void add_inline()
{
	mat8x8_1.add_inline(mat8x8_2);
}
fn void add()
{
	mat8x8_1.add(mat8x8_2);
}
fn void add_assign_inline()
{
	mat8x8_1.add_assign_inline(mat8x8_2);
}
fn void add_assign()
{
	mat8x8_1.add_assign(mat8x8_2);
}
fn void sub_inline()
{
	mat8x8_1.sub_inline(mat8x8_2);
}
fn void sub()
{
	mat8x8_1.sub(mat8x8_2);
}
fn void sub_assign_inline()
{
	mat8x8_1.sub_assign_inline(mat8x8_2);
}
fn void sub_assign()
{
	mat8x8_1.sub_assign(mat8x8_2);
}
fn void negate_inline()
{
	mat8x8_1.negate_inline();
}
fn void negate()
{
	mat8x8_1.negate();
}
fn void mul()
{
}
fn void mul_inline()
{
}
fn void mul_assign()
{
	matrix::mul_assign(&m8, &mat8x8_1, &mat8x8_2);
}
fn void mul_scalar_inline()
{
	mat8x8_1.mul_scalar_inline(2);
}
fn void mul_scalar()
{
	mat8x8_1.mul_scalar(2);
}
fn void mul_scalar_assign_inline()
{
	mat8x8_1.mul_scalar_assign_inline(2);
}
fn void mul_scalar_assign()
{
	mat8x8_1.mul_scalar_assign(2);
}
fn void div_scalar_inline()
{
	mat8x8_1.div_scalar_inline(0.5);
}
fn void div_scalar()
{
	mat8x8_1.div_scalar(0.5);
}
fn void div_scalar_assign_inline()
{
	mat8x8_1.div_scalar_assign_inline(0.5);
}
fn void div_scalar_assign()
{
	mat8x8_1.div_scalar_assign(0.5);
}
fn void mul_vec()
{
	mat8x8_1.mul_vec(v8);
}
fn void mul_array()
{
	mat8x8_1.mul_array(a8);
}
fn void eq_inline()
{
	mat8x8_1.eq_inline(mat8x8_2);
}
fn void eq()
{
	mat8x8_1.eq(mat8x8_2);
}
fn void neq_inline()
{
	mat8x8_1.neq_inline(mat8x8_2);
}
fn void neq()
{
	mat8x8_1.neq(mat8x8_2);
}
fn void determinant()
{
	mat8x8_1.determinant();
}
fn void cofactor()
{
	mat8x8_1.cofactor(1, 0);
}
fn void comatrix_assign()
{
	m8.comatrix_assign(&mat8x8_1);
}
fn void trace()
{
	mat8x8_1.trace();
}
fn void get_row()
{
	mat8x8_1.@get_row(0, a8);
}
fn void set_row()
{
	m8.@set_row(0, a8);
}
fn void swap_col()
{
	mat8x8_1.swap_col(0, 1);
}
fn void swap_row()
{
	mat8x8_1.swap_row(0, 1);
}
fn void lu_decomp()
{
	mat8x8_1.lu_decomp(&l8, &u8)!!;
}
fn void lu_decomp_pivot()
{
	mat8x8_1.lu_decomp_pivot(&l8, &u8, &p8)!!;
}
fn void translate()
{
	mat8x8_1.translate(v7);
}
fn void rotate_2d()
{
}
fn void rotate_x()
{
}
fn void rotate_y()
{
}
fn void rotate_z()
{
}
fn void transpose_assign()
{
	matrix::transpose_assign(&m8, &mat8x8_1);
}
fn void transpose()
{
	mat8x8_1.transpose();
}
fn void row_slice()
{
	matrix::row_slice(&m7x8, &mat8x8_1, 0);
}
fn void col_slice()
{
	matrix::col_slice(&m8x7, &mat8x8_1, 0);
}
fn void strassen_mul()
{
	matrix::strassen_mul(&m8, &mat8x8_1, &mat8x8_2);
}
fn void minor()
{
	matrix::minor(&mat8x8_1, 1,0);
}
fn void identity()
{
	matrix::@identity(4);
}
fn void identity_assign()
{
	matrix::identity_assign(&m8);
}
fn void adjugate_assign()
{
	m8.adjugate_assign(&mat8x8_1);
}
fn void inverse()
{
	matrix::inverse(&m8, &mat8x8_1)!!;
}
fn void downsize()
{
	matrix::@downsize(&mat8x8_1, &m4, 0,0);
}
fn void upsize()
{
	matrix::@upsize(&m4, &m8, 0,0);
}

module c3math::matrix::benchmarks::matrix8x8 @if($$BENCHMARKING);
fn void i() @init
{
   set_benchmark_warmup_iterations(300);
   set_benchmark_max_iterations(30_000);
}
