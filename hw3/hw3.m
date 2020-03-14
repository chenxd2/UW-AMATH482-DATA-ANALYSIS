clear all; close all; clc;
%% test 1
load('cam1_1.mat');
load('cam2_1.mat');
load('cam3_1.mat');
numFrames1 = size(vidFrames1_1,4);
numFrames2 = size(vidFrames2_1,4);
numFrames3 = size(vidFrames3_1,4);

for k = 1 : numFrames1
    mov(k).cdata = vidFrames1_1(:,:,:,k);
    mov(k).colormap = [];
end

% draw each frame
%for j = 1:numFrames1
 %   img = frame2im(mov(j));
 %   imshow(img); drawnow
%end

% first camera
X1 = [];
Y1 = [];
for j=1:numFrames1
    img = frame2im(mov(j));
    img_2 = double(img(:,300:420));
    [~,I]=max(img_2(:));
    [newy,newx]=ind2sub(size(img_2),I);
    X1 = [X1 newx];
    Y1 = [Y1 newy];
end

% second camera
for k = 1 : numFrames2
    mov(k).cdata = vidFrames2_1(:,:,:,k);
    mov(k).colormap = [];
end
% draw 
%for j = 1:numFrames2
% img = frame2im(mov(j));
% imshow(img); drawnow
%end
%img = frame2im(mov(3));
%imtool(img)

X2 = [];
Y2 = [];

for j=1:numFrames2
    img = frame2im(mov(j));
    img_2 = double(img(:,250:340));
    [~,I]=max(img_2(:));
    [newy,newx]=ind2sub(size(img_2),I);
    X2 = [X2 newx];
    Y2 = [Y2 newy];
end

% third camera
for k = 1 : numFrames3
    mov(k).cdata = vidFrames3_1(:,:,:,k);
    mov(k).colormap = [];
end
% draw 
%for j = 1:numFrames3
% img = frame2im(mov(j));
% imshow(img); drawnow
%end
img = frame2im(mov(3));
imtool(img)

X3 = [];
Y3 = [];

for j=1:numFrames3
    img = frame2im(mov(j));
    img_2 = double(img(240:320,290:350));
    [~,I]=max(img_2(:));
    [newy,newx]=ind2sub(size(img_2),I);
    X3 = [X3 newx];
    Y3 = [Y3 newy];
end

minSize = 226; % 226, first camera size
X2 = X2(10:minSize+9); % shift the data vector by 10 frame
Y2 = Y2(10:minSize+9);
X3 = X3(1:minSize);
Y3 = Y3(1:minSize);

figure(1)
subplot(2,1,1);
plot(X1-mean(X1)), hold on
plot(X2-mean(X2))
plot(Y3-mean(Y3))
xlabel('Time')
ylabel('Displacement in x direction')
ylim([-100, 200])
title('Test 1 (x direction)')
legend('camera1','camera2','camera3');
subplot(2,1,2);
plot(Y1-mean(Y1)), hold on
plot(Y2-mean(Y2))
plot(X3-mean(X3))
xlabel('Time')
ylabel('Displacement in y direction')
title('Test 1 (y direction)')
legend('camera1','camera2','camera3');
hold off

% produce the principal components of interest using the SVD
X = [X1;Y1;X2;Y2;X3;Y3];
[m,n] = size(X); % compute data size
mn = mean(X,2);  % compute mean for each row
X = X-repmat(mn,1,n); % subtract mean

[u,s,v]=svd(X'/sqrt(n-1)); % perform svd
lambda=diag(s).^2;   % diagnal variances
figure(2)
plot(lambda/sum(lambda),'o');  % percentage of energy in each mode
xlabel('Mode')
ylabel('Percent of Energy')
title('Test 1 Principle Component Analysis')

%% test 2
clear all; close all; clc;

load('cam1_2.mat');
load('cam2_2.mat');
load('cam3_2.mat');
numFrames1 = size(vidFrames1_2,4);
numFrames2 = size(vidFrames2_2,4);
numFrames3 = size(vidFrames3_2,4);

for k = 1 : numFrames1
    mov1(k).cdata = vidFrames1_2(:,:,:,k);
    mov1(k).colormap = [];
end

% draw each frame
% for j = 1:numFrames1
  %img = frame2im(mov(j));
  %imshow(img); drawnow
%end
%img = frame2im(mov(3));
%imtool(img)

% first camera
X1 = [];
Y1 = [];
for j=1:numFrames1
    img = frame2im(mov1(j));
    img_2 = double(img(200:end,280:400));
    [~,I]=max(img_2(:));
    [newy,newx]=ind2sub(size(img_2),I);
    X1 = [X1 newx];
    Y1 = [Y1 newy];
end

% second camera
for k = 1 : numFrames2
    mov2(k).cdata = vidFrames2_2(:,:,:,k);
    mov2(k).colormap = [];
end
% draw 
%for j = 1:numFrames2
% img = frame2im(mov(j));
% imshow(img); drawnow
%end
%img = frame2im(mov(3));
%imtool(img)

X2 = [];
Y2 = [];

for j=1:numFrames2
    img = frame2im(mov2(j));
    img_2 = double(img(:,200:400));
    [~,I]=max(img_2(:));
    [newy,newx]=ind2sub(size(img_2),I);
    X2 = [X2 newx];
    Y2 = [Y2 newy];
end

% third camera
for k = 1 : numFrames3
    mov3(k).cdata = vidFrames3_2(:,:,:,k);
    mov3(k).colormap = [];
end
% draw 
%for j = 1:numFrames3
% img = frame2im(mov(j));
% imshow(img); drawnow
%end
%img = frame2im(mov(3));
%imtool(img)

X3 = [];
Y3 = [];

for j=1:numFrames3
    img = frame2im(mov3(j));
    img_2 = double(img(210:320,310:360));
    [~,I]=max(img_2(:));
    [newy,newx]=ind2sub(size(img_2),I);
    X3 = [X3 newx];
    Y3 = [Y3 newy];
end

minSize = 314; % 314, first camera size
X2 = X2(20:minSize + 19); % shift the data vector by 20 frame
Y2 = Y2(20:minSize + 19);
X3 = X3(1:minSize);
Y3 = Y3(1:minSize);

figure(1)
subplot(2,1,1);
plot(X1-mean(X1)), hold on
plot(X2-mean(X2))
plot(Y3-mean(Y3))
xlabel('Time')
ylabel('Displacement in x direction')
ylim([-100, 200])
title('Test 2 (x direction)')
legend('camera1','camera2','camera3');
subplot(2,1,2);
plot(Y1-mean(Y1)), hold on
plot(Y2-mean(Y2))
plot(X3-mean(X3))
xlabel('Time')
ylabel('Displacement in y direction')
title('Test 2 (y direction)')
legend('camera1','camera2','camera3');
hold off

% produce the principal components of interest using the SVD
X = [X1;Y1;X2;Y2;X3;Y3];
[m,n] = size(X); % compute data size
mn = mean(X,2);  % compute mean for each row
X = X-repmat(mn,1,n); % subtract mean

[u,s,v]=svd(X'/sqrt(n-1)); % perform svd
lambda=diag(s).^2;   % diagnal variances
figure(2)
plot(lambda/sum(lambda),'o');  % percentage of energy in each mode
xlabel('Mode')
ylabel('Percent of Energy')
title('Test 2 Principle Component Analysis')




%% test 3
clear all; close all; clc;

load('cam1_3.mat');
load('cam2_3.mat');
load('cam3_3.mat');
numFrames1 = size(vidFrames1_3,4);
numFrames2 = size(vidFrames2_3,4);
numFrames3 = size(vidFrames3_3,4);

for k = 1 : numFrames1
    mov1(k).cdata = vidFrames1_3(:,:,:,k);
    mov1(k).colormap = [];
end

% draw each frame
% for j = 1:numFrames1
  %img = frame2im(mov(j));
  %imshow(img); drawnow
%end
%img = frame2im(mov(3));
%imtool(img)

% first camera
X1 = [];
Y1 = [];
for j=1:numFrames1
    img = frame2im(mov1(j));
    img_2 = double(img(220:370,280:370));
    [~,I]=max(img_2(:));
    [newy,newx]=ind2sub(size(img_2),I);
    X1 = [X1 newx];
    Y1 = [Y1 newy];
end

% second camera
for k = 1 : numFrames2
    mov2(k).cdata = vidFrames2_3(:,:,:,k);
    mov2(k).colormap = [];
end
% draw 
%for j = 1:numFrames2
% img = frame2im(mov(j));
% imshow(img); drawnow
%end
%img = frame2im(mov(3));
%imtool(img)

X2 = [];
Y2 = [];

for j=1:numFrames2
    img = frame2im(mov2(j));
    img_2 = double(img(230:350,180:270));
    [~,I]=max(img_2(:));
    [newy,newx]=ind2sub(size(img_2),I);
    X2 = [X2 newx];
    Y2 = [Y2 newy];
end

% third camera
for k = 1 : numFrames3
    mov3(k).cdata = vidFrames3_3(:,:,:,k);
    mov3(k).colormap = [];
end
% draw 
%for j = 1:numFrames3
% img = frame2im(mov(j));
% imshow(img); drawnow
%end
%img = frame2im(mov(3));
%imtool(img)

X3 = [];
Y3 = [];

for j=1:numFrames3
    img = frame2im(mov3(j));
    img_2 = double(img(180:270,300:400));
    [~,I]=max(img_2(:));
    [newy,newx]=ind2sub(size(img_2),I);
    X3 = [X3 newx];
    Y3 = [Y3 newy];
end

minSize = 237; % 237, third camera size
X2 = X2(30:minSize + 29); % shift the data vector by 30 frame
Y2 = Y2(30:minSize + 29);
X1 = X1(1:minSize);
Y1 = Y1(1:minSize);

figure(1)
subplot(2,1,1);
plot(X1-mean(X1)), hold on
plot(X2-mean(X2))
plot(Y3-mean(Y3))
xlabel('Time')
ylabel('Displacement in x direction')
title('Test 3 (x direction)')
legend('camera1','camera2','camera3');
subplot(2,1,2);
plot(Y1-mean(Y1)), hold on
plot(Y2-mean(Y2))
plot(X3-mean(X3))
xlabel('Time')
ylabel('Displacement in y direction')
title('Test 3 (y direction)')
legend('camera1','camera2','camera3');
hold off

% produce the principal components of interest using the SVD
X = [X1;Y1;X2;Y2;X3;Y3];
[m,n] = size(X); % compute data size
mn = mean(X,2);  % compute mean for each row
X = X-repmat(mn,1,n); % subtract mean

[u,s,v]=svd(X'/sqrt(n-1)); % perform svd
lambda=diag(s).^2;   % diagnal variances
figure(2)
plot(lambda/sum(lambda),'o');  % percentage of energy in each mode
xlabel('Mode')
ylabel('Percent of Energy')
title('Test 3 Principle Component Analysis')

%% test 4
clear all; close all; clc;

load('cam1_4.mat');
load('cam2_4.mat');
load('cam3_4.mat');
numFrames1 = size(vidFrames1_4,4);
numFrames2 = size(vidFrames2_4,4);
numFrames3 = size(vidFrames3_4,4);

for k = 1 : numFrames1
    mov1(k).cdata = vidFrames1_4(:,:,:,k);
    mov1(k).colormap = [];
end

% draw each frame
% for j = 1:numFrames1
  %img = frame2im(mov(j));
  %imshow(img); drawnow
%end
%img = frame2im(mov(3));
%imtool(img)

% first camera
X1 = [];
Y1 = [];
for j=1:numFrames1
    img = frame2im(mov1(j));
    img_2 = double(img(200:360,300:480));
    [~,I]=max(img_2(:));
    [newy,newx]=ind2sub(size(img_2),I);
    X1 = [X1 newx];
    Y1 = [Y1 newy];
end

% second camera
for k = 1 : numFrames2
    mov2(k).cdata = vidFrames2_4(:,:,:,k);
    mov2(k).colormap = [];
end
% draw 
%for j = 1:numFrames2
% img = frame2im(mov(j));
% imshow(img); drawnow
%end
%img = frame2im(mov(3));
%imtool(img)

X2 = [];
Y2 = [];

for j=1:numFrames2
    img = frame2im(mov2(j));
    img_2 = double(img(110:390,140:400));
    [~,I]=max(img_2(:));
    [newy,newx]=ind2sub(size(img_2),I);
    X2 = [X2 newx];
    Y2 = [Y2 newy];
end

% third camera
for k = 1 : numFrames3
    mov3(k).cdata = vidFrames3_4(:,:,:,k);
    mov3(k).colormap = [];
end
% draw 
%for j = 1:numFrames3
% img = frame2im(mov(j));
% imshow(img); drawnow
%end
%img = frame2im(mov(3));
%imtool(img)

X3 = [];
Y3 = [];

for j=1:numFrames3
    img = frame2im(mov3(j));
    img_2 = double(img(150:300,300:500));
    [~,I]=max(img_2(:));
    [newy,newx]=ind2sub(size(img_2),I);
    X3 = [X3 newx];
    Y3 = [Y3 newy];
end

minSize = 392; % 392, first camera size
X2 = X2(1:minSize);
Y2 = Y2(1:minSize);
X3 = X3(1:minSize);
Y3 = Y3(1:minSize);

figure(1)
subplot(2,1,1);
plot(X1-mean(X1)), hold on
plot(X2-mean(X2))
plot(Y3-mean(Y3))
xlabel('Time')
ylabel('Displacement in x direction')
title('Test 4 (x direction)')
legend('camera1','camera2','camera3');
subplot(2,1,2);
plot(Y1-mean(Y1)), hold on
plot(Y2-mean(Y2))
plot(X3-mean(X3))
xlabel('Time')
ylabel('Displacement in y direction')
title('Test 4 (y direction)')
legend('camera1','camera2','camera3');
hold off

% produce the principal components of interest using the SVD
X = [X1;Y1;X2;Y2;X3;Y3];
[m,n] = size(X); % compute data size
mn = mean(X,2);  % compute mean for each row
X = X-repmat(mn,1,n); % subtract mean

[u,s,v]=svd(X'/sqrt(n-1)); % perform svd
lambda=diag(s).^2;   % diagnal variances
figure(2)
plot(lambda/sum(lambda),'o');  % percentage of energy in each mode
xlabel('Mode')
ylabel('Percent of Energy')
title('Test 4 Principle Component Analysis')



