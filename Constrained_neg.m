%Constrained_neg.m

B11 = []; B22 = [];

for k=k_init1:K

    buy1 = Index1(k:K);

    for j = k_init2:K

        buy2 = Index2(j:K);

        set12 = intersect(buy1,buy2);
        B11 = setdiff(buy1,buy2);
        B22 = setdiff(buy2,buy1);
        
        set_out = intersect(Index1(1:k-1),Index2(1:j-1));

        Constrained_neg_insert

        if dum_sol == 1
            break
        end

    end

    if dum_sol == 1
        break
    end

end

if dum_sol ~= 1

    back = 1;
    Constrained_neg_back

end