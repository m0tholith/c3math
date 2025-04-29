module maths;
import matrix;

import std::io;
import std::math::random;

usz num;

fn int main(String[] args)
{
	rndIndex = rand(char.max);
	if (args.len <= 1)
	{
		general();
		return 0;
	}
	specialized(4);
	return 0;
}

fn void general()
{
	Matrix{2,2, double} mat  = {{ r(), r(), r(), r() }};
	Matrix{3,3, double} mat0 = {{ r(), r(), r(), r(), r(), r(), r(), r(), r() }};
	Matrix{3,2, double} mat1 = {{ r(), r(), r(), r(), r(), r() }};
	Matrix{3,2, double} mat2 = {{ r(), r(), r(), r(), r(), r() }};
	Matrix{2,3, double} mat3 = {{ r(), r(), r(), r(), r(), r() }};
	double scalar1 = r();
	double[<2>] vec1 = { r(), r() };
	for (int i = 0; i < 1000000; i++)
	{
		Matrix{3,2, double} mat4 = mat1 + mat2; num++;
		Matrix{2,3, double} mat5 = -mat3; num++;
		Matrix{3,3, double} mat6 = matrix::@mul(mat1,mat3); num++;
		Matrix{3,2, double} mat7 = mat2 * scalar1; num++;
		Matrix{2,3, double} mat8 = matrix::@transpose(mat1); num++;
		Matrix{2,2, double} mat9 = matrix::@col_slice(matrix::@row_slice(mat0, 0), 0); num++; num++;
		double mat9_det = mat0.@determinant(); num++;
		double[<2>] vec2 = mat9 * vec1; num++;
		Matrix{4,4, double} identity_4 = matrix::@identity(4); num++;
		double mat6_minor_1_1 = mat0.@minor(1, 1); num++;
		double mat9_cofactor_0_1 = mat0.@cofactor(0, 1); num++;
		Matrix{2,2, double} mat10 = mat.@comatrix(); num++;
		Matrix{2,2, double} mat11 = matrix::inverse(mat); num++;
		double mat10_trace = mat0.trace(); num++;
	}
	io::printn(num);
}
macro specialized($size)
{
	Matrix{$size,$size, double} mat1 = rand_mat($size);
	Matrix{$size,$size, double} mat2 = rand_mat($size);
	Matrix{$size,$size, double} mat3 = rand_mat($size);
	double scalar1 = r();
	double[<$size>] vec1 = rand_vec($size);
	for (int i = 0; i < 1000000; i++)
	{
		if (i % 10000 == 0) io::printfn("loop %d", i);
		Matrix{$size,$size, double} mat4 = mat1 + mat2; num++;
		Matrix{$size,$size, double} mat5 = -mat3; num++;
		Matrix{$size,$size, double} mat6 = matrix::@mul(mat4,mat5); num++;
		Matrix{$size,$size, double} mat7 = mat6 * scalar1; num++;
		Matrix{$size,$size, double} mat8 = matrix::@transpose(mat1); num++;
		Matrix{$size-1,$size-1, double} mat9 = matrix::@col_slice(matrix::@row_slice(mat7, 0), 0); num++; num++;
		double mat9_det = mat9.@determinant(); num++;
		double[<$size>] vec2 = mat8 * vec1; num++;
		Matrix{$size,$size, double} identity_4 = matrix::@identity($size); num++;
		double mat6_minor_1_1 = mat6.@minor(1, 1); num++;
		double mat9_cofactor_0_1 = mat8.@cofactor(0, 1); num++;
		Matrix{$size,$size, double} mat10 = mat8.@comatrix(); num++;
		Matrix{$size,$size, double} mat11 = matrix::inverse(mat10); num++;
		double mat10_trace = mat10.trace(); num++;
	}
	io::printn(num);
}
macro rand_mat($size)
{
	Matrix{$size,$size, double} result;
	for (usz i = 0; i < $size * $size; i++) result.val[i] = r();
	return result;
}
macro rand_vec($size)
{
	double[<$size>] result;
	for (usz i = 0; i < $size; i++) result[i] = r();
	return result;
}

char[] rndTable = {
    0,   8, 109, 220, 222, 241, 149, 107,  75, 248, 254, 140,  16,  66 ,
    74,  21, 211,  47,  80, 242, 154,  27, 205, 128, 161,  89,  77,  36 ,
    95, 110,  85,  48, 212, 140, 211, 249,  22,  79, 200,  50,  28, 188 ,
    52, 140, 202, 120,  68, 145,  62,  70, 184, 190,  91, 197, 152, 224 ,
    149, 104,  25, 178, 252, 182, 202, 182, 141, 197,   4,  81, 181, 242 ,
    145,  42,  39, 227, 156, 198, 225, 193, 219,  93, 122, 175, 249,   0 ,
    175, 143,  70, 239,  46, 246, 163,  53, 163, 109, 168, 135,   2, 235 ,
    25,  92,  20, 145, 138,  77,  69, 166,  78, 176, 173, 212, 166, 113 ,
    94, 161,  41,  50, 239,  49, 111, 164,  70,  60,   2,  37, 171,  75 ,
    136, 156,  11,  56,  42, 146, 138, 229,  73, 146,  77,  61,  98, 196 ,
    135, 106,  63, 197, 195,  86,  96, 203, 113, 101, 170, 247, 181, 113 ,
    80, 250, 108,   7, 255, 237, 129, 226,  79, 107, 112, 166, 103, 241 ,
    24, 223, 239, 120, 198,  58,  60,  82, 128,   3, 184,  66, 143, 224 ,
    145, 224,  81, 206, 163,  45,  63,  90, 168, 114,  59,  33, 159,  95 ,
    28, 139, 123,  98, 125, 196,  15,  70, 194, 253,  54,  14, 109, 226 ,
    71,  17, 161,  93, 186,  87, 244, 138,  20,  52, 123, 251,  26,  36 ,
    17,  46,  52, 231, 232,  76,  31, 221,  84,  37, 216, 165, 212, 106 ,
    197, 242,  98,  43,  39, 175, 254, 145, 190,  84, 118, 222, 187, 136 ,
    120, 163, 236, 249
};
usz rndIndex = 0;
fn double random() => (double)rndTable[(rndIndex++) % 0xFF] / (double)char.max;
macro double random_range(min, max) => min + (double)(max - min) * random();

macro r(min = -20, max = 20) => min + (double)(max - min) * (double)random_range(min, max);
