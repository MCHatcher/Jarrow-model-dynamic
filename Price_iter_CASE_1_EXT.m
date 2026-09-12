% Price_iter_CASE_1_EXT

B12_guess = k_init:K;

V_sum = sum(n_prod(B12_guess))*V_bar;
FV_sum = V_bar*[ n_prod(B12_guess)*F(1,B12_guess)'; n_prod(B12_guess)*F(2,B12_guess)' ];
P_guess = ( V_sum \ eye(2) )*( FV_sum  - N_bar );
Demands_guess = c.*( V_bar*( F - P_guess ) );   %For all investors
k_con = max(2,nnz(Demands_guess(2,:)<0));
k_con_lag = k_con;

    for jj=2:n_iter
    
        B12_guess = k_con:K;
        V_sum = sum(n_prod(B12_guess))*V_bar;
        FV_sum = V_bar*[ n_prod(B12_guess)*F(1,B12_guess)'; n_prod(B12_guess)*F(2,B12_guess)' ];          
        P_guess = ( V_sum \ eye(2) )*( FV_sum  - N_bar ); P_g(:,jj) = P_guess;
        Demands_guess = c.*(V_bar*( F(:,Investors) - P_guess ) );   %For all investors
        k_con = max(2,nnz(Demands_guess(2,:)<0));

        if max( abs(P_g(:,jj)-P_g(:,jj-1)) )  / max(abs(P_g(:,jj-1))) < 1e-4
            break
        end

        %if k_con - k_con_lag == 0
        %    break
        %end

        k_con_lag = k_con; 

    end

k_init = max(2,k_con-k_back); 