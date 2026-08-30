%Constrained_CASE_1_EXT_2_FAST.m

 Prod = NaN(2,K);

for k=k_init:K

    set12 = k:K;
    B11 = 1:k-1;

    V_sum = sum(n(set12))*V_bar + [sum(V_add_tild(set12)) 0; 0 0] + [sum(V11_q_tild(B11)) 0; 0 0];
 
    for q = 1:K
        if q < k
            Prod(:,q) = [V11_q_tild(q) 0; 0 0]*F(:,q);
        else
            Prod(:,q) = (n(q)*V_bar + [V_add_tild(q) 0; 0 0])*F(:,q);
        end
    end

    FV_sum = sum(Prod(:,:),2);
                
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

    Prod = NaN(2,K);

    back = 1;

    for k=k_init-1:-1:2    

    set12 = k:K;
    B11 = 1:k-1;

    V_sum = sum(n(set12))*V_bar + [sum(V_add_tild(set12)) 0; 0 0] + [sum(V11_q_tild(B11)) 0; 0 0];

    for q = 1:K
        if q < k
            Prod(:,q) = [V11_q_tild(q) 0; 0 0]*F(:,q);
        else
            Prod(:,q) = (n(q)*V_bar + [V_add_tild(q) 0; 0 0])*F(:,q);
        end
    end

    FV_sum = sum(Prod(:,:),2);
                
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

end