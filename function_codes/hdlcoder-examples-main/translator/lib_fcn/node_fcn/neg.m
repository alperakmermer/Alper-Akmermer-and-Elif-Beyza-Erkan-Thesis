function [y] = neg(x)
    coder.inline('always') ;
    y = -x;
end