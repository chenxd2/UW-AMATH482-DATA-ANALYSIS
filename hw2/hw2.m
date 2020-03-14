%% part1
load handel
v = y';
plot((1:length(v))/Fs,v);
xlabel('Time [sec]');
ylabel('Amplitude');
title('Signal of Interest, v(n)');

%p8 = audioplayer(v,Fs);
%playblocking(p8);

v = v(1:length(v)-1);
n = length(v);
L = length(v)/Fs;

k=(2*pi/(L))*[0:(n/2-1) -n/2:-1];
ks=fftshift(k);

% Calculate Gabor transform and plot spectrogram
a = 10;
tau = 0.1;
tslide=0:tau:L;
Sgt_spec = zeros(length(tslide),n);
Sgt_spec = [];
t = (1:length(v))/Fs;
for j=1:length(tslide)
    gau = exp(-a*(t-tslide(j)).^2); 
    mex = (1-a*(t-tslide(j)).^2).*exp(-a*(t-tslide(j)).^2/2);
    step = abs(t-tslide(j)) <= a / 2;
    Sg=mex.*v; 
    Sgt=fft(Sg); 
    Sgt_spec(j,:) = fftshift(abs(Sgt)); 
end
pcolor(tslide,ks,Sgt_spec.'), 
shading interp 
xlabel('time(s)')
ylabel('frequency')
title('Step Function, a=10, \tau=0.1')
colormap(hot)

%% part 2 piano
[y,Fs] = audioread('music1.wav');
piano = y';  % transpose
tr_piano=length(y)/Fs; % record time in seconds
plot((1:length(y))/Fs,y);
xlabel('Time [sec]'); ylabel('Amplitude');
title('Mary had a little lamb (piano)');
% p8 = audioplayer(y,Fs); playblocking(p8);
L_piano = length(y)/Fs;
n = length(y);
k=(2*pi/(L_piano))*[0:(n/2-1) -n/2:-1];
ks=fftshift(k);
% Calculate Gabor transform and plot spectrogram
a = 100;
tau = 0.1;
tslide=0:tau:L_piano;
Sgt_spec = zeros(length(tslide),n);
Sgt_spec = [];
t = (1:length(piano))/Fs;
for j=1:length(tslide)
    gau = exp(-a*(t-tslide(j)).^2);
    Sg=gau.*piano; 
    Sgt=fft(Sg); 
    Sgt_spec(j,:) = fftshift(abs(Sgt)); 
end
pcolor(tslide,ks/(2*pi),Sgt_spec.'), 
shading interp 
xlabel('time(s)')
ylabel('frequency(hz)')
title('Piano Spectrogram, Gaussian, a=100, \tau=0.1')
set(gca,'Ylim',[200 400])
colormap(hot)


%% part 2 recorder
[y,Fs] = audioread('music2.wav');
plot((1:length(y))/Fs,y);
xlabel('Time [sec]'); ylabel('Amplitude');
title('Mary had a little lamb (recorder)');
% p8 = audioplayer(y,Fs); playblocking(p8);
L_recorder = length(y)/Fs;
recorder = y';
n = length(y);
k=(2*pi/(L_recorder))*[0:(n/2-1) -n/2:-1];
ks=fftshift(k);
% Calculate Gabor transform and plot spectrogram
a = 100;
tau = 0.1;
tslide=0:tau:L_recorder;
Sgt_spec = zeros(length(tslide),n);
Sgt_spec = [];
t = (1:length(recorder))/Fs;
for j=1:length(tslide)
    gau = exp(-a*(t-tslide(j)).^2);
    Sg=gau.*recorder; 
    Sgt=fft(Sg); 
    Sgt_spec(j,:) = fftshift(abs(Sgt)); 
end
pcolor(tslide,ks/(2*pi),Sgt_spec.'), 
shading interp 
xlabel('time(s)')
ylabel('frequency(hz)')
title('Recorder Spectrogram, Gaussian, a=100, \tau=0.1')
set(gca,'Ylim',[600 1200])
colormap(hot)
