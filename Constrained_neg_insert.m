% Constrained_neg_insert

FV_sum = V_bar*[ n(set12)*F(1,set12)' ; n(set12)*F(2,set12)' ] + V11*[ n(B11)*F(1,B11)' ; n(B11)*F(2,B11)' ] + V22*[ n(B22)*F(1,B22)' ; n(B22)*F(2,B22)' ];
V_sum = sum(n(set12))*V_bar + sum(n(B11))*V11 + sum(n(B22))*V22;
                
P_guess = ( V_sum \ eye(2) )*( FV_sum  - N_bar );

Demands_opt = V_bar*( F(:,set12) - P_guess );
min_opt = min(min(Demands_opt));

if isempty(set12) == 1
    min_opt = 0;
end

out = F(:,set_out) - P_guess;
max_out = max(max(out));

if isempty(set_out) == 1
    max_out = -1;
end

Demands_pes = V_bar*( F(:,B11) - P_guess );
max_pes = max(Demands_pes(2,:));
min_11 = min(F(1,B11));

if isempty(B11) == 1
    max_pes = -1; min_11 = P_guess(1);
end

Demands_pes2 = V_bar*( F(:,B22) - P_guess );
max_pes2 = max(Demands_pes2(1,:));
min_22 = min(F(2,B22));

if isempty(B22) == 1
    max_pes2 = -1; min_22 = P_guess(2);
end

    if min_opt >= 0 && max_pes < 0 && max_pes2 < 0 && min_11 >= P_guess(1) && min_22 >= P_guess(2) && max_out <0
        dum_sol = 1; 
    end