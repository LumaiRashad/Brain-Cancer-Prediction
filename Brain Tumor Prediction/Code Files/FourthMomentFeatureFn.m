function Mue4 = FourthMomentFeatureFn(Mean, N, X, Variance)
Sum = 0;
Sigma = sqrt(Variance);
Sigma = Sigma^4;
for i = 1: 100
    for j = 1: 100
        Sum = Sum + ((X(i, j) - Mean)^4);
    end
end
%Mue4 = (Sum / ((N*N) * Sigma));
%ASK DR ISLAM
Mue4 = (Sum / ((N*N) * Sigma)) - 3;
end


