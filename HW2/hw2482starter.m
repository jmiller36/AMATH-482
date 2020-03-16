clear; clc; close all;

%Part 1
load handel
v = y';
t = (1:length(v))/Fs;
%plot(t,v);
%xlabel('Time [sec]');
%ylabel('Amplitude');
%title('Signal of Interest, v(n)');
%p8 = audioplayer(v,Fs);
%playblocking(p8);
fs = 8192;
L = length(v) / fs;
k=(1/L)*[0:(length(v)-1)/2 -(length(v)-1)/2:-1]; ks=fftshift(k);

%Gaussian
tslide = 0:.05:L;
a = 50;
Sgt_spec = zeros(length(tslide),length(v));
for j = 1:length(tslide)
    g = exp(-a*(t-tslide(j)).^2); 
    Sg = g.*v; 
    Sgt = fft(Sg); 
    Sgt_spec(j,:) = abs(fftshift(Sgt)); % We don't want to scale it
end
figure(1)
subplot(2,2,1);
pcolor(tslide, ks, Sgt_spec.'), 
shading interp 
%set(gca,'Ylim',[-50 50],'Fontsize',16) 
colormap(hot)
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Oversampling');

tslide = 0:1:L;
a = 50;
Sgt_spec = zeros(length(tslide),length(v));
for j = 1:length(tslide)
    g = exp(-a*(t-tslide(j)).^2); 
    Sg = g.*v; 
    Sgt = fft(Sg); 
    Sgt_spec(j,:) = abs(fftshift(Sgt)); % We don't want to scale it
end
subplot(2,2,2);
pcolor(tslide, ks, Sgt_spec.'), 
shading interp 
%set(gca,'Ylim',[-50 50],'Fontsize',16) 
colormap(hot)
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Undersampling');

tslide = 0:.3:L;
a = 2000;
Sgt_spec = zeros(length(tslide),length(v));
for j = 1:length(tslide)
    g = exp(-a*(t-tslide(j)).^2); 
    Sg = g.*v; 
    Sgt = fft(Sg); 
    Sgt_spec(j,:) = abs(fftshift(Sgt)); % We don't want to scale it
end
subplot(2,2,3);
pcolor(tslide, ks, Sgt_spec.'), 
shading interp 
%set(gca,'Ylim',[-50 50],'Fontsize',16) 
colormap(hot)
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Too Small Window Width');

tslide = 0:.3:L;
a = 10;
Sgt_spec = zeros(length(tslide),length(v));
for j = 1:length(tslide)
    g = exp(-a*(t-tslide(j)).^2); 
    Sg = g.*v; 
    Sgt = fft(Sg); 
    Sgt_spec(j,:) = abs(fftshift(Sgt)); % We don't want to scale it
end
subplot(2,2,4);
pcolor(tslide, ks, Sgt_spec.'), 
shading interp 
%set(gca,'Ylim',[-50 50],'Fontsize',16) 
colormap(hot)
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Too Large Window Width');
print(gcf,'-dpng','Explore_Spectrogram.png');

tslide = 0:.3:L;
a = 85;
Sgt_spec = zeros(length(tslide),length(v));
for j = 1:length(tslide)
    g = exp(-a*(t-tslide(j)).^2); 
    Sg = g.*v; 
    Sgt = fft(Sg); 
    Sgt_spec(j,:) = abs(fftshift(Sgt)); % We don't want to scale it
end
figure(2);
subplot(2,2,1);
pcolor(tslide, ks, Sgt_spec.'), 
shading interp 
%set(gca,'Ylim',[-50 50],'Fontsize',16) 
colormap(hot)
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Gaussian; Normal Sampling and Window Width');

%Mexican Hat
tslidem = 0:.3:L;
om = .05;
Smt_spec = zeros(length(tslidem),length(v));
for j = 1:length(tslidem)
    m = 2/(sqrt(3*om)*pi^.25)*(1-((t-tslidem(j))/om).^2).*exp(-((t-tslidem(j))/om).^2/2);
    Sm = m.*v; 
    Smt = fft(Sm); 
    Smt_spec(j,:) = abs(fftshift(Smt)); % We don't want to scale it
end
subplot(2,2,2);
pcolor(tslidem, ks, Smt_spec.'), 
shading interp 
%set(gca,'Ylim',[-50 50],'Fontsize',16) 
colormap(hot)
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Mexican Hat');

%Shannon
tslides = 0:.3:L;
width = .2;
Sst_spec = zeros(length(tslides),length(v));
for j = 1:length(tslides)
    s = abs(t - tslides(j)) <= width / 2;
    Ssh = s.*v; 
    Sst = fft(Ssh); 
    Sst_spec(j,:) = abs(fftshift(Sst)); % We don't want to scale it
end
subplot(2,2,3);
pcolor(tslides, ks, Sst_spec.'), 
shading interp 
%set(gca,'Ylim',[-50 50],'Fontsize',16) 
colormap(hot)
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Shannon Window');
print(gcf,'-dpng','Explore_Wavelets.png');

%Part 2
%Piano
[yp,Fsp] = audioread('music1.wav');
tr_piano=length(yp)/Fsp; % record time in seconds
%figure(4)
%plot((1:length(yp))/Fsp,yp);
%xlabel('Time [sec]'); ylabel('Amplitude');
%title('Mary had a little lamb (piano)');
%p8 = audioplayer(yp,Fsp); playblocking(p8);
kp=(1/tr_piano)*[0:(length(yp))/2-1 -(length(yp))/2:-1]; kps=fftshift(kp);
tp = (1:length(yp)) / Fsp;
tslidep = 0:.1:tr_piano;
ap = 100;
Sgt_spec_p = zeros(length(tslidep),length(yp));
for j = 1:length(tslidep)
    g = exp(-ap*(tp-tslidep(j)).^2); 
    Sg_p = g.*yp'; 
    Sgt_p = fft(Sg_p); 
    Sgt_spec_p(j,:) = abs(fftshift(Sgt_p)); % We don't want to scale it
end
figure(3)
subplot(1,2,1);
pcolor(tslidep, kps, Sgt_spec_p.'), 
shading interp 
ylim([0,500]);
%set(gca,'Ylim',[-50 50],'Fontsize',16) 
colormap(hot)
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Piano Score');

%Recorder
[yr,Fsr] = audioread('music2.wav');
tr_rec=length(yr)/Fsr; % record time in seconds
%plot((1:length(yr))/Fsr,yr);
%xlabel('Time [sec]'); ylabel('Amplitude');
%title('Mary had a little lamb (recorder)');
%p8 = audioplayer(yr,Fsr); playblocking(p8);
kr=(1/tr_rec)*[0:(length(yr))/2-1 -(length(yr))/2:-1]; krs=fftshift(kr);
tr = (1:length(yr)) / Fsr;
tslider = 0:.1:tr_rec;
ar = 100;
Sgt_spec_r = zeros(length(tslider),length(yr));
for j = 1:length(tslider)
    g = exp(-ar*(tr-tslider(j)).^2); 
    Sg_r = g.*yr'; 
    Sgt_r = fft(Sg_r); 
    Sgt_spec_r(j,:) = abs(fftshift(Sgt_r)); % We don't want to scale it
end
subplot(1,2,2);
pcolor(tslider, krs, Sgt_spec_r.'), 
shading interp 
ylim([0,1200]);
%set(gca,'Ylim',[-50 50],'Fontsize',16) 
colormap(hot)
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Recorder Score');
print(gcf,'-dpng','Mary_Score.png');