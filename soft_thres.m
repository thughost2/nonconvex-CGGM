function S_soft = soft_thres(A, lambda)
 
sgn = sign(A);
uu = max(abs(A) - lambda, 0);
S_soft = sgn.*uu;

end