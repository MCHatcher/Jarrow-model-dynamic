%Constrained_CASE_1_EXT_2.m

Prod = NaN(2,K);

for k=k_init:K

    set12 = k:K;
    B11 = 1:k-1;

    V_sum = sum(V_tild(:,:,set12),3) + sum(V11_tild(:,:,B11),3); 
   
    for q = 1:K
        if q < k
            Prod(:,q) = V11_tild(:,:,q)*F(:,q);
        else
            Prod(:,q) = V_tild(:,:,q)*F(:,q);
        end
    end

    FV_sum = sum(Prod(:,:),2);
                
    F_bar = ( V_sum \ eye(2) )*FV_sum;
    N_hat =  ( V_sum \ eye(2) )*N_bar;

    if V(2,:,k)*(F_bar - F(:,k)) <= V(2,:,k)*N_hat && V(2,:,k)*(F_bar - F(:,k-1)) > V(2,:,k)*N_hat 
        %V(2,:,k) same for all k
        dum_sol = 1;
        P_guess = ( V_sum \ eye(2) )*( FV_sum  - N_bar );
    end

    if dum_sol== 1
        break 
    end


end

if dum_sol ~= 1
    
    back = 1;

    Prod = NaN(2,K);

    for k=k_init-1:-1:2    

    set12 = k:K;
    B11 = 1:k-1;

    V_sum = sum(V_tild(:,:,set12),3) + sum(V11_tild(:,:,B11),3); 

    for q = 1:K
        if q < k
            Prod(:,q) = V11_tild(:,:,q)*F(:,q);
        else
            Prod(:,q) = V_tild(:,:,q)*F(:,q);
        end
    end

    FV_sum = sum(Prod(:,:),2);
                
    F_bar = ( V_sum \ eye(2) )*FV_sum;
    N_hat =  ( V_sum \ eye(2) )*N_bar;

    if V(2,:,k)*(F_bar - F(:,k)) <= V(2,:,k)*N_hat && V(2,:,k)*(F_bar - F(:,k-1)) > V(2,:,k)*N_hat 
        %V(2,:,k) same for all k
        dum_sol = 1;
        P_guess = ( V_sum \ eye(2) )*( FV_sum  - N_bar );
    end

    if dum_sol == 1
        break 
    end

    end


end