function rxy = rotate2( xy, theta, x0, y0 )
% Rotation 2D coordinates about any point.
%
% INPUTS
% ------
%	xy      - a 2-D matrix has a size of 2-by-n.
%   theta	- rotation angle( in radians ), the direction 
%             of rotation is counterclockwise.
%	x0,y0   - center of rotation, ( 0,0 ) by default.
% 
% OUTPUTS
% -------
%   rxy     - coordinates after rotation, same size as xy.
%
% EXAMPLE
% -------
% two points ( 1.5, 2.0 ) and ( 3.5, 1.0 ), rotate about 
%            ( 0.5, 0.0 ) for 60 degrees.
%
%   xy = [ 1.5 3.5
%          2.0 1.0 ];
%   rxy = rotate2( xy, pi / 3, 0.5, 0 );
%
% See also ROTATE3, AXANG2ROTM, MAKEHGTFORM
%
% WuYu's SnakeM Matlab Toolbox     Version 1.00
% Copyright (c) 2018 by WuYu. [ losengarden@aliyun.com ]

if nargin < 2
    error( 'Not enough input arguments.' );
end

if nargin < 3
    x0 = 0;
end

if nargin < 4
    y0 = 0;
end

[ rows, cols ]= size( xy );
if rows ~= 2
    error( 'xy must has a size of 2-by-n.' );
end

% construct the transform matrix
cth = cos( theta );
sth = sin( theta );
rm = [ cth,     -sth,   x0 - cth * x0 + sth * y0
       sth,     cth,    y0 - sth * x0 - cth * y0
       0,       0,      1 ];

% fill third row of xy with ones and execute the transform
xy = [ xy; ones( 1, cols ) ];
rxy = rm * xy;
rxy = rxy( 1 : 2, : );
