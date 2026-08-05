%Constrained_pos.m

B11 = []; B22 = [];

for k=k_init:K

    set12 = k:K;

    Insert_first

    if dum_sol == 1 
        break 
    end

    Constrained_pos_main

    if dum_sol == 1 
        break 
    end

end

if dum_sol ~= 1

    Insert_pos_back

end