function radius = blur_radius(i,rows,columns)
fftA = fft2(i);
%figure,imshow(log(fftshift(abs(fftA))),[])
ffta = log(fftshift(abs(fftA)));
fftb = ifft2(log(abs(fftshift(fftA))));
%figure,imshow(log(fftshift(abs(fftb))),[])
fftc = (fftshift(abs(fftb)));
% [Ix,Iy] = gradient(fftc);
% I = Ix.*Ix + Iy.*Iy;
[I,thresh] = edge(fftc,'Canny');
%figure,imshow(I,[])
k=1;index =0;
for j = (floor(columns/2)+1):columns
    k= k+1;
    if I(floor(rows/2)+1,j)== 1 && k>3
        break
    end
    index= index+1;
end        
radius = (k+1)/2;
% [centers, radii,metric] = imfindcircles(I,[1 round(rows/2)]);
% centersStrong5 = centers(1:5,:);
% radiiStrong5 = radii(1:5);
% radius = max(radii);
end
