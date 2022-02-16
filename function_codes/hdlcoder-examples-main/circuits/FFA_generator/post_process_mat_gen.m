function [Q_reg,Q_rel] = post_process_mat_gen(twos,threes)

    Q_2 = [1 0 7 ; -1 1 -1]; %post-processing matrix of 2-phase FFA
    Q_3 = [1 -7 -7 0 7 0 ; -1 -1 7 1 0 0 ; 0 2 0 -1 -1 1]; %post-processing matrix of 3-phase FFA
    pre = ones(1);
    number_of_cascades = twos + threes;
    Q1 =cell(1,number_of_cascades);
    for i=1:number_of_cascades
        if threes
            threes = threes - 1;
            Q1{1,i} = Q_3;
            for ii=1:i
                Q1{1,i} = unfold(Q1{1,i},pre(end-ii+1));
            end
            pre(1,i+1) = 3;
        elseif twos
            twos = twos - 1;
            Q1{1,i} = Q_2;
            for ii=1:i
                Q1{1,i} = unfold(Q1{1,i},pre(end-ii+1));
            end
            pre(1,i+1) = 2;
        end
        threes1 = threes;
        twos1 =  twos;
        while threes1
            Q1{1,i} = kron(eye(6),Q1{1,i});
            threes1 = threes1 - 1;
        end
        while twos1
            Q1{1,i} = kron(eye(3),Q1{1,i});
            twos1 = twos1 - 1;
        end
    end
    if number_of_cascades
        Q = Q1{1,number_of_cascades};
        for i=number_of_cascades-1:-1:1
            Q = Q*Q1{1,i};
        end
    else
        Q = 1;
    end
    Q_reg = zeros(size(Q));
    Q_rel = zeros(size(Q));
    for i=1:size(Q,1)
        for j=1:size(Q,2)
            if mod(Q(i,j),7)
                Q_reg(i,j) = 0;
                Q_rel(i,j) = Q(i,j);
            elseif (Q(i,j) ~= 0)
                Q_reg(i,j) = 1;
                Q_rel(i,j) = Q(i,j)/7;
            end
        end
    end
end

function Y = unfold(X,n)

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