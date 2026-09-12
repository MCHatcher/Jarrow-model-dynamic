% Jarrow dynamic simulations, July 2026. Case of one short-selling
% constrained asset (asset 2), diff cov matrices (fast version). Code written by M. Hatcher.

clc, clear

K = 100;          % No. of investors
J = 2;             % No. of markets
T = 50;            % No. of periods

r = 0.01;          % Riskfree rate 
betta = 0.975;         % Intensity of choice
dbar = 10;            % Expected dividend
D_bar = dbar*ones(J,1);   
N_bar = ones(J,1);  % Outside supplies

n_iter = 50;        % No. of price iterations
k_back = 0;         %no. of back steps
Iter = 1;           % Turn on price iterations
dum_slack = 0;      %0 = shorting ban; 1 = no shorting ban;

Investors = 1:K; dum_sol_t = zeros(T,1); slack_t = dum_sol_t; back_t = dum_sol_t; 
constrained_t = dum_sol_t; Demands1 = NaN(T,K); Demands2 = Demands1;  Pop = Demands1;
dummy = 0; %Ptild = NaN(J,T); %Beliefs1 = Pop;  Beliefs2 = Pop;

%Covariance matrix
Var1 = 1; Var2 = 3; CV = -0.65*sqrt(Var1)*sqrt(Var2);  
Omega_bar = [Var1 CV;CV Var2];   %vcov matrix
V_bar = Omega_bar \ eye(2);

Pf = ( D_bar - Omega_bar*N_bar )/r;  %Fundamental price vector

%Price beliefs
g = 0.80*ones(1,K) + linspace(0,0.3,K); C = zeros(1,K); 
%b = C; b(1:round(K/2)) = linspace(-0.1,0.1,round(K/2));

g(1:round(K/2)) = linspace(0,0.2,round(K/2));  C(1:round(K/2)) = 1-g(1:round(K/2));
rng(3)

%--------------------------
%Generate dividend shocks 
%--------------------------
T_sim = max(T,100);
mu = [0 0];
Sigma = Omega_bar/(100^2);
draws = mvnrnd(mu,Sigma,T_sim);
shock = draws(:,:); 
shock = shock';
%NB. For timed sims, set 'tic' below this line

%-------------------------------
%Initial values and predictors 
%-------------------------------
n_init = 1/K*ones(1,K); Constant = Omega_bar*N_bar;  %Constant = Omega_bar*N_bar + ones(2,1)*b;
Ptild0 = [2;8];
Gen_V_2_FAST;  %Generate vcov matrices which differ by element V(1,1)

tic

for t=1:T

    % Compute population shares

    if t==1
        F = Constant + [g*Ptild0(1); g*Ptild0(2)];
        mult = V_bar*F; [~,Index] = sort(mult(2,:));
        F = [F(1,Index); F(2,Index)];
        n = n_init; 
    elseif t==2
        F = Constant + [g*Ptild(1,t-1); g*Ptild(2,t-1)];
        mult = V_bar*F; [~,Index] = sort(mult(2,:));
        F = [F(1,Index); F(2,Index)];
        n = n_init;
    elseif t>=3
        F = Constant + [g*Ptild(1,t-1); g*Ptild(2,t-1)];
        mult = V_bar*F; [~,Index] = sort(mult(2,:));
        F = [F(1,Index); F(2,Index)];

        R1 = Ptild(1,t-1) - (1+r)*Ptild(1,t-2) + Constant(1) + shock(1,t-1);
        R2 = Ptild(2,t-1) - (1+r)*Ptild(2,t-2) + Constant(2) + shock(2,t-1);
        
        U = R1*Demands1(t-2,:) + R2*Demands2(t-2,:) - C;
        exp_U = exp(betta*U);
        n = transpose(exp_U)/sum(exp_U); n = n(Index); n = n';
        if anynan(n)
            n = Pop(t-1,:); dummy = t; break
        end
    end

    if dummy>0
        break
    end

    Pop(t,:) = n;  
    %Beliefs1(t,:) = F(1,:); Beliefs2(t,:) = F(2,:);  

    V_add_tild = V_add(Index); %V_add_tild = V_add_tild';
    V11_q_tild = V11_q(Index);

    for q=1:K
        V_add_tild(q) = n(q)*V_add_tild(q);
        V11_q_tild(q) = n(q)*V11_q_tild(q);
    end

    %V_add_tild = n.*V_add_tild';
    %V11_q_tild = n.*V11_q_tild';
   
dum_sol = 0; slack = 0; back = 0;
    
CASE_1_EXT_2_INSERT_FAST

constrained_t(t) = constrained;
dum_sol_t(t) = dum_sol;
slack_t(t) = slack;

end

toc

max_check = max(Check)

min_Demands = min(min(Demands2));
if min_Demands<0 && dum_slack==0
    disp('"Warning: Demands are not non-negative!!"')
end

figure(1)
subplot(1,2,1),  plot(Ptild(1,:)), xlabel('Periods'),  title('Asset 1 price: P_1'), hold on 
subplot(1,2,2),  plot(Ptild(2,:)), xlabel('Periods'),  title('Asset 2 price: P_2'), hold on, %plot(constrained_t/K), hold on,




