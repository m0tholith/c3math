<*
 @require types::is_int($typeof(ROWS)) && types::is_int($typeof(COLS)) : "Can't create non-integer-sized matrix"
 @require ROWS > 0 && COLS > 0 : "Can't create 0-row or 0-column matrix"
 *>
module c3math::matrix::mat_type {ROWS,COLS, Type};

import c3math::matrix @public;

import std::io;
import std::core::mem;
import std::math;
import std::collections::tuple;

const usz ELEMENTS = COLS * ROWS;
const bool IS_SQUARE = COLS == ROWS;
const bool USES_PRIMITIVE_TYPES = Type.kindof == UNSIGNED_INT || Type.kindof == SIGNED_INT || Type.kindof == FLOAT;
const MAX_VECTOR = 64;
alias InnerType @if(USES_PRIMITIVE_TYPES && ELEMENTS <= MAX_VECTOR) = Type[<ELEMENTS>];
macro @is_big_matrix() @const => ELEMENTS > 65536;
macro @use_vectors() @const => matrix::@is_pow_2(ROWS) && !@is_big_matrix();

union Matrix (Printable) @packed @align(Type.sizeof)
{
	Type[ELEMENTS] val;
	Type[<ROWS>][COLS] m @if(@use_vectors());
	Type[ROWS][COLS] m @if(!@use_vectors());
}
fn usz? Matrix.to_format(&self, Formatter* f) @dynamic
{
	usz result = f.printf("[")!;
	result += f.printf("%s", (Type[ROWS])self.m[0])!;
	for (usz i = 1; i < COLS; i++)
	{
		result += f.printf(", %s", (Type[ROWS])self.m[i])!;
	}
	result += f.printf("]")!;
	return result;
}
macro usz Matrix.cols(#mat) @const @safemacro => COLS;
macro usz Matrix.rows(#mat) @const @safemacro => ROWS;
macro Matrix.type(#mat) @const @safemacro => Type.typeid;

<*
 Matrix for fast add for small matrices
*>
macro Matrix Matrix.add_inline(self, Matrix mat) @operator(+)
{
	$if $defined(InnerType):
		return { .val = (InnerType)self.val + (InnerType)mat.val };
	$else
		return self.add(mat);
	$endif
}

<*
 Matrix add function
*>
fn Matrix Matrix.add(&self, Matrix mat)
{
	$if $defined(InnerType):
		return { .val = (InnerType)self.val + (InnerType)mat.val };
	$else
		Matrix result @noinit;
		foreach (i, element : self.val)
		{
			result.val[i] = element + mat.val[i];
		}
		return result;
	$endif
}

<*
 Fast add inline.
*>
macro Matrix Matrix.add_assign_inline(&self, Matrix mat) @operator(+=)
{
	$if $defined(InnerType):
		self.val = (InnerType)self.val + (InnerType)mat.val;
	$else
		self.add_assign(mat);
	$endif
	return *self;
}

<*
 Regular add assign
*>
fn void Matrix.add_assign(&self, Matrix mat)
{
	$if $defined(InnerType):
		self.val = (InnerType)self.val + (InnerType)mat.val;
	$else
		foreach (i, &element : self.val)
		{
			*element += mat.val[i];
		}
	$endif
}

<*
 Matrix for fast subtract for small matrices
*>
macro Matrix Matrix.sub_inline(self, Matrix mat) @operator(-)
{
	$if $defined(InnerType):
		return { .val = (InnerType)self.val - (InnerType)mat.val };
	$else
		return self.sub(mat);
	$endif
}

<*
 Matrix sub function
*>
fn Matrix Matrix.sub(&self, Matrix mat)
{
	$if $defined(InnerType):
		return { .val = (InnerType)self.val - (InnerType)mat.val };
	$else
		Matrix result @noinit;
		foreach (i, element : self.val)
		{
			result.val[i] = element - mat.val[i];
		}
		return result;
	$endif
}

<*
 Fast sub assign
*>
macro Matrix Matrix.sub_assign_inline(&self, Matrix mat) @operator(-=)
{
	$if $defined(InnerType):
		self.val = (InnerType)self.val - (InnerType)mat.val;
	$else
		self.sub_assign(mat);
	$endif
	return *self;
}

<*
 Regular subtract assign
*>
fn void Matrix.sub_assign(&self, Matrix mat)
{
	$if $defined(InnerType):
		self.val = (InnerType)self.val - (InnerType)mat.val;
	$else
		foreach (i, &element : self.val)
		{
			*element -= mat.val[i];
		}
	$endif
}

<*
 Matrix for fast negate for small matrices
*>
macro Matrix Matrix.negate_inline(self) @operator(-)
{
	$if $defined(InnerType):
		return { .val = -(InnerType)self.val };
	$else
		return self.negate();
	$endif
}

<*
 Matrix negate function
*>
fn Matrix Matrix.negate(&self)
{
	$if $defined(InnerType):
		return { .val = -(InnerType)self.val };
	$else
		Matrix result @noinit;
		foreach (i, element : self.val)
		{
			result.val[i] = -element;
		}
		return result;
	$endif
}

const bool IS_FAST_2X2 = IS_SQUARE && ELEMENTS == 4 && USES_PRIMITIVE_TYPES;

macro mul2x2(InnerType a, InnerType b) @local @if(IS_FAST_2X2) => a.xyxy * b.xxzz + a.zwzw * b.yyww;

<*
 Regular fast 2x2 multiplication
*>
fn Matrix Matrix.mul(&a, Matrix b) @if(IS_FAST_2X2)
{
	return { .val = mul2x2(a.val, b.val) };
}

<*
 Inline fast 2x2 multiplication.
*>
macro Matrix Matrix.mul_inline(a, Matrix b) @operator(*) @if(IS_FAST_2X2)
{
	return { .val = mul2x2(a.val, b.val) };
}

<*
 Regular mult + assign, no macro base `*=` operator is defined, as it would
 not offer any performance benefit.
*>
fn void Matrix.mul_assign(&a, Matrix b) @operator(*=) @if(IS_FAST_2X2)
{
	a.val = mul2x2(a.val, b.val);
}


<*
 Matrix for fast scalar multiplication for small matrices
*>
macro Matrix Matrix.mul_scalar_inline(self, Type scalar) @operator(*)
{
	$if $defined(InnerType):
		return { .val = (InnerType)self.val * scalar };
	$else
		return self.mul_scalar(scalar);
	$endif
}

<*
 Scalar multiplication function
*>
fn Matrix Matrix.mul_scalar(&self, Type scalar)
{
	$if $defined(InnerType):
		return { .val = (InnerType)self.val * scalar };
	$else
		Matrix result @noinit;
		foreach (i, &element : self.val)
		{
			result.val[i] = *element * scalar;
		}
		return result;
	$endif
}

<*
 Fast scalar assign multiplication
*>
macro Matrix Matrix.mul_scalar_assign_inline(&self, Type scalar) @operator(*=)
{
	$if $defined(InnerType):
		self.val = (InnerType)self.val * scalar;
	$else
		self.mul_scalar_assign(scalar);
	$endif
	return *self;
}

<*
 Regular scalar assign multiplication
*>
fn void Matrix.mul_scalar_assign(&self, Type scalar)
{
	$if $defined(InnerType):
		self.val = (InnerType)self.val * scalar;
	$else
		foreach (i, &element : self.val)
		{
			*element *= scalar;
		}
	$endif
}

<*
 Matrix for fast scalar div for small matrices
*>
macro Matrix Matrix.div_scalar_inline(self, Type scalar) @operator(/)
{
	$if $defined(InnerType):
		return { .val = (InnerType)self.val / scalar };
	$else
		return self.div_scalar(scalar);
	$endif
}

<*
 Regular matrix divisition
*>
fn Matrix Matrix.div_scalar(&self, Type scalar)
{
	$if $defined(InnerType):
		return { .val = (InnerType)self.val / scalar };
	$else
		Matrix result @noinit;
		foreach (i, &element : self.val)
		{
			result.val[i] = *element / scalar;
		}
		return result;
	$endif
}

<*
 Fast div assign for operator overloading
*>
macro Matrix Matrix.div_scalar_assign_inline(&self, Type scalar) @operator(/=)
{
	$if $defined(InnerType):
		self.val = (InnerType)self.val / scalar;
	$else
		self.div_scalar_assign(scalar);
	$endif
	return *self;
}

<*
 Regular div assign
*>
fn void Matrix.div_scalar_assign(&self, Type scalar)
{
	$if $defined(InnerType):
		self.val = (InnerType)self.val / scalar;
	$else

		foreach (i, &element : self.val)
		{
			*element /= scalar;
		}
	$endif
}

fn Type[<ROWS>] Matrix.mul_vec(&self, Type[<COLS>] vec) @operator(*) => matrix::apply(self, vec);

fn Type[ROWS] Matrix.mul_array(&self, Type[COLS] array) @operator(*)
	=> (Type[ROWS])matrix::apply(self, ((Type[<COLS>])array));

macro bool Matrix.eq_inline(self, Matrix mat) @operator(==)
{
	$if $defined(InnerType):
		return (InnerType)self.val == (InnerType)mat.val;
	$else
		return self.eq(mat);
	$endif
}

fn bool Matrix.eq(&self, Matrix mat)
{
	$if $defined(InnerType):
		return (InnerType)self.val == (InnerType)mat.val;
	$else
		return self.val == mat.val;
	$endif
}

macro bool Matrix.neq_inline(self, Matrix mat) @operator(!=)
{
	$if $defined(InnerType):
		return (InnerType)self.val != (InnerType)mat.val;
	$else
		return self.neq(mat);
	$endif
}

fn bool Matrix.neq(&self, Matrix mat)
{
	$if $defined(InnerType):
		return (InnerType)self.val != (InnerType)mat.val;
	$else
		return self.val != mat.val;
	$endif
}

<*
 @require IS_SQUARE : "Can't compute determinant of non-square matrix"
 *>
macro Type Matrix.determinant(&self)
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
		Matrix* l = allocator::new(tmem, Matrix);
		Matrix* u = allocator::new(tmem, Matrix);
		Matrix* p = allocator::new(tmem, Matrix);
		self.lu_decomp_pivot(l, u, p)!!;
		for (usz i = 0; i < COLS; i++) result *= u.m[i][i];
	};
	return result;
	$endswitch
}
<*
 @param i : "Row index"
 @param j : "Column index"
 *>
macro Type Matrix.cofactor(&self, usz i, usz j)
	=> (Type)(math::pow(-1, (int)(i + j)) * matrix::minor(self, i, j));

<*
 @require ROWS > 1 && COLS > 1 : "Comatrix of a one-row or one-column matrix is invalid"
 @require source != null && source != self
 *>
macro void Matrix.comatrix_assign(&self, Matrix* source)
{
	$if ROWS == COLS:
		$switch ROWS:
			$case 2:
	self.val = {
		[0] = source.m[1][1], [2] = -source.m[0][1],
		[1] = -source.m[1][0], [3] = source.m[0][0],
	};
	return;
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
	return;
			$case 4:
	self.val = {
		(source.m[1][1] * (source.m[2][2] * source.m[3][3] - source.m[2][3] * source.m[3][2]) -
		 source.m[2][1] * (source.m[1][2] * source.m[3][3] - source.m[1][3] * source.m[3][2]) +
		 source.m[3][1] * (source.m[1][2] * source.m[2][3] - source.m[1][3] * source.m[2][2])),
		-(source.m[1][0] * (source.m[2][2] * source.m[3][3] - source.m[2][3] * source.m[3][2]) -
		  source.m[2][0] * (source.m[1][2] * source.m[3][3] - source.m[1][3] * source.m[3][2]) +
		  source.m[3][0] * (source.m[1][2] * source.m[2][3] - source.m[1][3] * source.m[2][2])),
		(source.m[1][0] * (source.m[2][1] * source.m[3][3] - source.m[2][3] * source.m[3][1]) -
		 source.m[2][0] * (source.m[1][1] * source.m[3][3] - source.m[1][3] * source.m[3][1]) +
		 source.m[3][0] * (source.m[1][1] * source.m[2][3] - source.m[1][3] * source.m[2][1])),
		-(source.m[1][0] * (source.m[2][1] * source.m[3][2] - source.m[2][2] * source.m[3][1]) -
		  source.m[2][0] * (source.m[1][1] * source.m[3][2] - source.m[1][2] * source.m[3][1]) +
		  source.m[3][0] * (source.m[1][1] * source.m[2][2] - source.m[1][2] * source.m[2][1])),
			
		-(source.m[0][1] * (source.m[2][2] * source.m[3][3] - source.m[2][3] * source.m[3][2]) -
		  source.m[2][1] * (source.m[0][2] * source.m[3][3] - source.m[0][3] * source.m[3][2]) +
		  source.m[3][1] * (source.m[0][2] * source.m[2][3] - source.m[0][3] * source.m[2][2])),
		(source.m[0][0] * (source.m[2][2] * source.m[3][3] - source.m[2][3] * source.m[3][2]) -
		 source.m[2][0] * (source.m[0][2] * source.m[3][3] - source.m[0][3] * source.m[3][2]) +
		 source.m[3][0] * (source.m[0][2] * source.m[2][3] - source.m[0][3] * source.m[2][2])),
		-(source.m[0][0] * (source.m[2][1] * source.m[3][3] - source.m[2][3] * source.m[3][1]) -
		  source.m[2][0] * (source.m[0][1] * source.m[3][3] - source.m[0][3] * source.m[3][1]) +
		  source.m[3][0] * (source.m[0][1] * source.m[2][3] - source.m[0][3] * source.m[2][1])),
		(source.m[0][0] * (source.m[2][1] * source.m[3][2] - source.m[2][2] * source.m[3][1]) -
		 source.m[2][0] * (source.m[0][1] * source.m[3][2] - source.m[0][2] * source.m[3][1]) +
		 source.m[3][0] * (source.m[0][1] * source.m[2][2] - source.m[0][2] * source.m[2][1])),
			
		(source.m[0][1] * (source.m[1][2] * source.m[3][3] - source.m[1][3] * source.m[3][2]) -
		 source.m[1][1] * (source.m[0][2] * source.m[3][3] - source.m[0][3] * source.m[3][2]) +
		 source.m[3][1] * (source.m[0][2] * source.m[1][3] - source.m[0][3] * source.m[1][2])),
		-(source.m[0][0] * (source.m[1][2] * source.m[3][3] - source.m[1][3] * source.m[3][2]) -
		  source.m[1][0] * (source.m[0][2] * source.m[3][3] - source.m[0][3] * source.m[3][2]) +
		  source.m[3][0] * (source.m[0][2] * source.m[1][3] - source.m[0][3] * source.m[1][2])),
		(source.m[0][0] * (source.m[1][1] * source.m[3][3] - source.m[1][3] * source.m[3][1]) -
		 source.m[1][0] * (source.m[0][1] * source.m[3][3] - source.m[0][3] * source.m[3][1]) +
		 source.m[3][0] * (source.m[0][1] * source.m[1][3] - source.m[0][3] * source.m[1][1])),
		-(source.m[0][0] * (source.m[1][1] * source.m[3][2] - source.m[1][2] * source.m[3][1]) -
		  source.m[1][0] * (source.m[0][1] * source.m[3][2] - source.m[0][2] * source.m[3][1]) +
		  source.m[3][0] * (source.m[0][1] * source.m[1][2] - source.m[0][2] * source.m[1][1])),
			
		-(source.m[0][1] * (source.m[1][2] * source.m[2][3] - source.m[1][3] * source.m[2][2]) -
		  source.m[1][1] * (source.m[0][2] * source.m[2][3] - source.m[0][3] * source.m[2][2]) +
		  source.m[2][1] * (source.m[0][2] * source.m[1][3] - source.m[0][3] * source.m[1][2])),
		(source.m[0][0] * (source.m[1][2] * source.m[2][3] - source.m[1][3] * source.m[2][2]) -
		 source.m[1][0] * (source.m[0][2] * source.m[2][3] - source.m[0][3] * source.m[2][2]) +
		 source.m[2][0] * (source.m[0][2] * source.m[1][3] - source.m[0][3] * source.m[1][2])),
		-(source.m[0][0] * (source.m[1][1] * source.m[2][3] - source.m[1][3] * source.m[2][1]) -
		  source.m[1][0] * (source.m[0][1] * source.m[2][3] - source.m[0][3] * source.m[2][1]) +
		  source.m[2][0] * (source.m[0][1] * source.m[1][3] - source.m[0][3] * source.m[1][1])),
		(source.m[0][0] * (source.m[1][1] * source.m[2][2] - source.m[1][2] * source.m[2][1]) -
		 source.m[1][0] * (source.m[0][1] * source.m[2][2] - source.m[0][2] * source.m[2][1]) +
		 source.m[2][0] * (source.m[0][1] * source.m[1][2] - source.m[0][2] * source.m[1][1])),
	};
	return;
		$endswitch
	$endif
	matrix::@ij_loop(ROWS, COLS; usz i, usz j)
	{
		self.m[j][i] = source.cofactor(i, j);
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
 @param #row_output : "Output array, vector, slice, list, etc."
 @require #row_output.len >= COLS
 @require row_index < self.cols() : "Index out of bounds"
 *>
macro void Matrix.@get_row(&self, usz row_index, #row_output)
{
	$if ROWS == 1:
	#row_output[..] = self.val[..];
	$else
	for (usz i = 0; i < COLS; i++)
	{
		#row_output[i] = self.m[i][row_index];
	}
	$endif
}
<*
 @param #new_row : "Input array, vector, slice, list, etc."
 @require #new_row.len >= COLS
 @require row_index < self.cols() : "Index out of bounds"
 *>
macro void Matrix.@set_row(&self, usz row_index, #new_row)
{
	$if ROWS == 1:
	self.val[..] = #new_row[..];
	$else
	for (usz i = 0; i < COLS; i++)
	{
		self.m[i][row_index] = #new_row[i];
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
 Decomposes `self` into lower and upper matrices, without pivoting.
 `lower` and `upper` may be the same matrix.

 @param [&inout] lower : "Pointer to lower triangluar matrix"
 @param [&inout] upper : "Pointer to upper triangluar matrix"
 @require COLS == ROWS : "Can't perform LU decomp on non-square matrix"
 @require lower != self && upper != self
 *>
macro void? Matrix.lu_decomp(&self, Matrix* lower, Matrix* upper) => @pool()
{
	matrix::transpose(self);
	defer matrix::transpose(self);

	matrix::identity_assign(lower);
	mem::copy(upper, self, $typeof(upper.val).sizeof);

	Type[] temp_row_j = allocator::new_array_aligned(tmem, Type, COLS);
	Type[] temp_row_i = allocator::new_array_aligned(tmem, Type, COLS);
		
	for (usz i = 0; i + 1 < ROWS; i++) // diagonal wise
	{
		upper.@get_row(i, temp_row_i);

		Type diagonal = upper.m[i][i];
		if (diagonal == 0) return PIVOT_IS_ZERO?;
		for (usz j = i + 1; j < ROWS; j++) // row wise
		{
			Type coefficient = upper.m[i][j] / diagonal;
			lower.m[i][j] = coefficient;

			upper.@get_row(j, temp_row_j);
			defer upper.@set_row(j, temp_row_j);

			for (usz k = i; k < COLS; k++) // column wise
			{
				temp_row_j[k] -= coefficient * temp_row_i[k];
			}
		}
	}
}

<*
 Decomposes `self` into lower and upper matrices, populating the pivot matrix.
 `lower` and `upper` may *not* be the same matrix.

 @param [&inout] lower : "Pointer to lower triangluar matrix"
 @param [&inout] upper : "Pointer to upper triangluar matrix"
 @param [&inout] p : "Pointer to permutation matrix"
 @require COLS == ROWS : "Can't perform LU decomp on non-square matrix"
 @require lower != upper : "Lower and upper matrix pointers may not be the same"
 @require lower != self && upper != self
 @require p != lower && p != upper && p != self
 *>
macro void? Matrix.lu_decomp_pivot(&self, Matrix* lower, Matrix* upper, Matrix* p) => @pool()
{
	matrix::identity_assign(p);
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
		upper.@get_row(i, temp_row_i);

		Type diagonal = upper.m[i][i];
		if (diagonal == 0) return PIVOT_IS_ZERO?;
		for (usz j = i + 1; j < ROWS; j++) // row wise
		{
			Type coefficient = upper.m[i][j] / diagonal;
			lower.m[i][j] = coefficient;

			upper.@get_row(j, temp_row_j);
			defer upper.@set_row(j, temp_row_j);

			for (usz k = i; k < COLS; k++) // column wise
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

<*
 @require translate_vec.len == self.cols() : "Incompatible translation vector"
 *>
macro Matrix.translate(&self, translate_vec) => self *= translated(scale_vec);
<*
 @param theta : "Rotation degree in radians"
 *>
macro Matrix.rotate_2d(&self, theta) => self *= rotated_2d(scale_vec);
<*
 @param theta : "Rotation degree in radians"
 *>
macro Matrix.rotate_x(&self, theta) => self *= rotated_x(theta);
<*
 @param theta : "Rotation degree in radians"
 *>
macro Matrix.rotate_y(&self, theta) => self *= rotated_y(theta);
<*
 @param theta : "Rotation degree in radians"
 *>
macro Matrix.rotate_z(&self, theta) => self *= rotated_z(theta);

module c3math::matrix;

macro @ij_loop(rows, cols; @body(usz i, usz j)) @private
{
	for (usz i = 0; i < rows; i++) for (usz j = 0; j < cols; j++) @body(i, j);
}
macro @mat_mul_sum(mat1, mat2, i, j, $n) @private
{
	$typefrom(mat1.type())[<$n>] row;
	var col = mat2.m[j];
	mat1.@get_row(i, row);
	return row.dot(col);
}
<*
 @require $typeof(mat1).kindof == POINTER && $typeof(mat2).kindof == POINTER
 @require mat1.cols() == mat2.rows() : "Incompatible multiplication"
 @require mat1.type() == mat2.type() : "Incompatible multiplication"
 *>
macro mul_assign(&dest, mat1, mat2)
{
	const N = mat1.cols();
	const ROWS = mat1.rows();
	const COLS = mat2.cols();
	@ij_loop(ROWS, COLS; usz i, usz j)
	{
		dest.m[j][i] = @mat_mul_sum(mat1, mat2, i, j, N);
	};
}
<*
 @require $typeof(source).kindof == POINTER
 @require mat.cols() == source.rows() && mat.rows() == source.cols()
 *>
macro transpose_assign(&mat, source)
{
	$if mat.rows() == 1 ||| mat.cols() == 1:
	return;
	$else
	for (usz i = 0; i < source.cols(); i++)
	{
		mat.@set_row(i, source.m[i]);
	}
	$endif
}
<*
 Transposes matrix in-place.

 @require mat.cols() == mat.rows()
 *>
macro transpose(&mat)
{
	for (usz i = 0; i < mat.cols(); i++)
	{
		for (usz j = 0; j < i; j++) @swap(mat.m[i][j], mat.m[j][i]);
	}
}
<*
 @require $typeof(source).kindof == POINTER
 @require mat.rows() == source.rows() - 1 && mat.cols() == source.cols()
 *>
macro row_slice(&mat, source, usz idx)
{
	if (idx > 0)
	{
		for (usz i = 0; i < source.cols(); i++)
		{
			mat.m[i][..idx-1] = source.m[i][..idx-1];
		}
	}
	if (idx < source.rows() - 1)
	{
		for (usz i = 0; i < source.cols(); i++)
		{
			mat.m[i][idx..] = source.m[i][idx+1..];
		}
	}
}
<*
 @require $typeof(source).kindof == POINTER
 @require mat.cols() == source.cols() - 1 && mat.rows() == source.rows()
 *>
macro col_slice(&mat, source, usz idx)
{
	mem::copy(
		&mat.m[0],
		&source.m[0],
		$typefrom(source.type()).sizeof * source.rows() * idx);
	if (idx < source.cols() - 1) mem::copy(
		&mat.m[idx],
		&source.m[idx + 1],
		$typefrom(source.type()).sizeof * source.rows() * (source.cols() - idx - 1));
}
macro apply(&mat, vec) @private
{
	$typefrom($typeof(vec).inner)[<mat.rows()>] result;
	$typeof(vec) row;
	for (usz i = 0; i < result.len; i++)
	{
		mat.@get_row(i, row);
		result[i] = (row * vec).sum();
	}
	return result;
}

<*
 @param r : "Result matrix from multiplying `s` and `o`"
 @param s : "Left-side matrix to multiply"
 @param o : "Right-side matrix to multiply"

 @require $typeof(r).kindof == POINTER
 @require $typeof(s).kindof == POINTER
 @require $typeof(o).kindof == POINTER

 @require $defined(*s = *o) : "Incompatible multiplication"
 @require $defined(*r = *s) : "Incompatible multiplication"
 @require @is_pow_2(s.cols()) : "Can't do Strassen multiplication on matrix whose sides aren't a power of 2"
 *>
macro strassen_mul(r, s, o)
{
	var $EntryType = $typefrom(s.type());
	$if s.cols() == 2:
	$EntryType _m1 = (s.m[0][0] + s.m[1][1]) * (o.m[0][0] + o.m[1][1]);
	$EntryType _m2 = (s.m[0][1] + s.m[1][1]) * o.m[0][0];
	$EntryType _m3 = s.m[0][0] * (o.m[1][0] - o.m[1][1]);
	$EntryType _m4 = s.m[1][1] * (o.m[0][1] - o.m[0][0]);
	$EntryType _m5 = (s.m[0][0] + s.m[1][0]) * o.m[1][1];
	$EntryType _m6 = (s.m[0][1] - s.m[0][0]) * (o.m[0][0] + o.m[1][0]);
	$EntryType _m7 = (s.m[1][0] - s.m[1][1]) * (o.m[0][1] + o.m[1][1]);
	r.val = {
		[0] = _m1 + _m4 - _m5 + _m7, [2] = _m3 + _m5,
		[1] = _m2 + _m4,             [3] = _m1 - _m2 + _m3 + _m6,
	};
	$else
	const HALF_SIZE = s.cols() / 2;
	var $MatType = Matrix{HALF_SIZE,HALF_SIZE, $EntryType};
	var $OriginalType = $typeof(r);
	var lambda = fn void($OriginalType result, $OriginalType self, $OriginalType other) => @pool() {
	const HALF_SIZE = self.cols() / 2;
	$MatType* tmp = allocator::new(tmem, $MatType);

	$MatType* a11 = allocator::new(tmem, $MatType);
	$MatType* a21 = allocator::new(tmem, $MatType);
	$MatType* a12 = allocator::new(tmem, $MatType);
	$MatType* a22 = allocator::new(tmem, $MatType);
	$MatType* b11 = allocator::new(tmem, $MatType);
	$MatType* b21 = allocator::new(tmem, $MatType);
	$MatType* b12 = allocator::new(tmem, $MatType);
	$MatType* b22 = allocator::new(tmem, $MatType);

	@resize(self,  a11, HALF_SIZE,HALF_SIZE, 0        ,0        );
	@resize(self,  a21, HALF_SIZE,HALF_SIZE, HALF_SIZE,0        );
	@resize(self,  a12, HALF_SIZE,HALF_SIZE, 0        ,HALF_SIZE);
	@resize(self,  a22, HALF_SIZE,HALF_SIZE, HALF_SIZE,HALF_SIZE);
	@resize(other, b11, HALF_SIZE,HALF_SIZE, 0        ,0        );
	@resize(other, b21, HALF_SIZE,HALF_SIZE, HALF_SIZE,0        );
	@resize(other, b12, HALF_SIZE,HALF_SIZE, 0        ,HALF_SIZE);
	@resize(other, b22, HALF_SIZE,HALF_SIZE, HALF_SIZE,HALF_SIZE);

	$MatType* m1 = allocator::new(tmem, $MatType);
	$MatType* m2 = allocator::new(tmem, $MatType);
	$MatType* m3 = allocator::new(tmem, $MatType);
	$MatType* m4 = allocator::new(tmem, $MatType);
	$MatType* m5 = allocator::new(tmem, $MatType);
	$MatType* m6 = allocator::new(tmem, $MatType);
	$MatType* m7 = allocator::new(tmem, $MatType);

	*m1 = *a11;
	m1.add_assign(*a22);
	*tmp = *b11;
	tmp.add_assign(*b22);
	strassen_mul(m1, m1, tmp);

	*m2 = *a21;
	m2.add_assign(*a22);
	strassen_mul(m2, m2, b11);

	*m3 = *b12;
	m3.sub_assign(*b22);
	strassen_mul(m3, a11, m3);

	*m4 = *b21;
	m4.sub_assign(*b11);
	strassen_mul(m4, a22, m4);

	*m5 = *a11;
	m5.add_assign(*a12);
	strassen_mul(m5, m5, b22);

	*m6 = *a21;
	m6.sub_assign(*a11);
	*tmp = *b11;
	tmp.add_assign(*b12);
	strassen_mul(m6, m6, tmp);

	*m7 = *a12;
	m7.sub_assign(*a22);
	*tmp = *b21;
	tmp.add_assign(*b22);
	strassen_mul(m7, m7, tmp);

	*tmp = *m1;
	tmp.add_assign(*m4);
	tmp.sub_assign(*m5);
	tmp.add_assign(*m7);
	set_submatrix(result, tmp, 0        ,0        );

	*tmp = *m2;
	tmp.add_assign(*m4);
	set_submatrix(result, tmp, HALF_SIZE,0        );
                                                  
	*tmp = *m3;                                   
	tmp.add_assign(*m5);                          
	set_submatrix(result, tmp, 0        ,HALF_SIZE);

	*tmp = *m1;
	tmp.sub_assign(*m2);
	tmp.add_assign(*m3);
	tmp.add_assign(*m6);
	set_submatrix(result, tmp, HALF_SIZE,HALF_SIZE);
	};
	lambda(r, s, o);
	$endif
}
macro @is_pow_2($n) @private @const
{
	$for var $x = $n; $x % 2 == 0; $x /= 2:
		$if $x == 2:
			return true;
		$endif
	$endfor
	return false;
}
<*
 @param mat : "Bigger, main matrix to copy into"
 @param sub : "Smaller, sub matrix to copy from"

 @require $typeof(mat).kindof == POINTER
 @require $typeof(sub).kindof == POINTER

 @require row_offset + sub.cols() - 1 < mat.cols() : "Row index out of range"
 @require col_offset + sub.rows() - 1 < mat.rows() : "Column index out of range"
 *>
macro set_submatrix(mat, sub, usz row_offset, usz col_offset)
{
	@ij_loop(sub.rows(), sub.cols(); usz i, usz j)
	{
		mat.m[col_offset + i][row_offset + j] = sub.m[i][j];
	};
}

<*
 @param i : "Row index"
 @param j : "Column index"
 @require i < self.cols() && j < self.rows() : "Index out of range"
 @require self.rows() > 1 && self.cols() > 1 : "Slicing a one-row or one-column matrix is invalid"
 @require $typeof(self).kindof == POINTER
 *>
macro minor(&self, usz i, usz j)
{
	@pool()
	{
		Matrix{self.rows()-1,self.cols(), $typefrom(self.type())}* tmp1 = allocator::new(tmem, Matrix{self.rows()-1,self.cols(), $typefrom(self.type())});
		matrix::row_slice(tmp1, self, i);
		Matrix{self.rows()-1,self.cols()-1, $typefrom(self.type())}* tmp2 = allocator::new(tmem, Matrix{self.rows()-1,self.cols()-1, $typefrom(self.type())});
		matrix::col_slice(tmp2, tmp1, j);
		return tmp2.determinant();
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
 @require self.cols() == self.rows() : "Cannot create non-square identity matrix"
 *>
macro identity_assign(&self)
{
	mem::clear(self, $typeof(self.val).sizeof);
	for (usz x = 0; x < self.cols(); x++) self.m[x][x] = 1;
}

<*
 @require $typeof(source).kindof == POINTER
 @require mat.cols() == source.rows() && mat.rows() == source.cols()
 *>
macro adjugate(&mat, source)
{
	mat.comatrix_assign(source);
	matrix::transpose(mat);
}

faultdef MATRIX_INVERSE_DOESNT_EXIST;
<*
 @require mat.rows() == mat.cols() : "Can't invert a non-square matrix"
 @require $typeof(source).kindof == POINTER
 @require mat.cols() == source.rows() && mat.rows() == source.cols()
 *>
macro inverse(&mat, source)
{
	$typefrom(source.type()) det = source.determinant();
	if (det == 0) return MATRIX_INVERSE_DOESNT_EXIST?;
	$if $defined(mat.adjugate):
	mat.adjugate(source);
	$else
	adjugate(mat, source);
	$endif
	mat.div_scalar_assign(det);
}

macro @resize(&mat, result, usz $new_rows, usz $new_cols, usz row_offset = 0, usz col_offset = 0)
{
	$if $new_cols == mat.cols() &&& $new_rows == mat.rows():
	*result = *mat;
	return;
	$endif

	$if $new_rows == mat.rows():
		$if $new_cols < mat.cols():
	*result = { .m = mat.m[col_offset:$new_cols] };
	return;
		$else
	result.val[col_offset:mat.cols() * mat.rows()] = mat.val[..];
	return;
		$endif
	$endif

	$if $new_cols < mat.cols():
	for (usz i = 0; i < $new_cols; i++)
	{
		$if $new_rows < mat.rows():
		result.m[i][..] = mat.m[col_offset + i][row_offset:$new_rows];
		$else
		result.m[i][row_offset:mat.rows()] = mat.m[col_offset + i][..];
		$endif
	}
	$else
	for (usz i = 0; i < mat.cols(); i++)
	{
		$if $new_rows < mat.rows():
		result.m[col_offset + i][..] = mat.m[i][row_offset:$new_rows];
		$else
		result.m[col_offset + i][row_offset:mat.rows()] = mat.m[i][..];
		$endif
	}
	$endif
}
