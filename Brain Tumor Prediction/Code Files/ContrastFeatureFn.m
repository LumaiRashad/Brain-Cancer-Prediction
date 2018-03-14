function Contrast = ContrastFeatureFn(X)
Contrast = 0;
for i = 1: 32
     for j = 1: 32
         %Contrast = Contrast + sum(sum((i - j)^2 * X(i, j)));
         Contrast = Contrast + (i - j)^2 * X(i, j);
     end
end
end