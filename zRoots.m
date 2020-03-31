function z = zRoots(Bi,zmax)
% Function is modified from the following source:
%      Recktenwald, G., 2006. Transient, one-dimensional heat conduction in
%       a convectively cooled sphere, Portland State University, Dept. of
%       MME. Permanent link: http://www.webcitation.org/60nDyv3Yy
%
% zRoots  Find all roots to 1 - z*cot(z) - Bi over a range of z
%
% Synopsis:  z = zRoots
%            z = zRoots(Bi)
%            z = zRoots(Bi,zmax)
%
% Input:     Bi = Biot number.  Default:  Bi = 10
%            zmax = upper limit of a range.  Roots are sought in the
%                   range 0 < zeta <= zmax.  Default: zmax=50
%
% Output:    z = Vector of roots in the interval 0 < z <= zmax

if nargin<1 || isempty(Bi),       Bi = 10;      end
if nargin<2 || isempty(zmax),     zmax = 50;    end

% --- Find brackets for zeros of 1 - z*cot(z) - Bi
nzb = max([250 50*zmax]);
zb = bracket(@zfun,10*eps,zmax,nzb,Bi);   %  zb is a 2 column matrix

% --- Find the zero (or singularity) contained in each bracket pair
mb = size(zb,1);  zall = zeros(mb,1);  %  Preallocate array for roots
%  Call optimset to create the data structure that controls fzero
%  Use no messages ('Display','Off') and tight tolerance ('TolX',5e-9)
fzopts = optimset('Display','Off','TolX',5e-9);
for k=1:mb
  zall(k) = fzero(@zfun,zb(k,:),fzopts,Bi);
end

% --- Sort out roots and singularities.  Singularites are "roots"
%     returned from fzero that have f(z) greater than a tolerance.
fall = zfun(zall,Bi);          %  evaluate f(z) at all potential roots
igood = find(abs(fall)<5e-4);     %  vector of indices of good roots
ngood = length(igood);
z = zall(igood);   f = fall(igood);
zbad = zall(:);    ibad = (1:length(zbad))';  %  First copy all data
zbad(igood) = [];  ibad(igood) = [];          %  then throw away good parts
nbad = length(ibad);

    function f = zfun(z,Bi)
        % ztest  Evaluate f = 1 - z*cot(z) - Bi for root-finding algorithm
            f = 1 - z.*cot(z) - Bi;
    end

    function xb = bracket(fun,xmin,xmax,nx,varargin)
    % brackPlot  Find brackets for roots of a function.
    %
    % Synopsis:  xb = bracket(fun,xmin,xmax)
    %            xb = bracket(fun,xmin,xmax,nx)
    %
    % Input:  fun = (string) name of function for which roots are sought
    %         xmin,xmax = endpoints of interval to subdivide into brackets.
    %         nx = (optional) number of subintervals.  Default:  nx = 20.
    %
    % Output:  xb = 2-column matrix of bracket limits.  xb(k,1) is the left
    %               bracket and xb(k,2) is the right bracket for the kth
    %               potential root.  If no brackets are found, xb = [].

    if nargin<4, nx=20; end

    x = linspace(xmin,xmax,nx);    %  Test f(x) at these x values
    f = feval(fun,x,varargin{:});
    nb = 0;
    xbtemp = zeros(nx,2);   %  Temporary storage for brackets as they are found

    for k = 1:length(f)-1
      if sign(f(k))~=sign(f(k+1))  %  True if f(x) changes sign in interval
        nb = nb + 1;
        xbtemp(nb,:) = x(k:k+1);
      end
    end

    % -- Return nb-by-2 matrix of brackets.
    if nb == 0
        warning('bracket:NoSignChange','No brackets found. Change [xmin,xmax] or nx');
      xb = [];
    else
      xb = xbtemp(1:nb,:);
    end

    end

end