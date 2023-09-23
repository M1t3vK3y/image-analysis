clc;
clear;

[T_l,Yw,Msx]=loadsysm('ciexyz.mat');
[tm,a,g]=loadmonm('std_crt.mat',eye(3));
datos=[];

[ar2,tray2]=uiputfile('*.xlsx','seleccione donde guardar archivo')

im=imread('0.jpg');
figure,imshow(im);
y=1:size(im,1);
x=1:size(im,2);

  [x1,y1]=getpts;
  
  
  [th,r]=cart2pol(y'-y1,x-x1);
  masc= r<700;
  im2=(double(im).*repmat(double(masc),1,1,3)/255);
  figure,imshow(im2);
  [imind,palRGB]=true2pal(im2,255);
 palxyz=rgb2xyz(palRGB);
palxyz(imind(masc==1),:);
XYZ=mean(palxyz(imind(masc==1),:));
XYZw=[XYZ];
  
  
for i=1:8;

im=imread([num2str(i),'.jpg']);
  figure,imshow(im)
  
y=1:size(im,1);
x=1:size(im,2);

  [x1,y1]=getpts;
  tam=size(x1,1);
  for i=1:tam;
  [th,r]=cart2pol(y'-y1(i),x-x1(i));
  masc= r<700;
  im2=(double(im).*repmat(double(masc),1,1,3)/255);
  figure;imshow(im2)
 [imind,palRGB]=true2pal(im2,255);
 palxyz=rgb2xyz(palRGB);
palxyz(imind(masc==1),:);
XYZ=mean(palxyz(imind(masc==1),:));
datos=[datos;XYZ];
  end
end
  xyz=datos;
  rgb=xyz2rgb(xyz);
  lab=xyz2lab(xyz,XYZw);
  tty=tri2coor(xyz,Yw);
  lpy=coor2lp(tty,2,T_l,Yw);
  lhc=lab2perc(lab);
  v=[1:tam];
  numeromuestra=v'
  
 %carta(:,:,1)=rgb(:,1);
  %carta(:,:,2)=rgb(:,2);
   %carta(:,:,3)=rgb(:,3);
   %openfig('locusxy120limpia2.fig')
  %hold on
  %colordgm(tty,2,T_l,Yw)
   %figure; image(carta)
  

  
   xlswrite(fullfile(tray2,ar2),{'muestra','R','G','B','X','Y','Z','L*','a*','b*','t1','t2','Y','L*','h*','C*','lambda','P','Y'},'Datos Color','A1')
xlswrite(fullfile(tray2,ar2),[numeromuestra],'Datos Color','A2')
xlswrite(fullfile(tray2,ar2),[rgb],'Datos Color','B2')
xlswrite(fullfile(tray2,ar2),[xyz],'Datos Color','E2')
xlswrite(fullfile(tray2,ar2),[lab],'Datos Color','H2')
xlswrite(fullfile(tray2,ar2),[tty],'Datos Color','K2')
xlswrite(fullfile(tray2,ar2),[lhc],'Datos Color','N2')
xlswrite(fullfile(tray2,ar2),[lpy],'Datos Color','Q2')