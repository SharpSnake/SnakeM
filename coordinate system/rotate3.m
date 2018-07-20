function rxyz = rotate3( xyz, axang, center )
% Rotation 3D coordinates about any point.
%
% INPUTS
% ------
%	xyz       - a 2-D matrix has a size of 3-by-n.
%   axang     - axis-angle vector [ ax ay az theta ].
%	center    - center of rotation, [0,0,0] by default.
% 
% OUTPUTS
% -------
%   rxyz      - coordinates after rotation, same size as xyz.
%
% EXAMPLE
% -------
% two points ( 1.5, 2.0, 1.0 ) and ( 3.5, 1.0, 4.5 ), rotate about 
%            ( 0.5, 0.0, 0.3 ) for 60 degrees.
%
%   xyz = [ 1.5 3.5
%           2.0 1.0 
%           1.0 4.5 ];
%   rxyz = rotate3( xyz, [ 1 0 0 pi / 3 ], [ 0.5, 0, 0.3 ] );
%
% See also ROTATE2, AXANG2ROTM, MAKEHGTFORM
%
% WuYu's SnakeM Matlab Toolbox     Version 1.00
% Copyright (c) 2018 by WuYu. [ losengarden@aliyun.com ]

if nargin < 2
    error( 'Not enough input arguments.' );
end

if nargin < 3
    center = [ 0, 0, 0 ];
end

[ rows, cols ]= size( xyz );
if rows ~= 3
    error( 'xyz must has a size of 3-by-n.' );
end

axang = axang( : );
if length( axang ) ~= 4
    error( 'axis-angle vector must be a quaternion.' );
end

center = center( 1 : 3 );
center = center( : );

% normalize the axis vector to unit vector
axv = axang( 1 : 3 );
axv = axv / norm( axv );
ax = axv( 1 );
ay = axv( 2 );
az = axv( 3 );

% construct the transform matrix
theta = axang( 4 );
ct = cos( theta );
st = sin( theta );
vt = 1 - ct;

rm = [ ct + ax * ax * vt, ax * ay * vt - az * st, ax * az * vt + ay * st
       ay * ax * vt + az * st, ct + ay * ay * vt, ay * az * vt - ax * st
       az * ax * vt - ay * st, az * ay * vt + ax * st, ct + az * az * vt ];
rm = [ rm, center - rm * center; 0, 0, 0, 1 ];

% fill fourth row of xyz with ones and execute the transform
xyz = [ xyz; ones( 1, cols ) ];
rxyz = rm * xyz;
rxyz = rxyz( 1 : 3, : );
