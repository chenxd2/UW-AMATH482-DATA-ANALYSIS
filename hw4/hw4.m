clear all; close all; clc;
%% band classification test 1

% get 100 random sampled 5-second pieces for Beethoven
info = audioinfo("Beethoven.wav"); % load 5th symphony, classical dark
time = info.Duration;  
% get 50 random sampled 5-second pieces
Ab = [];  % store Beethoven signals
start_time = rand(1,50)*(time - 5)
% specify each period
start = round(start_time)*info.SampleRate;
for i = 1:50
    [y, Fs] = audioread("Beethoven.wav", [start(i), start(i) + 5*info.SampleRate]);
    Ab = [Ab sum(y,2)/size(y,2)];  % average two data sets for each channel
end
info = audioinfo("Moonlight.wav"); % load moonlight, classical sad
time = info.Duration;  
start_time = rand(1,50)*(time - 5)
start = round(start_time)*info.SampleRate;
for i = 1:50
    [y, Fs] = audioread("Moonlight.wav", [start(i), start(i) + 5*info.SampleRate]);
    Ab = [Ab sum(y,2)/size(y,2)];  % average two data sets for each channel
end

% get 100 random sampled 5-second pieces for Eveningland
info = audioinfo("Nimbus.wav"); % load Nimbus, dance electronic
time = info.Duration;  
Ae = [];
start_time = rand(1,50)*(time - 5)
% specify each period
start = round(start_time)*info.SampleRate;
for i = 1:50
    [y, Fs] = audioread("Nimbus.wav", [start(i), start(i) + 5*info.SampleRate]);
    Ae = [Ae sum(y,2)/size(y,2)];  % average two data sets for each channel
end

info = audioinfo("Nightingale.wav"); % load Nightingale, dance electronic
time = info.Duration;  
start_time = rand(1,50)*(time - 5)
start = round(start_time)*info.SampleRate;
for i = 1:50
    [y, Fs] = audioread("Nightingale.wav", [start(i), start(i) + 5*info.SampleRate]);
    Ae = [Ae sum(y,2)/size(y,2)];  % average two data sets for each channel
end

% get 100 random sampled 5-second pieces for Puddle of Infinity
info = audioinfo("Wind.wav"); % load Wind Marching For Rain, ambient calm
time = info.Duration;  
Ap = [];
start_time = rand(1,50)*(time - 5)
% specify each period
start = round(start_time)*info.SampleRate;
for i = 1:50
    [y, Fs] = audioread("Wind.wav", [start(i), start(i) + 5*info.SampleRate]);
    Ap = [Ap sum(y,2)/size(y,2)];  % average two data sets for each channel
end

info = audioinfo("Young.wav"); % load Young And Old Know Love, ambient calm
time = info.Duration;  
start_time = rand(1,50)*(time - 5)
start = round(start_time)*info.SampleRate;
for i = 1:50
    [y, Fs] = audioread("Young.wav", [start(i), start(i) + 5*info.SampleRate]);
    Ap = [Ap sum(y,2)/size(y,2)];  % average two data sets for each channel
end



% plot signals
figure
subplot(3,1,1)
plot(Ab(:,1))
title("One Piece of 5-second Beethoven's Music")
xlabel("Time(s)")
ylabel("Frequency")
xticks([0, 220501/5, 220501*2/5, 220501*3/5, 220501*4/5, 220501]) % manually create the x label
xticklabels({'0', '1', '2', '3', '4', '5'})
subplot(3,1,2)
plot(Ae(:,1))
title("One Piece of 5-second Eveningland's Music")
xlabel("Time(s)")
ylabel("Frequency")
xticks([0, 220501/5, 220501*2/5, 220501*3/5, 220501*4/5, 220501]) % manually create the x label
xticklabels({'0', '1', '2', '3', '4', '5'})
subplot(3,1,3)
plot(Ap(:,1))
title("One Piece of 5-second Puddle of Infinity's Music")
xlabel("Time(s)")
ylabel("Frequency")
xticks([0, 220501/5, 220501*2/5, 220501*3/5, 220501*4/5, 220501]) % manually create the x label
xticklabels({'0', '1', '2', '3', '4', '5'})

% compute the spectrogram and perform SVD 
A = [Ab, Ae, Ap];
S = [];
for i = 1:300
    sp = spectrogram(A(:,i));
    S = [S, sp(:)];
end
[u,s,v]=svd(S,'econ');

% plot singular
energy = diag(s)/sum(diag(s));
plot(energy,'o')
xlabel('Singular Values')
ylabel('Captured Energey(%)')
title('Singular Value Spectrum Test 1')

% use first 100 modes, split data into 8:2 training and testing, labelled the data 
xb = v(1:100, 1:100);
xe = v(101:200, 1:100);
xp = v(201:300, 1:100);
index_helper1 = randperm(100);
index_helper2 = randperm(100);
index_helper3 = randperm(100);
xtrain = [xb(index_helper1(1:80),:); xe(index_helper2(1:80),:);xp(index_helper3(1:80),:)];
ytrain = [zeros(80,1)+1;
          zeros(80,1)+2;
          zeros(80,1)+3];          % label y in training set 

xtest = [xb(index_helper1(81:end),:); xe(index_helper2(81:end),:);xp(index_helper3(81:end),:)];
ytest = [zeros(20,1)+1;
          zeros(20,1)+2;
          zeros(20,1)+3]; 

% classification
classifier = fitcnb(real(xtrain),ytrain);
predict_value = predict(classifier,real(xtest));
% prediction accuracy
accuracy = sum(predict_value == ytest)/size(ytest,1);  % 85 percent


%% Test 2
% get 100 random sampled 5-second pieces for Doug Maxwell
info = audioinfo("Lost.wav"); % load lost in prayer, classical dark
time = info.Duration;  
Ad = [];  % store Doug Maxwell signals
start_time = rand(1,50)*(time - 5)
% specify each period
start = round(start_time)*info.SampleRate;
for i = 1:50
    [y, Fs] = audioread("Lost.wav", [start(i), start(i) + 5*info.SampleRate]);
    Ad = [Ad sum(y,2)/size(y,2)];  % average two data sets for each channel
end
info = audioinfo("Bellissimo.wav"); % load Bellissimo, classical sad
time = info.Duration;  
start_time = rand(1,50)*(time - 5)
start = round(start_time)*info.SampleRate;
for i = 1:50
    [y, Fs] = audioread("Bellissimo.wav", [start(i), start(i) + 5*info.SampleRate]);
    Ad = [Ad sum(y,2)/size(y,2)];  % average two data sets for each channel
end

% get 100 random sampled 5-second pieces for Asher Fulero
info = audioinfo("Aurora.wav"); % load Aurora Borealis Expedition, classical calm
time = info.Duration;  
Aa = [];  % store Asher Fulero signals
start_time = rand(1,50)*(time - 5)
% specify each period
start = round(start_time)*info.SampleRate;
for i = 1:50
    [y, Fs] = audioread("Aurora.wav", [start(i), start(i) + 5*info.SampleRate]);
    Aa = [Aa sum(y,2)/size(y,2)];  % average two data sets for each channel
end
info = audioinfo("Confliction.wav"); % load Confliction & Catharsis, classical calm
time = info.Duration;  
start_time = rand(1,50)*(time - 5)
start = round(start_time)*info.SampleRate;
for i = 1:50
    [y, Fs] = audioread("Confliction.wav", [start(i), start(i) + 5*info.SampleRate]);
    Aa = [Aa sum(y,2)/size(y,2)];  % average two data sets for each channel
end

% plot signals
figure
subplot(3,1,1)
plot(Ab(:,1))
title("One Piece of 5-second Beethoven's Music")
xlabel("Time(s)")
ylabel("Frequency")
xticks([0, 220501/5, 220501*2/5, 220501*3/5, 220501*4/5, 220501]) % manually create the x label
xticklabels({'0', '1', '2', '3', '4', '5'})
subplot(3,1,2)
plot(Ad(:,1))
title("One Piece of 5-second Doug Maxwell's Music")
xlabel("Time(s)")
ylabel("Frequency")
xticks([0, 220501/5, 220501*2/5, 220501*3/5, 220501*4/5, 220501]) % manually create the x label
xticklabels({'0', '1', '2', '3', '4', '5'})
subplot(3,1,3)
plot(Aa(:,1))
title("One Piece of 5-second Asher Fulero's Music")
xlabel("Time(s)")
ylabel("Frequency")
xticks([0, 220501/5, 220501*2/5, 220501*3/5, 220501*4/5, 220501]) % manually create the x label
xticklabels({'0', '1', '2', '3', '4', '5'})

% compute the spectrogram and perform SVD 
A = [Ab, Ad, Aa];
S = [];
for i = 1:300
    sp = spectrogram(A(:,i));
    S = [S, sp(:)];
end
[u,s,v]=svd(S,'econ');

% plot singular
energy = diag(s)/sum(diag(s));
plot(energy,'o')
xlabel('Singular Values')
ylabel('Captured Energey(%)')
title('Singular Value Spectrum Test 2')

% use first 100 modes, split data into 8:2 training and testing, labelled the data 
xb = v(1:100, 1:100);
xd = v(101:200, 1:100);
xa = v(201:300, 1:100);
index_helper1 = randperm(100);
index_helper2 = randperm(100);
index_helper3 = randperm(100);
xtrain = [xb(index_helper1(1:80),:); xd(index_helper2(1:80),:);xa(index_helper3(1:80),:)];
ytrain = [zeros(80,1)+1;
          zeros(80,1)+2;
          zeros(80,1)+3];          % label y in training set 

xtest = [xb(index_helper1(81:end),:); xd(index_helper2(81:end),:);xa(index_helper3(81:end),:)];
ytest = [zeros(20,1)+1;
          zeros(20,1)+2;
          zeros(20,1)+3]; 

% classification
classifier = fitcnb(real(xtrain),ytrain);
predict_value = predict(classifier,real(xtest));
% prediction accuracy
accuracy = sum(predict_value == ytest)/size(ytest,1);  % 72 percent

%% test 3
% get 100 random sampled 5-second pieces for classical music, three bands
info = audioinfo("Lost.wav"); % load lost in prayer, Doug Maxwell, dark
time = info.Duration;  
Ac = [];  % store classical music signals
start_time = rand(1,40)*(time - 5)
% specify each period
start = round(start_time)*info.SampleRate;
for i = 1:40
    [y, Fs] = audioread("Lost.wav", [start(i), start(i) + 5*info.SampleRate]);
    Ac = [Ac sum(y,2)/size(y,2)];  % average two data sets for each channel
end
info = audioinfo("Confliction.wav"); % load Confliction & Catharsis, Asher Fulero, calm
time = info.Duration;  
start_time = rand(1,30)*(time - 5)
start = round(start_time)*info.SampleRate;
for i = 1:30
    [y, Fs] = audioread("Confliction.wav", [start(i), start(i) + 5*info.SampleRate]);
    Ac = [Ac sum(y,2)/size(y,2)];  % average two data sets for each channel
end
info = audioinfo("Moonlight.wav"); % load moonlight, Beethoven, classical sad
time = info.Duration;  
start_time = rand(1,30)*(time - 5)
start = round(start_time)*info.SampleRate;
for i = 1:30
    [y, Fs] = audioread("Moonlight.wav", [start(i), start(i) + 5*info.SampleRate]);
    Ac = [Ac sum(y,2)/size(y,2)];  % average two data sets for each channel
end

% get 100 random sampled 5-second pieces for edm, three bands
info = audioinfo("Nimbus.wav"); % load Nimbus, dance electronic
time = info.Duration;  
Aedm = [];
start_time = rand(1,50)*(time - 5)
% specify each period
start = round(start_time)*info.SampleRate;
for i = 1:50
    [y, Fs] = audioread("Nimbus.wav", [start(i), start(i) + 5*info.SampleRate]);
    Aedm = [Aedm sum(y,2)/size(y,2)];  % average two data sets for each channel
end
info = audioinfo("Sky.wav"); % load Skycrapper, Geographer
time = info.Duration;  
start_time = rand(1,30)*(time - 5)
start = round(start_time)*info.SampleRate;
for i = 1:30
    [y, Fs] = audioread("Sky.wav", [start(i), start(i) + 5*info.SampleRate]);
    Aedm = [Aedm sum(y,2)/size(y,2)];  % average two data sets for each channel
end
info = audioinfo("Venetian.wav"); % by Density & Time
time = info.Duration;  
start_time = rand(1,30)*(time - 5)
start = round(start_time)*info.SampleRate;
for i = 1:30
    [y, Fs] = audioread("Venetian.wav", [start(i), start(i) + 5*info.SampleRate]);
    Aedm = [Aedm sum(y,2)/size(y,2)];  % average two data sets for each channel
end

% get 100 random sampled 5-second pieces for Hip pop, three bands
info = audioinfo("Orange.wav"); 
time = info.Duration;  
Ah = [];
start_time = rand(1,50)*(time - 5)
% specify each period
start = round(start_time)*info.SampleRate;
for i = 1:50
    [y, Fs] = audioread("Orange.wav", [start(i), start(i) + 5*info.SampleRate]);
    Ah = [Ah sum(y,2)/size(y,2)];  % average two data sets for each channel
end
info = audioinfo("Emotional.wav"); 
time = info.Duration;  
start_time = rand(1,30)*(time - 5)
start = round(start_time)*info.SampleRate;
for i = 1:30
    [y, Fs] = audioread("Emotional.wav", [start(i), start(i) + 5*info.SampleRate]);
    Ah = [Ah sum(y,2)/size(y,2)];  % average two data sets for each channel
end
info = audioinfo("Jane.wav"); 
time = info.Duration;  
start_time = rand(1,30)*(time - 5)
start = round(start_time)*info.SampleRate;
for i = 1:30
    [y, Fs] = audioread("Jane.wav", [start(i), start(i) + 5*info.SampleRate]);
    Ah = [Ah sum(y,2)/size(y,2)];  % average two data sets for each channel
end

% plot signals
figure
subplot(3,1,1)
plot(Ac(:,1))
title("One Piece of 5-second Classical Music")
xlabel("Time(s)")
ylabel("Frequency")
xticks([0, 220501/5, 220501*2/5, 220501*3/5, 220501*4/5, 220501]) % manually create the x label
xticklabels({'0', '1', '2', '3', '4', '5'})
subplot(3,1,2)
plot(Aedm(:,1))
title("One Piece of 5-second Electronic Dance Music")
xlabel("Time(s)")
ylabel("Frequency")
xticks([0, 220501/5, 220501*2/5, 220501*3/5, 220501*4/5, 220501]) % manually create the x label
xticklabels({'0', '1', '2', '3', '4', '5'})
subplot(3,1,3)
plot(Ah(:,1))
title("One Piece of 5-second Hip Pop Music")
xlabel("Time(s)")
ylabel("Frequency")
xticks([0, 220501/5, 220501*2/5, 220501*3/5, 220501*4/5, 220501]) % manually create the x label
xticklabels({'0', '1', '2', '3', '4', '5'})

% compute the spectrogram and perform SVD 
A = [Ac, Aedm, Ah];
S = [];
for i = 1:300
    sp = spectrogram(A(:,i));
    S = [S, sp(:)];
end
[u,s,v]=svd(S,'econ');

% plot singular
energy = diag(s)/sum(diag(s));
plot(energy,'o')
xlabel('Singular Values')
ylabel('Captured Energey(%)')
title('Singular Value Spectrum Test 3')

% use first 100 modes, split data into 8:2 training and testing, labelled the data 
xc = v(1:100, 1:100);
xedm = v(101:200, 1:100);
xh = v(201:300, 1:100);
index_helper1 = randperm(100);
index_helper2 = randperm(100);
index_helper3 = randperm(100);
xtrain = [xc(index_helper1(1:80),:); xedm(index_helper2(1:80),:);xh(index_helper3(1:80),:)];
ytrain = [zeros(80,1)+1;
          zeros(80,1)+2;
          zeros(80,1)+3];          % label y in training set 

xtest = [xc(index_helper1(81:end),:); xedm(index_helper2(81:end),:);xh(index_helper3(81:end),:)];
ytest = [zeros(20,1)+1;
          zeros(20,1)+2;
          zeros(20,1)+3]; 

% classification
classifier = fitcnb(real(xtrain),ytrain);
predict_value = predict(classifier,real(xtest));
% prediction accuracy
accuracy = sum(predict_value == ytest)/size(ytest,1);  % 72 percent