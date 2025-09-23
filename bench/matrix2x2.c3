module c3math::matrix::benchmarks::matrix2x2 @benchmark @if($$BENCHMARKING);
import c3math::matrix::mat_type;
import std::math @norecurse;
import c3math::matrix;

Matrix2x2 l2;
Matrix2x2 u2;
Matrix2x2 p2;
Matrix2x2 m2;
Matrix1x2 m1x2;
Matrix2x1 m2x1;
double[2] v2 = { 1, 3 };
double[2] a2 = { 1, 3 };
Matrix2x2 mat2x2_1 = {{ 3, 5, 5, 2 }};
Matrix2x2 mat2x2_2 = {{ 4, 7, 2, 8 }};

fn void cols() => mat2x2_1.cols();
fn void rows() => mat2x2_1.rows();
fn void type() => mat2x2_1.type();
fn void add_inline()
{
	mat2x2_1.add_inline(mat2x2_2);
}
fn void add()
{
	mat2x2_1.add(mat2x2_2);
}
fn void add_assign_inline()
{
	mat2x2_1.add_assign_inline(mat2x2_2);
}
fn void add_assign()
{
	mat2x2_1.add_assign(mat2x2_2);
}
fn void sub_inline()
{
	mat2x2_1.sub_inline(mat2x2_2);
}
fn void sub()
{
	mat2x2_1.sub(mat2x2_2);
}
fn void sub_assign_inline()
{
	mat2x2_1.sub_assign_inline(mat2x2_2);
}
fn void sub_assign()
{
	mat2x2_1.sub_assign(mat2x2_2);
}
fn void negate_inline()
{
	mat2x2_1.negate_inline();
}
fn void negate()
{
	mat2x2_1.negate();
}
fn void mul()
{
	mat2x2_1.mul(mat2x2_2);
}
fn void mul_inline()
{
	mat2x2_1.mul_inline(mat2x2_2);
}
fn void mul_assign()
{
	mat2x2_1 *= mat2x2_2;
}
fn void mul_scalar_inline()
{
	mat2x2_1.mul_scalar_inline(2);
}
fn void mul_scalar()
{
	mat2x2_1.mul_scalar(2);
}
fn void mul_scalar_assign_inline()
{
	mat2x2_1.mul_scalar_assign_inline(2);
}
fn void mul_scalar_assign()
{
	mat2x2_1.mul_scalar_assign(2);
}
fn void div_scalar_inline()
{
	mat2x2_1.div_scalar_inline(0.5);
}
fn void div_scalar()
{
	mat2x2_1.div_scalar(0.5);
}
fn void div_scalar_assign_inline()
{
	mat2x2_1.div_scalar_assign_inline(0.5);
}
fn void div_scalar_assign()
{
	mat2x2_1.div_scalar_assign(0.5);
}
fn void mul_vec()
{
	mat2x2_1.mul_vec(v2);
}
fn void mul_array()
{
	mat2x2_1.mul_array(a2);
}
fn void eq_inline()
{
	mat2x2_1.eq_inline(mat2x2_2);
}
fn void eq()
{
	mat2x2_1.eq(mat2x2_2);
}
fn void neq_inline()
{
	mat2x2_1.neq_inline(mat2x2_2);
}
fn void neq()
{
	mat2x2_1.neq(mat2x2_2);
}
fn void determinant()
{
	mat2x2_1.determinant();
}
fn void cofactor()
{
	mat2x2_1.cofactor(1, 0);
}
fn void comatrix_assign()
{
	m2.comatrix_assign(&mat2x2_1);
}
fn void trace()
{
	mat2x2_1.trace();
}
fn void get_row()
{
	mat2x2_1.@get_row(0, a2);
}
fn void set_row()
{
	m2.@set_row(0, a2);
}
fn void swap_col()
{
	mat2x2_1.swap_col(0, 1);
}
fn void swap_row()
{
	mat2x2_1.swap_row(0, 1);
}
fn void lu_decomp()
{
	mat2x2_1.lu_decomp(&l2, &u2)!!;
}
fn void lu_decomp_pivot()
{
	mat2x2_1.lu_decomp_pivot(&l2, &u2, &p2)!!;
}
fn void translate()
{
}
fn void rotate_2d()
{
	m2.rotate_2d(math::PI);
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
	matrix::transpose_assign(&m2, &mat2x2_1);
}
fn void transpose()
{
	mat2x2_1.transpose();
}
fn void row_slice()
{
	matrix::row_slice(&m1x2, &mat2x2_1, 0);
}
fn void col_slice()
{
	matrix::col_slice(&m2x1, &mat2x2_1, 0);
}
fn void strassen_mul()
{
	matrix::strassen_mul(&m2, &mat2x2_1, &mat2x2_2);
}
fn void minor()
{
	matrix::minor(&mat2x2_1, 1,0);
}
fn void identity()
{
	matrix::@identity(2);
}
fn void identity_assign()
{
	matrix::identity_assign(&m2);
}
fn void adjugate_assign()
{
	m2.adjugate_assign(&mat2x2_1);
}
fn void inverse()
{
	matrix::inverse(&m2, &mat2x2_1)!!;
}
fn void downsize()
{
}
fn void upsize()
{
}
