# nonconvex-CGGM
Fast nonconvex algorithm for covariate-adjusted precision matrix estimation/conditional Gaussian graphical model estimation
This repository contains our Matlab implementation of covariate-adjusted precision matrix estimation in the paper [Covariate Adjusted Precision Matrix Estimation via Nonconvex Optimization](http://proceedings.mlr.press/v80/chen18n.html).

Useful parameters:
- params.T            : Number of total iterations
- params.n            : Number of samples
- params.m            : Number of output dimensions
- params.d            : Number of input dimensions
- params.eta_Gamma    : Learning rate for Gamma
- params.eta_Omega    : Learning rate for Omega
- params.s_Gamma      : Hard-thresholding parameter for Gamma
- params.s_Omega      : Hard-thresholding parameter for Omega
- params.Gamma_star   : Ground truth matrix Gamma_star, if exists
- params.Omega_star   : Ground truth matrix Omega_star, if exists
- params.stopprecision: Threshold for stopping criterion
- params.test         : Evaluate test samples (1) or training only (0)
- params.lambda_Gamma : Soft-thresholding parameter for initialize Gamma
- params.lambda_Omega : Soft-thresholding parameter for initialize Omega
- params.epsilon      : Ridge parameter for initialize Gamma
- params.nu           : Ridge parameter for initialize Omega



