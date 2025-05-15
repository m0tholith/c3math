<*
 @require types::is_int($typeof(ROWS)) && types::is_int($typeof(COLS)) : "Can't create non-integer-sized matrix"
 @require ROWS > 0 && COLS > 0 : "Can't create 0-row or 0-column matrix"
 *>
module matrix::mat_type {ROWS,COLS, Type};

import matrix @public;

import std::io;
import std::core::mem;
import std::math;
import std::collections::tuple;

macro @is_big_matrix() @const => ROWS * COLS > 65536;
macro @is_pow_2() @const
{
	$for var $x = ROWS; $x % 2 == 0; $x /= 2:
		$if $x == 2:
			return true;
		$endif
	$endfor
	return false;
}
macro @use_vectors() @const => @is_pow_2() && !@is_big_matrix();

union Matrix (Printable)
{
	Type[COLS * ROWS] val;
	Type[<ROWS>][COLS] m @if(@use_vectors());
	Type[ROWS][COLS] m @if(!@use_vectors());
}
fn usz? Matrix.to_format(&self, Formatter* f) @dynamic
{
	return f.printf("%s", self.m);
}
macro usz Matrix.@cols(#mat) @const => COLS;
macro usz Matrix.@rows(#mat) @const => ROWS;
macro Matrix.@type(#mat) @const => Type.typeid;

fn Matrix Matrix.add(&self, Matrix mat) @operator(+)
{
	$if !@is_big_matrix():
	return { .val = (Type[<COLS * ROWS>])self.val + (Type[<COLS * ROWS>])mat.val };
	$else
	Matrix result = *self;
	for (usz i = 0; i < COLS * ROWS; i++)
	{
		result.val[i] += mat.val[i];
	}
	return result;
	$endif
}
fn void Matrix.add_assign(&self, Matrix mat) @operator(+=)
{
	$if !@is_big_matrix():
	self.val = (Type[<COLS * ROWS>])self.val + (Type[<COLS * ROWS>])mat.val;
	$else
	for (usz i = 0; i < COLS * ROWS; i++)
	{
		self.val[i] += mat.val[i];
	}
	$endif
}
fn Matrix Matrix.negate(&self) @operator(-)
{
	$if !@is_big_matrix():
	return { .val = -(Type[<COLS * ROWS>])self.val };
	$else
	Matrix result;
	for (usz i = 0; i < COLS * ROWS; i++)
	{
		result.val[i] = -self.val[i];
	}
	return result;
	$endif
}
fn Matrix Matrix.subtract(&self, Matrix mat) @operator(-)
{
	$if !@is_big_matrix():
	return { .val = (Type[<COLS * ROWS>])self.val - (Type[<COLS * ROWS>])mat.val };
	$else
	Matrix result = *self;
	for (usz i = 0; i < COLS * ROWS; i++)
	{
		result.val[i] -= mat.val[i];
	}
	return result;
	$endif
}
fn void Matrix.subtract_assign(&self, Matrix mat) @operator(-=)
{
	$if !@is_big_matrix():
	self.val = (Type[<COLS * ROWS>])self.val - (Type[<COLS * ROWS>])mat.val;
	$else
	for (usz i = 0; i < COLS * ROWS; i++)
	{
		self.val[i] -= mat.val[i];
	}
	$endif
}
fn Matrix Matrix.mul_scalar(&self, Type scalar) @operator(*)
{
	$if !@is_big_matrix():
	return { .val = (Type[<COLS * ROWS>])self.val * scalar };
	$else
	Matrix result = *self;
	for (usz i = 0; i < COLS * ROWS; i++)
	{
		result.val[i] *= scalar;
	}
	return result;
	$endif
}
fn void Matrix.mul_scalar_assign(&self, Type scalar) @operator(*=)
{
	$if !@is_big_matrix():
	self.val = (Type[<COLS * ROWS>])self.val * scalar;
	$else
	for (usz i = 0; i < COLS * ROWS; i++)
	{
		self.val[i] *= scalar;
	}
	$endif
}
fn Matrix Matrix.div_scalar(&self, Type scalar) @operator(/)
{
	$if !@is_big_matrix():
	return { .val = (Type[<COLS * ROWS>])self.val / scalar };
	$else
	Matrix result = *self;
	for (usz i = 0; i < COLS * ROWS; i++)
	{
		result.val[i] /= scalar;
	}
	return result;
	$endif
}
fn void Matrix.div_scalar_assign(&self, Type scalar) @operator(/=)
{
	$if !@is_big_matrix():
	self.val = (Type[<COLS * ROWS>])self.val / scalar;
	$else
	for (usz i = 0; i < COLS * ROWS; i++)
	{
		self.val[i] /= scalar;
	}
	$endif
}

fn Type[<ROWS>] Matrix.mul_vec(&self, Type[<ROWS>] vec) @operator(*) => matrix::apply(self, vec);

fn Type[ROWS] Matrix.mul_array(&self, Type[ROWS] array) @operator(*)
	=> (Type[ROWS])matrix::apply(self, ((Type[<ROWS>])array));

fn bool Matrix.eq(&self, Matrix mat) @operator(==)
{
	$if !@is_big_matrix():
	return (Type[<COLS * ROWS>])self.val == (Type[<COLS * ROWS>])mat.val;
	$else
	for (usz i = 0; i < COLS * ROWS; i++)
	{
		if (self.val[i] != mat.val[i]) return false;
	}
	return true;
	$endif
}
fn bool Matrix.neq(&self, Matrix mat) @operator(!=)
{
	$if !@is_big_matrix():
	return (Type[<COLS * ROWS>])self.val != (Type[<COLS * ROWS>])mat.val;
	$else
	for (usz i = 0; i < COLS * ROWS; i++)
	{
		if (self.val[i] != mat.val[i]) return true;
	}
	return false;
	$endif
}
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
	Type result = 1;
	@pool()
	{
		Matrix* lu = allocator::new_aligned(tmem, Matrix)!!;
		lu.lu_decomp(self)!!;
		for (usz i = 0; i < COLS; i++) result *= lu.m[i][i];
	};
	return result;
	$endswitch
}
macro Matrix.@cofactor(&self, i, j)
	=> (Type)(math::pow(-1, (int)(i + j)) * matrix::@minor(self, i, j));

<*
 @require ROWS > 1 && COLS > 1 : "Comatrix of a one-row or one-column matrix is invalid"
 @require source != null && source != self
 *>
macro void Matrix.@comatrix_assign(&self, Matrix* source)
{
	$if ROWS == COLS:
		$switch ROWS:
			$case 2:
	self.val = {
		[0] = source.m[1][1], [2] = -source.m[0][1],
		[1] = -source.m[1][0], [3] = source.m[0][0],
	};
			$case 3:
	self.val = {
		source.m[1][1] * source.m[2][2] - source.m[2][1] * source.m[1][2],
		source.m[2][0] * source.m[1][2] - source.m[1][0] * source.m[2][2],
		source.m[1][0] * source.m[2][1] - source.m[2][0] * source.m[1][1],
		source.m[2][1] * source.m[0][2] - source.m[0][1] * source.m[2][2],
		source.m[0][0] * source.m[2][2] - source.m[2][0] * source.m[0][2],
		source.m[2][0] * source.m[0][1] - source.m[0][0] * source.m[2][1],
		source.m[0][1] * source.m[1][2] - source.m[1][1] * source.m[0][2],
		source.m[1][0] * source.m[0][2] - source.m[0][0] * source.m[1][2],
		source.m[0][0] * source.m[1][1] - source.m[1][0] * source.m[0][1],
	};
			$case 4:
	self.val = {
		(source.m[1][1] * (source.m[2][2] * source.m[3][3] - source.m[2][3] * source.m[3][2]) -
		 source.m[2][1] * (source.m[1][2] * source.m[3][3] - source.m[1][3] * source.m[3][2]) +
		 source.m[3][1] * (source.m[1][2] * source.m[2][3] - source.m[1][3] * source.m[2][2])),
		-(source.m[0][1] * (source.m[2][2] * source.m[3][3] - source.m[2][3] * source.m[3][2]) -
		  source.m[2][1] * (source.m[0][2] * source.m[3][3] - source.m[0][3] * source.m[3][2]) +
		  source.m[3][1] * (source.m[0][2] * source.m[2][3] - source.m[0][3] * source.m[2][2])),
		(source.m[0][1] * (source.m[1][2] * source.m[3][3] - source.m[1][3] * source.m[3][2]) -
		 source.m[1][1] * (source.m[0][2] * source.m[3][3] - source.m[0][3] * source.m[3][2]) +
		 source.m[3][1] * (source.m[0][2] * source.m[1][3] - source.m[0][3] * source.m[1][2])),
		-(source.m[0][1] * (source.m[1][2] * source.m[2][3] - source.m[1][3] * source.m[2][2]) -
		  source.m[1][1] * (source.m[0][2] * source.m[2][3] - source.m[0][3] * source.m[2][2]) +
		  source.m[2][1] * (source.m[0][2] * source.m[1][3] - source.m[0][3] * source.m[1][2])),
			
		-(source.m[1][0] * (source.m[2][2] * source.m[3][3] - source.m[2][3] * source.m[3][2]) -
		  source.m[2][0] * (source.m[1][2] * source.m[3][3] - source.m[1][3] * source.m[3][2]) +
		  source.m[3][0] * (source.m[1][2] * source.m[2][3] - source.m[1][3] * source.m[2][2])),
		(source.m[0][0] * (source.m[2][2] * source.m[3][3] - source.m[2][3] * source.m[3][2]) -
		 source.m[2][0] * (source.m[0][2] * source.m[3][3] - source.m[0][3] * source.m[3][2]) +
		 source.m[3][0] * (source.m[0][2] * source.m[2][3] - source.m[0][3] * source.m[2][2])),
		-(source.m[0][0] * (source.m[1][2] * source.m[3][3] - source.m[1][3] * source.m[3][2]) -
		  source.m[1][0] * (source.m[0][2] * source.m[3][3] - source.m[0][3] * source.m[3][2]) +
		  source.m[3][0] * (source.m[0][2] * source.m[1][3] - source.m[0][3] * source.m[1][2])),
		(source.m[0][0] * (source.m[1][2] * source.m[2][3] - source.m[1][3] * source.m[2][2]) -
		 source.m[1][0] * (source.m[0][2] * source.m[2][3] - source.m[0][3] * source.m[2][2]) +
		 source.m[2][0] * (source.m[0][2] * source.m[1][3] - source.m[0][3] * source.m[1][2])),
			
		(source.m[1][0] * (source.m[2][1] * source.m[3][3] - source.m[2][3] * source.m[3][1]) -
		 source.m[2][0] * (source.m[1][1] * source.m[3][3] - source.m[1][3] * source.m[3][1]) +
		 source.m[3][0] * (source.m[1][1] * source.m[2][3] - source.m[1][3] * source.m[2][1])),
		-(source.m[0][0] * (source.m[2][1] * source.m[3][3] - source.m[2][3] * source.m[3][1]) -
		  source.m[2][0] * (source.m[0][1] * source.m[3][3] - source.m[0][3] * source.m[3][1]) +
		  source.m[3][0] * (source.m[0][1] * source.m[2][3] - source.m[0][3] * source.m[2][1])),
		(source.m[0][0] * (source.m[1][1] * source.m[3][3] - source.m[1][3] * source.m[3][1]) -
		 source.m[1][0] * (source.m[0][1] * source.m[3][3] - source.m[0][3] * source.m[3][1]) +
		 source.m[3][0] * (source.m[0][1] * source.m[1][3] - source.m[0][3] * source.m[1][1])),
		-(source.m[0][0] * (source.m[1][1] * source.m[2][3] - source.m[1][3] * source.m[2][1]) -
		  source.m[1][0] * (source.m[0][1] * source.m[2][3] - source.m[0][3] * source.m[2][1]) +
		  source.m[2][0] * (source.m[0][1] * source.m[1][3] - source.m[0][3] * source.m[1][1])),
			
		-(source.m[1][0] * (source.m[2][1] * source.m[3][2] - source.m[2][2] * source.m[3][1]) -
		  source.m[2][0] * (source.m[1][1] * source.m[3][2] - source.m[1][2] * source.m[3][1]) +
		  source.m[3][0] * (source.m[1][1] * source.m[2][2] - source.m[1][2] * source.m[2][1])),
		(source.m[0][0] * (source.m[2][1] * source.m[3][2] - source.m[2][2] * source.m[3][1]) -
		 source.m[2][0] * (source.m[0][1] * source.m[3][2] - source.m[0][2] * source.m[3][1]) +
		 source.m[3][0] * (source.m[0][1] * source.m[2][2] - source.m[0][2] * source.m[2][1])),
		-(source.m[0][0] * (source.m[1][1] * source.m[3][2] - source.m[1][2] * source.m[3][1]) -
		  source.m[1][0] * (source.m[0][1] * source.m[3][2] - source.m[0][2] * source.m[3][1]) +
		  source.m[3][0] * (source.m[0][1] * source.m[1][2] - source.m[0][2] * source.m[1][1])),
		(source.m[0][0] * (source.m[1][1] * source.m[2][2] - source.m[1][2] * source.m[2][1]) -
		 source.m[1][0] * (source.m[0][1] * source.m[2][2] - source.m[0][2] * source.m[2][1]) +
		 source.m[2][0] * (source.m[0][1] * source.m[1][2] - source.m[0][2] * source.m[1][1])),
	};
		$endswitch
	$endif
	matrix::@ij_loop(ROWS, COLS; usz i, usz j)
	{
		self.m[i][j] = source.@cofactor(i, j);
	};
}
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

<*
 @param [out] row_output
 @require row_output.len >= COLS
 *>
fn void Matrix.get_row(&self, usz row_index, Type[] row_output)
{
	$if ROWS == 1:
	row_output[..] = self.val[..];
	$else
	for (usz i = 0; i < ROWS; i++)
	{
		row_output[i] = self.m[i][row_index];
	}
	$endif
}
<*
 @param [in] new_row
 @require new_row.len >= COLS
 *>
fn void Matrix.set_row(&self, usz row_index, Type[] new_row)
{
	$if ROWS == 1:
	self.val[..] = new_row[..];
	$else
	for (usz i = 0; i < ROWS; i++)
	{
		self.m[i][row_index] = new_row[i];
	}
	$endif
}

<*
 @require col1 < COLS && col2 < COLS : "Index out of range"
 *>
fn void Matrix.swap_col(&self, usz col1, usz col2)
{
	if (col1 != col2)
	{
		@swap(self.m[col1], self.m[col2]);
	}
}
<*
 @require row1 < ROWS && row2 < ROWS : "Index out of range"
 *>
fn void Matrix.swap_row(&self, usz row1, usz row2)
{
	if (row1 != row2) for (usz i = 0; i < COLS; i++)
	{
		@swap(self.m[i][row1], self.m[i][row2]);
	}
}

faultdef PIVOT_IS_ZERO;
<*
 @require COLS == ROWS : "Can't perform LU decomp on non-square matrix"
 *>
macro void? Matrix.lu_decomp(&self, Matrix* source)
{
	Matrix* lower = self;
	Matrix* upper = self;
	*lower = matrix::@identity(COLS);
	for (usz i = 0; i < COLS; i++)
	{
		// compute upper, row by row
		for (usz j = i; j < COLS; j++)
		{
			upper.m[j][i] = source.m[j][i];
			for (usz k = 0; k < i; k++)
			{
				upper.m[j][i] -= upper.m[j][k] * lower.m[k][i];
			}
		}
		// compute lower, column by column
		if (i + 1 < COLS) lower.m[i][i + 1..] = source.m[i][i + 1..];
		for (usz j = i + 1; j < COLS; j++)
		{
			if (upper.m[i][i] == 0) return PIVOT_IS_ZERO?;
			for (usz k = 0; k < i; k++)
			{
				lower.m[i][j] -= upper.m[i][k] * lower.m[k][j];
			}
			lower.m[i][j] /= upper.m[i][i];
		}
	}
}

<*
 @param [&inout] lower : "Pointer to lower triangluar matrix"
 @param [&inout] upper : "Pointer to upper triangluar matrix"
 @param [&inout] p : "Pointer to permutation matrix"
 @require COLS == ROWS : "Can't perform LU decomp on non-square matrix"
 *>
macro void? Matrix.lu_decomp_pivot(&self, Matrix* lower, Matrix* upper, Matrix* p) => @pool()
{
	*p = matrix::@identity(COLS);
	mem::copy(lower, p, $typeof(lower.val).sizeof);
	mem::copy(upper, self, $typeof(upper.val).sizeof);

	Type[] temp_row_j = allocator::new_array_aligned(tmem, Type, COLS);
	Type[] temp_row_i = allocator::new_array_aligned(tmem, Type, COLS);

	for (usz i = 0; i + 1 < ROWS; i++) // diagonal wise
	{
		Tuple{usz, Type} maximum = upper.col_max(i, i);
		if (maximum.second == 0) return;
		p.swap_row(maximum.first, i);
		upper.swap_row(maximum.first, i);
	}
		
	for (usz i = 0; i + 1 < ROWS; i++) // diagonal wise
	{
		upper.get_row(i, temp_row_i);

		Type diagonal = upper.m[i][i];
		if (diagonal == 0) return PIVOT_IS_ZERO?;
		for (usz j = i + 1; j < ROWS; j++) // row wise
		{
			Type coefficient = upper.m[i][j] / diagonal;
			lower.m[i][j] = coefficient;

			upper.get_row(j, temp_row_j);
			defer upper.set_row(j, temp_row_j);

			for (usz k = 0; k < COLS; k++) // column wise
			{
				temp_row_j[k] -= coefficient * temp_row_i[k];
			}
		}
	}
}
macro Tuple{usz, Type} Matrix.col_max(&self, usz col, usz row = 0) @private
{
	Tuple{usz, Type} result = { row, self.m[col][row] };
	for (usz i = row + 1; i < ROWS; i++)
	{
		if (math::abs(result.second) < math::abs(self.m[col][i])) result = { i, self.m[col][i] };
	}
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
 @require $typeof(mat1).kindof == POINTER && $typeof(mat2).kindof == POINTER
 @require mat1.@cols() == mat2.@rows() : "Incompatible multiplication"
 @require mat1.@type() == mat2.@type() : "Incompatible multiplication"
 *>
macro @mul(dest, mat1, mat2)
{
	const N = mat1.@cols();
	const ROWS = mat1.@rows();
	const COLS = mat2.@cols();
	@ij_loop(ROWS, COLS; usz i, usz j)
	{
		dest.m[i][j] = @mat_mul_sum(mat1, mat2, i, j, N);
	};
}
<*
 @require $typeof(source).kindof == POINTER
 @require mat.@cols() == source.@rows() && mat.@rows() == source.@cols()
 *>
macro @set_transpose(&mat, source)
{
	$if mat.@rows() == 1 ||| mat.@cols() == 1:
	return;
	$else
	const ROWS = source.@cols();
	const COLS = source.@rows();
	@ij_loop(ROWS, COLS; usz i, usz j)
	{
		mat.m[j][i] = source.m[i][j];
	};
	$endif
}
<*
 @require mat.@cols() == mat.@rows()
 *>
macro @transpose(&mat)
{
	for (usz i = 0; i < mat.@cols(); i++)
	{
		for (usz j = 0; j < i; j++) @swap(mat.m[i][j], mat.m[j][i]);
	}
}
<*
 @require $typeof(source).kindof == POINTER
 @require mat.@rows() == source.@rows() - 1 && mat.@cols() == source.@cols()
 *>
macro @row_slice(&mat, source, idx)
{
	if (idx > 0)
	{
		for (usz i = 0; i < source.@cols(); i++)
		{
			mat.m[i][..idx-1] = source.m[i][..idx-1];
		}
	}
	if (idx < source.@rows() - 1)
	{
		for (usz i = 0; i < source.@cols(); i++)
		{
			mat.m[i][idx..] = source.m[i][idx+1..];
		}
	}
}
<*
 @require $typeof(mat).kindof == POINTER
 @require $typeof(source).kindof == POINTER
 @require mat.@cols() == source.@cols() - 1 && mat.@rows() == source.@rows()
 *>
macro @col_slice(&mat, source, idx)
{
	mem::copy(
		&mat.m[0],
		&source.m[0],
		$typefrom(source.@type()).sizeof * source.@rows() * idx);
	if (idx < source.@cols() - 1) mem::copy(
		&mat.m[idx],
		&source.m[idx + 1],
		$typefrom(source.@type()).sizeof * source.@rows() * (source.@cols() - idx));
}
macro apply(&mat, vec) @private
{
	$typeof(vec) result;
	for (usz i = 0; i < vec.len; i++) result[i] =
		(($typefrom(mat.@type())[<mat.@rows()>])mat.m[i] * ($typefrom(mat.@type())[<mat.@rows()>])vec).sum();
	return result;
}

<*
 @require i < self.@rows() && j < self.@cols() : "Index out of range"
 @require self.@rows() > 1 && self.@cols() > 1 : "Slicing a one-row or one-column matrix is invalid"
 @require $typeof(self).kindof == POINTER
 *>
macro @minor(&self, i, j)
{
	@pool()
	{
		Matrix{self.@rows(),self.@cols()-1, $typefrom(self.@type())}* tmp1 = allocator::new_aligned(tmem, Matrix{self.@rows(),self.@cols()-1, $typefrom(self.@type())})!!;
		matrix::@col_slice(tmp1, self, i);
		Matrix{self.@rows()-1,self.@cols()-1, $typefrom(self.@type())}* tmp2 = allocator::new_aligned(tmem, Matrix{self.@rows()-1,self.@cols()-1, $typefrom(self.@type())})!!;
		matrix::@row_slice(tmp2, tmp1, j);
		return tmp2.@determinant();
	};
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
<*
 @require self.@cols() == self.@rows() : "Cannot create non-square identity matrix"
 *>
macro @identity_assign(&self)
{
	for (usz x = 0; x < self.@cols(); x++) self.m[x][x] = 1;
}

<*
 @require $typeof(source).kindof == POINTER
 @require mat.@cols() == source.@rows() && mat.@rows() == source.@cols()
 *>
macro adjugate(&mat, source)
{
	mat.@comatrix_assign(source);
	matrix::@transpose(mat);
}

faultdef MATRIX_INVERSE_DOESNT_EXIST;
<*
 @require mat.@rows() == mat.@cols() : "Can't invert a non-square matrix"
 @require $typeof(source).kindof == POINTER
 @require mat.@cols() == source.@rows() && mat.@rows() == source.@cols()
 *>
macro inverse(&mat, source)
{
	$typefrom(source.@type()) det = source.@determinant();
	if (det == 0) return MATRIX_INVERSE_DOESNT_EXIST?;
	$if $defined(mat.adjugate):
	mat.adjugate(source);
	$else
	adjugate(mat, source);
	$endif
	mat.div_scalar_assign(det);
}

macro @resize(&mat, usz $new_rows, usz $new_cols)
{
	$if $new_cols == mat.@cols() &&& $new_rows == mat.@rows():
	return mat;
	$endif

	$if $new_rows == mat.@rows():
		$if $new_cols < mat.@cols():
	return (Matrix{$new_rows,$new_cols, $typefrom(mat.@type())}){ .m = mat.m[:$new_cols] };
		$else
	Matrix{$new_rows,$new_cols, $typefrom(mat.@type())} _result;
	_result.val[:mat.@cols() * mat.@rows()] = mat.val[..];
	return _result;
		$endif
	$endif

	Matrix{$new_rows,$new_cols, $typefrom(mat.@type())} result;
	$if $new_cols < mat.@cols():
	for (usz i = 0; i < $new_cols; i++)
	{
		$if $new_rows < mat.@rows():
		result.m[i][..] = mat.m[i][:$new_rows];
		$else
		result.m[i][:mat.@rows()] = mat.m[i][..];
		$endif
	}
	$else
	for (usz i = 0; i < mat.@cols(); i++)
	{
		$if $new_rows < mat.@rows():
		result.m[i][..] = mat.m[i][:$new_rows];
		$else
		result.m[i][:mat.@rows()] = mat.m[i][..];
		$endif
	}
	$endif
	return result;
}
