% Gen_V_2_FAST.m

V_add = NaN(K,1); V11_q = V_add; 

for q=1:K

    if q==1
        V_add(q) = 0;
    elseif q>1
        V_add(q) = -0.025 + 0.05*rand; 
    end

    V11_q(q) =  ( (V_bar(1,1) + V_add(q))*V_bar(2,2) - (V_bar(1,2))^2  )/V_bar(2,2);

end





