module c3math::tests::matrices @test;
import c3math::matrix;
import c3math::matrix::mat_type;

import std::math @norecurse;

fn void scaled()
{
	@assert_print(matrix::scaled(vec2),
		(Matrix3x3){{ -3, 0, 0, 0, 4, 0, 0, 0, 1 }},
		"2D scaled not equal",
	);
	@assert_print(matrix::scaled(vec3),
		(Matrix4x4){{ 1, 0, 0, 0, 0, -1, 0, 0, 0, 0, 5, 0, 0, 0, 0, 1 }},
		"3D scaled not equal",
	);
}
fn void translated()
{
	@assert_print(matrix::translated(vec2),
		(Matrix3x3){{ 0, 0, 0, 0, 0, 0, -3, 4, 1 }},
		"2D translated not equal",
	);
	@assert_print(matrix::translated(vec3),
		(Matrix4x4){{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, -1, 5, 1 }},
		"3D translated not equal",
	);
}
fn void rotated_2d()
{
	@assert_print(rounded(matrix::rotated_2d(math::PI / 2)),
		(Matrix2x2){{ 0, 1, -1, 0 }},
		"rotated_2d not equal",
	);
}
fn void rotated_x()
{
	@assert_print(rounded(matrix::rotated_x(math::PI / 2)),
		(Matrix3x3){{ 1, 0, 0, 0, 0, 1, 0, -1, 0 }},
		"rotated_x not equal",
	);
}                         
fn void rotated_y()
{                         
	@assert_print(rounded(matrix::rotated_y(math::PI / 2)),
		(Matrix3x3){{ 0, 0, -1, 0, 1, 0, 1, 0, 0 }},
		"rotated_y not equal",
	);
}                         
fn void rotated_z()
{                         
	@assert_print(rounded(matrix::rotated_z(math::PI / 2)),
		(Matrix3x3){{ 0, 1, 0, -1, 0, 0, 0, 0, 1 }},
		"rotated_z not equal",
	);
}
fn void ortho()
{
	@assert_print(rounded(matrix::ortho(0, 20, 20, 0, 0.1, 100)),
		rounded((Matrix4x4){{ 0.100000001, 0, 0, 0, 0, -0.100000001, 0, 0, 0, 0, -0.0200200193, 0, -1, 1, -1.002002, 1 }}),
		"ortho not equal",
	);
}
fn void perspective()
{
	@assert_print(rounded(matrix::perspective(math::PI / 2, 1, 0.1, 100)),
		rounded((Matrix4x4){{ 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, -1.002002, -1, 0, 0, -0.2002002, 0 }}),
		"perspective not equal",
	);
}
fn void look()
{
	@assert_print(rounded(matrix::look((double[<3>]){ 1, -1, 1 }, (double[<3>]){ 0.140028, 0.700140, 0.700140 }, (double[<3>]){ 0, 1, 0 })),
		rounded((Matrix4x4){{-0.980580688, -0.137308761, -0.140028015, 0, 0, 0.714005589, -0.700140059, 0, 0.196116135, -0.686543822, -0.700140059, 0, 0.784464538, 1.53785825, 0.140028, 1}}),
		"look not equal",
	);
}
fn void look_at()
{
	@assert_print(rounded(matrix::look_at((double[<3>]){ 1, -1, 1 }, (double[<3>]){ 2, 4, 6 }, (double[<3>]){ 0, 1, 0 })),
		rounded((Matrix4x4){{-0.980580688, -0.137308761, -0.140028015, 0, 0, 0.714005589, -0.700140059, 0, 0.196116135, -0.686543822, -0.700140059, 0, 0.784464538, 1.53785825, 0.140028, 1}}),
		"look_at not equal",
	);
}
