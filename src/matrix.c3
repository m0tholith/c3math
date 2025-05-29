<*
 @require types::is_int($typeof(ROWS)) && types::is_int($typeof(COLS)) : "Can't create non-integer-sized matrix"
 @require ROWS > 0 && COLS > 0 : "Can't create 0-row or 0-column matrix"
*>
module c3math::matrix::mat_type { ROWS, COLS, Type };
import c3math::matrix::mat_type;
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
macro @is_big_matrix() @const => ELEMENTS > 16;
macro @use_vectors() @const => matrix::@is_pow_2(ROWS) && !@is_big_matrix();

union Matrix (Printable)
{
	Type[ELEMENTS] val;
	Type[ROWS][COLS] m;
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

fn Matrix{ROWS, ROWS, Type} Matrix.mul(&a, Matrix{COLS, ROWS, Type} b) @if(COLS <= 16 && ROWS <= 16 && USES_PRIMITIVE_TYPES) @inline
{
	return a.mul_inline(b);
}

macro Matrix{ROWS, ROWS, Type} Matrix.mul_inline(&a, Matrix{COLS, ROWS, Type} b) @if(COLS <= 16 && ROWS <= 16 && USES_PRIMITIVE_TYPES) @operator(*)
{
	// m[ROW][COL]
	$switch:
		$case ROWS == 1 && COLS == 1:
			return { .val = { b.val[0] * a.val[0] } };
		$case ROWS == 1:
			return {{ ((Type[<COLS>])b.m[0]).dot(a.val) }};
		$case COLS == 1:
			var $elements = ROWS * ROWS;
			Type[<$elements>] av @noinit;
			Type[<$elements>] bv @noinit;
			$for var $i = 0; $i < $elements; $i++:
				av[$i] = a.val[$i % ROWS];
				bv[$i] = b.val[$i / ROWS];
			$endfor
			return { av * bv };
		$case COLS == 2 && ROWS == 2:
			Type[<4>] av = a.val;
			Type[<4>] bv = b.val;
			return { av.xyxy * bv.xxzz + av.zwzw * bv.yyww };
		$default:
			Matrix{ROWS, ROWS, Type} m @noinit;
            $assert(a.m.len == COLS);
            $assert(b.m.len == ROWS);
			$for var $i = 0; $i < ROWS; $i++:
				$for var $j = 0; $j < ROWS; $j++:
				{
					Type[<COLS>] val @noinit;
					a.@get_row($j, val);
					m.m[$i][$j] = val.dot(b.m[$i]);
				}
				$endfor
			$endfor
				return m;
	$endswitch
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

<*
 Pre-multiply matrix by 1xn vector
 @return "Result of multiplication: mx1 vector"
 *>
fn Type[<ROWS>] Matrix.mul_vec(&self, Type[<COLS>] vec) @operator(*) => matrix::apply(self, vec);

<*
 Pre-multiply matrix by 1xn array
 @return "Result of multiplication: mx1 array"
 *>
fn Type[ROWS] Matrix.mul_array(&self, Type[COLS] array) @operator(*)
	=> (Type[ROWS])matrix::apply(self, ((Type[<COLS>])array));

<*
 Fast equality check for operator overloading
 @return "`true` if `self` == `mat`, `false` otherwise"
 *>
macro bool Matrix.eq_inline(self, Matrix mat) @operator(==)
{
	$if $defined(InnerType):
		return (InnerType)self.val == (InnerType)mat.val;
	$else
		return self.eq(mat);
	$endif
}

<*
 Regular equality check
 @return "`true` if `self` == `mat`, false otherwise"
 *>
fn bool Matrix.eq(&self, Matrix mat)
{
	$if $defined(InnerType):
		return (InnerType)self.val == (InnerType)mat.val;
	$else
		return self.val == mat.val;
	$endif
}

<*
 Fast non-equality check for operator overloading
 @return "`true` if `self` != `mat`, false otherwise"
 *>
macro bool Matrix.neq_inline(self, Matrix mat) @operator(!=)
{
	$if $defined(InnerType):
		return (InnerType)self.val != (InnerType)mat.val;
	$else
		return self.neq(mat);
	$endif
}

<*
 Regular non-equality check
 @return "`true` if `self` != `mat`, `false` otherwise"
 *>
fn bool Matrix.neq(&self, Matrix mat)
{
	$if $defined(InnerType):
		return (InnerType)self.val != (InnerType)mat.val;
	$else
		return self.val != mat.val;
	$endif
}

<*
 Determinant function with optimizations for 1x1-4x4 matrices

 @return "Determinant of matrix"
 *>
macro Type Matrix.determinant(&self) @if(IS_SQUARE)
{
	$switch COLS:
		$case 1:
			return self.val[0];
		$case 2:
			$if $defined(InnerType):
				InnerType val = self.val;
				return val.x * val.w - val.y * val.z;
			$else
				return  self.m[0][0] * self.m[1][1] - self.m[1][0] * self.m[0][1];
			$endif
		$case 3:
			$if $defined(InnerType):
				InnerType val = self.val;
				return val[0] * val[4] * val[8]
						+ val[1] * val[5] * val[6] + val[2] * val[3] * val[7]
						- val[2] * val[4] * val[6] - val[1] * val[3] * val[8]
						- val[0] * val[5] * val[7];
			$else
				return self.m[0][0] * self.m[1][1] * self.m[2][2]
					+ self.m[0][1] * self.m[1][2] * self.m[2][0]
					+ self.m[0][2] * self.m[1][0] * self.m[2][1]
					- self.m[0][2] * self.m[1][1] * self.m[2][0]
					- self.m[0][1] * self.m[1][0] * self.m[2][2]
					- self.m[0][0] * self.m[1][2] * self.m[2][1];

			$endif
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
	@pool()
	{
		Matrix* l = allocator::new(tmem, Matrix);
		Matrix* u = allocator::new(tmem, Matrix);
		Matrix* p = allocator::new(tmem, Matrix);
		Type result = self.lu_decomp_pivot(l, u, p)!! % 2 == 0 ? 1 : -1;
		for (usz i = 0; i < COLS; i++) result *= u.m[i][i];
		return result;
	};
	$endswitch
}
<*
 @return "Cofactor of matrix"
 @param i : "Row index"
 @param j : "Column index"
 *>
macro Type Matrix.cofactor(&self, usz i, usz j)
	=> (Type)(math::pow(-1, (int)(i + j)) * matrix::minor(self, i, j));

<*
 Assigns cofactors of source matrix to self.
 Operation is optimized for 1x1-4x4 square matrices

 @param source : "Source matrix to calculate comatrices"
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
 Trace function that is optimized for 1x1-4x4 matrices

 @return "Sum of matrix diagonal values"
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
 Transposes matrix in-place.

 @require ROWS == COLS
 *>
macro void Matrix.transpose(&self)
{
	$switch ROWS:
		$case 1:
	return;
		$case 2:
	self.val = {
		[0] = self.val[0], [2] = self.val[1],
		[1] = self.val[2], [3] = self.val[3],
	};
		$case 3:
	self.val = {
		[0] = self.val[0], [3] = self.val[1], [6] = self.val[2],
		[1] = self.val[3], [4] = self.val[4], [7] = self.val[5],
		[2] = self.val[6], [5] = self.val[7], [8] = self.val[8],
	};
		$case 4:
	self.val = {
		[0] = self.val[0],  [4] = self.val[1],  [8]  = self.val[2],  [12] = self.val[3],
		[1] = self.val[4],  [5] = self.val[5],  [9]  = self.val[6],  [13] = self.val[7],
		[2] = self.val[8],  [6] = self.val[9],  [10] = self.val[10], [14] = self.val[11],
		[3] = self.val[12], [7] = self.val[13], [11] = self.val[14], [15] = self.val[15],
	};
		$default:
	for (usz i = 0; i < self.cols(); i++)
	{
		for (usz j = 0; j < i; j++) @swap(self.m[i][j], self.m[j][i]);
	}
	$endswitch
}

<*
 Computes comatrix of source matrix into self, then transposes

 @param source : "Source matrix to calculate comatrices"
 @require COLS == source.rows() && ROWS == source.cols()
 *>
macro Matrix.adjugate_assign(&mat, Matrix* source)
{
	mat.comatrix_assign(source);
	mat.transpose();
}

<*
 Sets values in `#row_output` to matrix row values at `row_index`

 @param #row_output : "Output array, vector, slice, list, etc."
 @require #row_output.len >= COLS
 @require row_index < self.rows() : "Index out of bounds"
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
 Sets matrix row values at `row_index` to each corresponding value in `#new_row`

 @param #new_row : "Input array, vector, slice, list, etc."
 @require #new_row.len >= COLS
 @require row_index < self.rows() : "Index out of bounds"
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
 Swaps columns in-place.
 Does nothing if `col1` and `col2` are the same

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
 Swaps rows value-by-value.
 Does nothing if `row1` and `row2` are the same

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
 @return "Number of row swaps"
 @require COLS == ROWS : "Can't perform LU decomp on non-square matrix"
 @require lower != upper : "Lower and upper matrix pointers may not be the same"
 @require lower != self && upper != self
 @require p != lower && p != upper && p != self
 *>
macro usz? Matrix.lu_decomp_pivot(&self, Matrix* lower, Matrix* upper, Matrix* p) => @pool()
{
	usz num_swaps;

	matrix::identity_assign(p);
	mem::copy(lower, p, $typeof(lower.val).sizeof);
	mem::copy(upper, self, $typeof(upper.val).sizeof);

	Type[] temp_row_j = allocator::new_array_aligned(tmem, Type, COLS);
	Type[] temp_row_i = allocator::new_array_aligned(tmem, Type, COLS);

	for (usz i = 0; i + 1 < ROWS; i++) // diagonal wise
	{
		Tuple{usz, Type} maximum = upper.col_max(i, i);
		if (maximum.second == 0) break;
		p.swap_row(maximum.first, i);
		upper.swap_row(maximum.first, i);
		if (maximum.first != i) num_swaps++;
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

	return num_swaps;
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
 Applies transformation into matrix from vector or array

 @param translate_vec : "Array/vector to translate matrix by"
 @require $defined(translate_vec[0]) : "Parameter `translate_vec` is not indexable (not an array/vector)"
 @require translate_vec.len == self.rows() - 1 : "Incompatible translation vector"
 *>
macro Matrix.translate(&self, translate_vec)
{
	for (usz i = 0; i < ROWS - 1; i++)
	{
		self.m[^1][i] += translate_vec[i];
	}
}
<*
 Applies 2D rotation of degree `theta` to matrix.
 Operation is optimized for 2x2 matrices

 @param theta : "Rotation degree in radians"
 @require ROWS == COLS : "Cannot apply 2D rotation to non-square matrix"
 @require ROWS >= 2 : "Cannot apply 2D rotation to matrix less than 2x2"
 *>
macro Matrix.rotate_2d(&self, double theta)
{
	$if ROWS == 2:
	double c = math::cos(theta);
	double s = math::sin(theta);
	self.val = {
		[0] = self.m[0][0] * c - self.m[0][1] * s, [2] = self.m[1][0] * c - self.m[1][1] * s,
		[1] = self.m[0][0] * s + self.m[0][1] * c, [3] = self.m[1][0] * s + self.m[1][1] * c,
	};
	$else
	*self = matrix::rotated_2d(theta, ROWS, Type).mul(*self);
	$endif
}
<*
 Applies 3D rotation on the X axis to matrix

 @param theta : "Rotation degree in radians"
 @require ROWS == COLS : "Cannot apply 3D rotation to non-square matrix"
 @require ROWS >= 3 : "Cannot apply 3D rotation to matrix less than 3x3"
 *>
macro Matrix.rotate_x(&self, double theta) => *self = matrix::rotated_x(theta, Type, ROWS).mul(*self);
<*
 Applies 3D rotation on the Y axis to matrix

 @param theta : "Rotation degree in radians"
 @require ROWS == COLS : "Cannot apply 3D rotation to non-square matrix"
 @require ROWS >= 3 : "Cannot apply 3D rotation to matrix less than 3x3"
 *>
macro Matrix.rotate_y(&self, double theta) => *self = matrix::rotated_y(theta, Type, ROWS).mul(*self);
<*
 Applies 3D rotation on the Z axis to matrix

 @param theta : "Rotation degree in radians"
 @require ROWS == COLS : "Cannot apply 3D rotation to non-square matrix"
 @require ROWS >= 3 : "Cannot apply 3D rotation to matrix less than 3x3"
 *>
macro Matrix.rotate_z(&self, double theta) => *self = matrix::rotated_z(theta, Type, ROWS).mul(*self);

module c3math::matrix;

macro @ij_loop(rows, cols; @body(usz i, usz j)) @private
{
	for (usz i = 0; i < rows; i++) for (usz j = 0; j < cols; j++) @body(i, j);
}
<*
 Sets result of multiplication of mxn and nxk matrices.
 Uses traditional `mat1.row * mat2.col` algorithm

 @require $typeof(dest).typeid == $typeof(mat1).typeid : "Type mismatch"
 @require $typeof(dest).typeid == $typeof(mat2).typeid : "Type mismatch"
 @require mat1.cols() == mat2.rows() : "Incompatible multiplication"
 @require mat1.type() == mat2.type() : "Incompatible multiplication"
 *>
macro mul_assign(&dest, mat1, mat2)
{
	const N = mat1.cols();
	const ROWS = mat1.rows();
	const COLS = mat2.cols();
	$typefrom(mat1.type())[<N>] row @noinit;
	$typefrom(mat1.type())[<N>] col @noinit;
	@ij_loop(ROWS, COLS; usz i, usz j)
	{
		col = mat2.m[j];
		mat1.@get_row(i, row);
		dest.m[j][i] = row.dot(col);
	};
}
<*
 Sets matrix to transpose of source.

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
 Sets matrix to source matrix, skipping the specified row

 @require $typeof(source).kindof == POINTER
 @require mat.rows() == source.rows() - 1 && mat.cols() == source.cols() : "Incompatible sizes"
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
 Sets matrix to source matrix, skipping the specified column

 @require $typeof(source).kindof == POINTER
 @require mat.cols() == source.cols() - 1 && mat.rows() == source.rows() : "Incompatible sizes"
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
 Sets result of multiplication of two nxn matrices.
 Uses Strassen multiplication algorithm

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

	@downsize(self,  a11, 0        ,0        );
	@downsize(self,  a21, HALF_SIZE,0        );
	@downsize(self,  a12, 0        ,HALF_SIZE);
	@downsize(self,  a22, HALF_SIZE,HALF_SIZE);
	@downsize(other, b11, 0        ,0        );
	@downsize(other, b21, HALF_SIZE,0        );
	@downsize(other, b12, 0        ,HALF_SIZE);
	@downsize(other, b22, HALF_SIZE,HALF_SIZE);

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
	@upsize(tmp, result, 0        ,0        );

	*tmp = *m2;
	tmp.add_assign(*m4);
	@upsize(tmp, result, HALF_SIZE,0        );
                                                  
	*tmp = *m3;                                   
	tmp.add_assign(*m5);                          
	@upsize(tmp, result, 0        ,HALF_SIZE);

	*tmp = *m1;
	tmp.sub_assign(*m2);
	tmp.add_assign(*m3);
	tmp.add_assign(*m6);
	@upsize(tmp, result, HALF_SIZE,HALF_SIZE);
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
 @param i : "Row index"
 @param j : "Column index"
 @return "Minor of matrix at index i,j"
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
 Identity generator.
 Function is constant for 1x1-4x4 matrices

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
		result.val[$x + $size * $x] = 1;
	$endfor
	return result;
}
<*
 Clears matrix and sets diagonal values to 1

 @require self.cols() == self.rows() : "Cannot create non-square identity matrix"
 *>
macro identity_assign(&self)
{
	mem::clear(self, $typeof(self.val).sizeof);
	for (usz x = 0; x < self.cols(); x++) self.m[x][x] = 1;
}

faultdef MATRIX_INVERSE_DOESNT_EXIST;
<*
 Sets matrix to the inverse of source matrix

 @require mat.rows() == mat.cols() : "Can't invert a non-square matrix"
 @require $typeof(source).kindof == POINTER
 @require mat.cols() == source.rows() && mat.rows() == source.cols()
 *>
macro inverse(&mat, source)
{
	$typefrom(source.type()) det = source.determinant();
	if (det == 0) return MATRIX_INVERSE_DOESNT_EXIST?;
	mat.adjugate_assign(source);
	mat.div_scalar_assign(det);
}

<*
 Sets `result` matrix to submatrix of `mat`

 @param [&in] result : "Result matrix"
 @param row_offset : "Starting row to set matrix to"
 @param col_offset : "Starting column to set matrix to"
 @require result.rows() <= mat.rows() && result.cols() <= mat.cols() : "Resized matrix won't fit result matrix"
 @require row_offset <= mat.rows() - result.rows() : "Row offset is out of bounds for source matrix"
 @require col_offset <= mat.cols() - result.cols() : "col offset is out of bounds for source matrix"
 *>
macro @downsize(&mat, result, usz row_offset = 0, usz col_offset = 0)
{
	for (usz i = 0; i < result.cols(); i++)
	{
		result.m[i][..] = mat.m[i + col_offset][row_offset:result.rows()];
	}
}
<*
 Sets submatrix of `result` matrix to `mat`

 @param [&in] result : "Result matrix"
 @param row_offset : "Starting row to set result matrix to"
 @param col_offset : "Starting column to set result matrix to"
 @require mat.rows() <= result.rows() && mat.cols() <= result.cols() : "Resized matrix won't fit result matrix"
 @require row_offset <= result.rows() - mat.rows() : "Row offset is out of bounds for source matrix"
 @require col_offset <= result.cols() - mat.cols() : "col offset is out of bounds for source matrix"
 *>
macro @upsize(&mat, result, usz row_offset = 0, usz col_offset = 0)
{
	for (usz i = 0; i < mat.cols(); i++)
	{
		result.m[i + col_offset][row_offset:mat.rows()] = mat.m[i][..];
	}
}
