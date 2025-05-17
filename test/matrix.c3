module tests::matrices @test;
import matrix;
import matrix::mat_type;

Matrix3x3 mat1 = {{ -20,  -7, -17,   4,  15,  20,  10,   8, -16, }};
Matrix3x2 mat2 = {{  -6,  12,   6,  17,  -1,  5,                 }};
Matrix3x3 mat3 = {{  -2,  20,  -1,  -6, -18,  12, -11,  -4,   0, }};
Matrix2x3 mat4 = {{   8,  -8,   7, -11,  14,  15,                }};
Matrix3x3 mat5 = {{   4,   6,   1,   3,   2,   5,   8,   5,   9, }};
Matrix3x2 mat6 = {{  -6, -15, -12, -11, -14,  12,                }};

Matrix4x4 mat7 = {{ -10, 7, -9, -1, -6, -8, -17, -4, -12, -18, 19, 9, -15, 16, -2, 2 }};
Matrix4x4 mat8 = {{ -19, -6, 17, -1, -3, -9, 3, 6, 5, 1, 19, 4, -20, 18, 11, 13 }};

Matrix1x3 mat9  = {{ 6, -2, 1 }};
Matrix3x1 mat10 = {{ 4, -6, 3 }};

Matrix2x2 mat11 = {{ 1, 5, 3, -2 }};
Matrix3x3 mat12 = {{ 2, 4, -2, 3, 7, 4, 1, 7, 5 }};
Matrix3x3 mat13 = {{ 2, -4, -4, -1, 6, -2, -2, 3, 8 }};

import std::io;
import std::collections::tuple;
macro @assert_print(mat1, mat2, $msg = "Not equal")
{
	io::printfn("actual:   %s", mat1);
	io::printfn("expected: %s", mat2);
	assert(mat1 == mat2, $msg);
}

fn void equality()
{
	assert(mat1 == mat1);
}
fn void unequality()
{
	assert(mat1 != mat3);
}
fn void addition()
{
	@assert_print(mat1 + mat3, (Matrix3x3){{ -22,  13, -18,  -2,  -3,  32,  -1,   4, -16 }});
}
fn void negation()
{
	@assert_print(-mat1, (Matrix3x3){{  20,   7,  17,  -4, -15, -20, -10,  -8,  16, }});
}
fn void subtraction()
{
	@assert_print(mat1 - mat3, (Matrix3x3){{ -18, -27, -16,  10,  33,   8,  21,  12, -16 }});
}
fn void scalar_mul()
{
	@assert_print(mat1 * 2, (Matrix3x3){{ -40, -14, -34,   8,  30,  40,  20,  16, -32, }});
}
fn void scalar_div()
{
	@assert_print(mat1 / 2, (Matrix3x3){{ -10,-3.5,-8.5,   2, 7.5,  10,   5,   4,  -8, }});
}
fn void vector_mul()
{
	@assert_print(mat1 * (double[<3>]){ 2, 3, 4 }, (double[<3>]){ -129, 133, -20 });
}
fn void list_mul()
{
	@assert_print(mat1 * (double[3]){ 2, 3, 4 }, (double[3]){ -129, 133, -20 });
}
fn void matrix_mul()
{
	@assert_print(mat4 * mat2, (Matrix2x2){{ 120, 199, 6, -50 }});
	@assert_print(mat6 * mat4, (Matrix3x3){{ 40, 79, -249, -8, 49, -420, -192, -216, 12 }});
	@assert_print(mat8 * mat7, (Matrix4x4){{ 144, 133, 197, 187, -30, 19, 415, -20, -331, -493, 202, -223, 3, -162, 97, 129 }});
	@assert_print(mat9 * mat10, (Matrix1x1){{ 39 }});
	@assert_print(mat10 * mat9, (Matrix3x3){{ 24, -36, 18, -8, 12, -6, 4, -6, 3 }});
}
fn void strassen()
{
	Matrix4x4 result;
	matrix::strassen_mul(&result, &mat8, &mat7);
	@assert_print(result, (Matrix4x4){{ 144, 133, 197, 187, -30, 19, 415, -20, -331, -493, 202, -223, 3, -162, 97, 129 }});
}
fn void determinant()
{
	@assert_print(mat1.determinant(), 8158);
}
fn void minor()
{
	@assert_print(matrix::minor(&mat1, 1, 2), -90);
}
fn void cofactor()
{
	@assert_print(mat1.cofactor(1, 2), 90);
}
fn void comatrix()
{
	Matrix3x3 co;
	co.comatrix_assign(&mat1);
	@assert_print(co, (Matrix3x3){{ -400, 264, -118, -248, 490, 90, 115, 332, -272 }});
}
fn void adjugate_matrix()
{
	Matrix2x2 adj2;
	matrix::adjugate(&adj2, &mat11);
	Matrix3x3 adj3;
	matrix::adjugate(&adj3, &mat1);
	Matrix4x4 adj4;
	matrix::adjugate(&adj4, &mat7);
	@assert_print(adj2, (Matrix2x2){{ -2, -5, -3, 1 }});
	@assert_print(adj3, (Matrix3x3){{ -400, -248, 115, 264, 490, 332, -118, 90, -272 }});
	@assert_print(adj4, (Matrix4x4){{ -2436, 960, -150, 1377, -315, 130, -15, 170, 3816, -1485, 240, -2142, -11934, 4675, -765, 6698 }});
}
fn void trace()
{
	@assert_print(mat1.trace(), -21);
}
fn void swap_col()
{
	Matrix3x3 test_mat = mat1;
	test_mat.swap_col(0, 1);
	@assert_print(test_mat, (Matrix3x3){{ 4, 15, 20, -20, -7, -17, 10, 8, -16 }});
}
fn void swap_row()
{
	Matrix3x3 test_mat = mat1;
	test_mat.swap_row(0, 1);
	@assert_print(test_mat, (Matrix3x3){{ -7, -20, -17, 15, 4, 20, 8, 10, -16 }});
}
fn void lu_decomp()
{
	Matrix3x3 l;
	Matrix3x3 u;
	assert(@ok(mat12.lu_decomp(&l, &u)));
	@assert_print(l * u, mat12);

	assert(@ok(mat13.lu_decomp(&l, &u)));
	@assert_print(l * u, mat13);
}
fn void lu_decomp_pivot()
{
	Matrix3x3 u3;
	Matrix3x3 l3;
	Matrix3x3 p3;
	assert(@ok(mat12.lu_decomp_pivot(&l3, &u3, &p3)));
	Matrix3x3 lu3 = l3 * u3;
	round_matrix(&lu3);
	Matrix3x3 pa3 = p3 * mat12;
	round_matrix(&pa3);
	@assert_print(lu3, pa3);

	Matrix4x4 u4;
	Matrix4x4 l4;
	Matrix4x4 p4;
	assert(@ok(mat7.lu_decomp_pivot(&l4, &u4, &p4)));
	Matrix4x4 lu4 = l4 * u4;
	round_matrix(&lu4);
	Matrix4x4 pa4 = p4 * mat7;
	round_matrix(&pa4);
	@assert_print(lu4, pa4);
}
fn void resize()
{
	Matrix4x4 result4x4;
	Matrix2x2 result2x2;
	Matrix3x3 result3x3;
	Matrix3x1 result3x1;
	matrix::@resize(&mat1, &result4x4, 4,4);
	@assert_print(result4x4, (Matrix4x4){{ -20, -7, -17, 0, 4, 15, 20, 0, 10, 8, -16, 0, 0, 0, 0, 0 }});
	matrix::@resize(&mat1, &result2x2, 2,2);
	@assert_print(result2x2, (Matrix2x2){{ -20, -7, 4, 15 }});
	matrix::@resize(&mat4, &result2x2, 2,2);
	@assert_print(result2x2, (Matrix2x2){{ 8, -8, 7, -11 }});
	matrix::@resize(&mat6, &result3x3, 3,3);
	@assert_print(result3x3, (Matrix3x3){{ -6, -15, -12, -11, -14, 12, 0, 0, 0 }});
	matrix::@resize(&mat3, &result3x1, 3,1);
	@assert_print(result3x1, (Matrix3x1){{ -2, 20, -1 }});

	mem::clear(&result4x4, $typeof(result4x4.val).sizeof);
	matrix::@resize(&mat1, &result4x4, 4,4, col_offset: 1);
	@assert_print(result4x4, (Matrix4x4){{ 0, 0, 0, 0, -20, -7, -17, 0, 4, 15, 20, 0, 10, 8, -16, 0 }});
	mem::clear(&result4x4, $typeof(result4x4.val).sizeof);
	matrix::@resize(&mat1, &result4x4, 4,4, row_offset: 1);
	@assert_print(result4x4, (Matrix4x4){{ 0, -20, -7, -17, 0, 4, 15, 20, 0, 10, 8, -16, 0, 0, 0, 0 }});

	matrix::@resize(&mat1, &result2x2, 2,2, col_offset: 1);
	@assert_print(result2x2, (Matrix2x2){{ 4, 15, 10, 8 }});
	matrix::@resize(&mat1, &result2x2, 2,2, row_offset: 1);
	@assert_print(result2x2, (Matrix2x2){{ -7, -17, 15, 20 }});
}
fn void transpose()
{
	@assert_print(mat1.transposed(), (Matrix3x3){{ -20, 4, 10, -7, 15, 8, -17, 20, -16 }});
	@assert_print(mat4.transposed(), (Matrix3x2){{ 8, 7, 14, -8, -11, 15 }});
	@assert_print(mat6.transposed(), (Matrix2x3){{ -6, -11, -15, -14, -12, 12 }});
	@assert_print(mat7.transposed(), (Matrix4x4){{ -10, -6, -12, -15, 7, -8, -18, 16, -9, -17, 19, -2, -1, -4, 9, 2 }});
}
fn void row_slice()
{
	Matrix2x3 tmp2x3;
	matrix::row_slice(&tmp2x3, &mat1, 0);
	@assert_print(tmp2x3, (Matrix2x3){{ -7, -17, 15, 20, 8, -16 }});
	matrix::row_slice(&tmp2x3, &mat1, 1);
	@assert_print(tmp2x3, (Matrix2x3){{ -20, -17, 4, 20, 10, -16 }});
	matrix::row_slice(&tmp2x3, &mat1, 2);
	@assert_print(tmp2x3, (Matrix2x3){{ -20, -7, 4, 15, 10, 8 }});

	Matrix1x3 tmp1x3;
	matrix::row_slice(&tmp1x3, &mat4, 0);
	@assert_print(tmp1x3, (Matrix1x3){{  -8, -11,  15, }});
	matrix::row_slice(&tmp1x3, &mat4, 1);
	@assert_print(tmp1x3, (Matrix1x3){{   8,   7,  14, }});
}
fn void col_slice()
{
	Matrix3x2 tmp3x2;
	matrix::col_slice(&tmp3x2, &mat1, 0);
	@assert_print(tmp3x2, (Matrix3x2){{   4,  15,  20,  10,   8, -16 }});
	matrix::col_slice(&tmp3x2, &mat1, 1);
	@assert_print(tmp3x2, (Matrix3x2){{ -20,  -7, -17,  10,   8, -16 }});
	matrix::col_slice(&tmp3x2, &mat1, 2);
	@assert_print(tmp3x2, (Matrix3x2){{ -20,  -7, -17,   4,  15,  20 }});

	Matrix2x2 tmp2x2;
	matrix::col_slice(&tmp2x2, &mat4, 0);
	@assert_print(tmp2x2, (Matrix2x2){{   7, -11,  14,  15, }});
	matrix::col_slice(&tmp2x2, &mat4, 1);
	@assert_print(tmp2x2, (Matrix2x2){{   8,  -8,  14,  15, }});
	matrix::col_slice(&tmp2x2, &mat4, 2);
	@assert_print(tmp2x2, (Matrix2x2){{   8,  -8,   7, -11, }});
}
fn void identity()
{
	@assert_print(matrix::@identity(1), (Matrix1x1){{ 1 }});
	@assert_print(matrix::@identity(2), (Matrix2x2){{ 1, 0, 0, 1 }});
	@assert_print(matrix::@identity(3), (Matrix3x3){{ 1, 0, 0, 0, 1, 0, 0, 0, 1 }});
}
fn void identity_assign()
{
	Matrix1x1 t1;
	matrix::identity_assign(&t1);
	@assert_print(t1, (Matrix1x1){{ 1 }});
	Matrix2x2 t2;
	matrix::identity_assign(&t2);
	@assert_print(t2, (Matrix2x2){{ 1, 0, 0, 1 }});
	Matrix3x3 t3;
	matrix::identity_assign(&t3);
	@assert_print(t3, (Matrix3x3){{ 1, 0, 0, 0, 1, 0, 0, 0, 1 }});
}
fn void inverted()
{
	// round up source and result matrices to nearest 1000th to
	// mitigate floating point precision problems
	Matrix3x3 source;
	matrix::inverse(&source, &mat5)!!;
	round_matrix(&source);
	Matrix3x3 result = {{
		-1.0/7.0, -1.0, 4.0/7.0, 13.0/49.0, 4.0/7.0, -17.0/49.0, -1.0/49.0, 4.0/7.0, -10.0/49.0
	}};
	round_matrix(&result);
	@assert_print(source, result);
}

<*
 @param [&inout] mat
 *>
macro round_matrix(mat, nearest = 1000.0) =>
	mat.val = ((double[<mat.cols() * mat.rows()>])mat.val * nearest).round() / nearest;
