function Homo = HomogenityFeatureFn(X)
Homo = 0;
for i = 1: 32
     for j = 1: 32
         %Homo = Homo + sum(sum((X(i, j)/ (1 + (abs(i - j))))));
         Homo = Homo +(X(i, j)/ (1 + (abs(i - j))));
     end
end
end