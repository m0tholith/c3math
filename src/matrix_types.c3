module matrix;

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

fn Matrix1x1 Matrix1x1.mul(&self, Matrix1x1 mat) @operator(*) => @mul(self, mat);
fn Matrix2x2 Matrix2x2.mul(&self, Matrix2x2 mat) @operator(*) => @mul(self, mat);
fn Matrix3x3 Matrix3x3.mul(&self, Matrix3x3 mat) @operator(*) => @mul(self, mat);
fn Matrix4x4 Matrix4x4.mul(&self, Matrix4x4 mat) @operator(*) => @mul(self, mat);
fn Matrix3x3 Matrix3x2.mul(&self, Matrix2x3 mat) @operator(*) => @mul(self, mat);
fn Matrix2x2 Matrix2x3.mul(&self, Matrix3x2 mat) @operator(*) => @mul(self, mat);
fn Matrix1x1 Matrix1x2.mul(&self, Matrix2x1 mat) @operator(*) => @mul(self, mat);
fn Matrix1x1 Matrix1x3.mul(&self, Matrix3x1 mat) @operator(*) => @mul(self, mat);
fn Matrix1x1 Matrix1x4.mul(&self, Matrix4x1 mat) @operator(*) => @mul(self, mat);
fn Matrix2x2 Matrix2x1.mul(&self, Matrix1x2 mat) @operator(*) => @mul(self, mat);
fn Matrix3x3 Matrix3x1.mul(&self, Matrix1x3 mat) @operator(*) => @mul(self, mat);
fn Matrix4x4 Matrix4x1.mul(&self, Matrix1x4 mat) @operator(*) => @mul(self, mat);

fn Matrix1x1f Matrix1x1f.mul(&self, Matrix1x1f mat) @operator(*) => @mul(self, mat);
fn Matrix2x2f Matrix2x2f.mul(&self, Matrix2x2f mat) @operator(*) => @mul(self, mat);
fn Matrix3x3f Matrix3x3f.mul(&self, Matrix3x3f mat) @operator(*) => @mul(self, mat);
fn Matrix4x4f Matrix4x4f.mul(&self, Matrix4x4f mat) @operator(*) => @mul(self, mat);
fn Matrix3x3f Matrix3x2f.mul(&self, Matrix2x3f mat) @operator(*) => @mul(self, mat);
fn Matrix2x2f Matrix2x3f.mul(&self, Matrix3x2f mat) @operator(*) => @mul(self, mat);
fn Matrix1x1f Matrix1x2f.mul(&self, Matrix2x1f mat) @operator(*) => @mul(self, mat);
fn Matrix1x1f Matrix1x3f.mul(&self, Matrix3x1f mat) @operator(*) => @mul(self, mat);
fn Matrix1x1f Matrix1x4f.mul(&self, Matrix4x1f mat) @operator(*) => @mul(self, mat);
fn Matrix2x2f Matrix2x1f.mul(&self, Matrix1x2f mat) @operator(*) => @mul(self, mat);
fn Matrix3x3f Matrix3x1f.mul(&self, Matrix1x3f mat) @operator(*) => @mul(self, mat);
fn Matrix4x4f Matrix4x1f.mul(&self, Matrix1x4f mat) @operator(*) => @mul(self, mat);

fn Matrix1x1 Matrix1x1.transposed(&self) => @transpose(self);
fn Matrix2x2 Matrix2x2.transposed(&self) => @transpose(self);
fn Matrix3x3 Matrix3x3.transposed(&self) => @transpose(self);
fn Matrix4x4 Matrix4x4.transposed(&self) => @transpose(self);
fn Matrix2x3 Matrix3x2.transposed(&self) => @transpose(self);
fn Matrix3x2 Matrix2x3.transposed(&self) => @transpose(self);
fn Matrix2x1 Matrix1x2.transposed(&self) => @transpose(self);
fn Matrix3x1 Matrix1x3.transposed(&self) => @transpose(self);
fn Matrix4x1 Matrix1x4.transposed(&self) => @transpose(self);
fn Matrix1x2 Matrix2x1.transposed(&self) => @transpose(self);
fn Matrix1x3 Matrix3x1.transposed(&self) => @transpose(self);
fn Matrix1x4 Matrix4x1.transposed(&self) => @transpose(self);
