function Entropy = EntropyGLCMFeatureFn(X)
Entropy = 0;
for i = 1: 32
     for j = 1: 32
         if(X(i, j) ~= 0)
             %Entropy = Entropy + sum(sum(X(i, j) * log(X(i, j))));
             Entropy = Entropy + X(i, j) * log2(X(i, j));
         end
     end
end
Entropy = -Entropy;
end