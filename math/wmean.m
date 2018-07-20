function m = wmean( a, w, dim )
% Weighted average value.
%
% INPUTS
% ------
%	a	- a 2-D matrix.
%   w	- the weight vector.
%	dim	- takes the wmean along this dimension, must be 1 or 2.
% 
% OUTPUTS
% -------
%
% EXAMPLE
% -------
% 
% See also MEAN
%
% WuYu's SnakeM Matlab Toolbox     Version 1.00
% Copyright (c) 2018 by WuYu. [ losengarden@aliyun.com ]


if nargin == 1
    m = mean( a );
    return
end

if nargin == 2
    dim = 1;
end

[ rows, cols ] = size( a );
w = w( : ); % stretch w to a column vector

if dim == 1         % every column's wmean
    if length( w ) ~= rows
        error( 'wmean: Length of weight must equal to the rows of a.' );
    else
        w = repmat( w, 1, cols );
    end
elseif dim == 2     % every row's wmean
    if length( w ) ~= cols
        error( 'wmean: Length of weight must equal to the columns of a.' );
    else
        w = repmat( w', rows, 1 );
    end
else
    error( 'Dimension > 2 is not supported.' );
end

m = sum( w .* a, dim ) ./ sum( w, dim );
