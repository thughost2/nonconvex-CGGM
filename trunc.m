function [ Wout ] = trunc( Win,s )
vec = Win(:)';
Woutvec = zeros(size(vec));
[~,idx] = sort(abs(vec),'descend');
for i = idx(1:s)
    Woutvec(i) = vec(i);
end
Wout = reshape(Woutvec,size(Win));
end

