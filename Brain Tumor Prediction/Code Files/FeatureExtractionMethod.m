function Features_Extracted = FeatureExtractionMethod(Normal_Number, Cancer_Number, Normal_Images_Training, Cancer_Images_Training)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIRST FEATURE: MEAN MeanMatrix(Training_Mean_Feature)
Training_Mean_Feature_Normal = zeros(Normal_Number, 1);
for i = 1: Normal_Number
   Training_Mean_Feature_Normal(i) = MeanFeatureFn(Normal_Images_Training{i});
end

Training_Mean_Feature_Cancer = zeros(Cancer_Number,1);
for i = 1: Cancer_Number
   Training_Mean_Feature_Cancer(i) = MeanFeatureFn(Cancer_Images_Training{i});
end
Training_Mean_Feature = [Training_Mean_Feature_Normal; Training_Mean_Feature_Cancer];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SECOND FEATURE: VARIANCE VarianceMatrix(Training_Variance_Feature)
Training_Variance_Feature_Normal = zeros(Normal_Number, 1);
Training_Variance_Feature_Cancer = zeros(Cancer_Number, 1);
Variance = cell(Normal_Number + Cancer_Number, 1);

for i = 1: Normal_Number
    Training_Variance_Feature_Normal(i) = VarianceFeatureFn(Training_Mean_Feature_Normal(i), 100, double(Normal_Images_Training{i}));
    %Variance = var(double(Normal_Images_Training{i}));
end

for i = 1: Cancer_Number
    Training_Variance_Feature_Cancer(i) = VarianceFeatureFn(Training_Mean_Feature_Cancer(i), 100, double(Cancer_Images_Training{i}));
    %Variance = var(double(Cancer_Images_Training{i}));
end
Training_Variance_Feature = [Training_Variance_Feature_Normal; Training_Variance_Feature_Cancer];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%THIRD FEATURE: SMOOTHNESS SmoothnessMatrix(Training_Smoothness_Feature)
Training_Smoothness_Feature_Normal = zeros(Normal_Number, 1);
Training_Smoothness_Feature_Cancer = zeros(Cancer_Number, 1);
for i = 1: Normal_Number
    Training_Smoothness_Feature_Normal(i) = SmoothnessFeatureFn(Training_Variance_Feature_Normal(i));
end

for i = 1: Cancer_Number
    Training_Smoothness_Feature_Cancer(i) = SmoothnessFeatureFn(Training_Variance_Feature_Cancer(i));
end
Training_Smoothness_Feature = [Training_Smoothness_Feature_Normal; Training_Smoothness_Feature_Cancer];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FOURTH FEATURE: SKEWNESS SkefnessMatrix(Training_Skewness_Feature)
Training_Skewness_Feature_Normal = zeros(Normal_Number, 1);
Training_Skewness_Feature_Cancer = zeros(Cancer_Number, 1);
for i = 1: Normal_Number
    Training_Skewness_Feature_Normal(i) = SkewnessFeatureFn(Training_Mean_Feature_Normal(i), 100, double(Normal_Images_Training{i}), Training_Variance_Feature_Normal(i));
end

for i = 1: Cancer_Number
    Training_Skewness_Feature_Cancer(i) = SkewnessFeatureFn(Training_Mean_Feature_Cancer(i), 100, double(Cancer_Images_Training{i}), Training_Variance_Feature_Cancer(i));
end
Training_Skewness_Feature = [Training_Skewness_Feature_Normal; Training_Skewness_Feature_Cancer];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FIFTH FEATURE: FOURTH MOMENT FourthMomentMatrix(Training_FourthMoment_Feature)
Training_FourthMoment_Feature_Normal = zeros(Normal_Number, 1);
Training_FourthMoment_Feature_Cancer = zeros(Cancer_Number, 1);
for i = 1: Normal_Number
    Training_FourthMoment_Feature_Normal(i) = FourthMomentFeatureFn(Training_Mean_Feature_Normal(i), 100, double(Normal_Images_Training{i}), Training_Variance_Feature_Normal(i));
end

for i = 1: Cancer_Number
    Training_FourthMoment_Feature_Cancer(i) = FourthMomentFeatureFn(Training_Mean_Feature_Cancer(i), 100, double(Cancer_Images_Training{i}), Training_Variance_Feature_Cancer(i));
end
Training_FourthMoment_Feature = [Training_FourthMoment_Feature_Normal; Training_FourthMoment_Feature_Cancer];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%HISTOGRAM OF GRADIENTS
HOG_Normal = cell(Normal_Number, 1);
HOG_Cancer =  cell(Cancer_Number, 1);
for i = 1: Normal_Number
    HOG_Normal{i} = HOG(Normal_Images_Training{i});
end
for i = 1: Cancer_Number
    HOG_Cancer{i} = HOG(Cancer_Images_Training{i});
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SIXTH FEATURE: UNIFORMITY UniformityMatrix(Training_Uniformity_Feature)
U_Normal = zeros(Normal_Number, 1);
U_Cancer = zeros(Cancer_Number, 1);
for i = 1: Normal_Number
    U_Normal(i) = UniformatyFeatureFn(HOG_Normal{i});
end
for i = 1: Cancer_Number
    U_Cancer(i) = UniformatyFeatureFn(HOG_Cancer{i});
end
Training_Uniformity_Feature = [U_Normal; U_Cancer];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SEVENTH FEATURE: ENTROPY EntropyMatrix(Training_Entropy_Feature)
E_Normal = zeros(Normal_Number, 1);
E_Cancer = zeros(Cancer_Number, 1);
for i = 1: Normal_Number
    E_Normal(i) = EntropyFeatureFn(HOG_Normal{i});
end
for i = 1: Cancer_Number
    E_Cancer(i) = EntropyFeatureFn(HOG_Cancer{i});
end
Training_Entropy_Feature = [E_Normal; E_Cancer];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%GRAY LEVEL CO-OCCURANCE MATRIX (GLCM)
X_Normal = cell(Normal_Number, 1);
X_Cancer = cell(Cancer_Number, 1);
for i = 1: Normal_Number
    X_Normal{i} = ConvertTo32(double(Normal_Images_Training{i}));
end
for i = 1: Cancer_Number
    X_Cancer{i} = ConvertTo32(double(Cancer_Images_Training{i}));
end

GLCM_Normal = cell(Normal_Number, 1);
GLCM_Cancer = cell(Cancer_Number, 1);
for i = 1: Normal_Number
    GLCM_Normal{i} = GLCMMatrixFn(X_Normal{i});
end
for i = 1: Cancer_Number
    GLCM_Cancer{i} = GLCMMatrixFn(X_Cancer{i});
end

GLCM_Training_Set = [GLCM_Normal; GLCM_Cancer];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%EIGHTH FEATURE: CONTRAST ContrastMatrix(Training_Contrast_Feature)
Normal_Contrast = zeros(Normal_Number, 1);
Cancer_Contrast = zeros(Cancer_Number, 1);
for i = 1: Normal_Number
    Normal_Contrast(i) = ContrastFeatureFn(GLCM_Normal{i});
end
for i = 1: Cancer_Number
    Cancer_Contrast(i) = ContrastFeatureFn(GLCM_Cancer{i});
end
Training_Contrast_Feature = [Normal_Contrast; Cancer_Contrast];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%NINTH FEATURE: ENTROPY GLCM EntropyMatrix(Training_EntropyGLCM_Feature)
Normal_Entropy = zeros(Normal_Number, 1);
Cancer_Entropy = zeros(Cancer_Number, 1);
for i = 1: Normal_Number
    Normal_Entropy(i) = EntropyGLCMFeatureFn(GLCM_Normal{i});
end
for i = 1: Cancer_Number
    Cancer_Entropy(i) = EntropyGLCMFeatureFn(GLCM_Cancer{i});
end
Training_EntropyGLCM_Feature = [Normal_Entropy; Cancer_Entropy];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TENTH FEATURE: ENERGY GLCM EnergyMatrix(Training_Energy_Feature)
Normal_Energy = zeros(Normal_Number, 1);
Cancer_Energy = zeros(Cancer_Number, 1);
for i = 1: Normal_Number
    Normal_Energy(i) = EnergyFeatureFn(GLCM_Normal{i});
end
for i = 1: Cancer_Number
    Cancer_Energy(i) = EnergyFeatureFn(GLCM_Cancer{i});
end
Training_Energy_Feature = [ Normal_Energy; Cancer_Energy];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%ELEVENTH FEATURE: HOMOGENITY GLCM HomogenityMatrix(Training_Hommogenity_Feature)
Normal_Homo = zeros(Normal_Number, 1);
Cancer_Homo = zeros(Cancer_Number, 1);
for i = 1: Normal_Number
    Normal_Homo(i) = HomogenityFeatureFn(GLCM_Normal{i});
end
for i = 1: Cancer_Number
    Cancer_Homo(i) = HomogenityFeatureFn(GLCM_Cancer{i});
end
Training_Homogenity_Feature = [ Normal_Homo; Cancer_Homo];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Features_Extracted = [Training_Mean_Feature, Training_Variance_Feature, Training_Smoothness_Feature, Training_Skewness_Feature, Training_FourthMoment_Feature, Training_Uniformity_Feature, Training_Entropy_Feature, Training_Contrast_Feature, Training_EntropyGLCM_Feature, Training_Energy_Feature, Training_Homogenity_Feature];

end