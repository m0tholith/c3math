module c3math::matrix;

alias Matrix1x1 = Matrix{1,1, double};
alias Matrix1x1f = Matrix{1,1, float};
alias Matrix2x2 = Matrix{2,2, double};
alias Matrix2x2f = Matrix{2,2, float};
alias Matrix3x3 = Matrix{3,3, double};
alias Matrix3x3f = Matrix{3,3, float};
alias Matrix4x4 = Matrix{4,4, double};
alias Matrix4x4f = Matrix{4,4, float};

const MATRIX1X1_IDENTITY  = (Matrix1x1 ){{ 1 }};
const MATRIX1X1_IDENTITYF = (Matrix1x1f){{ 1 }};
const MATRIX2X2_IDENTITY  = (Matrix2x2 ){{ 1, 0, 0, 1 }};
const MATRIX2X2_IDENTITYF = (Matrix2x2f){{ 1, 0, 0, 1 }};
const MATRIX3X3_IDENTITY  = (Matrix3x3 ){{ 1, 0, 0, 0, 1, 0, 0, 0, 1 }};
const MATRIX3X3_IDENTITYF = (Matrix3x3f){{ 1, 0, 0, 0, 1, 0, 0, 0, 1 }};
const MATRIX4X4_IDENTITY  = (Matrix4x4 ){{ 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 }};
const MATRIX4X4_IDENTITYF = (Matrix4x4f){{ 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1 }};

alias Matrix3x2 = Matrix{3,2, double};
alias Matrix3x2f = Matrix{3,2, float};
alias Matrix2x3 = Matrix{2,3, double};
alias Matrix2x3f = Matrix{2,3, float};

alias Matrix1x2 = Matrix{1,2, double};
alias Matrix1x2f = Matrix{1,2, float};
alias Matrix1x3 = Matrix{1,3, double};
alias Matrix1x3f = Matrix{1,3, float};
alias Matrix1x4 = Matrix{1,4, double};
alias Matrix1x4f = Matrix{1,4, float};

alias Matrix2x1 = Matrix{2,1, double};
alias Matrix2x1f = Matrix{2,1, float};
alias Matrix3x1 = Matrix{3,1, double};
alias Matrix3x1f = Matrix{3,1, float};
alias Matrix4x1 = Matrix{4,1, double};
alias Matrix4x1f = Matrix{4,1, float};

fn Matrix1x1 Matrix1x1.mul(&a, Matrix1x1 b) @operator(*) => {{ a.val[0] * b.val[0] }};
fn void Matrix1x1.mul_assign(&a, Matrix1x1 b) @operator(*=) => a.val[0] *= b.val[0];


fn Matrix3x3 Matrix3x3.mul(&a, Matrix3x3 b) @operator(*) => {{
	((double[<3>])b.m[0]).dot((double[<3>]){ a.m[0][0], a.m[1][0], a.m[2][0] }),
	((double[<3>])b.m[0]).dot((double[<3>]){ a.m[0][1], a.m[1][1], a.m[2][1] }),
	((double[<3>])b.m[0]).dot((double[<3>]){ a.m[0][2], a.m[1][2], a.m[2][2] }),
	((double[<3>])b.m[1]).dot((double[<3>]){ a.m[0][0], a.m[1][0], a.m[2][0] }),
	((double[<3>])b.m[1]).dot((double[<3>]){ a.m[0][1], a.m[1][1], a.m[2][1] }),
	((double[<3>])b.m[1]).dot((double[<3>]){ a.m[0][2], a.m[1][2], a.m[2][2] }),
	((double[<3>])b.m[2]).dot((double[<3>]){ a.m[0][0], a.m[1][0], a.m[2][0] }),
	((double[<3>])b.m[2]).dot((double[<3>]){ a.m[0][1], a.m[1][1], a.m[2][1] }),
	((double[<3>])b.m[2]).dot((double[<3>]){ a.m[0][2], a.m[1][2], a.m[2][2] }),
}};
fn void Matrix3x3.mul_assign(&a, Matrix3x3 b) @operator(*=) => a.val = {
	((double[<3>])b.m[0]).dot((double[<3>]){ a.m[0][0], a.m[1][0], a.m[2][0] }),
	((double[<3>])b.m[0]).dot((double[<3>]){ a.m[0][1], a.m[1][1], a.m[2][1] }),
	((double[<3>])b.m[0]).dot((double[<3>]){ a.m[0][2], a.m[1][2], a.m[2][2] }),
	((double[<3>])b.m[1]).dot((double[<3>]){ a.m[0][0], a.m[1][0], a.m[2][0] }),
	((double[<3>])b.m[1]).dot((double[<3>]){ a.m[0][1], a.m[1][1], a.m[2][1] }),
	((double[<3>])b.m[1]).dot((double[<3>]){ a.m[0][2], a.m[1][2], a.m[2][2] }),
	((double[<3>])b.m[2]).dot((double[<3>]){ a.m[0][0], a.m[1][0], a.m[2][0] }),
	((double[<3>])b.m[2]).dot((double[<3>]){ a.m[0][1], a.m[1][1], a.m[2][1] }),
	((double[<3>])b.m[2]).dot((double[<3>]){ a.m[0][2], a.m[1][2], a.m[2][2] }),
};
fn Matrix4x4 Matrix4x4.mul(&a, Matrix4x4 b) @operator(*) => {{
	b.m[0].dot((double[<4>]){ a.m[0][0], a.m[1][0], a.m[2][0], a.m[3][0] }),
	b.m[0].dot((double[<4>]){ a.m[0][1], a.m[1][1], a.m[2][1], a.m[3][1] }),
	b.m[0].dot((double[<4>]){ a.m[0][2], a.m[1][2], a.m[2][2], a.m[3][2] }),
	b.m[0].dot((double[<4>]){ a.m[0][3], a.m[1][3], a.m[2][3], a.m[3][3] }),
	b.m[1].dot((double[<4>]){ a.m[0][0], a.m[1][0], a.m[2][0], a.m[3][0] }),
	b.m[1].dot((double[<4>]){ a.m[0][1], a.m[1][1], a.m[2][1], a.m[3][1] }),
	b.m[1].dot((double[<4>]){ a.m[0][2], a.m[1][2], a.m[2][2], a.m[3][2] }),
	b.m[1].dot((double[<4>]){ a.m[0][3], a.m[1][3], a.m[2][3], a.m[3][3] }),
	b.m[2].dot((double[<4>]){ a.m[0][0], a.m[1][0], a.m[2][0], a.m[3][0] }),
	b.m[2].dot((double[<4>]){ a.m[0][1], a.m[1][1], a.m[2][1], a.m[3][1] }),
	b.m[2].dot((double[<4>]){ a.m[0][2], a.m[1][2], a.m[2][2], a.m[3][2] }),
	b.m[2].dot((double[<4>]){ a.m[0][3], a.m[1][3], a.m[2][3], a.m[3][3] }),
	b.m[3].dot((double[<4>]){ a.m[0][0], a.m[1][0], a.m[2][0], a.m[3][0] }),
	b.m[3].dot((double[<4>]){ a.m[0][1], a.m[1][1], a.m[2][1], a.m[3][1] }),
	b.m[3].dot((double[<4>]){ a.m[0][2], a.m[1][2], a.m[2][2], a.m[3][2] }),
	b.m[3].dot((double[<4>]){ a.m[0][3], a.m[1][3], a.m[2][3], a.m[3][3] }),
}};
fn void Matrix4x4.mul_assign(&a, Matrix4x4 b) @operator(*=) => a.val = {
	b.m[0].dot((double[<4>]){ a.m[0][0], a.m[1][0], a.m[2][0], a.m[3][0] }),
	b.m[0].dot((double[<4>]){ a.m[0][1], a.m[1][1], a.m[2][1], a.m[3][1] }),
	b.m[0].dot((double[<4>]){ a.m[0][2], a.m[1][2], a.m[2][2], a.m[3][2] }),
	b.m[0].dot((double[<4>]){ a.m[0][3], a.m[1][3], a.m[2][3], a.m[3][3] }),
	b.m[1].dot((double[<4>]){ a.m[0][0], a.m[1][0], a.m[2][0], a.m[3][0] }),
	b.m[1].dot((double[<4>]){ a.m[0][1], a.m[1][1], a.m[2][1], a.m[3][1] }),
	b.m[1].dot((double[<4>]){ a.m[0][2], a.m[1][2], a.m[2][2], a.m[3][2] }),
	b.m[1].dot((double[<4>]){ a.m[0][3], a.m[1][3], a.m[2][3], a.m[3][3] }),
	b.m[2].dot((double[<4>]){ a.m[0][0], a.m[1][0], a.m[2][0], a.m[3][0] }),
	b.m[2].dot((double[<4>]){ a.m[0][1], a.m[1][1], a.m[2][1], a.m[3][1] }),
	b.m[2].dot((double[<4>]){ a.m[0][2], a.m[1][2], a.m[2][2], a.m[3][2] }),
	b.m[2].dot((double[<4>]){ a.m[0][3], a.m[1][3], a.m[2][3], a.m[3][3] }),
	b.m[3].dot((double[<4>]){ a.m[0][0], a.m[1][0], a.m[2][0], a.m[3][0] }),
	b.m[3].dot((double[<4>]){ a.m[0][1], a.m[1][1], a.m[2][1], a.m[3][1] }),
	b.m[3].dot((double[<4>]){ a.m[0][2], a.m[1][2], a.m[2][2], a.m[3][2] }),
	b.m[3].dot((double[<4>]){ a.m[0][3], a.m[1][3], a.m[2][3], a.m[3][3] }),
};
fn Matrix3x3 Matrix3x2.mul(&a, Matrix2x3 b) @operator(*) => {{
	b.m[0].dot((double[<2>]){ a.m[0][0], a.m[1][0] }),
	b.m[0].dot((double[<2>]){ a.m[0][1], a.m[1][1] }),
	b.m[0].dot((double[<2>]){ a.m[0][2], a.m[1][2] }),
	b.m[1].dot((double[<2>]){ a.m[0][0], a.m[1][0] }),
	b.m[1].dot((double[<2>]){ a.m[0][1], a.m[1][1] }),
	b.m[1].dot((double[<2>]){ a.m[0][2], a.m[1][2] }),
	b.m[2].dot((double[<2>]){ a.m[0][0], a.m[1][0] }),
	b.m[2].dot((double[<2>]){ a.m[0][1], a.m[1][1] }),
	b.m[2].dot((double[<2>]){ a.m[0][2], a.m[1][2] }),
}};
fn Matrix2x2 Matrix2x3.mul(&a, Matrix3x2 b) @operator(*) => {{
	((double[<3>])b.m[0]).dot((double[<3>]){ a.m[0][0], a.m[1][0], a.m[2][0] }),
	((double[<3>])b.m[0]).dot((double[<3>]){ a.m[0][1], a.m[1][1], a.m[2][1] }),
	((double[<3>])b.m[1]).dot((double[<3>]){ a.m[0][0], a.m[1][0], a.m[2][0] }),
	((double[<3>])b.m[1]).dot((double[<3>]){ a.m[0][1], a.m[1][1], a.m[2][1] }),
}};
fn Matrix1x1 Matrix1x2.mul(&a, Matrix2x1 b) @operator(*) => {{
	b.m[0].dot((double[<2>])a.val),
}};
fn Matrix1x1 Matrix1x3.mul(&a, Matrix3x1 b) @operator(*) => {{
	((double[<3>])b.m[0]).dot((double[<3>])a.val),
}};
fn Matrix1x1 Matrix1x4.mul(&a, Matrix4x1 b) @operator(*) => {{
	b.m[0].dot((double[<4>])a.val),
}};
fn Matrix2x2 Matrix2x1.mul(&a, Matrix1x2 b) @operator(*) => {{
	a.val[0] * b.val[0],
	a.val[1] * b.val[0],
	a.val[0] * b.val[1],
	a.val[1] * b.val[1],
}};
fn Matrix3x3 Matrix3x1.mul(&a, Matrix1x3 b) @operator(*) => {{
	a.val[0] * b.val[0],
	a.val[1] * b.val[0],
	a.val[2] * b.val[0],
	a.val[0] * b.val[1],
	a.val[1] * b.val[1],
	a.val[2] * b.val[1],
	a.val[0] * b.val[2],
	a.val[1] * b.val[2],
	a.val[2] * b.val[2],
}};
fn Matrix4x4 Matrix4x1.mul(&a, Matrix1x4 b) @operator(*) => {{
	a.val[0] * b.val[0],
	a.val[1] * b.val[0],
	a.val[2] * b.val[0],
	a.val[3] * b.val[0],
	a.val[0] * b.val[1],
	a.val[1] * b.val[1],
	a.val[2] * b.val[1],
	a.val[3] * b.val[1],
	a.val[0] * b.val[2],
	a.val[1] * b.val[2],
	a.val[2] * b.val[2],
	a.val[3] * b.val[2],
	a.val[0] * b.val[3],
	a.val[1] * b.val[3],
	a.val[2] * b.val[3],
	a.val[3] * b.val[3],
}};

fn Matrix1x1f Matrix1x1f.mul(&a, Matrix1x1f b) @operator(*) => {{ a.val[0] * b.val[0] }};
fn void Matrix1x1f.mul_assign(&a, Matrix1x1f b) @operator(*=) => a.val[0] *= b.val[0];
fn Matrix3x3f Matrix3x3f.mul(&a, Matrix3x3f b) @operator(*) => {{
	((float[<3>])b.m[0]).dot((float[<3>]){ a.m[0][0], a.m[1][0], a.m[2][0] }),
	((float[<3>])b.m[0]).dot((float[<3>]){ a.m[0][1], a.m[1][1], a.m[2][1] }),
	((float[<3>])b.m[0]).dot((float[<3>]){ a.m[0][2], a.m[1][2], a.m[2][2] }),
	((float[<3>])b.m[1]).dot((float[<3>]){ a.m[0][0], a.m[1][0], a.m[2][0] }),
	((float[<3>])b.m[1]).dot((float[<3>]){ a.m[0][1], a.m[1][1], a.m[2][1] }),
	((float[<3>])b.m[1]).dot((float[<3>]){ a.m[0][2], a.m[1][2], a.m[2][2] }),
	((float[<3>])b.m[2]).dot((float[<3>]){ a.m[0][0], a.m[1][0], a.m[2][0] }),
	((float[<3>])b.m[2]).dot((float[<3>]){ a.m[0][1], a.m[1][1], a.m[2][1] }),
	((float[<3>])b.m[2]).dot((float[<3>]){ a.m[0][2], a.m[1][2], a.m[2][2] }),
}};
fn void Matrix3x3f.mul_assign(&a, Matrix3x3f b) @operator(*=) => a.val = {
	((float[<3>])b.m[0]).dot((float[<3>]){ a.m[0][0], a.m[1][0], a.m[2][0] }),
	((float[<3>])b.m[0]).dot((float[<3>]){ a.m[0][1], a.m[1][1], a.m[2][1] }),
	((float[<3>])b.m[0]).dot((float[<3>]){ a.m[0][2], a.m[1][2], a.m[2][2] }),
	((float[<3>])b.m[1]).dot((float[<3>]){ a.m[0][0], a.m[1][0], a.m[2][0] }),
	((float[<3>])b.m[1]).dot((float[<3>]){ a.m[0][1], a.m[1][1], a.m[2][1] }),
	((float[<3>])b.m[1]).dot((float[<3>]){ a.m[0][2], a.m[1][2], a.m[2][2] }),
	((float[<3>])b.m[2]).dot((float[<3>]){ a.m[0][0], a.m[1][0], a.m[2][0] }),
	((float[<3>])b.m[2]).dot((float[<3>]){ a.m[0][1], a.m[1][1], a.m[2][1] }),
	((float[<3>])b.m[2]).dot((float[<3>]){ a.m[0][2], a.m[1][2], a.m[2][2] }),
};
fn Matrix4x4f Matrix4x4f.mul(&a, Matrix4x4f b) @operator(*) => {{
	b.m[0].dot((float[<4>]){ a.m[0][0], a.m[1][0], a.m[2][0], a.m[3][0] }),
	b.m[0].dot((float[<4>]){ a.m[0][1], a.m[1][1], a.m[2][1], a.m[3][1] }),
	b.m[0].dot((float[<4>]){ a.m[0][2], a.m[1][2], a.m[2][2], a.m[3][2] }),
	b.m[0].dot((float[<4>]){ a.m[0][3], a.m[1][3], a.m[2][3], a.m[3][3] }),
	b.m[1].dot((float[<4>]){ a.m[0][0], a.m[1][0], a.m[2][0], a.m[3][0] }),
	b.m[1].dot((float[<4>]){ a.m[0][1], a.m[1][1], a.m[2][1], a.m[3][1] }),
	b.m[1].dot((float[<4>]){ a.m[0][2], a.m[1][2], a.m[2][2], a.m[3][2] }),
	b.m[1].dot((float[<4>]){ a.m[0][3], a.m[1][3], a.m[2][3], a.m[3][3] }),
	b.m[2].dot((float[<4>]){ a.m[0][0], a.m[1][0], a.m[2][0], a.m[3][0] }),
	b.m[2].dot((float[<4>]){ a.m[0][1], a.m[1][1], a.m[2][1], a.m[3][1] }),
	b.m[2].dot((float[<4>]){ a.m[0][2], a.m[1][2], a.m[2][2], a.m[3][2] }),
	b.m[2].dot((float[<4>]){ a.m[0][3], a.m[1][3], a.m[2][3], a.m[3][3] }),
	b.m[3].dot((float[<4>]){ a.m[0][0], a.m[1][0], a.m[2][0], a.m[3][0] }),
	b.m[3].dot((float[<4>]){ a.m[0][1], a.m[1][1], a.m[2][1], a.m[3][1] }),
	b.m[3].dot((float[<4>]){ a.m[0][2], a.m[1][2], a.m[2][2], a.m[3][2] }),
	b.m[3].dot((float[<4>]){ a.m[0][3], a.m[1][3], a.m[2][3], a.m[3][3] }),
}};
fn void Matrix4x4f.mul_assign(&a, Matrix4x4f b) @operator(*=) => a.val = {
	b.m[0].dot((float[<4>]){ a.m[0][0], a.m[1][0], a.m[2][0], a.m[3][0] }),
	b.m[0].dot((float[<4>]){ a.m[0][1], a.m[1][1], a.m[2][1], a.m[3][1] }),
	b.m[0].dot((float[<4>]){ a.m[0][2], a.m[1][2], a.m[2][2], a.m[3][2] }),
	b.m[0].dot((float[<4>]){ a.m[0][3], a.m[1][3], a.m[2][3], a.m[3][3] }),
	b.m[1].dot((float[<4>]){ a.m[0][0], a.m[1][0], a.m[2][0], a.m[3][0] }),
	b.m[1].dot((float[<4>]){ a.m[0][1], a.m[1][1], a.m[2][1], a.m[3][1] }),
	b.m[1].dot((float[<4>]){ a.m[0][2], a.m[1][2], a.m[2][2], a.m[3][2] }),
	b.m[1].dot((float[<4>]){ a.m[0][3], a.m[1][3], a.m[2][3], a.m[3][3] }),
	b.m[2].dot((float[<4>]){ a.m[0][0], a.m[1][0], a.m[2][0], a.m[3][0] }),
	b.m[2].dot((float[<4>]){ a.m[0][1], a.m[1][1], a.m[2][1], a.m[3][1] }),
	b.m[2].dot((float[<4>]){ a.m[0][2], a.m[1][2], a.m[2][2], a.m[3][2] }),
	b.m[2].dot((float[<4>]){ a.m[0][3], a.m[1][3], a.m[2][3], a.m[3][3] }),
	b.m[3].dot((float[<4>]){ a.m[0][0], a.m[1][0], a.m[2][0], a.m[3][0] }),
	b.m[3].dot((float[<4>]){ a.m[0][1], a.m[1][1], a.m[2][1], a.m[3][1] }),
	b.m[3].dot((float[<4>]){ a.m[0][2], a.m[1][2], a.m[2][2], a.m[3][2] }),
	b.m[3].dot((float[<4>]){ a.m[0][3], a.m[1][3], a.m[2][3], a.m[3][3] }),
};
fn Matrix3x3f Matrix3x2f.mul(&a, Matrix2x3f b) @operator(*) => {{
	b.m[0].dot((float[<2>]){ a.m[0][0], a.m[1][0] }),
	b.m[0].dot((float[<2>]){ a.m[0][1], a.m[1][1] }),
	b.m[0].dot((float[<2>]){ a.m[0][2], a.m[1][2] }),
	b.m[1].dot((float[<2>]){ a.m[0][0], a.m[1][0] }),
	b.m[1].dot((float[<2>]){ a.m[0][1], a.m[1][1] }),
	b.m[1].dot((float[<2>]){ a.m[0][2], a.m[1][2] }),
	b.m[2].dot((float[<2>]){ a.m[0][0], a.m[1][0] }),
	b.m[2].dot((float[<2>]){ a.m[0][1], a.m[1][1] }),
	b.m[2].dot((float[<2>]){ a.m[0][2], a.m[1][2] }),
}};
fn Matrix2x2f Matrix2x3f.mul(&a, Matrix3x2f b) @operator(*) => {{
	((float[<3>])b.m[0]).dot((float[<3>]){ a.m[0][0], a.m[1][0], a.m[2][0] }),
	((float[<3>])b.m[0]).dot((float[<3>]){ a.m[0][1], a.m[1][1], a.m[2][1] }),
	((float[<3>])b.m[1]).dot((float[<3>]){ a.m[0][0], a.m[1][0], a.m[2][0] }),
	((float[<3>])b.m[1]).dot((float[<3>]){ a.m[0][1], a.m[1][1], a.m[2][1] }),
}};
fn Matrix1x1f Matrix1x2f.mul(&a, Matrix2x1f b) @operator(*) => {{
	b.m[0].dot((float[<2>])a.val),
}};
fn Matrix1x1f Matrix1x3f.mul(&a, Matrix3x1f b) @operator(*) => {{
	((float[<3>])b.m[0]).dot((float[<3>])a.val),
}};
fn Matrix1x1f Matrix1x4f.mul(&a, Matrix4x1f b) @operator(*) => {{
	b.m[0].dot((float[<4>])a.val),
}};
fn Matrix2x2f Matrix2x1f.mul(&a, Matrix1x2f b) @operator(*) => {{
	a.val[0] * b.val[0],
	a.val[1] * b.val[0],
	a.val[0] * b.val[1],
	a.val[1] * b.val[1],
}};
fn Matrix3x3f Matrix3x1f.mul(&a, Matrix1x3f b) @operator(*) => {{
	a.val[0] * b.val[0],
	a.val[1] * b.val[0],
	a.val[2] * b.val[0],
	a.val[0] * b.val[1],
	a.val[1] * b.val[1],
	a.val[2] * b.val[1],
	a.val[0] * b.val[2],
	a.val[1] * b.val[2],
	a.val[2] * b.val[2],
}};
fn Matrix4x4f Matrix4x1f.mul(&a, Matrix1x4f b) @operator(*) => {{
	a.val[0] * b.val[0],
	a.val[1] * b.val[0],
	a.val[2] * b.val[0],
	a.val[3] * b.val[0],
	a.val[0] * b.val[1],
	a.val[1] * b.val[1],
	a.val[2] * b.val[1],
	a.val[3] * b.val[1],
	a.val[0] * b.val[2],
	a.val[1] * b.val[2],
	a.val[2] * b.val[2],
	a.val[3] * b.val[2],
	a.val[0] * b.val[3],
	a.val[1] * b.val[3],
	a.val[2] * b.val[3],
	a.val[3] * b.val[3],
}};

fn Matrix1x1 Matrix1x1.transposed(&self) => *self;
fn Matrix2x2 Matrix2x2.transposed(&self) => {{
	[0] = self.val[0], [2] = self.val[1],
	[1] = self.val[2], [3] = self.val[3],
}};
fn Matrix3x3 Matrix3x3.transposed(&self) => {{
	[0] = self.val[0], [3] = self.val[1], [6] = self.val[2],
	[1] = self.val[3], [4] = self.val[4], [7] = self.val[5],
	[2] = self.val[6], [5] = self.val[7], [8] = self.val[8],
}};
fn Matrix4x4 Matrix4x4.transposed(&self) => {{
	[0] = self.val[0],  [4] = self.val[1],  [8]  = self.val[2],  [12] = self.val[3],
	[1] = self.val[4],  [5] = self.val[5],  [9]  = self.val[6],  [13] = self.val[7],
	[2] = self.val[8],  [6] = self.val[9],  [10] = self.val[10], [14] = self.val[11],
	[3] = self.val[12], [7] = self.val[13], [11] = self.val[14], [15] = self.val[15],
}};
fn Matrix2x3 Matrix3x2.transposed(&self) => {{
	[0] = self.val[0], [2] = self.val[1], [4] = self.val[2],
	[1] = self.val[3], [3] = self.val[4], [5] = self.val[5],
}};
fn Matrix3x2 Matrix2x3.transposed(&self) => {{
	[0] = self.val[0], [3] = self.val[1],
	[1] = self.val[2], [4] = self.val[3],
	[2] = self.val[4], [5] = self.val[5],
}};
fn Matrix2x1 Matrix1x2.transposed(&self) => { self.val };
fn Matrix3x1 Matrix1x3.transposed(&self) => { self.val };
fn Matrix4x1 Matrix1x4.transposed(&self) => { self.val };
fn Matrix1x2 Matrix2x1.transposed(&self) => { self.val };
fn Matrix1x3 Matrix3x1.transposed(&self) => { self.val };
fn Matrix1x4 Matrix4x1.transposed(&self) => { self.val };

fn Matrix1x1f Matrix1x1f.transposed(&self) => *self;
fn Matrix2x2f Matrix2x2f.transposed(&self) => {{
	[0] = self.val[0], [2] = self.val[1],
	[1] = self.val[2], [3] = self.val[3],
}};
fn Matrix3x3f Matrix3x3f.transposed(&self) => {{
	[0] = self.val[0], [3] = self.val[1], [6] = self.val[2],
	[1] = self.val[3], [4] = self.val[4], [7] = self.val[5],
	[2] = self.val[6], [5] = self.val[7], [8] = self.val[8],
}};
fn Matrix4x4f Matrix4x4f.transposed(&self) => {{
	[0] = self.val[0],  [4] = self.val[1],  [8]  = self.val[2],  [12] = self.val[3],
	[1] = self.val[4],  [5] = self.val[5],  [9]  = self.val[6],  [13] = self.val[7],
	[2] = self.val[8],  [6] = self.val[9],  [10] = self.val[10], [14] = self.val[11],
	[3] = self.val[12], [7] = self.val[13], [11] = self.val[14], [15] = self.val[15],
}};
fn Matrix2x3f Matrix3x2f.transposed(&self) => {{
	[0] = self.val[0], [2] = self.val[1], [4] = self.val[2],
	[1] = self.val[3], [3] = self.val[4], [5] = self.val[5],
}};
fn Matrix3x2f Matrix2x3f.transposed(&self) => {{
	[0] = self.val[0], [3] = self.val[1],
	[1] = self.val[2], [4] = self.val[3],
	[2] = self.val[4], [5] = self.val[5],
}};
fn Matrix2x1f Matrix1x2f.transposed(&self) => { self.val };
fn Matrix3x1f Matrix1x3f.transposed(&self) => { self.val };
fn Matrix4x1f Matrix1x4f.transposed(&self) => { self.val };
fn Matrix1x2f Matrix2x1f.transposed(&self) => { self.val };
fn Matrix1x3f Matrix3x1f.transposed(&self) => { self.val };
fn Matrix1x4f Matrix4x1f.transposed(&self) => { self.val };

fn void Matrix2x2.adjugate(&self, Matrix2x2* source)
{
	self.comatrix_assign(source);
	self.transpose();
}
fn void Matrix3x3.adjugate(&self, Matrix3x3* source)
{
	self.comatrix_assign(source);
	self.transpose();
}
fn void Matrix4x4.adjugate(&self, Matrix4x4* source)
{
	self.comatrix_assign(source);
	self.transpose();
}

fn void Matrix2x2f.adjugate(&self, Matrix2x2f* source)
{
	self.comatrix_assign(source);
	self.transpose();
}
fn void Matrix3x3f.adjugate(&self, Matrix3x3f* source)
{
	self.comatrix_assign(source);
	self.transpose();
}
fn void Matrix4x4f.adjugate(&self, Matrix4x4f* source)
{
	self.comatrix_assign(source);
	self.transpose();
}
