module matrix;

import std::math;

macro scaled(scale_vec)
{
	const N = scale_vec.len;
	Matrix{N+1,N+1, $typefrom($typeof(scale_vec).inner)} result;
	for (usz i = 0; i < N; i++) result.m[i][i] = scale_vec[i];
	return result;
}
macro translated(translate_vec)
{
	const N = translate_vec.len;
	Matrix{N+1,N+1, $typefrom($typeof(translate_vec).inner)} result;
	result.m[^1][:N] = translate_vec[..];
	return result;
}
macro rotated_2d(theta, $Type = double)
	=> (Matrix{2,2, $Type}){{
		math::cos(theta),  math::sin(theta),
		-math::sin(theta), math::cos(theta),
	}};
macro rotated_x(theta, $Type = double)
	=> (Matrix{3,3, $Type}){{
		1, 0, 0,
		0, math::cos(theta), math::sin(theta),
		0, -math::sin(theta), math::cos(theta),
	}};
macro rotated_y(theta, $Type = double)
	=> (Matrix{3,3, $Type}){{
		math::cos(theta), 0, -math::sin(theta),
		0, 1, 0,
		math::sin(theta), 0, math::cos(theta),
	}};
macro rotated_z(theta, $Type = double)
	=> (Matrix{3,3, $Type}){{
		math::cos(theta), math::sin(theta), 0,
		-math::sin(theta), math::cos(theta), 0,
		0, 0, 1,
	}};

macro ortho(left, right, top, bottom, near, far, $Type = double)
{
	var width = right - left;
	var height = top - bottom;
	var depth = far - near;

	return (Matrix{4,4, $Type}){{
		2 / ($Type)width, 0, 0, 0,
		0, -2 / ($Type)height, 0, 0,
		0, 0, -2 / ($Type)depth, 0,
		-($Type)(right + left) / ($Type)width, ($Type)(top + bottom) / ($Type)height, -($Type)(far + near) / ($Type)depth, 1
	}};
}
macro perspective(fov, aspect_ratio, near, far, $Type = double)
{
	var f = ($Type)math::cotan(fov / 2.0);
	var range_inv = 1.0 / ($Type)(near - far);

	return (Matrix{4,4, $Type}){{
		f / ($Type)aspect_ratio, 0, 0, 0,
		0, f, 0, 0,
		0, 0, (near + far) * range_inv, -1,
		0, 0, near * far * range_inv * 2, 0,
	}};
}
<*
 @require $typeof(eye).kindof == VECTOR && eye.len == 3
 @require $typeof(target).kindof == VECTOR && target.len == 3
 @require $typeof(world_up).kindof == VECTOR && world_up.len == 3
 *>
macro look_at(eye, target, world_up, $Type = double)
{
	var forward = (target - eye).normalize();
	var right = (forward.cross(world_up)).normalize();
	var up = right.cross(forward);

	return (Matrix{4,4, $Type}){{
		right.x, up.x, -forward.x, 0,
		right.y, up.y, -forward.y, 0,
		right.z, up.z, -forward.z, 0,
		-eye.dot(right), -eye.dot(up), eye.dot(forward), 1,
	}};
}
