q = quantizer('fixed','floor','saturate',[16 14]);
clear mlhdlc_2_phase24_tap_filter;

Ts = 10e-6; % örnekleme periyodu 10 us, fs=100KHz
fNy = 1 / Ts / 2; % Nyquist frekansi
ns = 1000; % dizideki örnek sayisi

nf = 10; % dizide kaç farkli frekansta isaret olacagi

freq = zeros(1,ns);
for i = 1:ns
freq(i) = (fNy/ns) * round(i/ns*nf)*ns/nf; % orneklerin frekansi
end
x = zeros(1,ns);
for i = 1:ns
x(i) = cos(2*pi*freq(i)*Ts*i);
end

x_in=num2hex(q,x);
x_in=hex2num(q,x_in);
len=length(x_in);

y_out_1p=zeros(1,len);
y_out_2p=zeros(1,len);
y_out_3p=zeros(1,len);
y_out_4p=zeros(1,len);
y_out_6p=zeros(1,len);
y_out_8p=zeros(1,len);
y_out_9p=zeros(1,len);
y_out_12p=zeros(1,len);
y_out_16p=zeros(1,len);
y_out_18p=zeros(1,len);
y_out_24p=zeros(1,len);
y_out_27p=zeros(1,len);
%%
for ii=1:len
    [y_out_1p(ii)] = mlhdlc_1_phase_216_tap_direct_filter(x_in(ii));
end
%%
for ii=1:2:len-1
    [y_out_2p(ii),y_out_2p(ii+1)] = mlhdlc_2_phase_216_tap_direct_filter(x_in(ii),x_in(ii+1));
end
%%
for ii=1:3:len-2
    [y_out_3p(ii),y_out_3p(ii+1),y_out_3p(ii+2)] = mlhdlc_3_phase_216_tap_direct_filter(x_in(ii),x_in(ii+1),x_in(ii+2));
end
%%
for ii=1:4:len-3
    [y_out_4p(ii),y_out_4p(ii+1),y_out_4p(ii+2),y_out_4p(ii+3)] = mlhdlc_4_phase_216_tap_direct_filter(x_in(ii),x_in(ii+1),x_in(ii+2),x_in(ii+3));
end
%%
for ii=1:6:len-5
    [y_out_6p(ii),y_out_6p(ii+1),y_out_6p(ii+2),y_out_6p(ii+3),y_out_6p(ii+4),y_out_6p(ii+5)] = mlhdlc_6_phase_216_tap_direct_filter(x_in(ii),x_in(ii+1),x_in(ii+2),x_in(ii+3),x_in(ii+4),x_in(ii+5));
end
%%
for ii=1:8:len-7
    [y_out_8p(ii),y_out_8p(ii+1),y_out_8p(ii+2),y_out_8p(ii+3),y_out_8p(ii+4),y_out_8p(ii+5),y_out_8p(ii+6),y_out_8p(ii+7)] = mlhdlc_8_phase_216_tap_direct_filter(x_in(ii),x_in(ii+1),x_in(ii+2),x_in(ii+3),x_in(ii+4),x_in(ii+5),x_in(ii+6),x_in(ii+7));
end
%%
for ii=1:9:len-8
    [y_out_9p(ii),y_out_9p(ii+1),y_out_9p(ii+2),y_out_9p(ii+3),y_out_9p(ii+4),y_out_9p(ii+5),y_out_9p(ii+6),y_out_9p(ii+7),y_out_9p(ii+8)] = mlhdlc_9_phase_216_tap_direct_filter(x_in(ii),x_in(ii+1),x_in(ii+2),x_in(ii+3),x_in(ii+4),x_in(ii+5),x_in(ii+6),x_in(ii+7),x_in(ii+8));
end
%%
for ii=1:12:len-11
    [y_out_12p(ii),y_out_12p(ii+1),y_out_12p(ii+2),y_out_12p(ii+3),y_out_12p(ii+4),y_out_12p(ii+5),y_out_12p(ii+6),y_out_12p(ii+7),y_out_12p(ii+8),y_out_12p(ii+9),y_out_12p(ii+10),y_out_12p(ii+11)] = mlhdlc_12_phase_216_tap_direct_filter(x_in(ii),x_in(ii+1),x_in(ii+2),x_in(ii+3),x_in(ii+4),x_in(ii+5),x_in(ii+6),x_in(ii+7),x_in(ii+8),x_in(ii+9),x_in(ii+10),x_in(ii+11));
end
%%
for ii=1:18:len-17
    [y_out_18p(ii),y_out_18p(ii+1),y_out_18p(ii+2),y_out_18p(ii+3),y_out_18p(ii+4),y_out_18p(ii+5),y_out_18p(ii+6),y_out_18p(ii+7),y_out_18p(ii+8),y_out_18p(ii+9),y_out_18p(ii+10),y_out_18p(ii+11),y_out_18p(ii+12),y_out_18p(ii+13),y_out_18p(ii+14),y_out_18p(ii+15),y_out_18p(ii+16),y_out_18p(ii+17)] = mlhdlc_18_phase_216_tap_direct_filter(x_in(ii),x_in(ii+1),x_in(ii+2),x_in(ii+3),x_in(ii+4),x_in(ii+5),x_in(ii+6),x_in(ii+7),x_in(ii+8),x_in(ii+9),x_in(ii+10),x_in(ii+11),x_in(ii+12),x_in(ii+13),x_in(ii+14),x_in(ii+15),x_in(ii+16),x_in(ii+17));
end
%%
for ii=1:24:len-23
    [y_out_24p(ii),y_out_24p(ii+1),y_out_24p(ii+2),y_out_24p(ii+3),y_out_24p(ii+4),y_out_24p(ii+5),y_out_24p(ii+6),y_out_24p(ii+7),y_out_24p(ii+8),y_out_24p(ii+9),y_out_24p(ii+10),y_out_24p(ii+11),y_out_24p(ii+12),y_out_24p(ii+13),y_out_24p(ii+14),y_out_24p(ii+15),y_out_24p(ii+16),y_out_24p(ii+17),y_out_24p(ii+18),y_out_24p(ii+19),y_out_24p(ii+20),y_out_24p(ii+21),y_out_24p(ii+22),y_out_24p(ii+23)] = mlhdlc_24_phase_216_tap_direct_filter(x_in(ii),x_in(ii+1),x_in(ii+2),x_in(ii+3),x_in(ii+4),x_in(ii+5),x_in(ii+6),x_in(ii+7),x_in(ii+8),x_in(ii+9),x_in(ii+10),x_in(ii+11),x_in(ii+12),x_in(ii+13),x_in(ii+14),x_in(ii+15),x_in(ii+16),x_in(ii+17),x_in(ii+18),x_in(ii+19),x_in(ii+20),x_in(ii+21),x_in(ii+22),x_in(ii+23));
end
%%
y_orj = conv(x_in,h);
y_orj(1001:end)=[];

%%
figure;
subplot(6,4,1);
plot(x_in);
title("original signal");
spec = abs(fft(x_in));
subplot(6,4,2);
plot((0:100:50e3-100),spec(1:ns/2));
title("original signal in frequency domain");

subplot(6,4,3);
plot(y_orj);
title("reference filtered signal");
specRef = abs(fft(y_orj));
subplot(6,4,4);
plot((0:100:50e3-100),specRef(1:ns/2));
title("reference filtered signal in frequency domain");

subplot(6,4,5);
plot(y_out_1p);
title("filtered signal 1p");
spec1 = abs(fft(y_out_1p));
subplot(6,4,6);
plot((0:100:50e3-100),spec1(1:ns/2));
title("filtered signal 1p in frequency domain");

subplot(6,4,7);
plot(y_out_2p);
title("filtered signal 2p");
spec2 = abs(fft(y_out_2p));
subplot(6,4,8);
plot((0:100:50e3-100),spec2(1:ns/2));
title("filtered signal 2p in frequency domain");

subplot(6,4,9);
plot(y_out_3p);
title("filtered signal 3p");
spec3 = abs(fft(y_out_3p));
subplot(6,4,10);
plot((0:100:50e3-100),spec3(1:ns/2));
title("filtered signal 3p in frequency domain");

subplot(6,4,11);
plot(y_out_4p);
title("filtered signal 4p");
spec4 = abs(fft(y_out_4p));
subplot(6,4,12);
plot((0:100:50e3-100),spec4(1:ns/2));
title("filtered signal 4p in frequency domain");

subplot(6,4,13);
plot(y_out_6p);
title("filtered signal 6p");
spec6 = abs(fft(y_out_6p));
subplot(6,4,14);
plot((0:100:50e3-100),spec6(1:ns/2));
title("filtered signal 6p in frequency domain");

subplot(6,4,15);
plot(y_out_8p);
title("filtered signal 8p");
spec8 = abs(fft(y_out_8p));
subplot(6,4,16);
plot((0:100:50e3-100),spec8(1:ns/2));
title("filtered signal 8p in frequency domain");

subplot(6,4,17);
plot(y_out_9p);
title("filtered signal 9p");
spec9 = abs(fft(y_out_9p));
subplot(6,4,18);
plot((0:100:50e3-100),spec9(1:ns/2));
title("filtered signal 9p in frequency domain");

subplot(6,4,19);
plot(y_out_12p);
title("filtered signal 12p");
spec12 = abs(fft(y_out_12p));
subplot(6,4,20);
plot((0:100:50e3-100),spec12(1:ns/2));
title("filtered signal 12p in frequency domain");

subplot(6,4,21);
plot(y_out_18p);
title("filtered signal 18p");
spec18 = abs(fft(y_out_18p));
subplot(6,4,22);
plot((0:100:50e3-100),spec18(1:ns/2));
title("filtered signal 18p in frequency domain");

subplot(6,4,23);
plot(y_out_24p);
title("filtered signal 24p");
spec24 = abs(fft(y_out_24p));
subplot(6,4,24);
plot((0:100:50e3-100),spec24(1:ns/2));
title("filtered signal 24p in frequency domain");

%%
rateRef = specRef(205)/spec(205);
rate(1) = spec1(205)/spec(205);
rate(2) = spec2(205)/spec(205);
rate(3) = spec3(205)/spec(205);
rate(4) = spec4(205)/spec(205);
rate(6) = spec6(205)/spec(205);
rate(8) = spec8(205)/spec(205);
rate(9) = spec9(205)/spec(205);
rate(12) = spec12(205)/spec(205);
rate(18) = spec18(205)/spec(205);
rate(24) = spec24(205)/spec(205);

%%

rateEarlyRef = specRef(5)/spec(5);
rateEarly(1) = spec1(5)/spec(5);
rateEarly(2) = spec2(5)/spec(5);
rateEarly(3) = spec3(5)/spec(5);
rateEarly(4) = spec4(5)/spec(5);
rateEarly(6) = spec6(5)/spec(5);
rateEarly(8) = spec8(5)/spec(5);
rateEarly(9) = spec9(5)/spec(5);
rateEarly(12) = spec12(5)/spec(5);
rateEarly(18) = spec18(5)/spec(5);
rateEarly(24) = spec24(5)/spec(5);