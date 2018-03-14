function [X, Labels] = ReadImageFn(Image_Path, Class_ID)
folder = Image_Path;
I = dir(fullfile(folder,'*.jpg'));
Label = zeros(numel(I), 1);
for k = 1: numel(I)
  filename = fullfile(folder, I(k).name);
  X{k} = imread(filename);
  X{k} = rgb2gray(X{k});
  n = 100*100;
  X{k} = imresize(X{k}, [100, 100]);
  Labels(k) = Class_ID;
 % X{k} = double(X{k});
 % X{k} = reshape(X{k}, 1, n);
 % X{k} = uint8(X{k});
end
end