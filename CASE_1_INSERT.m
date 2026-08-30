% Case 1 insert - one short-selling constrained asset (July 2026)

%----------------------
% Search for eqm sets
%----------------------
dum_sol = 0; slack = dum_sol; dum_sol1 = 0; dum_sol2 = dum_sol1;

%Check for slack constraints
FV_sum = [ n*F(1,:)'; n*F(2,:)' ];
P_guess = FV_sum  - Omega_bar*N_bar;

%Demands_guess_1 = V_bar*( F(:,1) - P_guess ); 
%min_slack = Demands_guess_1(2);

Demands_guess = V_bar*( F - P_guess );
min_slack = min(Demands_guess(2,:));


    if min_slack >= 0 || dum_slack==1
        dum_sol = 1;
        P_tild = P_guess;
        Ptild(:,t) = P_guess;
        slack = 1; constrained = 0;
        
        set_out = []; B11 = set_out; B22 = set_out;
        B12 = Investors;  
        Demands_opt = Demands_guess; 

    else

        k_con = nnz(Demands_guess(2,:)<0); 
        k_init = max(2,k_con-k_back);

        if Iter==1
            Price_iter_CASE_1
        end

        Constrained_CASE_1

            if dum_sol==1
                P_tild = P_guess;
                Ptild(:,t) = P_tild;
                constrained = k-1;  
                set_out = []; 

                Demands_opt = V_bar*( F(:,Investors) - P_tild );
                Demands_opt(:,B11) = V11*( F(:,B11) - P_tild );
                %Demands_opt(:,B12) = Demands_opt(:,B12);

            end


    end

        Demands_sum = [n*Demands_opt(1,:)'; n*Demands_opt(2,:)'];   %Can comment out for speed
        Check(t) = max(abs( Demands_sum  - N_bar) );                %Can comment out for speed

        Demands1(t,:) = Demands_opt(1,Index);
        Demands2(t,:) = Demands_opt(2,Index);




    
        










