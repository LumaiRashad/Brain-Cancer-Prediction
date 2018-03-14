function X = ConvertTo32(GrayScale)
GrayScale = double(GrayScale);
[rows, cols] = size(GrayScale);
X = zeros(rows, cols);
maxvalue = max(max(GrayScale));
minvalue = min(min(GrayScale));
 for i = 1: rows
     for j = 1: cols
     X(i, j) = ((GrayScale(i, j)/256) * 31) + 1;
     end
 end
 GrayScale = uint8(GrayScale);
end