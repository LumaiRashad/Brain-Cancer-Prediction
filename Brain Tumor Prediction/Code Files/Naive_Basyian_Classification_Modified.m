function Label = Naive_Basyian_Classification_Modified(Training_Set_Normal, Training_Set_Cancer, Samples_Number_Normal, Samples_Number_Cancer, Testing_Set, Test_Number)

Training_Samples = Samples_Number_Normal + Samples_Number_Cancer;

%PROBABILITY OF CANCER CLASS 
PwCancer = Samples_Number_Cancer/(Training_Samples);

%PROBABILITY OF MORMAL CLASS
PwNormal = Samples_Number_Normal/(Training_Samples);

%CALCULATE MEAN & VARIANCE VALUE OF NORMAL CLASS
Sum_Normal = sum(Training_Set_Normal , 1);
Mean_Matrix_Normal = Sum_Normal / Samples_Number_Normal;
Mean_Substracted_Normal = bsxfun(@minus, Training_Set_Normal, Mean_Matrix_Normal);
Variance_Normal = var(Mean_Substracted_Normal);

%CALCULATE MEAN & VARIANCE VALUE OF CANCER CLASS
Sum_Cancer = sum(Training_Set_Cancer , 1);
Mean_Matrix_Cancer = Sum_Cancer / Samples_Number_Cancer;
Mean_Substracted_Cancer = bsxfun(@minus, Training_Set_Cancer, Mean_Matrix_Cancer);
Variance_Cancer = var(Mean_Substracted_Cancer);

%CALCULATE MUs & SIGMAs OF BOTH CLASSES
Mus = [Mean_Matrix_Normal; Mean_Matrix_Cancer];
Sigmas = [Variance_Normal; Variance_Cancer];

%LIKELIHOOD VALUES FOR THE 2 CLASSES
Test_Labels = zeros(Test_Number , 1);
Features_Number = 11;
i=1;
for k =1: Test_Number 
 for j = 1: Features_Number
     pMatrix(i, j) = mynormalfn(Testing_Set(k,j), Mus(i, j),sqrt(Sigmas(i, j)));
     pMatrix(i + 1, j) = mynormalfn(Testing_Set(k,j), Mus(i + 1, j),sqrt(Sigmas(i + 1 , j)));
 end
 
 PXw = prod(pMatrix, 2);
 
 if PXw(1) > PXw(2)
     Test_Labels(k)=1;
 else
     Test_Labels(k)=2;
 end
     
end
   
Label = Test_Labels;
    
end

