function [Training_Features_Extracted_Normal, Training_Features_Extracted_Cancer] = SplitFn (Training_Features_Extracted, Normal_Number, Cancer_Number)
Training_Features_Extracted_Normal = zeros(Normal_Number, 11);
Training_Features_Extracted_Cancer = zeros(Cancer_Number, 11);
for i = 1: Normal_Number
    for j = 1: 11
        Training_Features_Extracted_Normal(i, j) = Training_Features_Extracted(i, j);
    end
end

Total = Normal_Number + Cancer_Number;
k = 1;
for i = (Cancer_Number + 1): Total
    for j = 1: 11
        Training_Features_Extracted_Cancer(k, j) = Training_Features_Extracted(i, j);
    end
    k = k+1;
end

%Training_Features_Extracted_Normal = double(Training_Features_Extracted_Normal);
%Training_Features_Extracted_Cancer = double(Training_Features_Extracted_Cancer);

end