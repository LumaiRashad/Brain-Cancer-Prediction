function U = UniformatyFeatureFn(HOG)
Pixels_Number = 100*100;
[Pins_Number, cols] = size(HOG);
U =0;
for i = 1: Pins_Number
    U = U + ((HOG(i)/Pixels_Number)^2);
end
end
