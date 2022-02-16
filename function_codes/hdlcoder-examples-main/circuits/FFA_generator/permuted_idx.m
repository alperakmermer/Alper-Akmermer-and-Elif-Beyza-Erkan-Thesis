function idx = permuted_idx(twos,threes,phase)


idx_temp{1} = [1:1:phase];

if threes == 0
    twos = twos - 1;
end

for i=1:twos
    idx_temp{i+1} = reshape(idx_temp{i}(1,:),2,[]);
    for j=2:size(idx_temp{i},1)
        idx_temp{i+1} = vertcat(idx_temp{i+1},reshape(idx_temp{i}(j,:),2,[]));
    end
end

if twos 
     threes = threes - 1;
 end

for i=twos+1:threes+twos
    idx_temp{i+1} = reshape(idx_temp{i}(1,:),3,[]);
    for j=2:size(idx_temp{i},1)
        idx_temp{i+1} = vertcat(idx_temp{i+1},reshape(idx_temp{i}(j,:),3,[]));
    end
end

idx = zeros(1,phase);
for j=1:size(idx_temp{end},1)
    for i=1:size(idx_temp{end},2)
        idx((j-1)*size(idx_temp{end},2)+i) = idx_temp{end}(j,i);
    end
end

end