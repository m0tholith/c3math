module maths;
import matrix;

import std::io;
import std::math::complex;

fn int main(String[] args)
{
	Matrix{3,2, double} mat1 = {{ 1.0, 2.0, -3.0, -4.0, 5.0, 6.0 }};
	io::printfn("mat1: %s", mat1);
	Matrix{3,2, double} mat2 = {{ -1.0, 5.0, -4.0, 3.0, -2.0, 12.0 }};
	io::printfn("mat2: %s", mat2);
	Matrix{3,2, double} mat3 = mat1 + mat2;
	io::printfn("mat3: mat1 + mat2 = %s", mat3);
	Matrix{3,2, double} mat4 = -mat3;
	io::printfn("mat4: -mat3 = %s", mat4);
	Matrix{2,3, double} mat5 = {{ -3.0, 6.0, -5.0, 8.0, 0.0, 2.0 }};
	io::printfn("mat5: %s", mat5);
	Matrix{3,3, double} mat6 = matrix::@mul(mat4,mat5);
	io::printfn("mat6: mat4 * mat5 = %s", mat6);
	Matrix{3,3, double} mat7 = mat6 * 0.5;
	io::printfn("mat7: mat6 * 0.5 = %s", mat7);
	Matrix{2,3, double} mat8 = matrix::@transpose(mat1);
	io::printfn("mat8: @transpose(mat1) = %s", mat8);
	Matrix{2,2, double} mat9 = matrix::@col_slice(matrix::@row_slice(mat7, 0), 0);
	io::printfn("mat9: @col_slice(@row_slice(mat7, 0), 0) = %s", mat9);
	double mat9_det = mat9.@determinant();
	io::printfn("mat9 determinant: %s", mat9_det);
	double[<2>] vec1 = { 3, 5 };
	io::printfn("vec1: %s", vec1);
	double[<2>] vec2 = mat9 * vec1;
	io::printfn("vec2: mat9 * vec1 = %s", vec2);
	return 0;
}
