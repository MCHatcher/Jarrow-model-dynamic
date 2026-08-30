% Case 1 insert - dynamic case, different vcov matrices

dum_sol = 0; slack = dum_sol; dum_sol1 = 0; dum_sol2 = dum_sol1;
Demands_guess = NaN(2,K);

%----------------------
% Search for eqm sets
%----------------------
%Check for slack constraints

V_sum = sum(V_tild(:,:,:),3); Prod = NaN(2,K);

for q=1:K
        Prod(:,q) = V_tild(:,:,q)*F(:,q);
end

FV_sum = sum(Prod(:,:),2);

P_guess = ( V_sum \ eye(2) )*( FV_sum  - N_bar );

    for ind = Investors
        Demands_guess(:,ind) = V(:,:,ind)*( F(:,ind) - P_guess );
    end
 
%min_slack = min(Demands_guess(2,:));
min_slack = Demands_guess(2,1);

    if min_slack >= 0 || dum_slack==1
        dum_sol = 1;
        P_tild = P_guess;
        Ptild(:,t) = P_guess;
        slack = 1; constrained = 0;
        
        set_out = []; B11 = set_out; B22 = set_out;
        B12 = Investors; 

        Demands_opt = Demands_guess; 

        Demands1(t,:) = Demands_opt(1,Index);
        Demands2(t,:) = Demands_opt(2,Index);

    else

        k_con = nnz(Demands_guess(2,:)<0); 
        k_init = max(2,k_con-k_back);

        if Iter==1
            Price_iter_CASE_1
        end

        Constrained_CASE_1_EXT_2
        
        Demands_opt = NaN(2,K);

            if dum_sol==1
                P_tild = P_guess;
                Ptild(:,t) = P_tild;
                constrained = k-1;  

                B11 = 1:k-1; 
                B12 = k:K; set_out = []; 

                for j=1:K
                    if j<k 
                        Demands_opt(:,j) = V11(:,:,j)*( F(:,j) - P_tild );
                    else
                        Demands_opt(:,j) = V(:,:,j)*( F(:,j) - P_tild );
                    end
                end
                

            end


    end


                Demands_sum = [n*Demands_opt(1,:)' ; n*Demands_opt(2,:)' ];   %Can comment out for speed
                Check(t) = max(abs(Demands_sum - N_bar));                     %Can comment out for speed
                
                %Check2(t) = max(abs( [n*Demands_opt1'; n*Demands_opt2'] - N_bar));
                
                Demands1(t,:) = Demands_opt(1,Index);
                Demands2(t,:) = Demands_opt(2,Index);

    
        










