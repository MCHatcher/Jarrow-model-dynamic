% Gen_V_2

V = NaN(2,2,K); V11 = V; Omega = V; %V_tild = V; V11_tild = V;

for q=1:K

    if q==1
        V(:,:,q) = V_bar;
    elseif q>1
        V(:,:,q) = V_bar + -0.025 + 0.05*rand(2,2);
        V(1,2,q) = V_bar(1,2);
        V(2,1,q) = V(1,2,q); V(2,2,q) = V_bar(2,2); 
    end

    V11(:,:,q) = [ det(V(:,:,q))/V(2,2,q) 0; 0 0];
    %V22(:,:,q) = [ 0 0; 0 det(V(:,:,q))/V(1,1,q)];

    Omega(:,:,q) = V(:,:,q) \ eye(2);  %Corresponding vcov matrix

end



