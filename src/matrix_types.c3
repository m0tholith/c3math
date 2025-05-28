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

<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix1x1 Matrix1x1.transposed(&self) => *self;
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix2x2 Matrix2x2.transposed(&self) => {{
	[0] = self.val[0], [2] = self.val[1],
	[1] = self.val[2], [3] = self.val[3],
}};
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix3x3 Matrix3x3.transposed(&self) => {{
	[0] = self.val[0], [3] = self.val[1], [6] = self.val[2],
	[1] = self.val[3], [4] = self.val[4], [7] = self.val[5],
	[2] = self.val[6], [5] = self.val[7], [8] = self.val[8],
}};
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix4x4 Matrix4x4.transposed(&self) => {{
	[0] = self.val[0],  [4] = self.val[1],  [8]  = self.val[2],  [12] = self.val[3],
	[1] = self.val[4],  [5] = self.val[5],  [9]  = self.val[6],  [13] = self.val[7],
	[2] = self.val[8],  [6] = self.val[9],  [10] = self.val[10], [14] = self.val[11],
	[3] = self.val[12], [7] = self.val[13], [11] = self.val[14], [15] = self.val[15],
}};
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix2x3 Matrix3x2.transposed(&self) => {{
	[0] = self.val[0], [2] = self.val[1], [4] = self.val[2],
	[1] = self.val[3], [3] = self.val[4], [5] = self.val[5],
}};
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix3x2 Matrix2x3.transposed(&self) => {{
	[0] = self.val[0], [3] = self.val[1],
	[1] = self.val[2], [4] = self.val[3],
	[2] = self.val[4], [5] = self.val[5],
}};
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix2x1 Matrix1x2.transposed(&self) => { self.val };
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix3x1 Matrix1x3.transposed(&self) => { self.val };
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix4x1 Matrix1x4.transposed(&self) => { self.val };
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix1x2 Matrix2x1.transposed(&self) => { self.val };
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix1x3 Matrix3x1.transposed(&self) => { self.val };
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix1x4 Matrix4x1.transposed(&self) => { self.val };
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix1x1f Matrix1x1f.transposed(&self) => *self;
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix2x2f Matrix2x2f.transposed(&self) => {{
	[0] = self.val[0], [2] = self.val[1],
	[1] = self.val[2], [3] = self.val[3],
}};
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix3x3f Matrix3x3f.transposed(&self) => {{
	[0] = self.val[0], [3] = self.val[1], [6] = self.val[2],
	[1] = self.val[3], [4] = self.val[4], [7] = self.val[5],
	[2] = self.val[6], [5] = self.val[7], [8] = self.val[8],
}};
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix4x4f Matrix4x4f.transposed(&self) => {{
	[0] = self.val[0],  [4] = self.val[1],  [8]  = self.val[2],  [12] = self.val[3],
	[1] = self.val[4],  [5] = self.val[5],  [9]  = self.val[6],  [13] = self.val[7],
	[2] = self.val[8],  [6] = self.val[9],  [10] = self.val[10], [14] = self.val[11],
	[3] = self.val[12], [7] = self.val[13], [11] = self.val[14], [15] = self.val[15],
}};
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix2x3f Matrix3x2f.transposed(&self) => {{
	[0] = self.val[0], [2] = self.val[1], [4] = self.val[2],
	[1] = self.val[3], [3] = self.val[4], [5] = self.val[5],
}};
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix3x2f Matrix2x3f.transposed(&self) => {{
	[0] = self.val[0], [3] = self.val[1],
	[1] = self.val[2], [4] = self.val[3],
	[2] = self.val[4], [5] = self.val[5],
}};
fn Matrix2x1f Matrix1x2f.transposed(&self) => { self.val };
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix3x1f Matrix1x3f.transposed(&self) => { self.val };
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix4x1f Matrix1x4f.transposed(&self) => { self.val };
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix1x2f Matrix2x1f.transposed(&self) => { self.val };
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix1x3f Matrix3x1f.transposed(&self) => { self.val };
<*
 @return "Regular transposed matrix from self"
 *>
fn Matrix1x4f Matrix4x1f.transposed(&self) => { self.val };

<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix1x1 Matrix1x1.transposed_inline(&self) => *self;
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix2x2 Matrix2x2.transposed_inline(&self) => {{
	[0] = self.val[0], [2] = self.val[1],
	[1] = self.val[2], [3] = self.val[3],
}};
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix3x3 Matrix3x3.transposed_inline(&self) => {{
	[0] = self.val[0], [3] = self.val[1], [6] = self.val[2],
	[1] = self.val[3], [4] = self.val[4], [7] = self.val[5],
	[2] = self.val[6], [5] = self.val[7], [8] = self.val[8],
}};
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix4x4 Matrix4x4.transposed_inline(&self) => {{
	[0] = self.val[0],  [4] = self.val[1],  [8]  = self.val[2],  [12] = self.val[3],
	[1] = self.val[4],  [5] = self.val[5],  [9]  = self.val[6],  [13] = self.val[7],
	[2] = self.val[8],  [6] = self.val[9],  [10] = self.val[10], [14] = self.val[11],
	[3] = self.val[12], [7] = self.val[13], [11] = self.val[14], [15] = self.val[15],
}};
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix2x3 Matrix3x2.transposed_inline(&self) => {{
	[0] = self.val[0], [2] = self.val[1], [4] = self.val[2],
	[1] = self.val[3], [3] = self.val[4], [5] = self.val[5],
}};
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix3x2 Matrix2x3.transposed_inline(&self) => {{
	[0] = self.val[0], [3] = self.val[1],
	[1] = self.val[2], [4] = self.val[3],
	[2] = self.val[4], [5] = self.val[5],
}};
macro Matrix2x1 Matrix1x2.transposed_inline(&self) => { self.val };
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix3x1 Matrix1x3.transposed_inline(&self) => { self.val };
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix4x1 Matrix1x4.transposed_inline(&self) => { self.val };
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix1x2 Matrix2x1.transposed_inline(&self) => { self.val };
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix1x3 Matrix3x1.transposed_inline(&self) => { self.val };
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix1x4 Matrix4x1.transposed_inline(&self) => { self.val };
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix1x1f Matrix1x1f.transposed_inline(&self) => *self;
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix2x2f Matrix2x2f.transposed_inline(&self) => {{
	[0] = self.val[0], [2] = self.val[1],
	[1] = self.val[2], [3] = self.val[3],
}};
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix3x3f Matrix3x3f.transposed_inline(&self) => {{
	[0] = self.val[0], [3] = self.val[1], [6] = self.val[2],
	[1] = self.val[3], [4] = self.val[4], [7] = self.val[5],
	[2] = self.val[6], [5] = self.val[7], [8] = self.val[8],
}};
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix4x4f Matrix4x4f.transposed_inline(&self) => {{
	[0] = self.val[0],  [4] = self.val[1],  [8]  = self.val[2],  [12] = self.val[3],
	[1] = self.val[4],  [5] = self.val[5],  [9]  = self.val[6],  [13] = self.val[7],
	[2] = self.val[8],  [6] = self.val[9],  [10] = self.val[10], [14] = self.val[11],
	[3] = self.val[12], [7] = self.val[13], [11] = self.val[14], [15] = self.val[15],
}};
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix2x3f Matrix3x2f.transposed_inline(&self) => {{
	[0] = self.val[0], [2] = self.val[1], [4] = self.val[2],
	[1] = self.val[3], [3] = self.val[4], [5] = self.val[5],
}};
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix3x2f Matrix2x3f.transposed_inline(&self) => {{
	[0] = self.val[0], [3] = self.val[1],
	[1] = self.val[2], [4] = self.val[3],
	[2] = self.val[4], [5] = self.val[5],
}};
macro Matrix2x1f Matrix1x2f.transposed_inline(&self) => { self.val };
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix3x1f Matrix1x3f.transposed_inline(&self) => { self.val };
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix4x1f Matrix1x4f.transposed_inline(&self) => { self.val };
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix1x2f Matrix2x1f.transposed_inline(&self) => { self.val };
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix1x3f Matrix3x1f.transposed_inline(&self) => { self.val };
<*
 @return "Fast transposed matrix from self"
 *>
macro Matrix1x4f Matrix4x1f.transposed_inline(&self) => { self.val };
