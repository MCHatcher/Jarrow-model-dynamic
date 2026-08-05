% Insert_pos_back.m

if dum_sol ~= 1

    for k=k_init-1:-1:2

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

end