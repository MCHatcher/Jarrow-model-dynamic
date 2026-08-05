% Constrained_pos_main_EXT.m

for m=k-1:-1:1

%for m=1:k-1

    B11 = m:k-1;
    B22 = [];

    Insert_1_EXT

    if dum_sol==1
        break
    end

    B22 = m:k-1;
    B11 = [];

    Insert_2_EXT

   if dum_sol==1
        break
   end

end

          
