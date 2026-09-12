% Bifurcation insert - Case of one short-selling constrained asset (asset 2). Code written by M. Hatcher.

%-------------------------------
%Initial values and predictors 
%-------------------------------
n_init = 1/K*ones(1,K); Constant = Omega_bar*N_bar;   %n_init = 1/K*ones(1,K); Constant = Omega_bar*N_bar + ones(2,1)*b;
%Ptild0 = [2;8];
constrained_t = NaN(T,1); dummy=0; dummy2 = 0;

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
            n = Pop(t-1,:); dummy=t;
            break
        end
    end

    if dummy>0
        break
    end

    Pop(t,:) = n;  
    %Beliefs1(t,:) = F(1,:); Beliefs2(t,:) = F(2,:);  
  
dum_sol = 0; slack = 0; back = 0; 
    
CASE_1_INSERT

constrained_t(t) = constrained;

if t>100 && sum(Ptild(1,t-8:t)) < 1e-5 && sum(Ptild(2,t-8:t)) < 1e-5
    dummy2 = 1; break
end

end

if dummy>0
    Ptild(1,T+1-window:T) = NaN; %Ptild(1,t-1)*ones(1,window)/1E5;
    Ptild(2,T+1-window:T) = NaN; %Ptild(2,t-1)*ones(1,window)/1E5;
end

if dummy2>0
    Ptild(1,T+1-window:T) = [NaN(1,window-1) Ptild(1,t-1)*1e-5];
    Ptild(2,T+1-window:T) = [NaN(1,window-1) Ptild(2,t-1)*1e-5];

end








