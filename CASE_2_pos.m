% CASE_2_pos.m - Positive alignment (July 2026)

%----------------------
% Search for eqm sets
%----------------------
dum_sol = 0; slack = dum_sol; dum_sol1 = 0; dum_sol2 = dum_sol1;

%Check for slack constraints
FV_sum = [ n*F(1,:)'; n*F(2,:)' ];
P_guess = FV_sum  - Omega_bar*N_bar;

Demands_guess = V_bar*( F - P_guess );
min_slack = min(min(Demands_guess));

if min_slack >= 0 || dum_slack==1
    dum_sol = 1;
    P_tild = P_guess;
    Ptild(:,t) = P_tild;
    slack = 1; constrained = 0;
    
    set_out = []; B11 = set_out; B22 = set_out;
    B12 = Investors; B12_star = B12; 
    B11_star = B11; B22_star = B22; 
    Demands_opt = V_bar*( F(:,B12) - P_guess );
    sum_Dem = [n*Demands_opt(1,:)'; n*Demands_opt(2,:)'];

    Demands1(t,:) = Demands_opt(1,Index);
    Demands2(t,:) = Demands_opt(2,Index);
    Check(t) = max(abs( sum_Dem  - N_bar) );

else

    k_con1 = nnz(Demands_guess(1,:)<0); k_con2 = nnz(Demands_guess(2,:)<0);
    k_con = max(k_con1,k_con2); k_init = max(1,k_con-k_back);

    if Iter==1
        Price_iter_MAIN
    end

    Constrained_pos

            if dum_sol==1

                P_tild = P_guess;
                Ptild(:,t) = P_tild;
                constrained = k-1; 

                B11_star = B11; B22_star = B22;
                B12_star = k:K; set_out = setdiff(1:k-1,B11_star); set_out = setdiff(set_out,B22_star); 

                Demands_opt = V_bar*( F(:,Investors) - P_tild );
                Demands_opt(:,set_out) = 0;
                Demands_opt(:,B11) = V11*(F(:,B11)-P_guess);
                Demands_opt(:,B22) = V22*(F(:,B22)-P_guess);

                %Demands_opt(:,B12_star) = Demands_opt(:,B12_star);
                
                Demands_sum = [n*Demands_opt(1,:)' ; n*Demands_opt(2,:)' ];

                Check(t) = max(abs(Demands_sum - N_bar));
                Demands1(t,:) = Demands_opt(1,Index);
                Demands2(t,:) = Demands_opt(2,Index);


            end


end


