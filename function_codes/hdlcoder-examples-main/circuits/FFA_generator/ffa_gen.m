function ffa_gen(name,h,phase,type)

% mkdir(name);
% cd(name);

f = factor(phase);
twos = sum(f(:) == 2);
threes = sum(f(:) == 3);
number_of_subfilters = (3^twos) * (6^threes);

% Y_p = Q * H_subs *P * X_p;
    idx = permuted_idx(twos,threes,phase); 
    P = pre_process_mat_gen(twos,threes);
    [Q_reg,Q_rel] = post_process_mat_gen(twos,threes);
    H_subs = H_sub_gen(h,idx,phase,number_of_subfilters,P);
    
%Nodes
    post_process_outputs = cell(1,phase);               % Post-Process Outputs
    pre_process_outputs = cell(1,number_of_subfilters); % Pre-Process Outputs
    matrix_sum_gen(sprintf('%s_pre_process',name),P,zeros(size(P))); % Pre-Process Node Operation
    matrix_sum_gen(sprintf('%s_post_process',name),Q_rel,Q_reg);     % Post-Process Node Operation
    
    for i = 1:phase
        input_nodes(1,i) = Node(sprintf('x_in_%d',i),0,1,@basic_buffer,{sprintf('x_in_%d',i)},{'num'});
        output_nodes(1,i) = Node(sprintf('y_out_%d',i),1,0,@basic_buffer,{sprintf('y_out_%d',i)},{'num'});
        post_process_outputs{1,i} = sprintf("y%d",i);
    end
     
    for i=1:number_of_subfilters
        pre_process_outputs{1,i} = sprintf("subfilter_%d_in",i);
        c_fir_gen(sprintf('%s_subfilter_%d',name,i),H_subs{i},type); %Subfiler Nodes Operations
        subfilters(i) = Node(sprintf('%s_subfilter_%d',name,i),1,1,str2func(sprintf('%s_subfilter_%d',name,i)),{sprintf('y_subs_%d',i)},{'num'});
    end
    
    pre_process = Node(sprintf('%s_pre_process',name),phase,number_of_subfilters,str2func(sprintf('%s_pre_process',name)),pre_process_outputs,{'num'}); % Pre-Process Node
    post_process = Node(sprintf('%s_post_process',name),number_of_subfilters,phase,str2func(sprintf('%s_post_process',name)),post_process_outputs,{'num'}); % Post-Process Node



% Connections
    for i=1:phase
        Node.connect(input_nodes(1,idx(i)),1,pre_process,i,0);
        Node.connect(post_process,i,output_nodes(1,idx(i)),1,0);
    end
    
    for i=1:number_of_subfilters
        Node.connect(pre_process,i,subfilters(i),1,0);
        Node.connect(subfilters(i),1,post_process,i,0);
    end

% Generating function
    circuit_nodes = horzcat([pre_process,post_process],subfilters);
    gen_coder_fcn(name,input_nodes,circuit_nodes,output_nodes);

%     cd('../');
 end

