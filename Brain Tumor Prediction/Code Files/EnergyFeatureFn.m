function Energy = EnergyFeatureFn(X)
Energy = 0;
for i = 1: 32
     for j = 1: 32
         %Energy = Energy + sum(sum((X(i, j)^2)));
         Energy = Energy + (X(i, j)^2);
     end
end
end