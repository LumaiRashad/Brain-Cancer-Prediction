function E = EntropyFeatureFn(HOG)
Pixels_Number = 100*100;
[Pins_Number, cols] = size(HOG);
Debug = zeros(Pins_Number, 1);
E = 0;
for i = 1: Pins_Number
    if(HOG(i)~=0)
        P = HOG(i)/Pixels_Number;
        Log2P = log2(HOG(i)/Pixels_Number);
        E = E + (P * Log2P);
        Debug(i) = E;
    end
end
E = -E;
end
