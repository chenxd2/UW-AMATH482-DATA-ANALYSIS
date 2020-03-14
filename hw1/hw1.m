
clear; close all; clc;
load Testdata
L=15; % spatial domain
n=64; % Fourier modes
x2=linspace(-L,L,n+1); x=x2(1:n); y=x; z=x;
k=(2*pi/(2*L))*[0:(n/2-1) -n/2:-1];  % frequency components
[X,Y,Z]=meshgrid(x,y,z);
[Kx,Ky,Kz]=meshgrid(k,k,k);

% first row data with noise
Un(:,:,:)=reshape(Undata(1,:),n,n,n);
close all, isosurface(X,Y,Z,abs(Un),0.4)
axis([-20 20 -20 20 -20 20]), grid on, drawnow
title('First Row of Data (with noise)','Fontsize',15);

% determine the center frequency by averaging 20 signals
Uavg = zeros(n,n,n);
for j=1:20
    Un(:,:,:) = reshape(Undata(j,:),n,n,n);
    Unt = fftn(Un);
    Uavg = Uavg+Unt;
end
Uavg = abs(Uavg)/20;
[value, idx] = max(Uavg(:));
[xi,yi,zi] = ind2sub(size(Uavg),idx);  % Convert linear indices to subscripts
kxc = Kx(xi,yi,zi);  % center frequency component in x direction
kyc = Ky(xi,yi,zi);  % center frequency component in y direction
kzc = Kz(xi,yi,zi);  % center frequency component in z direction

% filter the data to denoise
filter=exp(-0.2*((Kx-kxc).^2+(Ky-kyc).^2+(Kz-kzc).^2));
for j=1:20
    Un(:,:,:) = reshape(Undata(j,:),n,n,n);
    Unt = fftn(Un);
    Unft = Unt.*filter;
    Unf = ifftn(Unft);
    [value2,idx2] = max(Unf(:));    % idx2: the position of the marble in jth realization
    [xj,yj,zj] = ind2sub(size(Unf), idx2); 
    px(j) = X(xj,yj,zj);  % position of marble in x direction for jth realization
    py(j) = Y(xj,yj,zj);
    pz(j) = Z(xj,yj,zj);
end

% plot the path of the marble, i.e the position during each realizations
plot3(px,py,pz,'k','Linewidth', 2, 'DisplayName', 'Path of Marble')
hold on

% the position of the marble at the 20th realization
plot3(px(20),py(20),pz(20),'ro', 'Linewidth', 2, 'DisplayName', 'Marble at the 20th measurement')
legend('location','best');
title('Marble Path','Fontsize',15);
xlabel('x'),ylabel('y'),zlabel('y'), grid on
hold off

% final position is
[px(20),py(20),pz(20)]

