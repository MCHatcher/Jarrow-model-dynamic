% Case 1 insert - dynamic case, scaled covariances

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

%Demands_opt = NaN(2,K); 


    if min_slack >= 0 || dum_slack==1
        dum_sol = 1;
        P_tild = P_guess;
        slack = 1; constrained = 0;
        
        set_out = []; B11 = set_out; B22 = set_out;
        B12 = Investors; 

        Demands_opt = c(1,B12).*( V_bar*( F(:,B12) - P_guess ) ); 

    else

        k_con = nnz(Demands_guess(2,:)<0); 
        k_init = max(2,k_con-k_back);

        if Iter==1
            Price_iter_CASE_1_EXT
        end

        Constrained_CASE_1_EXT

            if dum_sol==1
                P_tild = P_guess;
                constrained = k-1; set_out = []; 
                
                Demands_opt = c.*( V_bar*( F(:,Investors) - P_tild ) );
                Demands_opt(:,B11) = c(B11).*( V11*(F(:,B11) - P_tild) );
   

            end


    end

        
        Demands_sum = [n*Demands_opt(1,:)'; n*Demands_opt(2,:)'];   %Can comment out for speed
        Check(t) = max(abs( Demands_sum  - N_bar) );                %Can comment out for speed
        
        %Check2(t) = max(abs( [n*Demands_opt1'; n*Demands_opt2'] - N_bar));

        Demands1(t,:) = Demands_opt(1,Index);
        Demands2(t,:) = Demands_opt(2,Index);

        Ptild(:,t) = P_tild/(1+r);
                





    
        










