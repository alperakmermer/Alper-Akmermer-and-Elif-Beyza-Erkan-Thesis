function ThreePhaseTB(Filter,h) 

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

x0 = x_in(1:3:end);
x1 = x_in(2:3:end);
x2 = x_in(3:3:end);


y0  =zeros(1,length(x0));
y1  =zeros(1,length(x1));
y2  =zeros(1,length(x2));
y_out=zeros(1,length(x_in));



%%

for ii=1:length(x1)
    
    [y0(ii),y1(ii),y2(ii)] = Filter(x0(ii),x1(ii),x2(ii));
end

for i=0 : (length(y1)-1)
    y_out(3*i+1) = y0(i+1);
    y_out(3*i+2) = y1(i+1);
    y_out(3*i+3) = y2(i+1);
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