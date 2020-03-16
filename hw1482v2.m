clear; close all; clc;
load Testdata

%Step 0: define our domain
L=15; % spatial domain
n=64; % Fourier modes
x2=linspace(-L,L,n+1); x=x2(1:n); y=x; z=x;
k_start=(2*pi/(2*L))*[0:(n/2-1) -n/2:-1]; ks=fftshift(k_start);
[X,Y,Z]=meshgrid(x,y,z);
[Kx,Ky,Kz]=meshgrid(ks,ks,ks);

%Step 1: find the frequency signature
spectrum_Avg=zeros(64,64,64);
Untarr=zeros(64,64,64,20);
for j=1:20
    Un(:,:,:)=reshape(Undata(j,:),n,n,n);
    Unt=fftshift(fftn(Un));
    Untarr(:,:,:,j)=Unt;
    spectrum_Avg=spectrum_Avg+Unt;
end
spectrum_Avg=abs(spectrum_Avg)./20;
[M,I]=max(spectrum_Avg(:));
[Ix,Iy,Iz]=ind2sub(size(spectrum_Avg),I);
k_starr_x=Kx(Ix,Iy,Iz);
k_starr_y=Ky(Ix,Iy,Iz);
k_starr_z=Kz(Ix,Iy,Iz);
k_star=[k_starr_x k_starr_y k_starr_z];

%Step 2: apply a Gaussian filter
tau=.5;
filter=exp(-tau*((Kx-k_star(1)).^2+(Ky-k_star(2)).^2+(Kx-k_star(3)).^2));
spec_Filtered=zeros(64,64,64,20);
signal_Filtered=zeros(64,64,64,20);
for t=1:20
    spec_Filtered(:,:,:,t)=filter.*Untarr(:,:,:,t);
    signal_Filtered(:,:,:,t)=abs(ifftn(spec_Filtered(:,:,:,t)));
end

%Step 3: go back to signal domain and plot path
marble_Path=zeros(20,3);
for t=1:20
    signal_Dummy=signal_Filtered(:,:,:,t);
    [M2,J]=max(signal_Dummy(:));
    [Sx,Sy,Sz]=ind2sub(size(signal_Filtered(:,:,:,t)),J);
    marble_Path(t,1)=X(Sx,Sy,Sz);
    marble_Path(t,2)=Y(Sx,Sy,Sz);
    marble_Path(t,3)=Z(Sx,Sy,Sz);
end
plot3(marble_Path(:,1),marble_Path(:,2),marble_Path(:,3),'-*','linewidth',2)
hold on
plot3(marble_Path(20,1),marble_Path(20,2),marble_Path(20,3),'r*','linewidth',5)
xlim([-12 12]);
ylim([-12 12]);
zlim([-12 12]);
xlabel('X');
ylabel('Y');
zlabel('Z');
title('Path of Marble');
grid on
print(gcf,'-dpng','marble_path.png');