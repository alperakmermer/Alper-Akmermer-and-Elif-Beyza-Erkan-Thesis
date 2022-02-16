function P = pre_process_mat_gen(twos,threes)
    P_2 = [1 0; 1 1; 0 1];   % pre-processing matrix of 2-phase FFA
    P_3 = [1 0 0; 0 1 0; 0 0 1; 1 1 0; 0 1 1; 1 1 1];      % pre-processing matrix of 3-phase FFA
    threes1 = threes;
    twos1 =  twos;
    if threes1
        P = P_3;
        threes1 = threes1-1;
    elseif twos1
        P = P_2;
        twos1 = twos1 -1;
    else
        P = 1;
    end
    while threes1
        P = kron(P_3,P);
        threes1 = threes1 - 1;
    end
    while twos1
        P = kron(P_2,P);
        twos1 = twos1 - 1;
    end
end