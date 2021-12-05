function SinglePhaseTB(Filter,h) 

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


len = length(x);
y_out=zeros(1,len);

for ii=1:len
   % x_in = x(ii);
   y_out(ii) = Filter(x_in(ii));
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