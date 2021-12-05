function TwoPhaseTB(Filter,h) 
  
q = quantizer('fixed','floor','saturate',[8 6]);

Ts = 10e-6; % örnekleme periyodu 10 us, fs=100KHz
fNy = 1 / Ts / 2; % Nyquist frekans?
ns = 1000; % dizideki örnek say?s?
nf = 10; % dizide kaç farkl? frekansta i?aret olaca??


for i = 1:ns
freq(i) = (fNy/ns) * round(i/ns*nf)*ns/nf; % örneklerin frekans?
end

for i = 1:ns
x(i) = cos(2*pi*freq(i)*Ts*i);
end

x_in=num2hex(q,x);
x_in=hex2num(q,x_in);

x0 = x_in(1:2:end);
x1 = x_in(2:2:end);



len = length(x)/2;
y0  =zeros(1,len);
y1  =zeros(1,len);
y_out=zeros(1,2*len);

%%
% h = [-0.0032,	-0.0063 ,0.0086 , 0.0108,	-0.0159,	-0.0213,	 0.0296,	 0.0397,	-0.0567 ,	-0.0838 ,	 0.1468 ,	 0.4485,	 0.4485,	 0.1468,	-0.0838 ,	-0.0567 ,	 0.0397,	 0.0296,	-0.0213,	-0.0159,	 0.0108 ,	 0.0086,	-0.0063 ,-0.0032 ];

%% 16 bit 15 fraction
%h = [ 0.001617431640625                        ,	-0.009307861328125                        ,	 0.004180908203125                        ,	 0.014739990234375                        ,	-0.010162353515625                        ,	-0.026458740234375                        ,	 0.022369384765625                        ,	 0.04644775390625                         ,	-0.0484771728515625                       ,	-0.0916900634765625                       ,	 0.1381988525390625                       ,	 0.4571380615234375                       ,	 0.4571380615234375                       ,	 0.1381988525390625                       ,	-0.0916900634765625                       ,	-0.0484771728515625                       ,	 0.04644775390625                         ,	 0.022369384765625                        ,	-0.026458740234375                        ,	-0.010162353515625                        ,	 0.014739990234375                        ,	 0.004180908203125                        ,	-0.009307861328125                        ,	 0.001617431640625 ];

%%

len = length(x)/2;
y   = zeros(1,len);

% %#ok<RHSFN>

for ii=1:len
    x_in1 = x0(ii);
    x_in2 = x1(ii);
    % call to the design 'mlhdlc_sfir' that is targeted for hardware
%     [y0(ii),y1(ii)] = mlhdlc_2_phase24_tap_filter(x_in1,x_in2,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12);
   % [y0(ii),y1(ii)] = twophase_ffa_sym_notranspose24tap_filter(x_in1,x_in2) ;
   [y0(ii),y1(ii)] = Filter(x_in1,x_in2) ;
end

for i=0 : (length(y0)-1)
    y_out(2*i+1) = y0(i+1);
    y_out(2*i+2) = y1(i+1);
end

y_orj = conv(x_in,h);

figure;
subplot(3,2,1);
plot(x_in);
spec = abs(fft(x_in));
subplot(3,2,2);
plot((0:100:50e3-100),spec(1:ns/2));

subplot(3,2,3);
plot(y_orj);
spec1 = abs(fft(y_orj));
subplot(3,2,4);
plot((0:100:50e3-100),spec1(1:ns/2));

subplot(3,2,5);
plot(y_out);
spec2 = abs(fft(y_out));
subplot(3,2,6);
plot((0:100:50e3-100),spec2(1:ns/2));

end