% Case 1 insert - dynamic case, different vcov matrices

dum_sol = 0; slack = dum_sol; dum_sol1 = 0; dum_sol2 = dum_sol1;
Demands_guess = NaN(2,K); Prod = Demands_guess; Demands_opt = Demands_guess;

%----------------------
% Search for eqm sets
%----------------------
%Check for slack constraints

V_sum = sum(n)*V_bar + [sum(V_add_tild) 0; 0 0]; 

for q=1:K
        Prod(:,q) =  (n(q)*V_bar + [V_add_tild(q) 0; 0 0])*F(:,q);
end

FV_sum = sum(Prod,2);

P_guess = ( V_sum \ eye(2) )*( FV_sum  - N_bar );

Demands_guess(2,:) = V_bar(2,:)*( F - P_guess );              
 
%min_slack =  V_bar(2,:)*( F(:,1) - P_guess );
min_slack = min(Demands_guess(2,:));

    if min_slack >= 0 || dum_slack==1
        dum_sol = 1;
        P_tild = P_guess;
        Ptild(:,t) = P_guess;
        slack = 1; constrained = 0;
        
        set_out = []; B11 = set_out; B22 = set_out;
        B12 = Investors; 

        Demands_opt(2,:) = Demands_guess(2,:);

        for j=1:K
            Demands_opt(1,j) = (V_bar(1,:) + [V_add(j) 0])*( F(:,j) - P_tild );
        end

    else
        
        k_con = nnz(Demands_guess(2,:)<0); 
        k_init = max(2,k_con-k_back);

        if Iter==1
            Price_iter_CASE_1
        end

        Constrained_CASE_1_EXT_2_FAST

            if dum_sol==1
                P_tild = P_guess;
                Ptild(:,t) = P_tild;
                constrained = k-1;  

                B11 = 1:k-1; B12 = k:K; set_out = []; 

                Demands_opt(2,B12) = V_bar(2,:)*( F(:,B12) - P_tild );
                Demands_opt(2,B11) = 0*V_bar(2,:)*( F(:,B11) - P_tild );

                for j = B11
                    Demands_opt(1,j) = [V11_q(j) 0]*( F(:,j) - P_tild );
                end
                
                for j= B12
                    Demands_opt(1,j) = (V_bar(1,:) + [V_add(j) 0])*( F(:,j) - P_tild );
                end
            
            end

    end
                
                Demands_sum = [n*Demands_opt(1,:)' ; n*Demands_opt(2,:)' ];   %Can comment out for speed
                Check(t) = max(abs(Demands_sum - N_bar));                     %Can comment out for speed
                
                %Check2(t) = max(abs( [n*Demands_opt1'; n*Demands_opt2'] - N_bar));
                
                Demands1(t,:) = Demands_opt(1,Index);
                Demands2(t,:) = Demands_opt(2,Index);

              




    
        










