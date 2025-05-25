module c3math::tests::matrices @test;
import c3math::matrix;

fn void mul_ops()
{
	@assert_print((Matrix1x1){{ 2 }} * (Matrix1x1){{ 3 }},
		(Matrix1x1){{ 2 }}.mul((Matrix1x1){{ 3 }}),
		"1x1 mul_op not equal",
	);
	@assert_print(mat2x2_1 * mat2x2_2,
		mat2x2_1.mul(mat2x2_2),
		"2x2 mul_op not equal",
	);
	@assert_print(mat2x3 * mat3x2,
		mat2x3.mul(mat3x2),
		"2x3,3x2 mul_op not equal",
	);
	@assert_print(mat3x3_1 * mat3x3_2,
		mat3x3_1.mul(mat3x3_2),
		"3x3 mul_op not equal",
	);
	@assert_print(mat3x2 * mat2x3,
		mat3x2.mul(mat2x3),
		"3x2,2x3 mul_op not equal",
	);
	@assert_print(mat4x4_1 * mat4x4_2,
		mat4x4_1.mul(mat4x4_2),
		"4x4 mul_op not equal",
	);
}
fn void mul_assign_ops()
{
	Matrix1x1 m1 = (Matrix1x1){{ 2 }};
	m1 *= (Matrix1x1){{ 3 }};
	@assert_print(m1,
		(Matrix1x1){{ 2 }}.mul((Matrix1x1){{ 3 }}),
		"1x1 mul_assign_op not equal",
	);
	Matrix2x2 m2 = mat2x2_1;
	m2 *= mat2x2_2;
	@assert_print(m2,
		mat2x2_1.mul(mat2x2_2),
		"2x2 mul_assign_op not equal",
	);
	Matrix3x3 m3 = mat3x3_1;
	m3 *= mat3x3_2;
	@assert_print(m3,
		mat3x3_1.mul(mat3x3_2),
		"3x3 mul_assign_op not equal",
	);
	Matrix4x4 m4 = mat4x4_1;
	m4 *= mat4x4_2;
	@assert_print(m4,
		mat4x4_1.mul(mat4x4_2),
		"4x4 mul_assign_op not equal",
	);
}
fn void transposed()
{
	@assert_print((Matrix1x1){{ 2 }}.transposed(),
		(Matrix1x1){{ 2 }},
		"1x1 transposed not equal",
	);
	@assert_print(mat2x2_1.transposed(),
		(Matrix2x2){{ 1, -3, 4, 3 }},
		"2x2 transposed not equal",
	);
	@assert_print(mat3x3_1.transposed(),
		(Matrix3x3){{ 1, 3, -2, 2, -2, 4, -1, 1, 5 }},
		"3x3 transposed not equal",
	);
	@assert_print(mat4x4_1.transposed(),
		(Matrix4x4){{ 0, 9, 2, -7, 3, -3, 2, 7, 4, -5, 8, 5, 1, 2, -8, 4 }},
		"4x4 transposed not equal",
	);
}

fn void mul_inline_ops()
{
	@assert_print((Matrix1x1){{ 2 }} * (Matrix1x1){{ 3 }},
		(Matrix1x1){{ 2 }}.mul_inline((Matrix1x1){{ 3 }}),
		"1x1 mul_inline_op not equal",
	);
	@assert_print(mat2x2_1 * mat2x2_2,
		mat2x2_1.mul_inline(mat2x2_2),
		"2x2 mul_inline_op not equal",
	);
	@assert_print(mat2x3 * mat3x2,
		mat2x3.mul_inline(mat3x2),
		"2x3,3x2 mul_inline_op not equal",
	);
	@assert_print(mat3x3_1 * mat3x3_2,
		mat3x3_1.mul_inline(mat3x3_2),
		"3x3 mul_inline_op not equal",
	);
	@assert_print(mat3x2 * mat2x3,
		mat3x2.mul_inline(mat2x3),
		"3x2,2x3 mul_inline_op not equal",
	);
	@assert_print(mat4x4_1 * mat4x4_2,
		mat4x4_1.mul_inline(mat4x4_2),
		"4x4 mul_inline_op not equal",
	);
}
fn void mul_inline_assign_ops()
{
	Matrix1x1 m1 = (Matrix1x1){{ 2 }};
	m1 *= (Matrix1x1){{ 3 }};
	@assert_print(m1,
		(Matrix1x1){{ 2 }}.mul_inline((Matrix1x1){{ 3 }}),
		"1x1 mul_inline_assign_op not equal",
	);
	Matrix2x2 m2 = mat2x2_1;
	m2 *= mat2x2_2;
	@assert_print(m2,
		mat2x2_1.mul_inline(mat2x2_2),
		"2x2 mul_inline_assign_op not equal",
	);
	Matrix3x3 m3 = mat3x3_1;
	m3 *= mat3x3_2;
	@assert_print(m3,
		mat3x3_1.mul_inline(mat3x3_2),
		"3x3 mul_inline_assign_op not equal",
	);
	Matrix4x4 m4 = mat4x4_1;
	m4 *= mat4x4_2;
	@assert_print(m4,
		mat4x4_1.mul_inline(mat4x4_2),
		"4x4 mul_inline_assign_op not equal",
	);
}
fn void transposed_inline()
{
	@assert_print((Matrix1x1){{ 2 }}.transposed_inline(),
		(Matrix1x1){{ 2 }},
		"1x1 transposed_inline not equal",
	);
	@assert_print(mat2x2_1.transposed_inline(),
		(Matrix2x2){{ 1, -3, 4, 3 }},
		"2x2 transposed_inline not equal",
	);
	@assert_print(mat3x3_1.transposed_inline(),
		(Matrix3x3){{ 1, 3, -2, 2, -2, 4, -1, 1, 5 }},
		"3x3 transposed_inline not equal",
	);
	@assert_print(mat4x4_1.transposed_inline(),
		(Matrix4x4){{ 0, 9, 2, -7, 3, -3, 2, 7, 4, -5, 8, 5, 1, 2, -8, 4 }},
		"4x4 transposed_inline not equal",
	);
}
