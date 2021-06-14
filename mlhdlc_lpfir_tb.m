q = quantizer('fixed','floor','saturate',[8 6]);
clear mlhdlc_lpfir;

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

h = [0.0313,0.0625,-0.0625,-0.0938,0.1563,0.4375,0.4375,0.1563,-0.0938,-0.0625,0.0625,0.0313] ;

h1 = 0.0313 ;
h2 = 0.0625 ;
h3 = -0.0625 ;
h4 = -0.0938 ;
h5 = 0.1563 ;
h6 = 0.4375 ;
h7 = 0.4375 ;
h8 = 0.1563 ;
h9 = -0.0938 ;
h10 = -0.0625 ;
h11 = 0.0625 ;
h12 = 0.0313 ;



for ii=1:len
    %x_in = x_i(ii);

    % call to the design 'mlhdlc_lpfir' that is targeted for hardware
   y_out(ii) = mlhdlc_lpfir(x_in(ii), h1, h2, h3, h4, h5, h6, h7, h8, h9, h10, h11,h12);
end

y_orj = conv(x_in,h);
y_tot_diff = 0 ;
max_diff = 0 ;

y_tot_diff_vivado = 0 ;
max_diff_vivado = 0 ;

for ii=2:len
    y_diff(ii) = y_orj(ii-1)-y_out(ii) ;
    y_tot_diff = y_tot_diff +  abs(y_diff(ii)) ;
    if (y_diff(ii) > max_diff) 
        max_diff = y_diff(ii) ;
    end
    
        y_diff_vivado(ii) = y_orj(ii-1)-y_out(ii) ;
    y_tot_diff_vivado = y_tot_diff_vivado +  abs(y_diff_vivado(ii)) ;
    if (y_diff_vivado(ii) > max_diff_vivado) 
        max_diff_vivado = y_diff_vivado(ii) ;
    end
    
end

% Inserting the Y data we get from vivado 
%
% fileID = fopen("Y_OUT_DATA.txt",'r');
% y_out_vivado = fscanf(fileID,'%x');
% y_out_vivado =dec2bin(y_out_vivado);
% y_out_vivado = bin2num(q, y_out_vivado);
% fclose(fileID);



figure;
subplot(6,2,1);
plot(x_in);
title('X signal in time');
spec = abs(fft(x_in));
subplot(6,2,2);
plot((0:100:50e3-100),spec(1:ns/2));
title('X signal in frequency');

subplot(6,2,3);
plot(y_orj);
title('Y signal, convolution, in time');
spec1 = abs(fft(y_orj));
subplot(6,2,4);
plot((0:100:50e3-100),spec1(1:ns/2));
title('Y signal, convolution, in frequency');

subplot(6,2,5);
plot(y_out);
title('Y signal, Matlab filter, in time');
spec2 = abs(fft(y_out));
subplot(6,2,6);
plot((0:100:50e3-100),spec2(1:ns/2));
title('Y signal, Matlab filter, in frequency');

subplot(6,2,7);
plot(y_out_vivado);
title('Y signal, Vivado, in time');
spec3 = abs(fft(y_out_vivado));
subplot(6,2,8);
plot((0:100:50e3-100),spec3(1:ns/2));
title('Y signal, Vivado, in frequency');


subplot(6,2,[9,10]);
%hold on
%bar(y_diff,'red');
bar(y_diff_vivado,'blue')%,legend('Conv-Matlab','Conv-HDL');
%xlabel('time'),ylabel('difference');
title('Difference between convolution and filter design');
hold off ;
spec4 = abs(fft(y_diff));
subplot(6,2,[11,12]);
hold on
plot((0:100:50e3-100),spec1(1:ns/2),'red');
plot((0:100:50e3-100),spec2(1:ns/2),'green')
plot((0:100:50e3-100),spec3(1:ns/2),'blue'),legend('Convolution','Matlab','HDL');
hold off ;
title('Output signals in single graph');

