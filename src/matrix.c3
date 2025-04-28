<*
 @require types::is_int($typeof(ROWS)) && types::is_int($typeof(COLS)) : "Can't create non-integer-sized matrix"
 @require ROWS > 0 && COLS > 0 : "Can't create 0-row or 0-column matrix"
 *>
module matrix::mat_type {ROWS,COLS, Type};

import matrix @public;

import std::io;
import std::core::mem;
import std::math;

union Matrix (Printable)
{
	Type[COLS * ROWS] val;
	Type[COLS][ROWS] m;
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
fn Matrix Matrix.mul(&self, Type scalar) @operator(*)
	=> { .val = (Type[<COLS * ROWS>])self.val * scalar };
fn Matrix Matrix.div(&self, Type scalar) @operator(/) => self.mul(1 / scalar);

fn Type[<COLS>] Matrix.mul_vec(&self, Type[<COLS>] vec) @operator(*) => matrix::apply(self, vec);

fn Type[COLS] Matrix.mul_array(&self, Type[COLS] array) @operator(*)
	=> (Type[COLS])matrix::apply(self, ((Type[<COLS>])array));

fn bool Matrix.eq(&self, Matrix mat) @operator(==)
	=> (Type[<COLS * ROWS>])self.val == (Type[<COLS * ROWS>])mat.val;
fn bool Matrix.neq(&self, Matrix mat) @operator(!=)
	=> (Type[<COLS * ROWS>])self.val != (Type[<COLS * ROWS>])mat.val;
<*
 @require ROWS == COLS : "Can't compute determinant of non-square matrix"
 *>
macro Type Matrix.@determinant(self)
{
	$if self.@rows() == 1 ||| self.@cols() == 1:
	return self.val[0];
	$else
	Type result;
	double mul = 1;
	var sliced = matrix::@row_slice(self, 0);
	for (usz i = 0; i < ROWS; i++)
	{
		result += (Type)(self.m[0][i] * mul * matrix::@col_slice(sliced, i).@determinant());
		mul *= -1;
	}
	return result;
	$endif
}

<*
 @require i < ROWS && j < COLS : "Index out of range"
 @require ROWS > 1 && COLS > 1 : "Slicing a one-row or one-column matrix is invalid"
 *>
macro Matrix.@minor(self, i, j)
	=> matrix::@col_slice(matrix::@row_slice(self, i), j).@determinant();
macro Matrix.@cofactor(self, i, j)
	=> (Type)(math::pow(-1, (int)(i + j)) * self.@minor(i, j));
macro Matrix.@comatrix(self)
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
	Type result;
	for (usz i = 0; i < ROWS; i++) result += self.m[i][i];
	return result;
}

module matrix;

macro @ij_loop(rows, cols; @body(usz i, usz j)) @private
{
	for (usz i = 0; i < rows; i++) for (usz j = 0; j < cols; j++) @body(i, j);
}
macro @mat_mul_sum(mat1, mat2, i, j, n) @private
{
	$typefrom($typeof(mat1.val).inner) result;
	for (usz n_iter = 0; n_iter < n; n_iter++)
	{
		result += mat1.m[i][n_iter] * mat2.m[n_iter][j];
	}
	return result;
}
macro @mul(mat1, mat2)
{
	var n = mat1.@cols();
	const ROWS = mat1.@rows();
	const COLS = mat2.@cols();
	Matrix{ROWS,COLS, $typefrom(mat1.@type())} result;
	@ij_loop(ROWS, COLS; usz i, usz j)
	{
		result.m[i][j] = @mat_mul_sum(mat1, mat2, i, j, n);
	};
	return result;
}
macro @transpose(mat)
{
	const ROWS = mat.@cols();
	const COLS = mat.@rows();
	Matrix{ROWS,COLS, $typefrom(mat.@type())} result;
	@ij_loop(ROWS, COLS; usz i, usz j)
	{
		result.m[i][j] = mat.m[j][i];
	};
	return result;
}
macro @row_slice(mat, idx)
{
	Matrix{mat.@rows() - 1,mat.@cols(), $typefrom(mat.@type())} result;
	@ij_loop(result.@rows(), result.@cols(); usz i, usz j)
	{
		result.m[i][j] = mat.m[i >= idx ? i + 1 : i][j];
	};
	return result;
}
macro @col_slice(mat, idx)
{
	Matrix{mat.@rows(),mat.@cols() - 1, $typefrom(mat.@type())} result;
	@ij_loop(result.@rows(), result.@cols(); usz i, usz j)
	{
		result.m[i][j] = mat.m[i][j >= idx ? j + 1 : j];
	};
	return result;
}
macro apply(mat, vec)
{
	$typeof(vec) result;
	for (usz i = 0; i < vec.len; i++) result[i] =
		(($typefrom(mat.@type())[<mat.@cols()>])mat.m[i] * ($typefrom(mat.@type())[<mat.@cols()>])vec).sum();
	return result;
}

<*
 @require $typeof($size).kindof.is_int() : "Cannot generate non-integer-sized matrix"
 @require $size > 0 : "Cannot generate matrix with size less than 1"
 *>
macro @identity($size, $Type = double)
{
	Matrix{$size,$size, $Type} result;
	$for var $x = 0; $x < $size; $x++:
		result.m[$x][$x] = 1;
	$endfor
	return result;
}

<*
 @require mat.@rows() == mat.@cols() : "Can't invert a non-square matrix"
 *>
macro inverse(mat)
{
	$typefrom(mat.@type()) det = mat.@determinant();
	assert(det != 0);
	$typeof(mat) result = mat.adjugate();
	return result / det;
}
