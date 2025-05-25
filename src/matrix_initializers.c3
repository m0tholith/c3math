module c3math::matrix;

import std::math;

macro scaled(scale_vec)
{
	const N = scale_vec.len;
	Matrix{N+1,N+1, $typefrom($typeof(scale_vec).inner)} result;
	for (usz i = 0; i < N; i++) result.m[i][i] = scale_vec[i];
	result.val[^1] = 1;
	return result;
}
macro translated(translate_vec)
{
	const N = translate_vec.len;
	Matrix{N+1,N+1, $typefrom($typeof(translate_vec).inner)} result;
	result.m[^1][:N] = translate_vec[..];
	result.val[^1] = 1;
	return result;
}
macro rotated_2d(double theta, $size = 2, $Type = double)
{
	double c = math::cos(theta);
	double s = math::sin(theta);
	Matrix{2,2, $Type} r = {{
		[0] = c, [2] = -s,
		[1] = s, [3] = c,
	}};
	$if $size == 2:
	return r;
	$else
	Matrix{$size,$size, $Type} result;
	matrix::identity_assign(&result);
	matrix::@upsize(&r, &result);
	return result;
	$endif
}
macro rotated_x(double theta, $Type = double, $size = 3)
{
	double c = math::cos(theta);
	double s = math::sin(theta);
	Matrix{3,3, $Type} r = {{
		[0] = 1, [3] = 0, [6] = 0,
		[1] = 0, [4] = c, [7] = -s,
		[2] = 0, [5] = s, [8] = c,
	}};
	$if $size == 3:
	return r;
	$else
	Matrix{$size,$size, $Type} result;
	matrix::identity_assign(&result);
	matrix::@upsize(&r, &result);
	return result;
	$endif
}
macro rotated_y(double theta, $Type = double, $size = 3)
{
	double c = math::cos(theta);
	double s = math::sin(theta);
	Matrix{3,3, $Type} r = {{
		[0] = c,  [3] = 0, [6] = s,
		[1] = 0,  [4] = 1, [7] = 0,
		[2] = -s, [5] = 0, [8] = c,
	}};
	$if $size == 3:
	return r;
	$else
	Matrix{$size,$size, $Type} result;
	matrix::identity_assign(&result);
	matrix::@upsize(&r, &result);
	return result;
	$endif
}
macro rotated_z(double theta, $Type = double, $size = 3)
{
	double c = math::cos(theta);
	double s = math::sin(theta);
	Matrix{3,3, $Type} r = {{
		[0] = c,  [3] = -s, [6] = 0,
		[1] = s,  [4] = c,  [7] = 0,
		[2] = 0,  [5] = 0,  [8] = 1,
	}};
	$if $size == 3:
	return r;
	$else
	Matrix{$size,$size, $Type} result;
	matrix::identity_assign(&result);
	matrix::@upsize(&r, &result);
	return result;
	$endif
}

macro ortho(left, right, top, bottom, near, far, $Type = double)
{
	var w = right - left;
	var h = top - bottom;
	var d = far - near;

	return (Matrix{4,4, $Type}){{
		[0] = 2 / ($Type)w, [4] = 0,             [8]  = 0,             [12] = -($Type)(right + left) / ($Type)w,
		[1] = 0,            [5] = -2 / ($Type)h, [9]  = 0,             [13] = ($Type)(top + bottom) / ($Type)h,
		[2] = 0,            [6] = 0,             [10] = -2 / ($Type)d, [14] = -($Type)(far + near) / ($Type)d,
		[3] = 0,            [7] = 0,             [11] = 0,             [15] = 1,
	}};
}
macro perspective(fov, aspect_ratio, near, far, $Type = double)
{
	var f = ($Type)math::cotan(fov / 2.0);
	var r = 1.0 / ($Type)(near - far);

	return (Matrix{4,4, $Type}){{
		[0] = f / ($Type)aspect_ratio, [4] = 0, [8]  = 0,                [12] = 0,
		[1] = 0,                       [5] = f, [9]  = 0,                [13] = 0,
		[2] = 0,                       [6] = 0, [10] = (near + far) * r, [14] = near * far * r * 2,
		[3] = 0,                       [7] = 0, [11] = -1,               [15] = 0,
	}};
}
<*
 @require $typeof(eye).kindof == VECTOR && eye.len == 3
 @require $typeof(forward).kindof == VECTOR && forward.len == 3
 @require $typeof(world_up).kindof == VECTOR && world_up.len == 3
 *>
macro look(eye, forward, world_up, $Type = double)
{
	var r = (forward.cross(world_up)).normalize();
	var u = r.cross(forward);

	return (Matrix{4,4, $Type}){{
		[0] = r.x,        [4] = r.y,        [8]  = r.z,        [12] = -eye.dot(r),
		[1] = u.x,        [5] = u.y,        [9]  = u.z,        [13] = -eye.dot(u),
		[2] = -forward.x, [6] = -forward.y, [10] = -forward.z, [14] = eye.dot(forward),
		[3] = 0,          [7] = 0,          [11] = 0,          [15] = 1,
	}};
}
<*
 @require $typeof(eye).kindof == VECTOR && eye.len == 3
 @require $typeof(target).kindof == VECTOR && target.len == 3
 @require $typeof(world_up).kindof == VECTOR && world_up.len == 3
 *>
macro look_at(eye, target, world_up, $Type = double)
{
	var f = (target - eye).normalize();
	var r = (f.cross(world_up)).normalize();
	var u = r.cross(f);

	return (Matrix{4,4, $Type}){{
		[0] = r.x,  [4] = r.y,  [8]  = r.z,  [12] = -eye.dot(r),
		[1] = u.x,  [5] = u.y,  [9]  = u.z,  [13] = -eye.dot(u),
		[2] = -f.x, [6] = -f.y, [10] = -f.z, [14] = eye.dot(f),
		[3] = 0,    [7] = 0,    [11] = 0,    [15] = 1,
	}};
}
