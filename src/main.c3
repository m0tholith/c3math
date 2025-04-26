module maths;

import matrix;
import std::io;

fn int main(String[] args)
{
	Matrix{3,2} mat1 = {{ 1.0, 2.0, -3.0, -4.0, 5.0, 6.0 }};
	io::printfn("mat1: %s", mat1);
	Matrix{3,2} mat2 = {{ -1.0, 5.0, -4.0, 3.0, -2.0, 12.0 }};
	io::printfn("mat2: %s", mat2);
	Matrix{3,2} mat3 = mat1 + mat2;
	io::printfn("mat3: mat1 + mat2 = %s", mat3);
	Matrix{3,2} mat4 = -mat3;
	io::printfn("mat4: -mat3 = %s", mat4);
	Matrix{2,3} mat5 = {{ -3.0, 6.0, -5.0, 8.0, 0.0, 2.0 }};
	io::printfn("mat5: %s", mat5);
	Matrix{3,3} mat6 = @mul(mat4,mat5);
	io::printfn("mat6: mat4 * mat5 = %s", mat6);
	Matrix{3,3} mat7 = mat6 * 0.5;
	io::printfn("mat7: mat6 * 0.5 = %s", mat7);
	Matrix{2,3} mat8 = @transpose(mat1);
	io::printfn("mat8: @transpose(mat1) = %s", mat8);
	Matrix{2,2} mat9 = @col_slice(@row_slice(mat7, 0), 0);
	io::printfn("mat9: @col_slice(@row_slice(mat7, 0), 0) = %s", mat9);
	double mat9_det = mat9.@determinant();
	io::printfn("mat9 determinant: %f", mat9_det);
	return 0;
}
