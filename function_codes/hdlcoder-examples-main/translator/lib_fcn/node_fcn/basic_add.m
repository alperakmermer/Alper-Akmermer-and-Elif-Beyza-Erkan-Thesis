function [out] = basic_add(in1,in2)
    coder.inline('always') ;
    out = in1 + in2;
end
