function R = SmoothnessFeatureFn(Variance)
R = 1 - (1/(1+Variance));
end