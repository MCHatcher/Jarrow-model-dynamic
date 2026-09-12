% Insert_2.m

FV_sum = V_bar*[ n(set12)*F(1,set12)' ; n(set12)*F(2,set12)' ] + V22*[ n(B22)*F(1,B22)' ; n(B22)*F(2,B22)' ];
V_sum = sum(n(set12))*V_bar + sum(n(B22))*V22;
                
P_guess = ( V_sum \ eye(2) )*( FV_sum  - N_bar );

Demands_opt = V_bar*( F(:,set12) - P_guess );
min_opt = min(min(Demands_opt));

Diff = 1:m-1;
P_out = F(:,Diff) - P_guess;
max_out = max(max(P_out));

if isempty(Diff)
    max_out = -1;
end

Demands_pes = V_bar*( F(:,B22) - P_guess );
max_pes = max(Demands_pes(1,:));

min_22 = min(F(2,B22)); 

    if min_opt >= 0 && max_pes < 0 && min_22 >= P_guess(2) && max_out <0 
        dum_sol = 1; 
    end