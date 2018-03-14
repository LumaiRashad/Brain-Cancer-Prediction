function Mean = MeanFeatureFn(Image)
N = 100 * 100;
Sum = 0;
Image = double(Image);
for i = 1: 100
     for j = 1: 100
         Sum = Sum + Image(i, j);
     end
end
Sum1 = sum(Image);
Sum1 = sum(Sum1);
Mean = Sum / (N);
Image = uint8(Image);
end
%ASK DR
%Dr Sum = 711129
%My Sum = 710969
%Matlab Sum = 710969