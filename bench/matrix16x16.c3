module c3math::matrix::benchmarks::matrix16x16 @benchmark @if($$BENCHMARKING);
import c3math::matrix::mat_type;
import std::math @norecurse;
import c3math::matrix;

alias Matrix16x16 = Matrix{16,16, double};

Matrix16x16 l16;
Matrix16x16 u16;
Matrix16x16 p16;
Matrix16x16 m16;
Matrix2x2 m8;
Matrix{15,16, double} m15x16;
Matrix{16,15, double} m16x15;
double[15] v7 = { 1, 3, -2, 4, 5, 6, -4, 1, 1, 3, -2, 4, 5, 6, -4 };
double[15] a7 = { 1, 3, -2, 4, 5, 6, -4, 1, 1, 3, -2, 4, 5, 6, -4 };
double[16] v8 = { 1, 3, -2, 4, 5, 6, -4, 3, 1, 3, -2, 4, 5, 6, -4, 3 };
double[16] a8 = { 1, 3, -2, 4, 5, 6, -4, 3, 1, 3, -2, 4, 5, 6, -4, 3 };
Matrix16x16 mat16x16_1 = {{ 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4, }};
Matrix16x16 mat16x16_2 = {{ 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1, }};

fn void cols() => mat16x16_1.cols();
fn void rows() => mat16x16_1.rows();
fn void type() => mat16x16_1.type();
fn void add_inline()
{
	mat16x16_1.add_inline(mat16x16_2);
}
fn void add()
{
	mat16x16_1.add(mat16x16_2);
}
fn void add_assign_inline()
{
	mat16x16_1.add_assign_inline(mat16x16_2);
}
fn void add_assign()
{
	mat16x16_1.add_assign(mat16x16_2);
}
fn void sub_inline()
{
	mat16x16_1.sub_inline(mat16x16_2);
}
fn void sub()
{
	mat16x16_1.sub(mat16x16_2);
}
fn void sub_assign_inline()
{
	mat16x16_1.sub_assign_inline(mat16x16_2);
}
fn void sub_assign()
{
	mat16x16_1.sub_assign(mat16x16_2);
}
fn void negate_inline()
{
	mat16x16_1.negate_inline();
}
fn void negate()
{
	mat16x16_1.negate();
}
fn void mul()
{
}
fn void mul_inline()
{
}
fn void mul_assign()
{
	matrix::mul_assign(&m16, &mat16x16_1, &mat16x16_2);
}
fn void mul_scalar_inline()
{
	mat16x16_1.mul_scalar_inline(2);
}
fn void mul_scalar()
{
	mat16x16_1.mul_scalar(2);
}
fn void mul_scalar_assign_inline()
{
	mat16x16_1.mul_scalar_assign_inline(2);
}
fn void mul_scalar_assign()
{
	mat16x16_1.mul_scalar_assign(2);
}
fn void div_scalar_inline()
{
	mat16x16_1.div_scalar_inline(0.5);
}
fn void div_scalar()
{
	mat16x16_1.div_scalar(0.5);
}
fn void div_scalar_assign_inline()
{
	mat16x16_1.div_scalar_assign_inline(0.5);
}
fn void div_scalar_assign()
{
	mat16x16_1.div_scalar_assign(0.5);
}
fn void mul_vec()
{
	mat16x16_1.mul_vec(v8);
}
fn void mul_array()
{
	mat16x16_1.mul_array(a8);
}
fn void eq_inline()
{
	mat16x16_1.eq_inline(mat16x16_2);
}
fn void eq()
{
	mat16x16_1.eq(mat16x16_2);
}
fn void neq_inline()
{
	mat16x16_1.neq_inline(mat16x16_2);
}
fn void neq()
{
	mat16x16_1.neq(mat16x16_2);
}
fn void determinant()
{
	mat16x16_1.determinant();
}
fn void cofactor()
{
	mat16x16_1.cofactor(1, 0);
}
fn void comatrix_assign()
{
	m16.comatrix_assign(&mat16x16_1);
}
fn void trace()
{
	mat16x16_1.trace();
}
fn void get_row()
{
	mat16x16_1.@get_row(0, a8);
}
fn void set_row()
{
	m16.@set_row(0, a8);
}
fn void swap_col()
{
	mat16x16_1.swap_col(0, 1);
}
fn void swap_row()
{
	mat16x16_1.swap_row(0, 1);
}
fn void lu_decomp()
{
	mat16x16_1.lu_decomp(&l16, &u16)!!;
}
fn void lu_decomp_pivot()
{
	mat16x16_1.lu_decomp_pivot(&l16, &u16, &p16)!!;
}
fn void translate()
{
	mat16x16_1.translate(v7);
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
	matrix::transpose_assign(&m16, &mat16x16_1);
}
fn void transpose()
{
	mat16x16_1.transpose();
}
fn void row_slice()
{
	matrix::row_slice(&m15x16, &mat16x16_1, 0);
}
fn void col_slice()
{
	matrix::col_slice(&m16x15, &mat16x16_1, 0);
}
fn void strassen_mul()
{
	matrix::strassen_mul(&m16, &mat16x16_1, &mat16x16_2);
}
fn void minor()
{
	matrix::minor(&mat16x16_1, 1,0);
}
fn void identity()
{
	matrix::@identity(4);
}
fn void identity_assign()
{
	matrix::identity_assign(&m16);
}
fn void adjugate_assign()
{
	m16.adjugate_assign(&mat16x16_1);
}
fn void inverse()
{
	matrix::inverse(&m16, &mat16x16_1)!!;
}
fn void downsize()
{
	matrix::@downsize(&mat16x16_1, &m8, 0,0);
}
fn void upsize()
{
	matrix::@upsize(&m8, &m16, 0,0);
}

module c3math::matrix::benchmarks::matrix16x16 @if($$BENCHMARKING);
fn void i() @init
{
   set_benchmark_warmup_iterations(30);
   set_benchmark_max_iterations(3_000);
}
