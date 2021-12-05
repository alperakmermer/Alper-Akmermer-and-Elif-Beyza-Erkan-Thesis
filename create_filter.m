function create_filter(h,varargin)

if nargin == 1
    phase = 1;
    transpose= 0;
elseif nargin<=2
    phase = varargin{1};
    transpose = 0;
elseif nargin<=3
    phase = varargin{1};
    transpose = varargin{2};
elseif nargin>3
    fprintf("Too many arguments. -> create_filter(filter_coefficients, phase_number, isTransposed)\n");
end

if transpose
    type = "transpose";
else
    type = "direct";
end

tap = length(h);
filter_inputs="x_in_1";
filter_outputs="y_out_1";
for i=1:phase-1
    filter_inputs = filter_inputs + ", x_in_" + num2str(i+1);
    filter_outputs = filter_outputs + ", y_out_" + num2str(i+1);
end

%%% Create File Name
fileName = "mlhdlc_"+num2str(phase)+"_phase_"+num2str(tap)+"_tap_"+type+"_filter";

%%% Define Function
functionName = "function ["+filter_outputs+"] ="+fileName+"("+filter_inputs+")";

x_in = split(filter_inputs,", ",2);
y_out = split(filter_outputs,", ",2);
%%% Define sub-filters
[number_of_subfilters,h_subs,x_subs,y,y_subs] = create_subfilters(phase,h,x_in,y_out);

defineX = string;
defineH = string;
defineY = string;

for i=1:number_of_subfilters
    defineX(i)="x"+num2str(i)+"="+x_subs(i)+";";
    isSymmetric(i) = isequal(h_subs(i,:),flip(h_subs(i,:))) & mod(length(h_subs(i,:)),2) == 0;
    for j=1:size(h_subs,2)
        defineH(i,j)="h"+num2str(i)+"_"+num2str(j)+"="+h_subs(i,j)+";";
    end
    if transpose
        [m{i},a{i},y_sub{i},updatePersistents{i},delays{i}] = transpose_subfilter(i,(tap/phase),isSymmetric(i));
    else
        [m{i},a{i},y_sub{i},updatePersistents{i},delays{i}] = direct_subfilter(i,(tap/phase),isSymmetric(i));
    end
end

%%% Create, Define and Initialize Persistents
definePersistents = "persistent";
ifBegin = "if isempty("+delays{1}(1)+")";
ifInside = string;

count=1;
for i=1:(number_of_subfilters)
    for j=delays{i}
        definePersistents = definePersistents+" "+j;
        ifInside = ifInside+j+"=0; ";
        if(mod(count,6)==0)
            ifInside = ifInside + "\n\t";
        end
        count=count+1;
    end
end

number_of_delays = 1;
updateDelays = string;
for i=1:size(y,1)
    defineY(i) = y_subs(i)+" = ";
    for j=1:size(y,2)-1
        if y(i,j) ~= 0
            if mod(y(i,j),7)~=0
                defineY(i) = defineY(i)+"(" + num2str(y(i,j))+") *y"+num2str(j)+" +";
            else
                definePersistents = definePersistents+" Z"+num2str(number_of_delays);
                ifInside = ifInside+"Z"+num2str(number_of_delays)+"=0; ";
                updateDelays(number_of_delays) = "Z"+num2str(number_of_delays)+"= y"+num2str(j)+";";
                defineY(i) = defineY(i)+"(" + num2str(y(i,j)/7)+") * Z"+num2str(number_of_delays)+" +";
                number_of_delays = number_of_delays +1;
            end
        end
    end
    if y(i,end) ~= 0
        if mod(y(i,end),7)~=0
            defineY(i) = defineY(i)+"(" + num2str(y(i,end))+") *y"+num2str(size(y,2))+";";
        else
            definePersistents = definePersistents+" Z"+num2str(number_of_delays);
            ifInside = ifInside+"Z"+num2str(number_of_delays)+"=0; ";
            updateDelays(number_of_delays) = "Z"+num2str(number_of_delays)+"= y"+num2str(size(y,2))+";";
            defineY(i) = defineY(i) +"("+ num2str(y(i,end)/7)+") * Z"+num2str(number_of_delays)+";";
            number_of_delays = number_of_delays +1;
        end
    else
        defineY(i)=strip(defineY(i),"+");
        defineY(i)=defineY(i)+";";
    end

end
ifEnd = "end";

%%% Write to file
fileID = fopen(fileName+".m",'w');
fprintf(fileID,functionName+"\n\n");
fprintf(fileID,definePersistents+";\n\n");
fprintf(fileID,ifBegin+"\n");
fprintf(fileID,"\t"+ifInside+"\n");
fprintf(fileID,ifEnd+"\n\n");
for i=1:size(defineX,2)
    fprintf(fileID,defineX(i)+"\n");
    fprintf(fileID,"\n");
    for j=1:size(defineH,2)
        fprintf(fileID,defineH(i,j)+"\n");
    end
    fprintf(fileID,"\n");
    if (transpose | (transpose==0 && isSymmetric(i) == 0))
        for k=m{i}
            fprintf(fileID,k+"\n");
        end
        fprintf(fileID,"\n");
        for l=a{i}
            fprintf(fileID,l+"\n");
        end
    else
        for l=1:(tap/(2*phase))
            fprintf(fileID,a{i}(l)+"\n");
        end
        for k=m{i}
            fprintf(fileID,k+"\n");
        end
        for l=(tap/(2*phase))+1:(length(a{i}))
            fprintf(fileID,a{i}(l)+"\n");
        end
    end
    fprintf(fileID,"\n");
    for n=1:length(updatePersistents{i})
        fprintf(fileID,updatePersistents{i}(end+1-n)+"\n");
    end
    fprintf(fileID,"\n");
    fprintf(fileID,y_sub(i)+"\n");
    fprintf(fileID,"\n\n");
end
for i=defineY
    fprintf(fileID,i+"\n");
end
fprintf(fileID,"\n\n");
for i=updateDelays
    fprintf(fileID,i+"\n");
end
fprintf(fileID,"\n\n");
fprintf(fileID,ifEnd+"\n\n");

fclose(fileID);

end

function [number_of_subfilters,h_subs,x_subs,y,y_subs] = create_subfilters(phase,h,x_in,y_out)
f = factor(phase);
u = unique(f);
if (isequal(u,[]) & isequal(u,[2]) & isequal(u,[3]) & isequal(u,[2,3]))
    ME = MException('Function:InvalidArgument', ...
        'The number of phases can only be a multiple of 2 or 3.');
    throw(ME)
end
twos = sum(f(:) == 2);
threes = sum(f(:) == 3);
hSub = {h};
xSub = {x_in};
ySub = {y_out};
number_of_subfilters = (3^twos) * (6^threes);
y = create_output_matrix(twos,threes);

while twos
    sz = size(hSub{1,1});
    limit = sz(1);
    for i=1:limit
        [xSub{1,3},hSub{1,3}] = create_coefficient2(xSub{1,1}(i,:),hSub{1,1}(i,:));
        hSub{1,2} = vertcat(hSub{1,2},hSub{1,3});
        xSub{1,2} = vertcat(xSub{1,2},xSub{1,3});
    end
    sz1 = size(ySub{1,1});
    limit1 = sz1(1);
    for i=1:limit1
        ySub{1,3} = create_y2(ySub{1,1}(i,:));
        ySub{1,2} = vertcat(ySub{1,2},ySub{1,3});
    end
    hSub{1,1} = hSub{1,2};
    hSub{1,2} = [];
    xSub{1,1} = xSub{1,2};
    xSub{1,2} = [];
    ySub{1,1} = ySub{1,2};
    ySub{1,2} = [];
    twos = twos - 1;
end
while threes
    sz = size(hSub{1,1});
    limit = sz(1);
    for i=1:limit
        [xSub{1,3},hSub{1,3}] = create_coefficient3(xSub{1,1}(i,:),hSub{1,1}(i,:));
        hSub{1,2} = vertcat(hSub{1,2},hSub{1,3});
        xSub{1,2} = vertcat(xSub{1,2},xSub{1,3});
    end
    sz1 = size(ySub{1,1});
    limit1 = sz1(1);
    for i=1:limit1
        ySub{1,3} = create_y3(ySub{1,1}(i,:));
        ySub{1,2} = vertcat(ySub{1,2},ySub{1,3});
    end
    hSub{1,1} = hSub{1,2};
    hSub{1,2} = [];
    xSub{1,1} = xSub{1,2};
    xSub{1,2} = [];
    ySub{1,1} = ySub{1,2};
    ySub{1,2} = [];
    threes = threes - 1;
end
h_subs = hSub{1,1};
x_subs = xSub{1,1};
y_subs = ySub{1,1};
end

function Qf = create_output_matrix(twos,threes)
number_of_cascades = twos + threes;
I6 = eye(6);
I3 = eye(3);
pre = ones(1);
Q =cell(1,number_of_cascades);

B = [1 0 7 ; -1 1 -1];
C = [1 -7 -7 0 7 0 ; -1 -1 7 1 0 0 ; 0 2 0 -1 -1 1];

for i=1:number_of_cascades
    if threes
        threes = threes - 1;
        Q{1,i} = C;
        for ii=1:i
            Q{1,i} = expand(Q{1,i},pre(end-ii+1));
        end
        pre(1,i+1) = 3;
    elseif twos
        twos = twos - 1;
        Q{1,i} = B;
        for ii=1:i
            Q{1,i} = expand(Q{1,i},pre(end-ii+1));
        end
        pre(1,i+1) = 2;
    end

    threes1 = threes;
    twos1 =  twos;

    while threes1
        Q{1,i} = kron(I6,Q{1,i});
        threes1 = threes1 - 1;
    end

    while twos1
        Q{1,i} = kron(I3,Q{1,i});
        twos1 = twos1 - 1;
    end
end

if number_of_cascades
    Qf = Q{1,number_of_cascades};
    for i=number_of_cascades-1:-1:1
        Qf = Qf*Q{1,i};
    end
else
    Qf = 1;
end
end

function Y = expand(X,n)

I2 = eye(2);
I3 = eye(3);
Z2 = zeros(2);
Z3 = zeros(3);
D2 = [0 7; 1 0];
D3 = [0 0 7; 1 0 0; 0 1 0];
limI = size(X,1);
limJ = size(X,2);
Z = cell(limI*n,limJ*n);
if n== 1
    Y=X;
else
    if n == 2
        for i=1:limI
            for j=1:limJ
                switch X(i,j)
                    case 0
                        Z{i,j} = Z2;
                    case 7
                        Z{i,j} = D2;
                    case -7
                        Z{i,j} = (-1)*D2;
                    otherwise
                        Z{i,j} = X(i,j)*I2;
                end
            end
        end
    elseif n==3
        for i=1:limI
            for j=1:limJ
                switch X(i,j)
                    case 0
                        Z{i,j} = Z3;
                    case 7
                        Z{i,j} = D3;
                    case -7
                        Z{i,j} = (-1)*D3;
                    otherwise
                        Z{i,j} = X(i,j)*I3;
                end
            end
        end
    else
        disp(n);
    end

    Y = cell2mat(Z);
end
end

function y_sub = create_y2(y_out)
y_sub(1,:) = y_out(1:2:end);
y_sub(2,:) = y_out(2:2:end);
end

function y_sub = create_y3(y_out)
y_sub(1,:) = y_out(1:3:end);
y_sub(2,:) = y_out(2:3:end);
y_sub(3,:) = y_out(3:3:end);
end

function [x_sub,h_sub] = create_coefficient2(x_in,h)
tap = length(h);
h_sub = zeros(3,(tap/2));

x_sub(1,:) = x_in(1:2:end);
x_sub(3,:) = x_in(2:2:end);
x_sub(2,:) = x_in(1:2:end)+" + "+x_in(2:2:end);
for i=1:(tap/2)
    h_sub(1,i) = h(2*i-1);          %H0
    h_sub(3,i) = h(2*i);            %H1
    h_sub(2,i) = h(2*i-1)+h(2*i);   %H0+H1
end
end

function [x_sub,h_sub] = create_coefficient3(x_in,h)
tap = length(h);
h_sub = zeros(3,(tap/3));

x_sub(1,:) = x_in(1:3:end);
x_sub(2,:) = x_in(2:3:end);
x_sub(3,:) = x_in(3:3:end);
x_sub(4,:) = x_in(1:3:end)+" + "+x_in(2:3:end);
x_sub(5,:) = x_in(2:3:end)+" + "+x_in(3:3:end);
x_sub(6,:) = x_in(1:3:end)+" + "+x_in(2:3:end)+" + "+x_in(3:3:end);
for i=1:(tap/3)
    h_sub(1,i) = h(3*i-2);
    h_sub(2,i) = h(3*i-1);
    h_sub(3,i) = h(3*i);
    h_sub(4,i) = h(3*i-2) +  h(3*i-1);
    h_sub(5,i) = h(3*i-1) + h(3*i);
    h_sub(6,i) = h(3*i-2) +  h(3*i-1) + h(3*i);
end
end

function [m,a,y,updateDelays,delays] = transpose_subfilter(numth, tap, isSymmetric)
a = string;
m = string;
updateDelays = string;
delays = string;
numthStr = num2str(numth);
if (isSymmetric)
    for i=1:((tap/2)-1)
        m(i) = "m"+numthStr+"_"+num2str(i)+" = x"+numthStr+" * h"+numthStr+"_"+num2str(i)+";";
        a(i) = "a"+numthStr+"_"+num2str(i)+" = ud"+numthStr+"_"+num2str(i)+" + m"+numthStr+"_"+num2str(i+1)+";";
        delays(i) =  "ud"+numthStr+"_"+num2str(i);
        updateDelays(i) = "ud"+numthStr+"_"+num2str(i)+" = a"+numthStr+"_"+num2str(i-1)+";";
    end
    m(tap/2) = "m"+numthStr+"_"+num2str(tap/2)+" = x"+numthStr+" * h"+numthStr+"_"+num2str(tap/2)+";";
    for i=((tap/2)):(tap-1)
        a(i) = "a"+numthStr+"_"+num2str(i)+" = ud"+numthStr+"_"+num2str(i)+" + m"+numthStr+"_"+num2str(tap-i)+";";
        delays(i) =  "ud"+numthStr+"_"+num2str(i);
        updateDelays(i) = "ud"+numthStr+"_"+num2str(i)+" = a"+numthStr+"_"+num2str(i-1)+";";
    end
    updateDelays(1) = "ud"+numthStr+"_1 = m"+numthStr+"_1;";
    y = "y"+numthStr+" = a"+numthStr+"_"+num2str(length(a))+";";
else
    m(tap) = "m"+numthStr+"_"+num2str(tap)+" = x"+numthStr+" * h"+numthStr+"_1;";

    for i=1:(tap-1)
        m(i) = "m"+numthStr+"_"+num2str(i)+" = x"+numthStr+" * h"+numthStr+"_"+num2str(tap-i+1)+";";
        a(i) = "a"+numthStr+"_"+num2str(i)+" = ud"+numthStr+"_"+num2str(i)+" + m"+numthStr+"_"+num2str(i+1)+";";
        delays(i) =  "ud"+numthStr+"_"+num2str(i);
        updateDelays(i) = "ud"+numthStr+"_"+num2str(i)+" = a"+numthStr+"_"+num2str(i-1)+";";
    end
    updateDelays(1) = "ud"+numthStr+"_1 = m"+numthStr+"_1;";
    y = "y"+numthStr+" = a"+numthStr+"_"+num2str(length(a))+";";
end
end

function [m, a, y, updateDelays, delays] = direct_subfilter(numth, tap ,isSymmetric)

numthStr = num2str(numth);
a = string;
m = string;
updateDelays = string;
delays = string;

if isSymmetric

    delays(1) =  "ud"+numthStr+"_1";
    updateDelays(1) = "ud"+numthStr+"_1 = x"+numthStr+";";

    for i=1:(tap/2) %%first adder chain and mult
        a(i) = "a"+numthStr+"_"+num2str(i)+" = ud"+numthStr+"_"+num2str(i)+" + ud"+numthStr+"_"+num2str(tap-i+1)+";";
        m(i) = "m"+numthStr+"_"+num2str(i)+" = a"+numthStr+"_"+num2str(i)+" * h"+numthStr+"_"+num2str(i)+";";
        delays(i+1) =  "ud"+numthStr+"_"+num2str(i+1);
        updateDelays(i+1) = "ud"+numthStr+"_"+num2str(i+1)+" = ud"+numthStr+"_"+num2str(i)+";";
    end

    for i=(tap/2)+2:(tap)
        delays(i) =  "ud"+numthStr+"_"+num2str(i);
        updateDelays(i) = "ud"+numthStr+"_"+num2str(i)+" = ud"+numthStr+"_"+num2str(i-1)+";";
    end

    len = tap/2;
    total_len = len;
    first = 1 ;

    while len > 1 %%second adder chain
        if(mod(len,2)==0)
            j=total_len-len+1;
            k=1;
            if (first == 1)
                for i=total_len+1:(total_len + len/2)
                    a(i) = "a"+numthStr+"_"+num2str(i)+"= m"+numthStr+"_"+(j)+"+ m"+numthStr+"_"+num2str((tap/2)+1-k)+";";
                    j=j+1;
                    k=k+1;
                end
                first = 0 ;
            else
                for i=total_len+1:(total_len + len/2)
                    a(i) = "a"+numthStr+"_"+num2str(i)+"= a"+numthStr+"_"+num2str(j)+"+ a"+numthStr+"_"+num2str(total_len+1-k)+";";
                    j=j+1;
                    k=k+1;
                end
            end
            len=len/2;
        else
            j=total_len-len+1;
            if (first == 1)
                for i=total_len+1:(total_len + (len-1)/2)
                    a(i) = "a"+numthStr+"_"+num2str(i)+"="+"m"+numthStr+"_"+num2str(j)+"+"+"m"+numthStr+"_"+num2str(j+1)+";";
                    j=j+2;
                    % add
                    if (i == (total_len + (len-1)/2))
                        a(i+1) = "a"+numthStr+"_"+num2str(i+1)+"="+"m"+numthStr+"_"+num2str(j)+";";
                    end
                end
                first = 0 ;
            else
                for i=total_len+1:(total_len + (len-1)/2)
                    a(i) = "a"+numthStr+"_"+num2str(i)+"= a"+numthStr+"_"+num2str(j)+"+ a"+numthStr+"_"+num2str(j+1)+";";
                    j=j+2;
                    % add
                    if (i == (total_len + (len-1)/2))
                        a(i+1) = "a"+numthStr+"_"+num2str(i+1)+"= a"+numthStr+"_"+num2str(j)+";";
                    end

                end
            end
            len=(len+1)/2;
        end
        total_len = total_len + len;
    end
    y = "y"+numthStr+" = a"+numthStr+"_"+num2str(length(a))+";";
else
    len = tap;
    total_len = 0;
    first = 1 ;

    m(1) = "m"+numthStr+"_1 = ud"+numthStr+"_1 * h"+numthStr+"_1;";
    delays(1) =  "ud"+numthStr+"_1";
    updateDelays(1) = "ud"+numthStr+"_1 = x"+numthStr+";";

    for i=2:(tap) %%mult chain
        m(i) = "m"+numthStr+"_"+num2str(i)+" = ud"+numthStr+"_"+num2str(i)+" * h"+numthStr+"_"+num2str(i)+";";
        delays(i) =  "ud"+numthStr+"_"+num2str(i);
        updateDelays(i) = "ud"+numthStr+"_"+num2str(i)+" = ud"+numthStr+"_"+num2str(i-1)+";";
    end

    while len > 1 %%add chain
        if(mod(len,2)==0)
            if(first==1)
                for i=1:len/2
                    a(i) = "a"+numthStr+"_"+num2str(i)+"="+"m"+numthStr+"_"+num2str(i)+"+"+"m"+numthStr+"_"+num2str(tap-i+1)+";";
                end
                first = 0;
            else
                j=1;
                for i=total_len+1:total_len+(len/2)
                    a(i) = "a"+numthStr+"_"+num2str(i)+"="+"a"+numthStr+"_"+num2str(i-len)+"+"+"a"+numthStr+"_"+num2str(i-j)+";";
                    j=j+2;
                end
            end
            len = len/2;
        else
            if(first==1)
                j=1;
                for i=1:(len-1)/2
                    a(i) = "a"+numthStr+"_"+num2str(i)+"="+"m"+numthStr+"_"+num2str(j)+"+"+"m"+numthStr+"_"+num2str(j+1)+";";
                    j=j+2;
                    %add
                    if(i==(total_len)+((len-1)/2))
                        a(i+1) = "a"+numthStr+"_"+num2str(i+1)+"="+"m"+numthStr+"_"+num2str(j)+";";
                    end
                end
                first = 0;
            else
                j=total_len-len+1;
                for i=total_len+1:total_len+((len-1)/2)
                    a(i) = "a"+numthStr+"_"+num2str(i)+"="+"a"+numthStr+"_"+num2str(j)+"+"+"a"+numthStr+"_"+num2str(j+1)+";";
                    j=j+2;
                    if (i == (total_len + (len-1)/2))
                        a(i+1) = "a"+numthStr+"_"+num2str(i+1)+"="+"a"+numthStr+"_"+num2str(j)+";";
                    end
                end
            end
            len = (len+1)/2;
        end
        total_len = total_len + len;
    end
    y = "y"+numthStr+" = a"+numthStr+"_"+num2str(length(a))+";";
end

end
