% CASE_2_neg.m

%----------------------
% Search for eqm sets
%----------------------
dum_sol = 0; slack = dum_sol;

%Check for slack constraints
FV_sum = [ n*F(1,:)'; n*F(2,:)' ];
P_guess = FV_sum  - Omega_bar*N_bar;

Demands_guess = V_bar*( F - P_guess );
%min_slack = min(Demands_guess(1,1),Demands_guess(2,K));
min_slack = min(min(Demands_guess));

if min_slack >= 0 || dum_slack==1
    dum_sol = 1;
    P_tild = P_guess;
    slack = 1; constrained = 0;
    
    set_out = []; B11 = set_out; B22 = set_out;
    B12 = Investors;  
    Demands_opt = V_bar*( F(:,B12) - P_guess );

else

    k_con1 = nnz(Demands_guess(1,:)<0); k_con2 = nnz(Demands_guess(2,:)<0);
    k_init1 = max(1,k_con1-k_back); k_init2 = max(1,k_con2-k_back);

    if Iter==1
        Price_iter_NEG
    end

    Constrained_neg

            if dum_sol==1

                P_tild = P_guess;
                constrained = k-1; 

                B12_star = set12; set_out = setdiff(1:k-1,B11); set_out = setdiff(set_out,B22); 

                Demands_opt = V_bar*( F(:,Investors) - P_tild );
                Demands_opt(:,set_out) = 0;
                Demands_opt(:,B11) = V11*(F(:,B11)-P_guess);
                Demands_opt(:,B22) = V22*(F(:,B22)-P_guess);

            end


end

                Demands_sum = [n*Demands_opt(1,:)' ; n*Demands_opt(2,:)' ];   %Can comment out for speed
                Check(t) = max(abs(Demands_sum - N_bar));                     %Can comment out for speed

                Demands1(t,:) = Demands_opt(1,Index);
                Demands2(t,:) = Demands_opt(2,Index);

                Ptild(:,t) = P_tild/(1+r);
