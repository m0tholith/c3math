module c3math::tests::matrices @test;
import c3math::matrix;
import c3math::matrix::mat_type;
import std::math;

fn void format()
	=> @assert_print(
		string::tformat("%s", mat2x2_1),
		"[[1.000000, 4.000000], [-3.000000, 3.000000]]",
	);
fn void cols() => @assert_print((Matrix3x2){{}}.cols(), 2);
fn void rows() => @assert_print((Matrix3x2){{}}.rows(), 3);
fn void type() => @assert_print((Matrix{1,1, short}){{}}.type(), short.typeid);
fn void add_inline()
{
	@assert_print(mat2x2_1.add_inline(mat2x2_2),
		(Matrix2x2){{ -1, 6, -3, 4 }},
		"2x2 add_inline not equal",
	);
	@assert_print(mat3x3_1.add_inline(mat3x3_2),
		(Matrix3x3){{ 4, 6, -3, -2, -1, 2, 4, 12, 7 }},
		"3x3 add_inline not equal",
	);
	@assert_print(mat4x4_1.add_inline(mat4x4_2),
		(Matrix4x4){{ -1, 13, -1, 10,  21, 2, -3, -2, 2, 6, -4, -16, -13, 10, -4, -6 }},
		"4x4 add_inline not equal",
	);
	@assert_print(mat8x8_1.add_inline(mat8x8_2),
		(Matrix8x8){{ 128, -6, 114, -172, 23, -81, -69, 39, 74, 49, -44, -42, 22, 82, -99, -67, 109, -169, -72, -70, -107, 96, -1, -40, 9, 80, -7, 21, 66, -78, -102, 94, -76, 45, -111, 87, 62, 10, 95, 85, 67, 51, 75, 109, -151, 109, -83, 84, -108, -64, 123, -131, -37, -155, -35, -22, 37, 8, -54, 56, 54, -12, -153, 116 }},
		"8x8 add_inline not equal",
	);
}
fn void add()
{
	@assert_print(mat2x2_1.add(mat2x2_2),
		(Matrix2x2){{ -1, 6, -3, 4 }},
		"2x2 add not equal",
	);
	@assert_print(mat3x3_1.add(mat3x3_2),
		(Matrix3x3){{ 4, 6, -3, -2, -1, 2, 4, 12, 7 }},
		"3x3 add not equal",
	);
	@assert_print(mat4x4_1.add(mat4x4_2),
		(Matrix4x4){{ -1, 13, -1, 10,  21, 2, -3, -2, 2, 6, -4, -16, -13, 10, -4, -6 }},
		"4x4 add not equal",
	);
	@assert_print(mat8x8_1.add(mat8x8_2),
		(Matrix8x8){{ 128, -6, 114, -172, 23, -81, -69, 39, 74, 49, -44, -42, 22, 82, -99, -67, 109, -169, -72, -70, -107, 96, -1, -40, 9, 80, -7, 21, 66, -78, -102, 94, -76, 45, -111, 87, 62, 10, 95, 85, 67, 51, 75, 109, -151, 109, -83, 84, -108, -64, 123, -131, -37, -155, -35, -22, 37, 8, -54, 56, 54, -12, -153, 116 }},
		"8x8 add not equal",
	);
}
fn void add_assign_inline()
{
	Matrix2x2 m2 = mat2x2_1;
	m2.add_assign_inline(mat2x2_2);
	@assert_print(m2,
		(Matrix2x2){{ -1, 6, -3, 4 }},
		"2x2 add_assign_inline not equal",
	);

	Matrix3x3 m3 = mat3x3_1;
	m3.add_assign_inline(mat3x3_2);
	@assert_print(m3,
		(Matrix3x3){{ 4, 6, -3, -2, -1, 2, 4, 12, 7 }},
		"3x3 add_assign_inline not equal",
	);

	Matrix4x4 m4 = mat4x4_1;
	m4.add_assign_inline(mat4x4_2);
	@assert_print(m4,
		(Matrix4x4){{ -1, 13, -1, 10,  21, 2, -3, -2, 2, 6, -4, -16, -13, 10, -4, -6 }},
		"4x4 add_assign_inline not equal",
	);

	Matrix8x8 m8 = mat8x8_1;
	m8.add_assign_inline(mat8x8_2);
	@assert_print(m8,
		(Matrix8x8){{ 128, -6, 114, -172, 23, -81, -69, 39, 74, 49, -44, -42, 22, 82, -99, -67, 109, -169, -72, -70, -107, 96, -1, -40, 9, 80, -7, 21, 66, -78, -102, 94, -76, 45, -111, 87, 62, 10, 95, 85, 67, 51, 75, 109, -151, 109, -83, 84, -108, -64, 123, -131, -37, -155, -35, -22, 37, 8, -54, 56, 54, -12, -153, 116 }},
		"8x8 add_assign_inline not equal",
	);
}
fn void add_assign()
{
	Matrix2x2 m2 = mat2x2_1;
	m2.add_assign(mat2x2_2);
	@assert_print(m2,
		(Matrix2x2){{ -1, 6, -3, 4 }},
		"2x2 add_assign not equal",
	);

	Matrix3x3 m3 = mat3x3_1;
	m3.add_assign(mat3x3_2);
	@assert_print(m3,
		(Matrix3x3){{ 4, 6, -3, -2, -1, 2, 4, 12, 7 }},
		"3x3 add_assign not equal",
	);

	Matrix4x4 m4 = mat4x4_1;
	m4.add_assign(mat4x4_2);
	@assert_print(m4,
		(Matrix4x4){{ -1, 13, -1, 10,  21, 2, -3, -2, 2, 6, -4, -16, -13, 10, -4, -6 }},
		"4x4 add_assign not equal",
	);

	Matrix8x8 m8 = mat8x8_1;
	m8.add_assign(mat8x8_2);
	@assert_print(m8,
		(Matrix8x8){{ 128, -6, 114, -172, 23, -81, -69, 39, 74, 49, -44, -42, 22, 82, -99, -67, 109, -169, -72, -70, -107, 96, -1, -40, 9, 80, -7, 21, 66, -78, -102, 94, -76, 45, -111, 87, 62, 10, 95, 85, 67, 51, 75, 109, -151, 109, -83, 84, -108, -64, 123, -131, -37, -155, -35, -22, 37, 8, -54, 56, 54, -12, -153, 116 }},
		"8x8 add_assign not equal",
	);
}
fn void sub_inline()
{
	@assert_print(mat2x2_1.sub_inline(mat2x2_2),
		(Matrix2x2){{ 3, 2, -3, 2 }},
		"2x2 sub_inline not equal",
	);
	@assert_print(mat3x3_1.sub_inline(mat3x3_2),
		(Matrix3x3){{ -2, -2, 1, 8, -3, 0, -8, -4, 3 }},
		"3x3 sub_inline not equal",
	);
	@assert_print(mat4x4_1.sub_inline(mat4x4_2),
		(Matrix4x4){{ 1, -7, 9, -8, -3, -8, -7, 6, 2, -2, 20, 0, -1, 4, 14, 14 }},
		"4x4 sub_inline not equal",
	);
	@assert_print(mat8x8_1.sub_inline(mat8x8_2),
		(Matrix8x8){{ -70, -158, -8, 4, -135, -115, 123, 155, 112, 119, 74, 56, 0, 56, 65, 41, 19, 13, -118, 50, -85, 100, -117, -56, 163, -64, 119, 131, 28, -92, -86, -30, -100, -85, -47, 101, 130, 148, -59, -25, 59, 81, 81, 15, 7, -37, -23, 78, 78, 8, -27, -43, -55, 17, 121, 120, -91, 174, 32, -134, -50, -12, 21, 14 }},
		"8x8 sub_inline not equal",
	);
}
fn void sub()
{
	@assert_print(mat2x2_1.sub(mat2x2_2),
		(Matrix2x2){{ 3, 2, -3, 2 }},
		"2x2 sub not equal",
	);
	@assert_print(mat3x3_1.sub(mat3x3_2),
		(Matrix3x3){{ -2, -2, 1, 8, -3, 0, -8, -4, 3 }},
		"3x3 sub not equal",
	);
	@assert_print(mat4x4_1.sub(mat4x4_2),
		(Matrix4x4){{ 1, -7, 9, -8, -3, -8, -7, 6, 2, -2, 20, 0, -1, 4, 14, 14 }},
		"4x4 sub not equal",
	);
	@assert_print(mat8x8_1.sub(mat8x8_2),
		(Matrix8x8){{ -70, -158, -8, 4, -135, -115, 123, 155, 112, 119, 74, 56, 0, 56, 65, 41, 19, 13, -118, 50, -85, 100, -117, -56, 163, -64, 119, 131, 28, -92, -86, -30, -100, -85, -47, 101, 130, 148, -59, -25, 59, 81, 81, 15, 7, -37, -23, 78, 78, 8, -27, -43, -55, 17, 121, 120, -91, 174, 32, -134, -50, -12, 21, 14 }},
		"8x8 sub not equal",
	);
}
fn void sub_assign_inline()
{
	Matrix2x2 m2 = mat2x2_1;
	m2.sub_assign_inline(mat2x2_2);
	@assert_print(m2,
		(Matrix2x2){{ 3, 2, -3, 2 }},
		"2x2 sub_assign_inline not equal",
	);

	Matrix3x3 m3 = mat3x3_1;
	m3.sub_assign_inline(mat3x3_2);
	@assert_print(m3,
		(Matrix3x3){{ -2, -2, 1, 8, -3, 0, -8, -4, 3 }},
		"3x3 sub_assign_inline not equal",
	);

	Matrix4x4 m4 = mat4x4_1;
	m4.sub_assign_inline(mat4x4_2);
	@assert_print(m4,
		(Matrix4x4){{ 1, -7, 9, -8, -3, -8, -7, 6, 2, -2, 20, 0, -1, 4, 14, 14 }},
		"4x4 sub_assign_inline not equal",
	);

	Matrix8x8 m8 = mat8x8_1;
	m8.sub_assign_inline(mat8x8_2);
	@assert_print(m8,
		(Matrix8x8){{ -70, -158, -8, 4, -135, -115, 123, 155, 112, 119, 74, 56, 0, 56, 65, 41, 19, 13, -118, 50, -85, 100, -117, -56, 163, -64, 119, 131, 28, -92, -86, -30, -100, -85, -47, 101, 130, 148, -59, -25, 59, 81, 81, 15, 7, -37, -23, 78, 78, 8, -27, -43, -55, 17, 121, 120, -91, 174, 32, -134, -50, -12, 21, 14 }},
		"8x8 sub_assign_inline not equal",
	);
}
fn void sub_assign()
{
	Matrix2x2 m2 = mat2x2_1;
	m2.sub_assign(mat2x2_2);
	@assert_print(m2,
		(Matrix2x2){{ 3, 2, -3, 2 }},
		"2x2 sub_assign not equal",
	);

	Matrix3x3 m3 = mat3x3_1;
	m3.sub_assign(mat3x3_2);
	@assert_print(m3,
		(Matrix3x3){{ -2, -2, 1, 8, -3, 0, -8, -4, 3 }},
		"3x3 sub_assign not equal",
	);

	Matrix4x4 m4 = mat4x4_1;
	m4.sub_assign(mat4x4_2);
	@assert_print(m4,
		(Matrix4x4){{ 1, -7, 9, -8, -3, -8, -7, 6, 2, -2, 20, 0, -1, 4, 14, 14 }},
		"4x4 sub_assign not equal",
	);

	Matrix8x8 m8 = mat8x8_1;
	m8.sub_assign(mat8x8_2);
	@assert_print(m8,
		(Matrix8x8){{ -70, -158, -8, 4, -135, -115, 123, 155, 112, 119, 74, 56, 0, 56, 65, 41, 19, 13, -118, 50, -85, 100, -117, -56, 163, -64, 119, 131, 28, -92, -86, -30, -100, -85, -47, 101, 130, 148, -59, -25, 59, 81, 81, 15, 7, -37, -23, 78, 78, 8, -27, -43, -55, 17, 121, 120, -91, 174, 32, -134, -50, -12, 21, 14 }},
		"8x8 sub_assign not equal",
	);
}
fn void negate_inline()
{
	@assert_print(mat2x2_1.negate_inline(),
		(Matrix2x2){{ -1, -4, 3, -3 }},
		"2x2 negate_inline not equal",
	);
	@assert_print(mat2x3.negate_inline(),
		(Matrix2x3){{ -4, 0, 1, -4, 10, -7 }},
		"2x3 negate_inline not equal",
	);
	@assert_print(mat3x3_1.negate_inline(),
		(Matrix3x3){{ -1, -2, 1, -3, 2, -1, 2, -4, -5 }},
		"3x3 negate_inline not equal",
	);
	@assert_print(mat3x2.negate_inline(),
		(Matrix3x2){{ -1, 3, 3, -2, -5, -8 }},
		"3x2 negate_inline not equal",
	);
	@assert_print(mat4x4_1.negate_inline(),
		(Matrix4x4){{ 0, -3, -4, -1, -9, 3, 5, -2, -2, -2, -8, 8, 7, -7, -5, -4 }},
		"4x4 negate_inline not equal",
	);
	@assert_print(mat8x8_1.negate_inline(),
		(Matrix8x8){{ -29, 82, -53, 84, 56, 98, -27, -97, -93, -84, -15, -7, -11, -69, 17, 13, -64, 78, 95, 10, 96, -98, 59, 48, -86, -8, -56, -76, -47, 85, 94, -32, 88, 20, 79, -94, -96, -79, -18, -30, -63, -66, -78, -62, 72, -36, 53, -81, 15, 28, -48, 87, 46, 69, -43, -49, 27, -91, 11, 39, -2, 12, 66, -65 }},
		"8x8 negate_inline not equal",
	);
}
fn void negate()
{
	@assert_print(mat2x2_1.negate(),
		(Matrix2x2){{ -1, -4, 3, -3 }},
		"2x2 negate not equal",
	);
	@assert_print(mat2x3.negate(),
		(Matrix2x3){{ -4, 0, 1, -4, 10, -7 }},
		"2x3 negate not equal",
	);
	@assert_print(mat3x3_1.negate(),
		(Matrix3x3){{ -1, -2, 1, -3, 2, -1, 2, -4, -5 }},
		"3x3 negate not equal",
	);
	@assert_print(mat3x2.negate(),
		(Matrix3x2){{ -1, 3, 3, -2, -5, -8 }},
		"3x2 negate not equal",
	);
	@assert_print(mat4x4_1.negate(),
		(Matrix4x4){{ 0, -3, -4, -1, -9, 3, 5, -2, -2, -2, -8, 8, 7, -7, -5, -4 }},
		"4x4 negate not equal",
	);
	@assert_print(mat8x8_1.negate(),
		(Matrix8x8){{ -29, 82, -53, 84, 56, 98, -27, -97, -93, -84, -15, -7, -11, -69, 17, 13, -64, 78, 95, 10, 96, -98, 59, 48, -86, -8, -56, -76, -47, 85, 94, -32, 88, 20, 79, -94, -96, -79, -18, -30, -63, -66, -78, -62, 72, -36, 53, -81, 15, 28, -48, 87, 46, 69, -43, -49, 27, -91, 11, 39, -2, 12, 66, -65 }},
		"8x8 negate not equal",
	);
}
fn void mul()
{
	@assert_print(mat2x2_1.mul(mat2x2_2),
		(Matrix2x2){{ -8, -2, -3, 3 }},
		"2x2 mul not equal",
	);
	@assert_print(mat2x3.mul(mat3x2),
		(Matrix2x2){{ 37, -33, -77, 76 }},
		"2x3 mul 3x2 not equal",
	);
	@assert_print(mat3x3_1.mul(mat3x3_2),
		(Matrix3x3){{ 19, -10, -9, -4, -8, 11, 26, 4, 12 }},
		"3x3 mul not equal",
	);
	@assert_print(mat3x2.mul(mat2x3),
		(Matrix3x3){{ 4, -12, -12, 7, 23, 35, 4, 65, 86 }},
		"3x2 mul 2x3 not equal",
	);
	@assert_print(mat4x4_1.mul(mat4x4_2),
		(Matrix4x4){{ 17, 20, -49, 95, 77, -3, 19, -10, 68, -92, -156, 72, 79, -115, -161, 32 }},
		"4x4 mul not equal",
	);
}
fn void mul_inline()
{
	@assert_print(mat2x2_1.mul_inline(mat2x2_2),
		(Matrix2x2){{ -8, -2, -3, 3 }},
		"2x2 mul_inline not equal",
	);
}
fn void mul_assign()
{
	Matrix2x2 m2 = mat2x2_1;
	m2.mul_assign(mat2x2_2);
	@assert_print(m2,
		(Matrix2x2){{ -8, -2, -3, 3 }},
		"2x2 mul_assign not equal",
	);

	Matrix3x3 m3 = mat3x3_1;
	m3.mul_assign(mat3x3_2);
	@assert_print(m3,
		(Matrix3x3){{ 19, -10, -9, -4, -8, 11, 26, 4, 12 }},
		"3x3 mul_assign not equal",
	);

	Matrix4x4 m4 = mat4x4_1;
	m4.mul_assign(mat4x4_2);
	@assert_print(m4,
		(Matrix4x4){{ 17, 20, -49, 95, 77, -3, 19, -10, 68, -92, -156, 72, 79, -115, -161, 32 }},
		"4x4 mul_assign not equal",
	);

	Matrix8x8 m8 = mat8x8_1;
	matrix::mul_assign(&m8, &mat8x8_1, &mat8x8_2);
	@assert_print(m8,
		(Matrix8x8){{ 3400, -10244, -13221, 4012, -4040, 23173, 6275, -1856, -9257, 848, -1868, 9297, 7824, 5473, 7716, -6269, -11090, -14416, -1116, -15723, -12113, -8374, 8919, 5394, -7084, 22784, -2117, 3920, 10379, 12576, 1119, -2366, -252, 5891, 4654, -17083, 1058, -10375, 4491, 2370, 14491, 6533, 13366, 2754, -9346, -7295, -10657, 4499, -8152, -11733, -25440, 8535, 6046, 21569, 3864, -28694, -5093, -2069, 2707, 12161, 13192, -14789, -9425, 13003 }},
		"8x8 mul_assign not equal",
	);
}
fn void mul_scalar_inline()
{
	@assert_print(mat2x2_1.mul_scalar_inline(2),
		(Matrix2x2){{ 2, 8, -6, 6 }},
		"2x2 mul_scalar_inline not equal",
	);
	@assert_print(mat2x3.mul_scalar_inline(2),
		(Matrix2x3){{ 8, 0, -2, 8, -20, 14 }},
		"2x3 mul_scalar_inline not equal",
	);
	@assert_print(mat3x3_1.mul_scalar_inline(2),
		(Matrix3x3){{ 2, 4, -2, 6, -4, 2, -4, 8, 10 }},
		"3x3 mul_scalar_inline not equal",
	);
	@assert_print(mat3x2.mul_scalar_inline(2),
		(Matrix3x2){{ 2, -6, -6, 4, 10, 16 }},
		"3x2 mul_scalar_inline not equal",
	);
	@assert_print(mat4x4_1.mul_scalar_inline(2),
		(Matrix4x4){{ 0, 6, 8, 2, 18, -6, -10, 4, 4, 4, 16, -16, -14, 14, 10, 8 }},
		"4x4 mul_scalar_inline not equal",
	);
	@assert_print(mat8x8_1.mul_scalar_inline(2),
		(Matrix8x8){{ 58, -164, 106, -168, -112, -196, 54, 194, 186, 168, 30, 14, 22, 138, -34, -26, 128, -156, -190, -20, -192, 196, -118, -96, 172, 16, 112, 152, 94, -170, -188, 64, -176, -40, -158, 188, 192, 158, 36, 60, 126, 132, 156, 124, -144, 72, -106, 162, -30, -56, 96, -174, -92, -138, 86, 98, -54, 182, -22, -78, 4, -24, -132, 130 }},
		"8x8 mul_scalar_inline not equal",
	);
}
fn void mul_scalar()
{
	@assert_print(mat2x2_1.mul_scalar(2),
		(Matrix2x2){{ 2, 8, -6, 6 }},
		"2x2 mul_scalar not equal",
	);
	@assert_print(mat2x3.mul_scalar(2),
		(Matrix2x3){{ 8, 0, -2, 8, -20, 14 }},
		"2x3 mul_scalar not equal",
	);
	@assert_print(mat3x3_1.mul_scalar(2),
		(Matrix3x3){{ 2, 4, -2, 6, -4, 2, -4, 8, 10 }},
		"3x3 mul_scalar not equal",
	);
	@assert_print(mat3x2.mul_scalar(2),
		(Matrix3x2){{ 2, -6, -6, 4, 10, 16 }},
		"3x2 mul_scalar not equal",
	);
	@assert_print(mat4x4_1.mul_scalar(2),
		(Matrix4x4){{ 0, 6, 8, 2, 18, -6, -10, 4, 4, 4, 16, -16, -14, 14, 10, 8 }},
		"4x4 mul_scalar not equal",
	);
	@assert_print(mat8x8_1.mul_scalar(2),
		(Matrix8x8){{ 58, -164, 106, -168, -112, -196, 54, 194, 186, 168, 30, 14, 22, 138, -34, -26, 128, -156, -190, -20, -192, 196, -118, -96, 172, 16, 112, 152, 94, -170, -188, 64, -176, -40, -158, 188, 192, 158, 36, 60, 126, 132, 156, 124, -144, 72, -106, 162, -30, -56, 96, -174, -92, -138, 86, 98, -54, 182, -22, -78, 4, -24, -132, 130 }},
		"8x8 mul_scalar not equal",
	);
}
fn void mul_scalar_assign_inline()
{
	Matrix2x2 m2 = mat2x2_1;
	m2.mul_scalar_assign_inline(2);
	@assert_print(m2,
		(Matrix2x2){{ 2, 8, -6, 6 }},
		"2x2 mul_scalar_assign_inline not equal",
	);
	Matrix2x3 m2x3 = mat2x3;
	m2x3.mul_scalar_assign_inline(2);
	@assert_print(m2x3,
		(Matrix2x3){{ 8, 0, -2, 8, -20, 14 }},
		"2x3 mul_scalar_assign_inline not equal",
	);
	Matrix3x3 m3 = mat3x3_1;
	m3.mul_scalar_assign_inline(2);
	@assert_print(m3,
		(Matrix3x3){{ 2, 4, -2, 6, -4, 2, -4, 8, 10 }},
		"3x3 mul_scalar_assign_inline not equal",
	);
	Matrix3x2 m3x2 = mat3x2;
	m3x2.mul_scalar_assign_inline(2);
	@assert_print(m3x2,
		(Matrix3x2){{ 2, -6, -6, 4, 10, 16 }},
		"3x2 mul_scalar_assign_inline not equal",
	);
	Matrix4x4 m4 = mat4x4_1;
	m4.mul_scalar_assign_inline(2);
	@assert_print(m4,
		(Matrix4x4){{ 0, 6, 8, 2, 18, -6, -10, 4, 4, 4, 16, -16, -14, 14, 10, 8 }},
		"4x4 mul_scalar_assign_inline not equal",
	);
	Matrix8x8 m8 = mat8x8_1;
	m8.mul_scalar_assign_inline(2);
	@assert_print(m8,
		(Matrix8x8){{ 58, -164, 106, -168, -112, -196, 54, 194, 186, 168, 30, 14, 22, 138, -34, -26, 128, -156, -190, -20, -192, 196, -118, -96, 172, 16, 112, 152, 94, -170, -188, 64, -176, -40, -158, 188, 192, 158, 36, 60, 126, 132, 156, 124, -144, 72, -106, 162, -30, -56, 96, -174, -92, -138, 86, 98, -54, 182, -22, -78, 4, -24, -132, 130 }},
		"8x8 mul_scalar_assign_inline not equal",
	);
}
fn void mul_scalar_assign()
{
	Matrix2x2 m2 = mat2x2_1;
	m2.mul_scalar_assign(2);
	@assert_print(m2,
		(Matrix2x2){{ 2, 8, -6, 6 }},
		"2x2 mul_scalar_assign not equal",
	);
	Matrix2x3 m2x3 = mat2x3;
	m2x3.mul_scalar_assign(2);
	@assert_print(m2x3,
		(Matrix2x3){{ 8, 0, -2, 8, -20, 14 }},
		"2x3 mul_scalar_assign not equal",
	);
	Matrix3x3 m3 = mat3x3_1;
	m3.mul_scalar_assign(2);
	@assert_print(m3,
		(Matrix3x3){{ 2, 4, -2, 6, -4, 2, -4, 8, 10 }},
		"3x3 mul_scalar_assign not equal",
	);
	Matrix3x2 m3x2 = mat3x2;
	m3x2.mul_scalar_assign(2);
	@assert_print(m3x2,
		(Matrix3x2){{ 2, -6, -6, 4, 10, 16 }},
		"3x2 mul_scalar_assign not equal",
	);
	Matrix4x4 m4 = mat4x4_1;
	m4.mul_scalar_assign(2);
	@assert_print(m4,
		(Matrix4x4){{ 0, 6, 8, 2, 18, -6, -10, 4, 4, 4, 16, -16, -14, 14, 10, 8 }},
		"4x4 mul_scalar_assign not equal",
	);
	Matrix8x8 m8 = mat8x8_1;
	m8.mul_scalar_assign(2);
	@assert_print(m8,
		(Matrix8x8){{ 58, -164, 106, -168, -112, -196, 54, 194, 186, 168, 30, 14, 22, 138, -34, -26, 128, -156, -190, -20, -192, 196, -118, -96, 172, 16, 112, 152, 94, -170, -188, 64, -176, -40, -158, 188, 192, 158, 36, 60, 126, 132, 156, 124, -144, 72, -106, 162, -30, -56, 96, -174, -92, -138, 86, 98, -54, 182, -22, -78, 4, -24, -132, 130 }},
		"8x8 mul_scalar_assign not equal",
	);
}
fn void div_scalar_inline()
{
	@assert_print(mat2x2_1.div_scalar_inline(0.5),
		(Matrix2x2){{ 2, 8, -6, 6 }},
		"2x2 div_scalar_inline not equal",
	);
	@assert_print(mat2x3.div_scalar_inline(0.5),
		(Matrix2x3){{ 8, 0, -2, 8, -20, 14 }},
		"2x3 div_scalar_inline not equal",
	);
	@assert_print(mat3x3_1.div_scalar_inline(0.5),
		(Matrix3x3){{ 2, 4, -2, 6, -4, 2, -4, 8, 10 }},
		"3x3 div_scalar_inline not equal",
	);
	@assert_print(mat3x2.div_scalar_inline(0.5),
		(Matrix3x2){{ 2, -6, -6, 4, 10, 16 }},
		"3x2 div_scalar_inline not equal",
	);
	@assert_print(mat4x4_1.div_scalar_inline(0.5),
		(Matrix4x4){{ 0, 6, 8, 2, 18, -6, -10, 4, 4, 4, 16, -16, -14, 14, 10, 8 }},
		"4x4 div_scalar_inline not equal",
	);
	@assert_print(mat8x8_1.div_scalar_inline(0.5),
		(Matrix8x8){{ 58, -164, 106, -168, -112, -196, 54, 194, 186, 168, 30, 14, 22, 138, -34, -26, 128, -156, -190, -20, -192, 196, -118, -96, 172, 16, 112, 152, 94, -170, -188, 64, -176, -40, -158, 188, 192, 158, 36, 60, 126, 132, 156, 124, -144, 72, -106, 162, -30, -56, 96, -174, -92, -138, 86, 98, -54, 182, -22, -78, 4, -24, -132, 130 }},
		"8x8 div_scalar_inline not equal",
	);
}
fn void div_scalar()
{
	@assert_print(mat2x2_1.div_scalar(0.5),
		(Matrix2x2){{ 2, 8, -6, 6 }},
		"2x2 div_scalar not equal",
	);
	@assert_print(mat2x3.div_scalar(0.5),
		(Matrix2x3){{ 8, 0, -2, 8, -20, 14 }},
		"2x3 div_scalar not equal",
	);
	@assert_print(mat3x3_1.div_scalar(0.5),
		(Matrix3x3){{ 2, 4, -2, 6, -4, 2, -4, 8, 10 }},
		"3x3 div_scalar not equal",
	);
	@assert_print(mat3x2.div_scalar(0.5),
		(Matrix3x2){{ 2, -6, -6, 4, 10, 16 }},
		"3x2 div_scalar not equal",
	);
	@assert_print(mat4x4_1.div_scalar(0.5),
		(Matrix4x4){{ 0, 6, 8, 2, 18, -6, -10, 4, 4, 4, 16, -16, -14, 14, 10, 8 }},
		"4x4 div_scalar not equal",
	);
	@assert_print(mat8x8_1.div_scalar(0.5),
		(Matrix8x8){{ 58, -164, 106, -168, -112, -196, 54, 194, 186, 168, 30, 14, 22, 138, -34, -26, 128, -156, -190, -20, -192, 196, -118, -96, 172, 16, 112, 152, 94, -170, -188, 64, -176, -40, -158, 188, 192, 158, 36, 60, 126, 132, 156, 124, -144, 72, -106, 162, -30, -56, 96, -174, -92, -138, 86, 98, -54, 182, -22, -78, 4, -24, -132, 130 }},
		"8x8 div_scalar not equal",
	);
}
fn void div_scalar_assign_inline()
{
	Matrix2x2 m2 = mat2x2_1;
	m2.div_scalar_assign_inline(0.5);
	@assert_print(m2,
		(Matrix2x2){{ 2, 8, -6, 6 }},
		"2x2 div_scalar_assign_inline not equal",
	);
	Matrix2x3 m2x3 = mat2x3;
	m2x3.div_scalar_assign_inline(0.5);
	@assert_print(m2x3,
		(Matrix2x3){{ 8, 0, -2, 8, -20, 14 }},
		"2x3 div_scalar_assign_inline not equal",
	);
	Matrix3x3 m3 = mat3x3_1;
	m3.div_scalar_assign_inline(0.5);
	@assert_print(m3,
		(Matrix3x3){{ 2, 4, -2, 6, -4, 2, -4, 8, 10 }},
		"3x3 div_scalar_assign_inline not equal",
	);
	Matrix3x2 m3x2 = mat3x2;
	m3x2.div_scalar_assign_inline(0.5);
	@assert_print(m3x2,
		(Matrix3x2){{ 2, -6, -6, 4, 10, 16 }},
		"3x2 div_scalar_assign_inline not equal",
	);
	Matrix4x4 m4 = mat4x4_1;
	m4.div_scalar_assign_inline(0.5);
	@assert_print(m4,
		(Matrix4x4){{ 0, 6, 8, 2, 18, -6, -10, 4, 4, 4, 16, -16, -14, 14, 10, 8 }},
		"4x4 div_scalar_assign_inline not equal",
	);
	Matrix8x8 m8 = mat8x8_1;
	m8.div_scalar_assign_inline(0.5);
	@assert_print(m8,
		(Matrix8x8){{ 58, -164, 106, -168, -112, -196, 54, 194, 186, 168, 30, 14, 22, 138, -34, -26, 128, -156, -190, -20, -192, 196, -118, -96, 172, 16, 112, 152, 94, -170, -188, 64, -176, -40, -158, 188, 192, 158, 36, 60, 126, 132, 156, 124, -144, 72, -106, 162, -30, -56, 96, -174, -92, -138, 86, 98, -54, 182, -22, -78, 4, -24, -132, 130 }},
		"8x8 div_scalar_assign_inline not equal",
	);
}
fn void div_scalar_assign()
{
	Matrix2x2 m2 = mat2x2_1;
	m2.div_scalar_assign(0.5);
	@assert_print(m2,
		(Matrix2x2){{ 2, 8, -6, 6 }},
		"2x2 div_scalar_assign not equal",
	);
	Matrix2x3 m2x3 = mat2x3;
	m2x3.div_scalar_assign(0.5);
	@assert_print(m2x3,
		(Matrix2x3){{ 8, 0, -2, 8, -20, 14 }},
		"2x3 div_scalar_assign not equal",
	);
	Matrix3x3 m3 = mat3x3_1;
	m3.div_scalar_assign(0.5);
	@assert_print(m3,
		(Matrix3x3){{ 2, 4, -2, 6, -4, 2, -4, 8, 10 }},
		"3x3 div_scalar_assign not equal",
	);
	Matrix3x2 m3x2 = mat3x2;
	m3x2.div_scalar_assign(0.5);
	@assert_print(m3x2,
		(Matrix3x2){{ 2, -6, -6, 4, 10, 16 }},
		"3x2 div_scalar_assign not equal",
	);
	Matrix4x4 m4 = mat4x4_1;
	m4.div_scalar_assign(0.5);
	@assert_print(m4,
		(Matrix4x4){{ 0, 6, 8, 2, 18, -6, -10, 4, 4, 4, 16, -16, -14, 14, 10, 8 }},
		"4x4 div_scalar_assign not equal",
	);
	Matrix8x8 m8 = mat8x8_1;
	m8.div_scalar_assign(0.5);
	@assert_print(m8,
		(Matrix8x8){{ 58, -164, 106, -168, -112, -196, 54, 194, 186, 168, 30, 14, 22, 138, -34, -26, 128, -156, -190, -20, -192, 196, -118, -96, 172, 16, 112, 152, 94, -170, -188, 64, -176, -40, -158, 188, 192, 158, 36, 60, 126, 132, 156, 124, -144, 72, -106, 162, -30, -56, 96, -174, -92, -138, 86, 98, -54, 182, -22, -78, 4, -24, -132, 130 }},
		"8x8 div_scalar_assign not equal",
	);
}
fn void mul_vec()
{
	@assert_print(mat2x2_1.mul_vec(vec2),
		(double[<2>]){ -15, 0 },
		"2x2 mul_vec not equal",
	);
	@assert_print(mat2x3.mul_vec(vec3),
		(double[<2>]){ -45, 31 },
		"2x3 mul_vec not equal",
	);
	@assert_print(mat3x3_1.mul_vec(vec3),
		(double[<3>]){ -12, 24, 23 },
		"3x3 mul_vec not equal",
	);
}
fn void mul_array()
{
	@assert_print(mat2x2_1.mul_array(arr2),
		(double[2]){ -15, 0 },
		"2x2 mul_array not equal",
	);
	@assert_print(mat2x3.mul_array(arr3),
		(double[2]){ -45, 31 },
		"2x3 mul_array not equal",
	);
	@assert_print(mat3x3_1.mul_array(arr3),
		(double[3]){ -12, 24, 23 },
		"3x3 mul_array not equal",
	);
}
fn void eq_inline()
{
	@assert_print(mat8x8_1.eq_inline(mat8x8_2),
		false,
		"8x8 (same) eq_inline not equal",
	);
	@assert_print(mat8x8_1.eq_inline(mat8x8_1),
		true,
		"8x8 (not same) eq_inline not equal",
	);
}
fn void eq()
{
	@assert_print(mat8x8_1.eq(mat8x8_2),
		false,
		"8x8 (same) eq not equal",
	);
	@assert_print(mat8x8_1.eq(mat8x8_1),
		true,
		"8x8 (not same) eq not equal",
	);
}
fn void neq_inline()
{
	@assert_print(mat8x8_1.neq_inline(mat8x8_2),
		true,
		"8x8 (same) neq_inline not equal",
	);
	@assert_print(mat8x8_1.neq_inline(mat8x8_1),
		false,
		"8x8 (not same) neq_inline not equal",
	);
}
fn void neq()
{
	@assert_print(mat8x8_1.neq(mat8x8_2),
		true,
		"8x8 (same) neq not equal",
	);
	@assert_print(mat8x8_1.neq(mat8x8_1),
		false,
		"8x8 (not same) neq not equal",
	);
}
fn void determinant()
{
	@assert_print(mat2x2_1.determinant(),
		15,
		"2x2 determinant not equal",
	);
	@assert_print(mat3x3_1.determinant(),
		-56,
		"3x3 determinant not equal",
	);
	@assert_print(mat4x4_1.determinant(),
		688,
		"4x4 determinant not equal",
	);
	@assert_print(math::round(mat8x8_3.determinant()),
		-612479662,
		"8x8 determinant not equal",
	);
}
fn void cofactor()
{
	@assert_print(mat2x2_1.cofactor(1, 0),
		3,
		"2x2 cofactor not equal",
	);
	@assert_print(mat3x3_1.cofactor(2, 1),
		-8,
		"3x3 cofactor not equal",
	);
	@assert_print(mat4x4_1.cofactor(1, 3),
		386,
		"4x4 cofactor not equal",
	);
	@assert_print(math::round(mat8x8_3.cofactor(4, 6)),
		-40883555,
		"8x8 cofactor not equal",
	);
}
fn void comatrix_assign()
{
	Matrix2x2 m2;
	m2.comatrix_assign(&mat2x2_1);
	@assert_print(m2,
		(Matrix2x2){{ 3, 3, -4, 1 }},
		"2x2 comatrix not equal",
	);
	Matrix3x3 m3;
	m3.comatrix_assign(&mat3x3_1);
	@assert_print(m3,
		(Matrix3x3){{ -14, -17, 8, -14, 3, -8, 0, -4, -8 }},
		"3x3 comatrix not equal",
	);
	Matrix4x4 m4;
	m4.comatrix_assign(&mat4x4_1);
	@assert_print(m4,
		(Matrix4x4){{ 12, -540, 488, 356, 86, 258, -172, -86, 34, 190, -108, -138, 22, 386, -252, -150 }},
		"4x4 comatrix not equal",
	);
	Matrix8x8 m8;
	m8.comatrix_assign(&mat8x8_3);
	Matrix8x8 right = (Matrix8x8){{ 45224051, 8325091, -46368758, 81258538, 30310437, -8507850, 14597485, 16396390, 2376442, 4110216, -17636390, 5723340, -46089848, 5048594, -49970400, 16743176, 19293654, 8078140, 4977284, 35084820, -11467218, 7448182, -2611842, 32200988, 53806131, 33677045, -62533958, 21249164, 4214255, 31499278, 19257633, 4895922, 54995587, -1435487, -41480138, 28458100, -17169069, 7327980, 498471, -24132738, 18084682, 25489032, -46744832, 27617544, -28739584, 12092624, 1573802, -6853130, -64283433, -4765151, 74110290, -100563300, -40883555, -41591226, -30114751, -32481998, -20218072, -4473936, 46623982, -4012480, 10049084, 13266104, -22176980, 701160 }};
	m8.sub_assign(right);
	round(&m8);
	@assert_print(m8,
		(Matrix8x8){{}}, // all zeros
		"8x8 comatrix not equal",
	);
}
fn void trace()
{
	@assert_print(mat2x2_1.trace(),
		4,
		"2x2 trace not equal",
	);
	@assert_print(mat3x3_1.trace(),
		4,
		"3x3 trace not equal",
	);
	@assert_print(mat4x4_1.trace(),
		9,
		"4x4 trace not equal",
	);
	@assert_print(mat8x8_3.trace(),
		11,
		"8x8 trace not equal",
	);
}
fn void get_row()
{
	double[2] a2;
	mat2x2_1.@get_row(0, a2);
	@assert_print(a2,
		(double[2]){ 1, -3 },
		"2x2 get_row not equal",
	);
	double[3] a3;
	mat3x3_1.@get_row(1, a3);
	@assert_print(a3,
		(double[3]){ 2, -2, 4 },
		"3x3 get_row not equal",
	);
	double[4] a4;
	mat4x4_1.@get_row(1, a4);
	@assert_print(a4,
		(double[4]){ 3, -3, 2, 7 },
		"4x4 get_row not equal",
	);
	double[8] a8;
	mat8x8_3.@get_row(6, a8);
	@assert_print(a8,
		(double[8]){ 8, 11, -9, 5, 0, -6, 3, 9 },
		"8x8 get_row not equal",
	);
}
fn void set_row()
{
	Matrix2x2 m2 = mat2x2_1;
	m2.@set_row(0, vec2);
	@assert_print(m2,
		(Matrix2x2){{ -3, 4, 4, 3 }},
		"2x2 set_row not equal",
	);
	Matrix3x3 m3 = mat3x3_1;
	m3.@set_row(1, vec3);
	@assert_print(m3,
		(Matrix3x3){{ 1, 1, -1, 3, -1, 1, -2, 5, 5 }},
		"3x3 set_row not equal",
	);
	Matrix4x4 m4 = mat4x4_1;
	m4.@set_row(1, vec4);
	@assert_print(m4,
		(Matrix4x4){{ 0, -2, 4, 1, 9, 3, -5, 2, 2, 3, 8, -8, -7, -1, 5, 4 }},
		"4x4 set_row not equal",
	);
	Matrix8x8 m8 = mat8x8_1;
	m8.@set_row(6, vec8);
	@assert_print(m8,
		(Matrix8x8){{ 29, -82, 53, -84, -56, -98, -4, 97, 93, 84, 15, 7, 11, 69, -3, -13, 64, -78, -95, -10, -96, 98, 1, -48, 86, 8, 56, 76, 47, -85, 1, 32, -88, -20, -79, 94, 96, 79, 6, 30, 63, 66, 78, 62, -72, 36, 8, 81, -15, -28, 48, -87, -46, -69, 10, 49, -27, 91, -11, -39, 2, -12, -2, 65 }},
		"8x8 set_row not equal",
	);
}
fn void swap_col()
{
	Matrix2x2 m2 = mat2x2_1;
	m2.swap_col(0, 1);
	@assert_print(m2,
		(Matrix2x2){{ -3, 3, 1, 4 }},
		"2x2 swap_col not equal",
	);
	Matrix3x3 m3 = mat3x3_1;
	m3.swap_col(1, 0);
	@assert_print(m3,
		(Matrix3x3){{ 3, -2, 1, 1, 2, -1, -2, 4, 5 }},
		"3x3 swap_col not equal",
	);
	Matrix4x4 m4 = mat4x4_1;
	m4.swap_col(1, 3);
	@assert_print(m4,
		(Matrix4x4){{ 0, 3, 4, 1, -7, 7, 5, 4, 2, 2, 8, -8, 9, -3, -5, 2 }},
		"4x4 swap_col not equal",
	);
	Matrix8x8 m8 = mat8x8_1;
	m8.swap_col(3, 0);
	@assert_print(m8,
		(Matrix8x8){{ 86, 8, 56, 76, 47, -85, -94, 32, 93, 84, 15, 7, 11, 69, -17, -13, 64, -78, -95, -10, -96, 98, -59, -48, 29, -82, 53, -84, -56, -98, 27, 97, -88, -20, -79, 94, 96, 79, 18, 30, 63, 66, 78, 62, -72, 36, -53, 81, -15, -28, 48, -87, -46, -69, 43, 49, -27, 91, -11, -39, 2, -12, -66, 65 }},
		"8x8 swap_col not equal",
	);
}
fn void swap_row()
{
	Matrix2x2 m2 = mat2x2_1;
	m2.swap_row(0, 1);
	@assert_print(m2,
		(Matrix2x2){{ 4, 1, 3, -3 }},
		"2x2 swap_row not equal",
	);
	Matrix3x3 m3 = mat3x3_1;
	m3.swap_row(1, 0);
	@assert_print(m3,
		(Matrix3x3){{ 2, 1, -1, -2, 3, 1, 4, -2, 5 }},
		"3x3 swap_row not equal",
	);
	Matrix4x4 m4 = mat4x4_1;
	m4.swap_row(1, 3);
	@assert_print(m4,
		(Matrix4x4){{ 0, 1, 4, 3, 9, 2, -5, -3, 2, -8, 8, 2, -7,4, 5, 7 }},
		"4x4 swap_row not equal",
	);
	Matrix8x8 m8 = mat8x8_1;
	m8.swap_row(3, 0);
	@assert_print(m8,
		(Matrix8x8){{ -84, -82, 53, 29, -56, -98, 27, 97, 7, 84, 15, 93, 11, 69, -17, -13, -10, -78, -95, 64, -96, 98, -59, -48, 76, 8, 56, 86, 47, -85, -94, 32, 94, -20, -79, -88, 96, 79, 18, 30, 62, 66, 78, 63, -72, 36, -53, 81, -87, -28, 48, -15, -46, -69, 43, 49, -39, 91, -11, -27, 2, -12, -66, 65 }},
		"8x8 swap_row not equal",
	);
}
fn void lu_decomp()
{
	Matrix2x2 l2;
	Matrix2x2 u2;
	@assert_print(@ok(mat2x2_1.lu_decomp(&l2, &u2)),
		true,
		"2x2 lu_decomp FAILED",
	);
	@assert_print(l2.mul(u2),
		mat2x2_1,
		"2x2 lu_decomp not equal",
	);
	Matrix3x3 l3;
	Matrix3x3 u3;
	@assert_print(@ok(mat3x3_1.lu_decomp(&l3, &u3)),
		true,
		"3x3 lu_decomp FAILED",
	);
	@assert_print(l3.mul(u3),
		mat3x3_1,
		"3x3 lu_decomp not equal",
	);
	Matrix4x4 l4;
	Matrix4x4 u4;
	// mat4x4_1 pivot 0 is zero
	@assert_print(@ok(mat4x4_1.lu_decomp(&l4, &u4)),
		false,
		"4x4 lu_decomp FALSE POSITIVE",
	);
	@assert_print(@ok(mat4x4_2.lu_decomp(&l4, &u4)),
		true,
		"4x4 lu_decomp FAILED",
	);
	@assert_print(l4.mul(u4),
		mat4x4_2,
		"4x4 lu_decomp not equal",
	);
	Matrix8x8 l8;
	Matrix8x8 u8;
	@assert_print(@ok(mat8x8_1.lu_decomp(&l8, &u8)),
		true,
		"8x8 lu_decomp FAILED",
	);
	Matrix8x8 lu8;
	matrix::mul_assign(&lu8, &l8, &u8);
	lu8.sub_assign(mat8x8_1);
	round(&lu8);
	@assert_print(lu8,
		(Matrix8x8){{}}, // all zeros
		"8x8 lu_decomp not equal",
	);
}
fn void lu_decomp_pivot()
{
	Matrix2x2 l2;
	Matrix2x2 u2;
	Matrix2x2 p2;
	@assert_print(@ok(mat2x2_1.lu_decomp_pivot(&l2, &u2, &p2)),
		true,
		"2x2 lu_decomp_pivot FAILED",
	);
	@assert_print(l2.mul(u2),
		p2.mul(mat2x2_1),
		"2x2 lu_decomp_pivot not equal",
	);
	Matrix3x3 l3;
	Matrix3x3 u3;
	Matrix3x3 p3;
	@assert_print(@ok(mat3x3_1.lu_decomp_pivot(&l3, &u3, &p3)),
		true,
		"3x3 lu_decomp_pivot FAILED",
	);
	@assert_print(l3.mul(u3),
		p3.mul(mat3x3_1),
		"3x3 lu_decomp_pivot not equal",
	);
	Matrix4x4 l4;
	Matrix4x4 u4;
	Matrix4x4 p4;
	@assert_print(@ok(mat4x4_1.lu_decomp_pivot(&l4, &u4, &p4)),
		true,
		"4x4 lu_decomp_pivot FAILED",
	);
	Matrix4x4 pa4;
	Matrix4x4 lu4;
	matrix::mul_assign(&pa4, &p4, &mat4x4_1);
	matrix::mul_assign(&lu4, &l4, &u4);
	lu4.sub_assign(pa4);
	round(&lu4);
	@assert_print(lu4,
		(Matrix4x4){{}}, // all zeros
		"4x4 lu_decomp_pivot not equal",
	);
	Matrix8x8 l8;
	Matrix8x8 u8;
	Matrix8x8 p8;
	@assert_print(@ok(mat8x8_1.lu_decomp_pivot(&l8, &u8, &p8)),
		true,
		"8x8 lu_decomp_pivot FAILED",
	);
	Matrix8x8 pa8;
	Matrix8x8 lu8;
	matrix::mul_assign(&pa8, &p8, &mat8x8_1);
	matrix::mul_assign(&lu8, &l8, &u8);
	lu8.sub_assign(pa8);
	round(&lu8);
	@assert_print(lu8,
		(Matrix8x8){{}}, // all zeros
		"8x8 lu_decomp_pivot not equal",
	);
}
fn void translate()
{
	Matrix3x3 m3 = mat3x3_1;
	m3.translate(vec2);
	@assert_print(m3,
		(Matrix3x3){{ 1, 2, -1, 3, -2, 1, -5, 8, 5 }},
		"3x3 translate not equal",
	);
	Matrix4x4 m4 = mat4x4_1;
	m4.translate(vec3);
	@assert_print(m4,
		(Matrix4x4){{ 0, 3, 4, 1, 9, -3, -5, 2, 2, 2, 8, -8, -6, 6, 10, 4 }},
		"4x4 translate not equal",
	);
}
fn void rotate_2d()
{
	Matrix2x2 m2 = mat2x2_1;
	m2.rotate_2d(math::PI);
	round(&m2);
	@assert_print(m2,
		(Matrix2x2){{ -1, -4, 3, -3 }},
		"rotate_2d PI not equal",
	);
	m2 = mat2x2_1;
	m2.rotate_2d(math::PI / 2.0);
	round(&m2);
	@assert_print(m2,
		(Matrix2x2){{ -4, 1, -3, -3 }},
		"rotate_2d PI/2 not equal",
	);
}
fn void rotate_x()
{
	Matrix3x3 m3 = matrix::@identity(3);
	m3.rotate_x(math::PI / 2.0);
	round(&m3);
	@assert_print(m3,
		(Matrix3x3){{ 1, 0, 0, 0, 0, 1, 0, -1, 0 }},
		"3x3 rotate_x not equal",
	);

	Matrix4x4 m4 = matrix::@identity(4);
	m4.rotate_x(math::PI / 2.0);
	round(&m4);
	@assert_print(m4,
		(Matrix4x4){{ 1, 0, 0, 0, 0, 0, 1, 0, 0, -1, 0, 0, 0, 0, 0, 1 }},
		"4x4 rotate_x not equal",
	);
}
fn void rotate_y()
{
	Matrix3x3 m3 = matrix::@identity(3);
	m3.rotate_y(math::PI / 2.0);
	round(&m3);
	@assert_print(m3,
		(Matrix3x3){{ 0, 0, -1, 0, 1, 0, 1, 0, 0 }},
		"3x3 rotate_y not equal",
	);

	Matrix4x4 m4 = matrix::@identity(4);
	m4.rotate_y(math::PI / 2.0);
	round(&m4);
	@assert_print(m4,
		(Matrix4x4){{ 0, 0, -1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1 }},
		"4x4 rotate_y not equal",
	);
}
fn void rotate_z()
{
	Matrix3x3 m3 = matrix::@identity(3);
	m3.rotate_z(math::PI / 2.0);
	round(&m3);
	@assert_print(m3,
		(Matrix3x3){{ 0, 1, 0, -1, 0, 0, 0, 0, 1 }},
		"3x3 rotate_z not equal",
	);

	Matrix4x4 m4 = matrix::@identity(4);
	m4.rotate_z(math::PI / 2.0);
	round(&m4);
	@assert_print(m4,
		(Matrix4x4){{ 0, 1, 0, 0, -1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 }},
		"4x4 rotate_z not equal",
	);
}
fn void transpose_assign()
{
	Matrix2x2 m2;
	matrix::transpose_assign(&m2, &mat2x2_1);
	round(&m2);
	@assert_print(m2,
		(Matrix2x2){{ 1, -3, 4, 3 }},
		"2x2 transpose_assign not equal",
	);
	Matrix2x3 m2x3;
	matrix::transpose_assign(&m2x3, &mat3x2);
	round(&m2x3);
	@assert_print(m2x3,
		(Matrix2x3){{ 1, 2, -3, 5, -3, 8 }},
		"3x2 -> 2x3 transpose_assign not equal",
	);
	Matrix3x3 m3;
	matrix::transpose_assign(&m3, &mat3x3_1);
	round(&m3);
	@assert_print(m3,
		(Matrix3x3){{ 1, 3, -2, 2, -2, 4, -1, 1, 5 }},
		"3x3 transpose_assign not equal",
	);
	Matrix3x2 m3x2;
	matrix::transpose_assign(&m3x2, &mat2x3);
	round(&m3x2);
	@assert_print(m3x2,
		(Matrix3x2){{ 4, -1, -10, 0, 4, 7 }},
		"2x3 -> 3x2 transpose_assign not equal",
	);
	Matrix4x4 m4;
	matrix::transpose_assign(&m4, &mat4x4_1);
	round(&m4);
	@assert_print(m4,
		(Matrix4x4){{ 0, 9, 2, -7, 3, -3, 2, 7, 4, -5, 8, 5, 1, 2, -8, 4 }},
		"4x4 transpose_assign not equal",
	);
	Matrix8x8 m8;
	matrix::transpose_assign(&m8, &mat8x8_3);
	round(&m8);
	@assert_print(m8,
		(Matrix8x8){{ -2, 0, -7, -8, -9, 12, -5, 0, -10, 3, -2, -12, 7, -8, -11, -9, 0, 6, -10, 0, -4, 0, -4, -7, -3, 3, -2, 8, -1, -10, 2, -5, -8, -2, 10, -7, 4, 8, -1, -6, 12, 1, 1, 0, -1, -4, 9, -7, 8, 11, -9, 5, 0, -6, 3, 9, 2, -5, -8, -3, 7, 9, 2, 9 }},
		"8x8 transpose_assign not equal",
	);
}
fn void transpose()
{
	Matrix2x2 m2 = mat2x2_1;
	m2.transpose();
	@assert_print(m2,
		(Matrix2x2){{ 1, -3, 4, 3 }},
		"2x2 transpose_assign not equal",
	);
	Matrix3x3 m3 = mat3x3_1;
	m3.transpose();
	@assert_print(m3,
		(Matrix3x3){{ 1, 3, -2, 2, -2, 4, -1, 1, 5 }},
		"3x3 transpose_assign not equal",
	);
	Matrix4x4 m4 = mat4x4_1;
	m4.transpose();
	@assert_print(m4,
		(Matrix4x4){{ 0, 9, 2, -7, 3, -3, 2, 7, 4, -5, 8, 5, 1, 2, -8, 4 }},
		"4x4 transpose_assign not equal",
	);
	Matrix8x8 m8 = mat8x8_3;
	m8.transpose();
	@assert_print(m8,
		(Matrix8x8){{ -2, 0, -7, -8, -9, 12, -5, 0, -10, 3, -2, -12, 7, -8, -11, -9, 0, 6, -10, 0, -4, 0, -4, -7, -3, 3, -2, 8, -1, -10, 2, -5, -8, -2, 10, -7, 4, 8, -1, -6, 12, 1, 1, 0, -1, -4, 9, -7, 8, 11, -9, 5, 0, -6, 3, 9, 2, -5, -8, -3, 7, 9, 2, 9 }},
		"8x8 transpose_assign not equal",
	);
}
fn void row_slice()
{
	Matrix1x2 m1x2;
	matrix::row_slice(&m1x2, &mat2x2_1, 0);
	@assert_print(m1x2,
		(Matrix1x2){{ 4, 3 }},
		"2x2 row_slice not equal",
	);
	Matrix1x3 m1x3;
	matrix::row_slice(&m1x3, &mat2x3, 0);
	@assert_print(m1x3,
		(Matrix1x3){{ 0, 4, 7 }},
		"2x3 row_slice not equal",
	);
	Matrix2x2 m2x2;
	matrix::row_slice(&m2x2, &mat3x2, 2);
	@assert_print(m2x2,
		(Matrix2x2){{ 1, -3, 2, 5 }},
		"3x2 row_slice not equal",
	);
	Matrix2x3 m2x3;
	matrix::row_slice(&m2x3, &mat3x3_1, 1);
	@assert_print(m2x3,
		(Matrix2x3){{ 1, -1, 3, 1, -2, 5 }},
		"3x3 row_slice not equal",
	);
	Matrix{3,4, double} m3x4;
	matrix::row_slice(&m3x4, &mat4x4_1, 3);
	@assert_print(m3x4,
		(Matrix{3,4, double}){{ 0, 3, 4, 9, -3, -5, 2, 2, 8, -7, 7, 5 }},
		"4x4 row_slice not equal",
	);
	Matrix{7,8, double} m7x8;
	matrix::row_slice(&m7x8, &mat8x8_3, 6);
	@assert_print(m7x8,
		(Matrix{7,8, double}){{ -2, -10, 0, -3, -8, 12, 2, 0, 3, 6, 3, -2, 1, -5, -7, -2, -10, -2, 10, 1, -8, -8, -12, 0, 8, -7, 0, -3, -9, 7, -4, -1, 4, -1, 7, 12, -8, 0, -10, 8, -4, 9, -5, -11, -4, 2, -1, 9, 2, 0, -9, -7, -5, -6, -7, 9 }},
		"8x8 row_slice not equal",
	);
}
fn void col_slice()
{
	Matrix2x1 m2x1;
	matrix::col_slice(&m2x1, &mat2x2_1, 0);
	@assert_print(m2x1,
		(Matrix2x1){{ -3, 3 }},
		"2x2 col_slice not equal",
	);
	Matrix3x1 m3x1;
	matrix::col_slice(&m3x1, &mat3x2, 0);
	@assert_print(m3x1,
		(Matrix3x1){{ 2, 5, 8 }},
		"3x2 col_slice not equal",
	);
	Matrix2x2 m2x2;
	matrix::col_slice(&m2x2, &mat2x3, 2);
	@assert_print(m2x2,
		(Matrix2x2){{ 4, 0, -1, 4 }},
		"2x3 col_slice not equal",
	);
	Matrix3x2 m3x2;
	matrix::col_slice(&m3x2, &mat3x3_1, 1);
	@assert_print(m3x2,
		(Matrix3x2){{ 1, 2, -1, -2, 4, 5 }},
		"3x3 col_slice not equal",
	);
	Matrix{4,3, double} m4x3;
	matrix::col_slice(&m4x3, &mat4x4_1, 3);
	@assert_print(m4x3,
		(Matrix{4,3, double}){{ 0, 3, 4, 1, 9, -3, -5, 2, 2, 2, 8, -8 }},
		"4x4 col_slice not equal",
	);
	Matrix{8,7, double} m8x7;
	matrix::col_slice(&m8x7, &mat8x8_3, 6);
	@assert_print(m8x7,
		(Matrix{8,7, double}){{ -2, -10, 0, -3, -8, 12, 8, 2, 0, 3, 6, 3, -2, 1, 11, -5, -7, -2, -10, -2, 10, 1, -9, -8, -8, -12, 0, 8, -7, 0, 5, -3, -9, 7, -4, -1, 4, -1, 0, 7, 12, -8, 0, -10, 8, -4, -6, 9, 0, -9, -7, -5, -6, -7, 9, 9 }},
		"8x8 col_slice not equal",
	);
}
fn void strassen_mul()
{
	Matrix2x2 m2;
	matrix::strassen_mul(&m2, &mat2x2_1, &mat2x2_2);
	@assert_print(m2,
		(Matrix2x2){{ -8, -2, -3, 3 }},
		"2x2 strassen_mul not equal",
	);
	Matrix4x4 m4;
	matrix::strassen_mul(&m4, &mat4x4_1, &mat4x4_2);
	@assert_print(m4,
		(Matrix4x4){{ 17, 20, -49, 95, 77, -3, 19, -10, 68, -92, -156, 72, 79, -115, -161, 32 }},
		"4x4 strassen_mul not equal",
	);
	Matrix8x8 m8;
	matrix::strassen_mul(&m8, &mat8x8_1, &mat8x8_2);
	@assert_print(m8,
		(Matrix8x8){{ 3400, -10244, -13221, 4012, -4040, 23173, 6275, -1856, -9257, 848, -1868, 9297, 7824, 5473, 7716, -6269, -11090, -14416, -1116, -15723, -12113, -8374, 8919, 5394, -7084, 22784, -2117, 3920, 10379, 12576, 1119, -2366, -252, 5891, 4654, -17083, 1058, -10375, 4491, 2370, 14491, 6533, 13366, 2754, -9346, -7295, -10657, 4499, -8152, -11733, -25440, 8535, 6046, 21569, 3864, -28694, -5093, -2069, 2707, 12161, 13192, -14789, -9425, 13003 }},
		"8x8 strassen_mul not equal",
	);
}
fn void set_submatrix()
{
	/// "cleared" matrix is matrix set to all 10's
	Matrix4x4 m4;
	foreach (i, &val : m4.val) *val = 10;
	matrix::set_submatrix(&m4, &mat2x2_1, 0,0);
	@assert_print(m4,
		(Matrix4x4){{ 1, 4, 10, 10, -3, 3, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 }},
		"4x4 0,0 set_submatrix not equal",
	);
	foreach (i, &val : m4.val) *val = 10;
	matrix::set_submatrix(&m4, &mat2x2_1, 1,0);
	@assert_print(m4,
		(Matrix4x4){{ 10, 1, 4, 10, 10, -3, 3, 10, 10, 10, 10, 10, 10, 10, 10, 10 }},
		"4x4 1,0 set_submatrix not equal",
	);
	foreach (i, &val : m4.val) *val = 10;
	matrix::set_submatrix(&m4, &mat2x2_1, 2,0);
	@assert_print(m4,
		(Matrix4x4){{ 10, 10, 1, 4, 10, 10, -3, 3, 10, 10, 10, 10, 10, 10, 10, 10 }},
		"4x4 2,0 set_submatrix not equal",
	);
	foreach (i, &val : m4.val) *val = 10;
	matrix::set_submatrix(&m4, &mat2x2_1, 0,1);
	@assert_print(m4,
		(Matrix4x4){{ 10, 10, 10, 10, 1, 4, 10, 10, -3, 3, 10, 10, 10, 10, 10, 10 }},
		"4x4 0,1 set_submatrix not equal",
	);
	foreach (i, &val : m4.val) *val = 10;
	matrix::set_submatrix(&m4, &mat2x2_1, 1,1);
	@assert_print(m4,
		(Matrix4x4){{ 10, 10, 10, 10, 10, 1, 4, 10, 10, -3, 3, 10, 10, 10, 10, 10 }},
		"4x4 1,1 set_submatrix not equal",
	);
	foreach (i, &val : m4.val) *val = 10;
	matrix::set_submatrix(&m4, &mat2x2_1, 2,1);
	@assert_print(m4,
		(Matrix4x4){{ 10, 10, 10, 10, 10, 10, 1, 4, 10, 10, -3, 3, 10, 10, 10, 10 }},
		"4x4 2,1 set_submatrix not equal",
	);
	foreach (i, &val : m4.val) *val = 10;
	matrix::set_submatrix(&m4, &mat2x2_1, 0,2);
	@assert_print(m4,
		(Matrix4x4){{ 10, 10, 10, 10, 10, 10, 10, 10, 1, 4, 10, 10, -3, 3, 10, 10 }},
		"4x4 0,2 set_submatrix not equal",
	);
	foreach (i, &val : m4.val) *val = 10;
	matrix::set_submatrix(&m4, &mat2x2_1, 1,2);
	@assert_print(m4,
		(Matrix4x4){{ 10, 10, 10, 10, 10, 10, 10, 10, 10, 1, 4, 10, 10, -3, 3, 10 }},
		"4x4 1,2 set_submatrix not equal",
	);
	foreach (i, &val : m4.val) *val = 10;
	matrix::set_submatrix(&m4, &mat2x2_1, 2,2);
	@assert_print(m4,
		(Matrix4x4){{ 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 1, 4, 10, 10, -3, 3 }},
		"4x4 2,2 set_submatrix not equal",
	);
}
fn void minor()
{
	@assert_print(matrix::minor(&mat2x2_1, 1,0),
		-3,
		"2x2 minor not equal",
	);
	@assert_print(matrix::minor(&mat3x3_1, 0,2),
		0,
		"3x3 minor not equal",
	);
	@assert_print(matrix::minor(&mat4x4_1, 2,1),
		172,
		"4x4 minor not equal",
	);
	@assert_print(math::round(matrix::minor(&mat8x8_3, 4,7)),
		-10049084.0,
		"8x8 minor not equal",
	);
}
fn void identity()
{
	@assert_print(matrix::@identity(1).val,
		(double[1]){ 1 },
		"1x1 identity not equal",
	);
	@assert_print(matrix::@identity(2).val,
		(double[4]){ 1, 0, 0, 1 },
		"2x2 identity not equal",
	);
	@assert_print(matrix::@identity(3).val,
		(double[9]){ 1, 0, 0, 0, 1, 0, 0, 0, 1 },
		"3x3 identity not equal",
	);
	@assert_print(matrix::@identity(4).val,
		(double[16]){ 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
		"4x4 identity not equal",
	);
	@assert_print(matrix::@identity(8).val,
		(double[64]){ 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
		"8x8 identity not equal",
	);
}
fn void identity_assign()
{
	Matrix1x1 m1;
	matrix::identity_assign(&m1);
	@assert_print(m1.val,
		(double[1]){ 1 },
		"1x1 identity_assign not equal",
	);
	Matrix2x2 m2;
	matrix::identity_assign(&m2);
	@assert_print(m2.val,
		(double[4]){ 1, 0, 0, 1 },
		"2x2 identity_assign not equal",
	);
	Matrix3x3 m3;
	matrix::identity_assign(&m3);
	@assert_print(m3.val,
		(double[9]){ 1, 0, 0, 0, 1, 0, 0, 0, 1 },
		"3x3 identity_assign not equal",
	);
	Matrix4x4 m4;
	matrix::identity_assign(&m4);
	@assert_print(m4.val,
		(double[16]){ 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 },
		"4x4 identity_assign not equal",
	);
	Matrix8x8 m8;
	matrix::identity_assign(&m8);
	@assert_print(m8.val,
		(double[64]){ 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
		"8x8 identity_assign not equal",
	);
}
fn void adjugate_assign()
{
	Matrix2x2 m2;
	m2.adjugate_assign(&mat2x2_1);
	round(&m2);
	@assert_print(m2,
		(Matrix2x2){{ 3, -4, 3, 1 }},
		"2x2 adjugate_assign not equal",
	);
	Matrix3x3 m3;
	m3.adjugate_assign(&mat3x3_1);
	round(&m3);
	@assert_print(m3,
		(Matrix3x3){{ -14, -14, 0, -17, 3, -4, 8, -8, -8 }},
		"3x3 adjugate_assign not equal",
	);
	Matrix4x4 m4;
	m4.adjugate_assign(&mat4x4_1);
	round(&m4);
	@assert_print(m4,
		(Matrix4x4){{ 12, 86, 34, 22, -540, 258, 190, 386, 488, -172, -108, -252, 356, -86, -138, -150 }},
		"4x4 adjugate_assign not equal",
	);
	Matrix8x8 m8;
	m8.adjugate_assign(&mat8x8_3);
	round(&m8);
	@assert_print(m8,
		(Matrix8x8){{ 45224051, 2376442, 19293654, 53806131, 54995587, 18084682, -64283433, -20218072, 8325091, 4110216, 8078140, 33677045, -1435487, 25489032, -4765151, -4473936, -46368758, -17636390, 4977284, -62533958, -41480138, -46744832, 74110290, 46623982, 81258538, 5723340, 35084820, 21249164, 28458100, 27617544, -100563300, -4012480, 30310437, -46089848, -11467218, 4214255, -17169069, -28739584, -40883555, 10049084, -8507850, 5048594, 7448182, 31499278, 7327980, 12092624, -41591226, 13266104, 14597485, -49970400, -2611842, 19257633, 498471, 1573802, -30114751, -22176980, 16396390, 16743176, 32200988, 4895922, -24132738, -6853130, -32481998, 701160 }},
		"8x8 adjugate_assign not equal",
	);
}
fn void inverse()
{
	Matrix2x2 m2;
	@assert_print(@ok(matrix::inverse(&m2, &mat2x2_1)),
		true,
		"2x2 inverse FAILED"
	);
	@assert_print(m2,
		(Matrix2x2){{ 1.0/5.0, -4.0/15.0, 1.0/5.0, 1.0/15.0 }},
		"2x2 inverse not equal",
	);
	Matrix3x3 m3;
	@assert_print(@ok(matrix::inverse(&m3, &mat3x3_1)),
		true,
		"3x3 inverse FAILED"
	);
	@assert_print(m3,
		(Matrix3x3){{ 1.0/4.0, 1.0/4.0, 0.0, 17.0/56.0, -3.0/56.0, 1.0/14.0, -1.0/7.0, 1.0/7.0, 1.0/7.0 }},
		"3x3 inverse not equal",
	);
	Matrix4x4 m4;
	@assert_print(@ok(matrix::inverse(&m4, &mat4x4_1)),
		true,
		"4x4 inverse FAILED"
	);
	@assert_print(m4,
		(Matrix4x4){{ 3.0/172.0, 1.0/8.0, 17.0/344.0, 11.0/344.0, -135.0/172.0, 3.0/8.0, 95.0/344.0, 193.0/344.0, 61.0/86.0, -1.0/4.0, -27.0/172.0, -63.0/172.0, 89.0/172.0, -1.0/8.0, -69.0/344.0, -75.0/344.0 }},
		"4x4 inverse not equal",
	);
	Matrix8x8 m8;
	@assert_print(@ok(matrix::inverse(&m8, &mat8x8_3)),
		true,
		"8x8 inverse FAILED"
	);
	m8.sub_assign((Matrix8x8){{ -45224051.0/612479662.0, -1188221.0/306239831.0, -9646827.0/306239831.0, -53806131.0/612479662.0, -54995587.0/612479662.0, -9042341.0/306239831.0, 64283433.0/612479662.0, 10109036.0/306239831.0, -99621901748224.0/7329215826055169.0, -2055108.0/306239831.0, -4039070.0/306239831.0, -33677045.0/612479662.0, 1435487.0/612479662.0, -2440108670582785.0/58633726608441350.0, 4765151.0/612479662.0, 2236968.0/306239831.0, 23184379.0/306239831.0, 8818195.0/306239831.0, -2488642.0/306239831.0, 31266979.0/306239831.0, 20740069.0/306239831.0, 23372416.0/306239831.0, -37055145.0/306239831.0, -23311991.0/306239831.0, -40629269.0/306239831.0, -2861670.0/306239831.0, -17542410.0/306239831.0, -4068437696577537.0/117267453216882700.0, -340542829158400.0/7329215826055169.0, -13808772.0/306239831.0, 50281650.0/306239831.0, 2006240.0/306239831.0, -30310437.0/612479662.0, 23044924.0/306239831.0, 5733609.0/306239831.0, -4214255.0/612479662.0, 17169069.0/612479662.0, 14369792.0/306239831.0, 40883555.0/612479662.0, -5024542.0/306239831.0, 4253925.0/306239831.0, -2524297.0/306239831.0, -3724091.0/306239831.0, -15749639.0/306239831.0, -3663990.0/306239831.0, -6046312.0/306239831.0, 20795613.0/306239831.0, -6633052.0/306239831.0, -14597485.0/612479662.0, 24985200.0/306239831.0, 1305921.0/306239831.0, -230445772019712.0/7329215826055169.0, -5964935276544.0/7329215826055169.0, -786901.0/306239831.0, 30114751.0/612479662.0, 11088490.0/306239831.0, -8198195.0/306239831.0, -8371588.0/306239831.0, -16100494.0/306239831.0, -2447961.0/306239831.0, 12066369.0/306239831.0, 3426565.0/306239831.0, 16240999.0/306239831.0, -350580.0/306239831.0 }});
	round(&m8);
	@assert_print(m8,
		(Matrix8x8){{}},
		"8x8 inverse not equal",
	);
}
fn void downsize()
{
	Matrix2x2 m2;
	matrix::@downsize(&mat4x4_1, &m2, 0,0);
	@assert_print(m2,
		(Matrix2x2){{ 0, 3, 9, -3 }},
		"0,0 downsize not equal",
	);
	matrix::@downsize(&mat4x4_1, &m2, 0,1);
	@assert_print(m2,
		(Matrix2x2){{ 9, -3, 2, 2 }},
		"0,1 downsize not equal",
	);
	matrix::@downsize(&mat4x4_1, &m2, 0,2);
	@assert_print(m2,
		(Matrix2x2){{ 2, 2, -7, 7 }},
		"0,2 downsize not equal",
	);
	matrix::@downsize(&mat4x4_1, &m2, 1,0);
	@assert_print(m2,
		(Matrix2x2){{ 3, 4, -3, -5 }},
		"1,0 downsize not equal",
	);
	matrix::@downsize(&mat4x4_1, &m2, 1,1);
	@assert_print(m2,
		(Matrix2x2){{ -3, -5, 2, 8 }},
		"1,1 downsize not equal",
	);
	matrix::@downsize(&mat4x4_1, &m2, 1,2);
	@assert_print(m2,
		(Matrix2x2){{ 2, 8, 7, 5 }},
		"1,2 downsize not equal",
	);
	matrix::@downsize(&mat4x4_1, &m2, 2,0);
	@assert_print(m2,
		(Matrix2x2){{ 4, 1, -5, 2 }},
		"2,0 downsize not equal",
	);
	matrix::@downsize(&mat4x4_1, &m2, 2,1);
	@assert_print(m2,
		(Matrix2x2){{ -5, 2, 8, -8 }},
		"2,1 downsize not equal",
	);
	matrix::@downsize(&mat4x4_1, &m2, 2,2);
	@assert_print(m2,
		(Matrix2x2){{ 8, -8, 5, 4 }},
		"2,2 downsize not equal",
	);
}
fn void upsize()
{
	/// "cleared" matrix is matrix set to all 10's
	Matrix4x4 m4;
	foreach (i, &val : m4.val) *val = 10;
	matrix::@upsize(&mat2x2_1, &m4, 0,0);
	@assert_print(m4,
		(Matrix4x4){{ 1, 4, 10, 10, -3, 3, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10 }},
		"0,0 upsize not equal",
	);
	foreach (i, &val : m4.val) *val = 10;
	matrix::@upsize(&mat2x2_1, &m4, 0,1);
	@assert_print(m4,
		(Matrix4x4){{ 10, 10, 10, 10, 1, 4, 10, 10, -3, 3, 10, 10, 10, 10, 10, 10 }},
		"0,1 upsize not equal",
	);
	foreach (i, &val : m4.val) *val = 10;
	matrix::@upsize(&mat2x2_1, &m4, 0,2);
	@assert_print(m4,
		(Matrix4x4){{ 10, 10, 10, 10, 10, 10, 10, 10, 1, 4, 10, 10, -3, 3, 10, 10 }},
		"0,2 upsize not equal",
	);
	foreach (i, &val : m4.val) *val = 10;
	matrix::@upsize(&mat2x2_1, &m4, 1,0);
	@assert_print(m4,
		(Matrix4x4){{ 10, 1, 4, 10, 10, -3, 3, 10, 10, 10, 10, 10, 10, 10, 10, 10 }},
		"1,0 upsize not equal",
	);
	foreach (i, &val : m4.val) *val = 10;
	matrix::@upsize(&mat2x2_1, &m4, 1,1);
	@assert_print(m4,
		(Matrix4x4){{ 10, 10, 10, 10, 10, 1, 4, 10, 10, -3, 3, 10, 10, 10, 10, 10 }},
		"1,1 upsize not equal",
	);
	foreach (i, &val : m4.val) *val = 10;
	matrix::@upsize(&mat2x2_1, &m4, 1,2);
	@assert_print(m4,
		(Matrix4x4){{ 10, 10, 10, 10, 10, 10, 10, 10, 10, 1, 4, 10, 10, -3, 3, 10 }},
		"1,2 upsize not equal",
	);
	foreach (i, &val : m4.val) *val = 10;
	matrix::@upsize(&mat2x2_1, &m4, 2,0);
	@assert_print(m4,
		(Matrix4x4){{ 10, 10, 1, 4, 10, 10, -3, 3, 10, 10, 10, 10, 10, 10, 10, 10 }},
		"2,0 upsize not equal",
	);
	foreach (i, &val : m4.val) *val = 10;
	matrix::@upsize(&mat2x2_1, &m4, 2,1);
	@assert_print(m4,
		(Matrix4x4){{ 10, 10, 10, 10, 10, 10, 1, 4, 10, 10, -3, 3, 10, 10, 10, 10 }},
		"2,1 upsize not equal",
	);
	foreach (i, &val : m4.val) *val = 10;
	matrix::@upsize(&mat2x2_1, &m4, 2,2);
	@assert_print(m4,
		(Matrix4x4){{ 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 1, 4, 10, 10, -3, 3 }},
		"2,2 upsize not equal",
	);
}

import std::io;
macro @assert_print(a, b, $msg = "Not equal")
{
	io::printfn("actual:   %s", a);
	io::printfn("expected: %s", b);
	assert(a == b, $msg);
}
macro void round(&mat, double precision = 1000000)
{
	foreach (&val : mat.val)
	{
		if (*val == 0.0 || math::abs(*val) * precision < 1.0)
		{
			mem::set(val, 0, $typeof(*val).sizeof);
		}
		else
		{
			*val = math::round(precision * *val);
			*val /= precision;
		}
	}
}
macro rounded(mat, double precision = 1000000)
{
	$typeof(mat) result = mat;
	round(&result, precision);
	return result;
}

double[<2>] vec2 = { -3, 4 };
double[<3>] vec3 = { 1, -1, 5 };
double[<4>] vec4 = { -2, 3, 3, -1 };
double[<8>] vec8 = { -4, -3, 1, 1, 6, 8, 10, -2 };
double[2] arr2 = { -3, 4 };
double[3] arr3 = { 1, -1, 5 };
double[4] arr4 = { -2, 3, 3, -1 };
double[8] arr8 = { -4, -3, 1, 1, 6, 8, 10, -2 };

Matrix2x2 mat2x2_1 = {{ 1, 4, -3, 3 }};
Matrix2x2 mat2x2_2 = {{ -2, 2, 0, 1 }};
Matrix2x2 mat2x2_3 = {{ -1, 4, -3, -8 }};

Matrix3x3 mat3x3_1 = {{ 1, 2, -1, 3, -2, 1, -2, 4, 5 }};
Matrix3x3 mat3x3_2 = {{ 3, 4, -2, -5, 1, 1, 6, 8, 2 }};
Matrix3x3 mat3x3_3 = {{ 3, 3, 5, -1, -3, 4, 4, 5, 10 }};

Matrix3x2 mat3x2 = {{ 1, -3, -3, 2, 5, 8 }};
Matrix2x3 mat2x3 = {{ 4, 0, -1, 4, -10, 7 }};

Matrix4x4 mat4x4_1 = {{ 0, 3, 4, 1, 9, -3, -5, 2, 2, 2, 8, -8, -7, 7, 5, 4 }};
Matrix4x4 mat4x4_2 = {{ -1, 10, -5, 9, 12, 5, 2, -4, 0, 4, -12, -8, -6, 3, -9, -10 }};
Matrix4x4 mat4x4_3 = {{ 3, -12, -1, 2, 4, -8, -9, 11, -7, 8, 0, -4, -5, 6, 7, 5 }};

alias Matrix8x8 = Matrix{8,8, double};
Matrix8x8 mat8x8_1 = {{ 29, -82, 53, -84, -56, -98, 27, 97, 93, 84, 15, 7, 11, 69, -17, -13, 64, -78, -95, -10, -96, 98, -59, -48, 86, 8, 56, 76, 47, -85, -94, 32, -88, -20, -79, 94, 96, 79, 18, 30, 63, 66, 78, 62, -72, 36, -53, 81, -15, -28, 48, -87, -46, -69, 43, 49, -27, 91, -11, -39, 2, -12, -66, 65 }};
Matrix8x8 mat8x8_2 = {{ 99, 76, 61, -88, 79, 17, -96, -58, -19, -35, -59, -49, 11, 13, -82, -54, 45, -91, 23, -60, -11, -2, 58, 8, -77, 72, -63, -55, 19, 7, -8, 62, 12, 65, -32, -7, -34, -69, 77, 55, 4, -15, -3, 47, -79, 73, -30, 3, -93, -36, 75, -44, 9, -86, -78, -71, 64, -83, -43, 95, 52, 0, -87, 51 }};
Matrix8x8 mat8x8_3 = {{ -2, -10, 0, -3, -8, 12, 8, 2, 0, 3, 6, 3, -2, 1, 11, -5, -7, -2, -10, -2, 10, 1, -9, -8, -8, -12, 0, 8, -7, 0, 5, -3, -9, 7, -4, -1, 4, -1, 0, 7, 12, -8, 0, -10, 8, -4, -6, 9, -5, -11, -4, 2, -1, 9, 3, 2, 0, -9, -7, -5, -6, -7, 9, 9 }};
