% Insert_first_EXT.m

B11 = []; B22 = [];
FV_sum = V_bar*[ n_prod(set12)*F(1,set12)' ; n_prod(set12)*F(2,set12)' ];
V_sum = sum(n_prod(set12))*V_bar;
                
P_guess = ( V_sum \ eye(2) )*( FV_sum  - N_bar );

Demands_opt = c(set12).*( V_bar*( F(:,set12) - P_guess ) );
min_opt = min(min(Demands_opt));
Diff = 1:k-1;

    if min_opt >= 0 && max(F(1,Diff)) < P_guess(1) && max(F(2,Diff)) < P_guess(2)
        dum_sol = 1;
    end