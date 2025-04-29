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
