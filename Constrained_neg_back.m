% Constrained_neg_back

for k=K-1:-1:1

    buy1 = Index1(k:K);

    for j = K-1:-1:1

        if j==1 && k==1
            %do nothing - all slack already checked
        else

        buy2 = Index2(j:K);

        set12 = intersect(buy1,buy2);
        B11 = setdiff(buy1,buy2);
        B22 = setdiff(buy2,buy1);
        
        set_out = intersect(Index1(1:k-1),Index1(1:j-1));

        Constrained_neg_insert

        if dum_sol == 1
            break
        end

        end
    
    end

    if dum_sol == 1
        break
    end

end

