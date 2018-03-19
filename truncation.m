% function res = truncation(beta,k)
%     [~,idx] = sort(abs(beta),'descend');
%     res = zeros(size(beta));
%     for i = idx(1:k)
%         res(i) = beta(i);
%     end
% end


% function res = truncation(beta,s)
%     m = size(beta,1);
%     beta_vec = beta(:); 
%     [~,idx] = sort(abs(beta_vec),'descend');
%     res = zeros(size(beta_vec));
%     res_vec = res(:);
%     for i = idx(1:s)
%         res_vec(i) = beta_vec(i);
%     end
%     res = reshape(res_vec,[m,m]);
% end

function res = truncation(beta,s)
    m = size(beta,1);
    beta_tri = beta;
    for i = 1:m
        for j = 1:i
            beta_tri(i,j)=0;
        end
    end
    
    beta_vec = beta_tri(:); 
    [~,idx] = sort(abs(beta_vec),'descend');
    res = zeros(size(beta_vec));
    res_vec = res(:);
    for i = idx(1:ceil((s-m)/2))
        res_vec(i) = beta_vec(i);
    end
    res = reshape(res_vec,[m,m]);
    res = res +res' +diag(diag(beta));
end