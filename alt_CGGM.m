function [Gamma, Omega, Gamma_err, Omega_err, obj, test_err, elapsed] = alt_CGGM(X, Y, X_test, Y_test, params)

tic
%================ Initialization ===================
Gamma = soft_thres((X'*X+ params.epsilon*eye(size(X,2)))^(-1)*(X'*Y), params.lambda_Gamma);
if isfield(params, 'Gamma_init') ~= 0, Gamma = params.Gamma_init; end
Gamma = trunc(Gamma, params.s_Gamma);


Covariance = (Y - X*Gamma)'*(Y - X*Gamma)/params.n;
Omega = soft_thres((Covariance + params.nu * eye(size(Y,2)))^(-1) , params.lambda_Omega);
if isfield(params, 'init_Omega') ~= 0, Omega = params.init_Omega; end
Omega = truncation(Omega, params.s_Omega);

% Omega = params.Omega_star;
if isfield(params, 'Gamma_star') ~= 0,  disp(['Gamma init err: ', num2str(norm(Gamma - params.Gamma_star,'fro'))]); end
if isfield(params, 'Omega_star') ~= 0,  disp(['Omega init err: ', num2str(norm(Omega - params.Omega_star,'fro'))]); end
%===================================================


% Gradient Descent with fixed step size
for t=1:params.T
        
    Gamma = Gamma - params.eta_Gamma*gradGamma(X,Y,Gamma,Omega);
    Gamma = trunc(Gamma, params.s_Gamma);
 
    Omega = Omega - params.eta_Omega*gradOmega(X,Y,Gamma,Omega);
    Omega = truncation(Omega, params.s_Omega);
 
    elapsed(t) = toc;   
    
    if params.test == 1
        obj(t) = objf(X,Y,Gamma, Omega); 
        t_err = zeros(1,size(Y_test,1));
        for p = 1:size(Y_test,1)
           t_err(p) = norm(Gamma'*X_test(p,:)' - Y_test(p,:)','fro')^2;
        end
        test_err(t) = mean(t_err);
    else
        obj(t) = 0;
        test_err(t) = 0;
    end
    
    if isfield(params, 'Gamma_star') ~= 0  && isfield(params, 'Omega_star') ~= 0,  
        Gamma_err(t) = norm(Gamma - params.Gamma_star,'fro'); 
        Omega_err(t) = norm(Omega - params.Omega_star,'fro');
        if t>1 && abs(Gamma_err(t) - Gamma_err(t-1)) <= params.stopprecision && abs(Omega_err(t) - Omega_err(t-1)) <=  params.stopprecision
            break
        end
    else
        Gamma_err(t) = 0; Omega_err(t) = 0;
    end
    
end
 

end

function Objf = objf(X, Y, Gamma, Omega)
    [n, m] = size(Y);
    tmp = Y - X*Gamma;
    Objf =  - log(det(Omega)) + trace(tmp*Omega*tmp')/n;

end

function gradientGamma = gradGamma(X, Y, Gamma, Omega)
    n = size(X,1);
    gradientGamma = -2/n*X'*(Y-X*Gamma)*Omega;
end

function gradientOmega = gradOmega(X, Y, Gamma, Omega)
    n = size(X,1);
    gradientOmega = -inv(Omega + 0.0000*eye(size(Omega,1)));
    tmp = Y - X*Gamma;
    gradientOmega = gradientOmega + 1/n*tmp'*tmp;
end

 
