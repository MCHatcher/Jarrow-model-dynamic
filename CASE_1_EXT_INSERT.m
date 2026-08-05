% Case 1 insert - dynamic case, scaled copvariances

dum_sol = 0; slack = dum_sol; dum_sol1 = 0; dum_sol2 = dum_sol1;
%----------------------
% Search for eqm sets
%----------------------
%Check for slack constraints
n_prod = c.*n;
V_sum = sum(n_prod)*V_bar;
FV_sum = V_bar*[ n_prod*F(1,:)'; n_prod*F(2,:)' ];

P_guess = ( V_sum \ eye(2) )*( FV_sum  - N_bar );

Demands_guess = c.*( V_bar*( F - P_guess ) );  
min_slack = min(Demands_guess(2,:));

    if min_slack >= 0 || dum_slack==1
        dum_sol = 1;
        P_tild = P_guess;
        Ptild(:,t) = P_guess;
        slack = 1; constrained = 0;
        
        set_out = []; B11 = set_out; B22 = set_out;
        B12 = Investors; B12_star = B12; 
        B11_star = B11; B22_star = B22;

        Demands_opt = c(1,B12).*( V_bar*( F(:,B12) - P_guess ) ); 
        sum_Dem = [n*Demands_opt(1,:)'; n*Demands_opt(2,:)'];

        Demands1(t,:) = Demands_opt(1,Index);
        Demands2(t,:) = Demands_opt(2,Index);
        Check(t) = max(abs( sum_Dem  - N_bar) );

    else

        k_con = nnz(Demands_guess(1,:)<0); 
        k_init = max(2,k_con-k_back);

        if Iter==1
            Price_iter_CASE_1
        end

        Constrained_CASE_1_EXT

            if dum_sol==1
                P_tild = P_guess;
                Ptild(:,t) = P_tild;
                constrained = k-1;  

                B11_star = B11; 
                B12_star = k:K; set_out = 1:k-1; 
                Demands_opt = c.*( V_bar*( F(:,Investors) - P_tild ) );
                
                Demands_opt(:,set_out) = c(set_out).*( V11*(F(:,set_out) - P_tild) );
                Demands_opt(:,B12_star) = Demands_opt(:,B12_star);
                
                Demands_sum = [n*Demands_opt(1,:)' ; n*Demands_opt(2,:)' ];
                Check(t) = max(abs(Demands_sum - N_bar));
                Demands1(t,:) = Demands_opt(1,Index);
                Demands2(t,:) = Demands_opt(2,Index);

                %Check2(t) = max(abs( [n*Demands_opt1'; n*Demands_opt2'] - N_bar));

            end


    end




    
        










