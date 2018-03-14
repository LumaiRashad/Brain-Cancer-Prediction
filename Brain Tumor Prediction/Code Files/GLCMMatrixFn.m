function glcm = GLCMMatrixFn(X)
[rows, cols] = size(X);
GLCM = zeros(32, 32);
X = uint8(X);
%Spatial Relation (1, 1)
maxvalue = max(max(X));
minvalue = min(min(X));
  for i = 1: rows-1
      for j = 1: cols-1
          current = X(i, j);
          next = X(i+1, j+1);
          GLCM(current, next) = GLCM(current, next) + 1;     
      end
  end
%GLCM = graycomatrix(X,'Offset',[1 1],'NumLevels',32,'GrayLimits',[]);
Summation = 0;
 Transpose = transpose(GLCM);
 Symmetric = GLCM + Transpose;
 for i = 1: 32
     for j = 1: 32
         Summation = Summation + Symmetric(i, j);
     end
 end
 for i = 1: 32
     for j = 1: 32
         Symmetric(i, j) = Symmetric(i, j)/Summation;
     end
 end
 
 glcm = Symmetric;
end