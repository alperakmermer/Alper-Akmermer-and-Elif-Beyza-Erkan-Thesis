% h1 = 0.0313 ;
% h2 = 0.0625 ;
% h3 = -0.0625 ;
% h4 = -0.0938 ;
% h5 = 0.1563 ;
% h6 = 0.4375 ;
% h7 = 0.4375 ;
% h8 = 0.1563 ;
% h9 = -0.0938 ;
% h10 = -0.0625 ;
% h11 = 0.0625 ;
% h12 = 0.0313 ;



%#codegen
function [y_out] = mlhdlc_lpfir(x_in,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12)
% Low-pass FIR Filter

% declare and initialize the delay registers
persistent ud1 ud2 ud3 ud4 ud5 ud6 ud7 ud8 ud9 ud10 ud11 ud12 ;
if isempty(ud1)
    ud1 = 0; ud2 = 0; ud3 = 0; ud4 = 0; ud5 = 0; ud6 = 0; ud7 = 0; ud8 = 0; ud9 = 0;
    ud10 = 0; ud11 = 0; ud12 = 0; 
end

% access the previous value of states/registers
a1 = ud1 ; a2 = ud2 ; a3 = ud3 ; a4 = ud4 ;
a5 = ud5 ; a6 = ud6 ; a7 = ud7 ; a8 = ud8 ;
a9 = ud9 ; a10 = ud10 ; a11 = ud11 ; a12 = ud12 ;

% multiplier chain
m1 = h1 * a1; m2 = h2 * a2; m3 = h3 * a3; m4 = h4 * a4;
m5 = h5 * a5; m6 = h6 * a6; m7 = h7 * a7; m8 = h8 * a8;
m9 = h9 * a9; m10 = h10 * a10; m11 = h11 * a11; m12 = h12 * a12;
% adder chain
aa1 = m1 + m2 ; aa2 = aa1 + m3 ; aa3 = aa2 + m4 ; aa4 = aa3 + m5 ;
aa5 = aa4 + m6 ; aa6 = aa5 + m7 ; aa7 = aa6 + m8 ; aa8 = aa7 + m9 ;
aa9 = aa8 + m10 ; aa10 = aa9 + m11 ; 

% filtered output
y_out = aa10 + m12;



% update the delay line
ud12 = ud11;
ud11 = ud10; 
ud10 = ud9;
ud9 = ud8;
ud8 = ud7; 
ud7 = ud6;
ud6 = ud5;
ud5 = ud4;
ud4 = ud3;
ud3 = ud2;
ud2 = ud1;
ud1 = x_in;

end