function [y] = basic_buffer(x)
    coder.inline('always') ;
    y = x;
end