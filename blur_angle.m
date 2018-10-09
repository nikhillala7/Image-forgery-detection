function direction = blur_angle(image)

[Ix,Iy] = gradient(image);
I  = sqrt(Ix.*Ix + Iy.*Iy);
fftA = fft2(I);  % using gradients we find the blur angle
fftB = log(fftshift(abs(fftA)));
theta = 0:179;
[R,xp] = radon(fftB,theta);
maxR = max(R(:));
[rowOfMax, columnOfMax] = find(R == maxR);
direction =  columnOfMax;

end