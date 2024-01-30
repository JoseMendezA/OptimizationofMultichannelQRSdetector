function[change] = delta(ct,mt,y,b)
% The delta function is the non-uniform distributions used by the nonUniform
% mutations.  This function returns a change based on the current gen, the
% max gen and the amount of possible deviation.
%
% The function ∆(t, y) returns a value in the range [0,y] such that 
% ∆(t, y) approaches to zero as t increases. This property causes 
% this operator to search the space uniformly initially (when t is small), 
% and very locally at later stages.


% function[change] = delta(ct,mt,y,b)
% ct - current generation
% mt - maximum generation
% y  - maximum amount of change, i.e. distance from parameter value to bounds
% b  - shape parameter: is a system parameter determining the degree of dependency on the iteration number

% Binary and Real-Valued 
% Copyright (C) Evolutionary Programming Based on Non-Uniform Mutation
% Xinchao Zhao and Xiao-Shan Gao
% (xczhao,xgao)@mmrc.iss.ac.cn
%
r=rand; % uniform random number from [0,1]
if(r>1)
  r=.99;
  % disp(sprintf('max gen %d < current gen %d setting ratio = 1',mt,ct));
end
change = y*(1-r^((1-(ct/mt))^b));


