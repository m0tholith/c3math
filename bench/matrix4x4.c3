module c3math::matrix::benchmarks::matrix4x4 @benchmark @if($$BENCHMARKING);
import c3math::matrix::mat_type;
import std::math @norecurse;
import c3math::matrix;

Matrix4x4 l4;
Matrix4x4 u4;
Matrix4x4 p4;
Matrix4x4 m4;
Matrix2x2 m2;
Matrix{3,4, double} m3x4;
Matrix{4,3, double} m4x3;
double[3] v3 = { 1, 3, -2 };
double[3] a3 = { 1, 3, -2 };
double[4] v4 = { 1, 3, 0, -2 };
double[4] a4 = { 1, 3, 0, -2 };
Matrix4x4 mat4x4_1 = {{ 3, 1, 2, 9,10, 1, 5, 5, 0, 1, -4, 5, -2, 1,  8, -4 }};
Matrix4x4 mat4x4_2 = {{ 4, 7, 2, 8, 0, 1, -4, 5, 9, 8, 10, 1, -4, -2, 1, 1 }};

fn void cols() => mat4x4_1.cols();
fn void rows() => mat4x4_1.rows();
fn void type() => mat4x4_1.type();
fn void add_inline()
{
	mat4x4_1.add_inline(mat4x4_2);
}
fn void add()
{
	mat4x4_1.add(mat4x4_2);
}
fn void add_assign_inline()
{
	mat4x4_1.add_assign_inline(mat4x4_2);
}
fn void add_assign()
{
	mat4x4_1.add_assign(mat4x4_2);
}
fn void sub_inline()
{
	mat4x4_1.sub_inline(mat4x4_2);
}
fn void sub()
{
	mat4x4_1.sub(mat4x4_2);
}
fn void sub_assign_inline()
{
	mat4x4_1.sub_assign_inline(mat4x4_2);
}
fn void sub_assign()
{
	mat4x4_1.sub_assign(mat4x4_2);
}
fn void negate_inline()
{
	mat4x4_1.negate_inline();
}
fn void negate()
{
	mat4x4_1.negate();
}
fn void mul()
{
	Matrix4x4 x;
	@volatile_store(x, mat4x4_1.mul(mat4x4_2));
}

fn void mul_inline()
{
	mat4x4_1.mul_inline(mat4x4_2);
}
fn void mul_assign()
{
	mat4x4_1 *= mat4x4_2;
}
fn void mul_scalar_inline()
{
	mat4x4_1.mul_scalar_inline(2);
}
fn void mul_scalar()
{
	mat4x4_1.mul_scalar(2);
}
fn void mul_scalar_assign_inline()
{
	mat4x4_1.mul_scalar_assign_inline(2);
}
fn void mul_scalar_assign()
{
	mat4x4_1.mul_scalar_assign(2);
}
fn void div_scalar_inline()
{
	mat4x4_1.div_scalar_inline(0.5);
}
fn void div_scalar()
{
	mat4x4_1.div_scalar(0.5);
}
fn void div_scalar_assign_inline()
{
	mat4x4_1.div_scalar_assign_inline(0.5);
}
fn void div_scalar_assign()
{
	mat4x4_1.div_scalar_assign(0.5);
}
fn void mul_vec()
{
	mat4x4_1.mul_vec(v4);
}
fn void mul_array()
{
	mat4x4_1.mul_array(a4);
}
fn void eq_inline()
{
	mat4x4_1.eq_inline(mat4x4_2);
}
fn void eq()
{
	mat4x4_1.eq(mat4x4_2);
}
fn void neq_inline()
{
	mat4x4_1.neq_inline(mat4x4_2);
}
fn void neq()
{
	mat4x4_1.neq(mat4x4_2);
}
fn void determinant()
{
	mat4x4_1.determinant();
}
fn void cofactor()
{
	mat4x4_1.cofactor(1, 0);
}
fn void comatrix_assign()
{
	m4.comatrix_assign(&mat4x4_1);
}
fn void trace()
{
	mat4x4_1.trace();
}
fn void get_row()
{
	mat4x4_1.@get_row(0, a4);
}
fn void set_row()
{
	m4.@set_row(0, a4);
}
fn void swap_col()
{
	mat4x4_1.swap_col(0, 1);
}
fn void swap_row()
{
	mat4x4_1.swap_row(0, 1);
}
fn void lu_decomp()
{
	mat4x4_1.lu_decomp(&l4, &u4)!!;
}
fn void lu_decomp_pivot()
{
	mat4x4_1.lu_decomp_pivot(&l4, &u4, &p4)!!;
}
fn void translate()
{
	mat4x4_1.translate(v3);
}
fn void rotate_2d()
{
	m4.rotate_2d(math::PI);
}
fn void rotate_x()
{
	mat4x4_1.rotate_x(math::PI);
}
fn void rotate_y()
{
	mat4x4_1.rotate_y(math::PI);
}
fn void rotate_z()
{
	mat4x4_1.rotate_z(math::PI);
}
fn void transpose_assign()
{
	matrix::transpose_assign(&m4, &mat4x4_1);
}
fn void transpose()
{
	mat4x4_1.transpose();
}
fn void row_slice()
{
	matrix::row_slice(&m3x4, &mat4x4_1, 0);
}
fn void col_slice()
{
	matrix::col_slice(&m4x3, &mat4x4_1, 0);
}
fn void strassen_mul()
{
	matrix::strassen_mul(&m4, &mat4x4_1, &mat4x4_2);
}
fn void minor()
{
	matrix::minor(&mat4x4_1, 1,0);
}
fn void identity()
{
	matrix::@identity(4);
}
fn void identity_assign()
{
	matrix::identity_assign(&m4);
}
fn void adjugate_assign()
{
	m4.adjugate_assign(&mat4x4_1);
}
fn void inverse()
{
	matrix::inverse(&m4, &mat4x4_1)!!;
}
fn void downsize()
{
	matrix::@downsize(&mat4x4_1, &m2, 0,0);
}
fn void upsize()
{
	matrix::@upsize(&m2, &m4, 0,0);
}
