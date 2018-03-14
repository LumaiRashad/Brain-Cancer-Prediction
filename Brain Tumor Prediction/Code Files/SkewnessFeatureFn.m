function Skewness = SkewnessFeatureFn(Mean, N, X, Variance)
Skewness = 0;
Sum = 0;
Sigma = sqrt(Variance);
Sigma = Sigma^3;
 
for i = 1: 100
    for j = 1: 100
        Sum = Sum + (X(i, j) - Mean)^3;
    end
end
Skewness = Sum / ((N*N) * Sigma);

end
