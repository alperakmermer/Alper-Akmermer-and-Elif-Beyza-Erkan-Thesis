function H_subs = H_sub_gen(h,permutaded_idx,phase,number_of_subfilters,P)
    %Create Coeff
    h_phase = cell(1,phase);
    H_subs = cell(1,number_of_subfilters);
    a = cell(1,number_of_subfilters);
    
    for i=1:phase
        h_phase{1,i}=h(i:phase:end);
    end

    for i=1:number_of_subfilters
        a{1,i} = find(P(i,:));
        H_subs{1,i} = zeros(1,length(h)/phase);
        for j=a{1,i}
            H_subs{1,i} = H_subs{1,i} + h_phase{1,permutaded_idx(j)};
        end
    end

end