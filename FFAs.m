Ts = 10e-6; % örnekleme periyodu 10 us, fs=100KHz
fNy = 1 / Ts / 2; % Nyquist frekans?
ns = 1002; % dizideki örnek sayýsý  1000 yerine 1002 hem 3 hem 2 faz için 
nf = 10; % dizide kaç farklý frekansta iþaret olacaðý
% cutoff 20khz _

h=[-0.03125,0.046875,0.015625,-0.140625,0.140625,0.46875,0.46875,0.140625,-0.140625,0.015625,0.046875,-0.03125];
%h = [0.0313,0.0625,-0.0625,-0.0938,0.1563,0.4375,0.4375,0.1563,-0.0938,-0.0625,0.0625,0.0313] ;

for i = 1:ns
freq(i) = (fNy/ns) * round(i/ns*nf)*ns/nf; % örneklerin frekansý
end

for i = 1:ns
x(i) = cos(2*pi*freq(i)*Ts*i);
end

q = quantizer('fixed','floor','saturate',[8 6]);
x=num2hex(q,x);
x=hex2num(q,x);

%% 2FFA

%Input Signals
x0    = x(1:2:end);
x1    = x(2:2:end);
x0px1 = x0 +x1;

%Subfilters
h0    = h(1:2:end);
h1    = h(2:2:end);
h0ph1 = h0 + h1;

%Filter Outputs
y_1 = conv (x0,h0);
y_2 = conv (x0px1, h0ph1);
y_3 = conv (x1,h1);

%Delay
y_3_delayed = delayseq(y_3,1) ;

%Outputs
y0 = y_1 + y_3_delayed;
y1 = y_2 - y_1 - y_3;

%Output
for i=0 : (length(y0)-1)
    y(2*i+1) = y0(i+1);
    y(2*i+2) = y1(i+1);
end

%Referans output
y_orj = conv(x,h);

figure;
title('2-Parallel FFA') ;
subplot(3,2,1);
plot(x);
title('Original Signal in Time')
X = abs(fft(x));
f = linspace(0,(1/(2*Ts)),length(X(1:ns/2)));
subplot(3,2,2);
plot(f,X(1:ns/2));
title('Original Signal in Freq')

subplot(3,2,3);
plot(y_orj);
title('Reference Filtered Signal in Time')
Y_orj = abs(fft(y_orj));
subplot(3,2,4);
plot(f,Y_orj(1:ns/2));
title('Reference Filtered Signal in Freq')

subplot(3,2,5);
plot(y);
title('FFA Filtered Signal in Time')
Y = abs(fft(y));
subplot(3,2,6);
plot(f,Y(1:ns/2));
title('FFA Filtered Signal in Freq')

%% Tsao & Choi 2-parallel

%Decomposition of input signal
x0    = x(1:2:end);
x1    = x(2:2:end);

%Decomposition of Filter
h0    = h(1:2:end);
h1    = h(2:2:end);

%Subfilters
hf1   = (1/2)*(h0-h1);
hf2   = (1/2)*(h0+h1);
hf3   = h1 ;

%Filter Inputs
hi1   = x0-x1  ;
hi2   = x0+x1  ;
hi3   = x1  ;

%Filter Outputs
Fo1 = conv(hi1,hf1) ;
Fo2 = conv(hi2,hf2) ;
Fo3 = conv(hi3,hf3) ;

%Delay
Fo3_delayed = delayseq(Fo3,1) ;

%Filter Outputs
Y0 = Fo3_delayed + Fo1 + Fo2 - Fo3 ;
Y1 = Fo2-Fo1 ;

%Output
for i=0 : (length(Y1)-1)
    Y(2*i+1) = Y0(i+1);
    Y(2*i+2) = Y1(i+1);
end

%Reference Signal
y_orj = conv(x,h);

figure;
subplot(3,2,1);
plot(x);
title('Original Signal in Time')
X = abs(fft(x));
f = linspace(0,(1/(2*Ts)),length(X(1:ns/2)));
subplot(3,2,2);
plot(f,X(1:ns/2));
title('Original Signal in Freq')

subplot(3,2,3);
plot(y_orj);
title('Reference Filtered Signal in Time')
Y_orj = abs(fft(y_orj));
subplot(3,2,4);
plot(f,Y_orj(1:ns/2));
title('Reference Filtered Signal in Freq')

subplot(3,2,5);
plot(Y);
title('T&C Filtered Signal in Time')
Y = abs(fft(Y));
subplot(3,2,6);
plot(f,Y(1:ns/2));
title('T&C Filtered Signal in Freq')

%% 3FFA

%Input Signals
x0    = x(1:3:end);
x1    = x(2:3:end);
x2    = x(3:3:end);
x0px1 = x0 +x1;
x1px2 = x1 + x2 ;
x0px1px2 = x0 + x1 + x2 ;

%Subfilters
h0    = h(1:3:end);
h1    = h(2:3:end);
h2    = h(3:3:end);
h0ph1 = h0 + h1;
h1ph2 = h1 + h2;
h0ph1ph2 = h0 + h1 + h2;

%Filter Outputs
y_1 = conv (x0,h0);
y_2 = conv (x1,h1);
y_3 = conv (x2,h2);
y_4 = conv (x0px1,h0ph1);
y_5 = conv (x1px2,h1ph2);
y_6 = conv (x0px1px2,h0ph1ph2);

%Delays
y_2_delayed = delayseq(y_2,1) ;
y_3_delayed = delayseq(y_3,1) ;
y_5_delayed = delayseq(y_5,1) ;

%Filter Outputs
y0 = y_1 - y_3_delayed + y_5_delayed - y_2_delayed;
y1 = y_4 - y_2 - y_1 + y_3_delayed;
y2 = y_6 - ( y_5 - y_2 ) - (y_4 - y_2 ) ;

%Output
for i=0 : (length(y0)-1)
    y(3*i+1) = y0(i+1);
    y(3*i+2) = y1(i+1);
    y(3*i+3) = y2(i+1);
end

%Reference Signals
y_orj = conv(x,h);

figure;
subplot(3,2,1);
plot(x);
title('Original Signal in Time')
X = abs(fft(x));
f = linspace(0,(1/(2*Ts)),length(X(1:ns/2)));
subplot(3,2,2);
plot(f,X(1:(ns)/2));
title('Original Signal in Freq')

subplot(3,2,3);
plot(y_orj);
title('Reference Filtered Signal in Time')
Y_orj = abs(fft(y_orj));
subplot(3,2,4);
plot(f,Y_orj(1:(ns)/2));
title('Reference Filtered Signal in Freq')

subplot(3,2,5);
plot(y);
title('FFA Filtered Signal in Time')
Y = abs(fft(y));
subplot(3,2,6);
plot(f,Y(1:(ns)/2));
title('FFA Filtered Signal in Freq')

%% T&C 3-parallel


%Input Signals
x0    = x(1:3:end);
x1    = x(2:3:end);
x2    = x(3:3:end);

%Filter Inputs
hi1 = x0+x1 ;
hi2 = x0-x1 ;
hi3 = x0+x2 ;
hi4 = x0-x2 ;
hi5 = x1 ;
hi6 = x0+x1+x2 ;

%Decomposition of Filter
h0    = h(1:3:end);
h1    = h(2:3:end);
h2    = h(3:3:end);

%Subfilters
hf1 = (1/2)*(h0+h1) ; 
hf2 = (1/2)*(h0-h1) ; 
hf3 = (1/2)*(h0+h2) ; 
hf4 = (1/2)*(h0-h2) ; 
hf5 = (h1) ; 
hf6 = (h0+h1+h2) ; 

%Filter Outputs
y_1 = conv (hi1,hf1);
y_2 = conv (hi2,hf2);
y_3 = conv (hi3,hf3);
y_4 = conv (hi4,hf4);
y_5 = conv (hi5,hf5);
y_6 = conv (hi6,hf6);

%Delays
temp0 = y_6 - 2*y_3 + y_2 - y_1 - y_5 ; 
temp1 = y_3+ y_4 - y_1 - y_2 + y_5 ;
delay_for_y0 = delayseq(temp0,1) ;
delay_for_y1 = delayseq(temp1,1) ;

%Filter Outputs
y0 = y_1 + y_2 - y_5 + delay_for_y0 ;
y1 = y_1 - y_2 + delay_for_y1 ;  
y2 = y_3 - y_4 + y_5 ;

%Output
for i=0 : (length(y0)-1)
    y(3*i+1) = y0(i+1);
    y(3*i+2) = y1(i+1);
    y(3*i+3) = y2(i+1);
end

%Reference Signals
y_orj = conv(x,h);

figure;
subplot(3,2,1);
plot(x);
title('Original Signal in Time')
X = abs(fft(x));
f = linspace(0,(1/(2*Ts)),length(X(1:ns/2)));
subplot(3,2,2);
plot(f,X(1:(ns)/2));
title('Original Signal in Freq')

subplot(3,2,3);
plot(y_orj);
title('Reference Filtered Signal in Time')
Y_orj = abs(fft(y_orj));
subplot(3,2,4);
plot(f,Y_orj(1:(ns)/2));
title('Reference Filtered Signal in Freq')

subplot(3,2,5);
plot(y);
title('T&C Filtered Signal in Time')
Y = abs(fft(y));
subplot(3,2,6);
plot(f,Y(1:(ns)/2));
title('T&C Filtered Signal in Freq')
