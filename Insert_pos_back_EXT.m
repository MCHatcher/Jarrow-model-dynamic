% Insert_pos_back_EXT.m

if dum_sol ~= 1

    for k=k_init-1:-1:2

        set12 = k:K;

        Insert_first_EXT

        if dum_sol == 1 
            break 
        end

        Constrained_pos_main_EXT

        if dum_sol == 1 
            break 
        end

    end

end