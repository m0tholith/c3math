module c3math::tests::matrices @test;
import c3math::matrix;

fn void test_mat2()
{
		Matrix2x2 mat = {{ 3, 5, 5, 2}};
		Matrix2x2 mat2 = {{ 4, 7, 2, 8 }};
		Matrix2x2 calc = mat.mul(mat2);
		Matrix2x2 value = {{ 47, 34, 46, 26 }};

		test::eq(calc.m, value.m);
}

fn void matric_scalar_mul()
{
	Matrix2x2 mat = {{ 3, 5, 5, 2}};
	Matrix2x2 calc = mat * 2;
	Matrix2x2 value = {{ 6, 10, 10, 4 }};
	test::eq(calc.m, value.m);

	calc = mat *= 2;
    test::eq(calc.m, value.m);
    test::eq(mat.m, value.m);
}

fn void matric_scalar_div()
{
	Matrix2x2 mat = {{ 3, 5, 5, 2}};
	Matrix2x2 calc = mat / 2;
	Matrix2x2 value = {{ 1.5, 2.5, 2.5, 1 }};
	test::eq(calc.m, value.m);

	calc = mat /= 2;
    test::eq(calc.m, value.m);
    test::eq(mat.m, value.m);
}
