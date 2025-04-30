<*
 @require types::is_int($typeof(ROWS)) && types::is_int($typeof(COLS)) : "Can't create non-integer-sized matrix"
 @require ROWS > 0 && COLS > 0 : "Can't create 0-row or 0-column matrix"
 *>
module matrix::mat_type {ROWS,COLS, Type};

import matrix @public;

import std::io;
import std::core::mem;
import std::math;

macro @is_pow_2() @const
{
	$for var $x = ROWS; $x % 2 == 0; $x /= 2:
		$if $x == 2:
			return true;
		$endif
	$endfor
	return false;
}

union Matrix (Printable)
{
	Type[COLS * ROWS] val;
	Type[<ROWS>][COLS] m @if(@is_pow_2());
	Type[ROWS][COLS] m @if(!@is_pow_2());
}
fn usz? Matrix.to_format(&self, Formatter* f) @dynamic
{
	return f.printf("%s", self.m);
}
macro usz Matrix.@cols(#mat) @const => COLS;
macro usz Matrix.@rows(#mat) @const => ROWS;
macro Matrix.@type(#mat) @const => Type.typeid;

fn Matrix Matrix.add(&self, Matrix mat) @operator(+)
	=> { .val = (Type[<COLS * ROWS>])self.val + (Type[<COLS * ROWS>])mat.val };
fn Matrix Matrix.negate(&self) @operator(-)
	=> { .val = -(Type[<COLS * ROWS>])self.val };
fn Matrix Matrix.subtract(&self, Matrix mat) @operator(-) => *self + -mat;
fn Matrix Matrix.mul_scalar(&self, Type scalar) @operator(*)
	=> { .val = (Type[<COLS * ROWS>])self.val * scalar };
fn Matrix Matrix.div_scalar(&self, Type scalar) @operator(/) => self.mul_scalar(1 / scalar);

fn Type[<ROWS>] Matrix.mul_vec(&self, Type[<ROWS>] vec) @operator(*) => matrix::apply(self, vec);

fn Type[ROWS] Matrix.mul_array(&self, Type[ROWS] array) @operator(*)
	=> (Type[ROWS])matrix::apply(self, ((Type[<ROWS>])array));

fn bool Matrix.eq(&self, Matrix mat) @operator(==)
	=> (Type[<COLS * ROWS>])self.val == (Type[<COLS * ROWS>])mat.val;
fn bool Matrix.neq(&self, Matrix mat) @operator(!=)
	=> (Type[<COLS * ROWS>])self.val != (Type[<COLS * ROWS>])mat.val;
<*
 @require ROWS == COLS : "Can't compute determinant of non-square matrix"
 *>
macro Type Matrix.@determinant(&self)
{
	$switch COLS:
		$case 1:
	return self.val[0];
		$case 2:
	return self.m[0][0] * self.m[1][1] - self.m[1][0] * self.m[0][1];
		$case 3:
	return
			self.m[0][0] * self.m[1][1] * self.m[2][2] +
			self.m[0][1] * self.m[1][2] * self.m[2][0] +
			self.m[0][2] * self.m[1][0] * self.m[2][1]
			-
			self.m[0][2] * self.m[1][1] * self.m[2][0] -
			self.m[0][1] * self.m[1][0] * self.m[2][2] -
			self.m[0][0] * self.m[1][2] * self.m[2][1];
		$case 4:
	return
		self.m[0][0] * (self.m[1][1] * (self.m[2][2] * self.m[3][3] - self.m[3][2] * self.m[2][3]) -
				   self.m[1][2] * (self.m[2][1] * self.m[3][3] - self.m[3][1] * self.m[2][3]) +
				   self.m[1][3] * (self.m[2][1] * self.m[3][2] - self.m[3][1] * self.m[2][2]) ) -
		self.m[0][1] * (self.m[1][0] * (self.m[2][2] * self.m[3][3] - self.m[3][2] * self.m[2][3]) -
				   self.m[1][2] * (self.m[2][0] * self.m[3][3] - self.m[3][0] * self.m[2][3]) +
				   self.m[1][3] * (self.m[2][0] * self.m[3][2] - self.m[3][0] * self.m[2][2]) ) +
		self.m[0][2] * (self.m[1][0] * (self.m[2][1] * self.m[3][3] - self.m[3][1] * self.m[2][3]) -
				   self.m[1][1] * (self.m[2][0] * self.m[3][3] - self.m[3][0] * self.m[2][3]) +
				   self.m[1][3] * (self.m[2][0] * self.m[3][1] - self.m[3][0] * self.m[2][1]) ) -
		self.m[0][3] * (self.m[1][0] * (self.m[2][1] * self.m[3][2] - self.m[3][1] * self.m[2][2]) -
				   self.m[1][1] * (self.m[2][0] * self.m[3][2] - self.m[3][0] * self.m[2][2]) +
				   self.m[1][2] * (self.m[2][0] * self.m[3][1] - self.m[3][0] * self.m[2][1]) );
		$default:
	Type result;
	double mul = 1;
	var sliced = matrix::@row_slice(self, 0);
	for (usz i = 0; i < ROWS; i++)
	{
		result += (Type)(self.m[0][i] * mul * matrix::@col_slice(sliced, i).@determinant());
		mul *= -1;
	}
	return result;
	$endswitch
}

<*
 @require i < ROWS && j < COLS : "Index out of range"
 @require ROWS > 1 && COLS > 1 : "Slicing a one-row or one-column matrix is invalid"
 *>
macro Matrix.@minor(&self, i, j)
	=> matrix::@row_slice(matrix::@col_slice(self, i), j).@determinant();
macro Matrix.@cofactor(&self, i, j)
	=> (Type)(math::pow(-1, (int)(i + j)) * self.@minor(i, j));
macro Matrix.@comatrix(&self)
{
	Matrix result;
	matrix::@ij_loop(ROWS, COLS; usz i, usz j)
	{
		result.m[i][j] = self.@cofactor(i, j);
	};
	return result;
}
macro Matrix.adjugate(&self) => matrix::@transpose(self.@comatrix());
<*
 @require ROWS == COLS : "Trace of a non-square matrix is undefined"
 *>
macro Type Matrix.trace(&self)
{
	$switch ROWS:
		$case 1:
	return self.val[0];
		$case 2:
	return self.m[0][0] + self.m[1][1];
		$case 3:
	return self.m[0][0] + self.m[1][1] + self.m[2][2];
		$case 4:
	return self.m[0][0] + self.m[1][1] + self.m[2][2] + self.m[3][3];
	$endswitch
	Type result;
	for (usz i = 0; i < ROWS; i++) result += self.m[i][i];
	return result;
}

macro Matrix.translate(&self, scale_vec) => self * translated(scale_vec);
macro Matrix.rotate_2d(&self, scale_vec) => self * rotated_2d(scale_vec);
macro Matrix.rotate_x(&self, scale_vec) => self * rotated_x(scale_vec);
macro Matrix.rotate_y(&self, scale_vec) => self * rotated_y(scale_vec);
macro Matrix.rotate_z(&self, scale_vec) => self * rotated_z(scale_vec);

module matrix;

macro @ij_loop(rows, cols; @body(usz i, usz j)) @private
{
	for (usz i = 0; i < rows; i++) for (usz j = 0; j < cols; j++) @body(i, j);
}
macro @mat_mul_sum(mat1, mat2, i, j, $n) @private
{
	$typefrom(mat1.@type())[<$n>] row;
	var col = mat2.m[j];
	for (usz n_iter = 0; n_iter < $n; n_iter++)
	{
		row[n_iter] = mat1.m[n_iter][i];
	}
	return row.dot(col);
}
<*
 @require mat1.@cols() == mat2.@rows() : "Incompatible multiplication"
 @require mat1.@type() == mat2.@type() : "Incompatible multiplication"
 *>
macro @mul(mat1, mat2)
{
	const N = mat1.@cols();
	const ROWS = mat1.@rows();
	const COLS = mat2.@cols();
	Matrix{ROWS,COLS, $typefrom(mat1.@type())} result;
	@ij_loop(ROWS, COLS; usz i, usz j)
	{
		result.m[i][j] = @mat_mul_sum(mat1, mat2, i, j, N);
	};
	return result;
}
macro @transpose(&mat)
{
	$if mat.@rows() == 1 ||| mat.@cols() == 1:
	return (Matrix{mat.@cols(),mat.@rows(), mat.@type()}){ mat.val };
	$else
	const ROWS = mat.@cols();
	const COLS = mat.@rows();
	Matrix{ROWS,COLS, $typefrom(mat.@type())} result;
	@ij_loop(ROWS, COLS; usz i, usz j)
	{
		result.m[j][i] = mat.m[i][j];
	};
	return result;
	$endif
}
<*
 @require mat.@rows() > 1 : "Can't row-slice a one-row matrix"
 *>
macro @row_slice(&mat, idx)
{
	Matrix{mat.@rows() - 1,mat.@cols(), $typefrom(mat.@type())} result;
	if (idx > 0)
	{
		for (usz i = 0; i < result.@cols(); i++)
		{
			result.m[i][..idx-1] = mat.m[i][..idx-1];
		}
	}
	if (idx < mat.@rows() - 1)
	{
		for (usz i = 0; i < result.@cols(); i++)
		{
			result.m[i][idx..] = mat.m[i][idx+1..];
		}
	}
	return result;
}
<*
 @require mat.@cols() > 1 : "Can't column-slice a one-column matrix"
 *>
macro @col_slice(&mat, idx)
{
	Matrix{mat.@rows(),mat.@cols() - 1, $typefrom(mat.@type())} result;
	mem::copy(
		&result.m[0],
		&mat.m[0],
		$typefrom(mat.@type()).sizeof * mat.@rows() * idx);
	if (idx < mat.@cols() - 1) mem::copy(
		&result.m[idx],
		&mat.m[idx + 1],
		$typefrom(mat.@type()).sizeof * mat.@rows() * (result.@cols() - idx));
	return result;
}
macro apply(&mat, vec) @private
{
	$typeof(vec) result;
	for (usz i = 0; i < vec.len; i++) result[i] =
		(($typefrom(mat.@type())[<mat.@rows()>])mat.m[i] * ($typefrom(mat.@type())[<mat.@rows()>])vec).sum();
	return result;
}

<*
 @require $typeof($size).kindof.is_int() : "Cannot generate non-integer-sized matrix"
 @require $size > 0 : "Cannot generate matrix with size less than 1"
 *>
macro @identity($size, $Type = double)
{
	$switch $Type:
		$case double:
		$switch $size:
			$case 1:
	return MATRIX1X1_IDENTITY;
			$case 2:
	return MATRIX2X2_IDENTITY;
			$case 3:
	return MATRIX3X3_IDENTITY;
			$case 4:
	return MATRIX4X4_IDENTITY;
		$endswitch
		$case float:
		$switch $size:
			$case 1:
	return MATRIX1X1_IDENTITYF;
			$case 2:
	return MATRIX2X2_IDENTITYF;
			$case 3:
	return MATRIX3X3_IDENTITYF;
			$case 4:
	return MATRIX4X4_IDENTITYF;
		$endswitch
	$endswitch
	Matrix{$size,$size, $Type} result;
	$for var $x = 0; $x < $size; $x++:
		result.m[$x][$x] = 1;
	$endfor
	return result;
}

faultdef MATRIX_INVERSE_DOESNT_EXIST;
<*
 @require mat.@rows() == mat.@cols() : "Can't invert a non-square matrix"
 *>
macro inverse(&mat)
{
	$typefrom(mat.@type()) det = mat.@determinant();
	if (det == 0) return MATRIX_INVERSE_DOESNT_EXIST?;
	$typeof(mat) result = mat.adjugate();
	return result / det;
}
