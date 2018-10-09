function rowOfMax = State_Space(i)
i = medfilt2(i);
[rows,columns] = size(i);
octaveDivisions = 10;
numOfOctaves = 5;
scaleFactor = 2.0^(1.0/octaveDivisions);
numOfLevels = octaveDivisions*numOfOctaves+1;

Sigma(1) = 1;
kernel = fspecial('gaussian',[rows columns],Sigma(1));
i1 = imfilter(i,kernel);
madBlock(1) = mean2(abs(double(i) - double(i1)));

for s = 2 : numOfLevels
Sigma(s) = Sigma(s-1)*scaleFactor;
kernel = fspecial('gaussian',[rows columns],Sigma(s));
i1 = imfilter(i,kernel);
madBlock(s) = mean2(abs(double(i) - double(i1)));
end

nor_madBlock = (madBlock - min(madBlock))/(max(madBlock) - min(madBlock));
% plot(Sigma(1:end),nor_madBlock(1:end))

dmadBlock = conv(nor_madBlock,[-1 1]);
dSigma = conv(Sigma,[-1 1]);
ratio = (dmadBlock(1:51)./dSigma(1:51));
% figure,plot(Sigma,ratio)
% axis([1 51 min(ratio) max(ratio)]) 

maxratio = max(ratio(:));
rowOfMax = find(ratio == maxratio);
rowOfMax = (Sigma(rowOfMax));
%if rowOfMax<1.5
%    rowOfMax= 0;
%else
%    rowOfMax = floor(rowOfMax);
%end

end