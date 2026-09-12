% Insert_1_EXT.m

FV_sum = V_bar*[ n_prod(set12)*F(1,set12)' ; n_prod(set12)*F(2,set12)' ] + V11*[ n_prod(B11)*F(1,B11)' ; n_prod(B11)*F(2,B11)' ];
V_sum = sum(n_prod(set12))*V_bar + sum(n_prod(B11))*V11;
                
P_guess = ( V_sum \ eye(2) )*( FV_sum  - N_bar );

Demands_opt = c(set12).*( V_bar*( F(:,set12) - P_guess ) );
min_opt = min(min(Demands_opt));

Diff = 1:m-1;
P_out = F(:,Diff) - P_guess;
max_out = max(max(P_out));

if isempty(Diff)
    max_out = -1;
end

Demands_pes = c(B11).*( V_bar*( F(:,B11) - P_guess ) );
max_pes = max(Demands_pes(2,:));

min_11 = min(F(1,B11));  

    if min_opt >= 0 && max_pes < 0 && min_11 >= P_guess(1) && max_out <0
        dum_sol = 1;   
    end