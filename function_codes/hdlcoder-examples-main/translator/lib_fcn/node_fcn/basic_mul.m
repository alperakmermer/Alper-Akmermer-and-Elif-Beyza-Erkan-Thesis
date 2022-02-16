function [out] = basic_mul(in1,in2)
    coder.inline('always') ;
    out = in1 * in2;
end