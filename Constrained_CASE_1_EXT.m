%Constrained_CASE_1_EXT.m

for k=k_init:K

    set12 = k:K;
    B11 = 1:k-1;

    FV_sum = V_bar*[ n_prod(set12)*F(1,set12)' ; n_prod(set12)*F(2,set12)' ] + V11*[ n_prod(B11)*F(1,B11)' ; n_prod(B11)*F(2,B11)' ];
    V_sum = sum(n_prod(set12))*V_bar + sum(n_prod(B11))*V11;
                
    F_bar = ( V_sum \ eye(2) )*FV_sum;
    N_hat =  ( V_sum \ eye(2) )*N_bar;

    if V_bar(2,:)*(F_bar - F(:,k)) <= V_bar(2,:)*N_hat && V_bar(2,:)*(F_bar - F(:,k-1)) > V_bar(2,:)*N_hat 
        dum_sol = 1;
        P_guess = ( V_sum \ eye(2) )*( FV_sum  - N_bar );
    end

    if dum_sol== 1
        break 
    end


end

if dum_sol ~= 1

    back = 1;

    for k=k_init-1:-1:2    

    set12 = k:K;
    B11 = 1:k-1;

    FV_sum = V_bar*[ n_prod(set12)*F(1,set12)' ; n_prod(set12)*F(2,set12)' ] + V11*[ n_prod(B11)*F(1,B11)' ; n_prod(B11)*F(2,B11)' ];
    V_sum = sum(n_prod(set12))*V_bar + sum(n_prod(B11))*V11;
                
    F_bar = ( V_sum \ eye(2) )*FV_sum;
    N_hat =  ( V_sum \ eye(2) )*N_bar;

    if V_bar(2,:)*(F_bar - F(:,k)) <= V_bar(2,:)*N_hat && V_bar(2,:)*(F_bar - F(:,k-1)) > V_bar(2,:)*N_hat 
        dum_sol = 1;
        P_guess = ( V_sum \ eye(2) )*( FV_sum  - N_bar );
    end

    if dum_sol == 1
        break 
    end

    end

end