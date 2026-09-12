% Insert_first.m

B11 = []; B22 = [];
FV_sum = V_bar*[ n(set12)*F(1,set12)' ; n(set12)*F(2,set12)' ];
V_sum = sum(n(set12))*V_bar;
                
P_guess = ( V_sum \ eye(2) )*( FV_sum  - N_bar );

Demands_opt = V_bar*( F(:,set12) - P_guess );
min_opt = min(min(Demands_opt));
Diff = 1:k-1;

    if min_opt >= 0 && max(F(1,Diff)) < P_guess(1) && max(F(2,Diff)) < P_guess(2)
        dum_sol = 1;
    end