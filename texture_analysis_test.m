Im = imread('textura1.jpg');
I=rgb2gray(Im);
figure,imshow(I)
title('Original Image')

E = entropyfilt(I);
S = stdfilt(I,ones(3));
R = rangefilt(I,ones(3));

Eim = rescale(E);
Sim = rescale(S);

%entropy, local standard deviation and local range
figure,montage({Eim,Sim,R},'Size',[1 3],'BackgroundColor','w',"BorderSize",20)
title('Texture Images Showing Local Entropy, Local Standard Deviation, and Local Range')

%paramaters to select region
BW1 = imbinarize(Eim,0.96);
figure,imshow(BW1)
title('Thresholded Texture Image')

%search big regions
BWao = bwareaopen(BW1,400);
figure,imshow(BWao)
title('Area-Opened Texture Image')

%remove noise
nhood = ones(3);
closeBWao = imclose(BWao,nhood);
figure,imshow(closeBWao)
title('Closed Texture Image')

%extract clean region
mask = imfill(closeBWao,'holes');
figure,imshow(mask);
title('Mask of Bottom Texture')