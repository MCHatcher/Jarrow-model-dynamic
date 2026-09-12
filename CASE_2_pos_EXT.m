% CASE_2_pos_EXT.m

%----------------------
% Search for eqm sets
%----------------------
dum_sol = 0; slack = dum_sol; dum_sol1 = 0; dum_sol2 = dum_sol1;

%Check for slack constraints
n_prod = c.*n;
V_sum = sum(n_prod)*V_bar;
FV_sum = V_bar*[ n_prod*F(1,:)'; n_prod*F(2,:)' ];

P_guess = ( V_sum \ eye(2) )*( FV_sum  - N_bar );

Demands_guess = c.*( V_bar*( F - P_guess ) );  
min_slack = min(min(Demands_guess));

if min_slack >= 0 || dum_slack==1
    dum_sol = 1;
    P_tild = P_guess;
    slack = 1; constrained = 0;
    
    set_out = []; B11 = set_out; B22 = set_out;
    B12 = Investors; 

    Demands_opt = Demands_guess; 

else

    k_con1 = nnz(Demands_guess(1,:)<0); k_con2 = nnz(Demands_guess(2,:)<0);
    k_con = max(k_con1,k_con2); k_init = max(1,k_con-k_back);

    if Iter==1
        Price_iter_MAIN_EXT
    end

    Constrained_pos_EXT

            if dum_sol==1

                P_tild = P_guess;
                constrained = k-1; 

                set_out = setdiff(1:k-1,B11); set_out = setdiff(set_out,B22); 

                Demands_opt = c(Investors).*( V_bar*( F(:,Investors) - P_tild ) );
                Demands_opt(:,set_out) = 0; 

                if ~isempty(B11)
                    Demands_opt(:,B11) = c(B11).*( V11*(F(:,B11)-P_guess) );
                end 
                if ~isempty(B22)
                    Demands_opt(:,B22) = c(B22).*( V22*(F(:,B22)-P_guess) );
                end
               
            end


end

                Demands_sum = [n*Demands_opt(1,:)' ; n*Demands_opt(2,:)' ];   %Can comment out for speed
                Check(t) = max(abs(Demands_sum - N_bar));                     %Can comment out for speed
                
                Demands1(t,:) = Demands_opt(1,Index);
                Demands2(t,:) = Demands_opt(2,Index);

                Ptild(:,t) = P_tild/(1+r);
