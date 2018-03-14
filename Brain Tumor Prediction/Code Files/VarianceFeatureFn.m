function Variance = VarianceFeatureFn(Mean, N, X)
Sum = 0;
for i = 1: 100
    for j = 1: 100
        Sum = Sum + (X(i, j) - Mean)^2;
    end
end
Variance = Sum /(N - 1);
end
