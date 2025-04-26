<*
 @require $typeof(ROWS).kindof != FLOAT && $typeof(COLS).kindof != FLOAT
 @require ROWS > 0 && COLS > 0
 *>
module matrix {ROWS,COLS, Type};
import maths;

import std::io;
import std::core::mem;

union Matrix (Printable)
{
	Type[COLS * ROWS] val;
	Type[COLS][ROWS] m;
}
fn usz? Matrix.to_format(&self, Formatter* f) @dynamic
{
	return f.printf("%s", self.m);
}
macro usz Matrix.@cols(#mat) => #mat.m[0].len;
macro usz Matrix.@rows(#mat) => #mat.m.len;

fn Matrix Matrix.add(&self, Matrix mat) @operator(+)
{
	Matrix result;
	maths::@ij_loop(ROWS, COLS; usz i, usz j)
	{
		result.m[i][j] = self.m[i][j] + mat.m[i][j];
	};
	return result;
}
fn Matrix Matrix.negate(&self) @operator(-)
{
	Matrix result;
	for (usz i = 0; i < COLS * ROWS; i++) result.val[i] = -self.val[i];
	return result;
}
fn Matrix Matrix.mul(&self, Type scalar) @operator(*)
{
	Matrix result = *self;
	for (usz i = 0; i < result.val.len; i++) result.val[i] = self.val[i] * scalar;
	return result;
}
<*
 @require #self.@rows() == #self.@cols() : "Cannot compute determinant of non-square matrix"
 *>
macro Type Matrix.@determinant(#self)
{
	$if #self.@rows() == 1 ||| #self.@cols() == 1:
	return #self.val[0];
	$else
	Type result;
	double mul = -1;
	var sliced = maths::@row_slice(#self, 0);
	for (usz i = 0; i < ROWS; i++)
	{
		result += #self.m[0][i] * mul * maths::@col_slice(sliced, i).@determinant();
		mul *= -1;
	}
	return result;
	$endif
}

module maths;
import matrix;

import std::io;

macro @ij_loop(rows, cols; @body(usz i, usz j))
{
	for (usz i = 0; i < rows; i++) for (usz j = 0; j < cols; j++) @body(i, j);
}
macro @mat_mul_sum(mat1, mat2, i, j, n)
{
	$typeof(mat1.val[0]) result;
	for (usz n_iter = 0; n_iter < n; n_iter++)
	{
		result += mat1.m[i][n_iter] * mat2.m[n_iter][j];
	}
	return result;
}
<*
 @require #mat1.@cols() == #mat2.@rows() : "Left matrix columns != Right matrix rows"
 *>
macro @mul(#mat1, #mat2)
{
	var n = #mat1.@cols();
	const ROWS = #mat1.@rows();
	const COLS = #mat2.@cols();
	Matrix{ROWS,COLS, $typeof(#mat1.val[0])} result;
	@ij_loop(ROWS, COLS; usz i, usz j)
	{
		result.m[i][j] = @mat_mul_sum(#mat1, #mat2, i, j, n);
	};
	return result;
}
macro @transpose(#mat)
{
	const ROWS = #mat.@cols();
	const COLS = #mat.@rows();
	Matrix{ROWS,COLS, $typeof(#mat.val[0])} result;
	@ij_loop(ROWS, COLS; usz i, usz j)
	{
		result.m[i][j] = #mat.m[j][i];
	};
	return result;
}
<*
 @require idx < #mat.@rows()
 *>
macro @row_slice(#mat, idx)
{
	Matrix{#mat.@rows() - 1,#mat.@cols(), $typeof(#mat.val[0])} result;
	@ij_loop(result.@rows(), result.@cols(); usz i, usz j)
	{
		result.m[i][j] = #mat.m[i >= idx ? i + 1 : i][j];
	};
	return result;
}
<*
 @require idx < #mat.@cols()
 *>
macro @col_slice(#mat, idx)
{
	Matrix{#mat.@rows(),#mat.@cols() - 1, $typeof(#mat.val[0])} result;
	@ij_loop(result.@rows(), result.@cols(); usz i, usz j)
	{
		result.m[i][j] = #mat.m[i][j >= idx ? j + 1 : j];
	};
	return result;
}
