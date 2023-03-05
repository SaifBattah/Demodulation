%Saif Battah
%1170986
clc; 
close all; 
clear;
load handel.mat
%1. ReadtheFDMA signal from FDMAMixedAudio.wav file (.wav format).
[y,Fs] = audioread('E:\Saif\BZU\ENEE3309 - Communucation -\Project\FDMAMixedAudio2.wav');
%sound(y,Fs);
disp(Fs);
%==========================================
[samples,channels] = size(y);
ydft = fft(y);
n = numel(y);
t = (0:n-1)/Fs;
freq = linspace(-Fs/2, Fs/2, n+1);
freq(end) = [];
shiftSpectrum = fftshift(ydft);
%===========================================
%2. Plot the FDMA signal in the time domain and frequency domain.
%Time Domain
figure;
subplot(2,1,1)
plot (t, y); %// Note you should start from time = 0, not time = 1/fs
title('FDMAMixedAudio2.wav in Time domain');
xlabel ('Time');
ylabel('Audio Signal');
%Frequency Domain
subplot(2,1,2)
plot(freq,abs(shiftSpectrum)); 
title('FDMAMixedAudio2.wav in Frequency domain');
xlabel ('Hz'); 
ylabel('Magnitude'); 
%==========================================================================
%3. Visually, estimate the bandwidth of each of the five signals.
%4. Visually, estimate the carrier frequencies that were used to modulate
%the five signals.

Fc1 = 1666;
A1 = 4;
Fc2 = 2000;
A2 = 2.65;
Fc3 = 2336;
A3 = 2.94;
Fc4 = 2666;
A4 = 2.32;
Fc5 = 3000;
A5 = 3.1;
%===============================
%5. Visually, determine the modulation technique for each of the five signals,
Carrier1 = (A1*cos(2*pi*Fc1*t));
Carrier2 = (A2*cos(2*pi*Fc2*t));
Carrier3 = (A3*cos(2*pi*Fc3*t));
Carrier4 = (A4*cos(2*pi*Fc4*t));
Carrier5 = (A5*cos(2*pi*Fc5*t));
%===============================
M1 = bandpass(y,[1507, 1800],Fs);
M2 = bandpass(y,[1910, 2100],Fs);
M3 = bandpass(y,[2240, 2430],Fs);
M4 = bandpass(y,[2600, 2708],Fs);
M5 = bandpass(y,[2960, 3110],Fs);
%==========================================================================
%6. Demodulate the five audio signals from the FDMA signal.
%7. Plot the each ofthe audio signals in the time and frequency domain.
%8. Write each of the audio signal into a separate audio file (.wav format). 

%M1 Demodulation
Z1 = amdemod(M1,Fc1,Fs);
Z1T = real(fft(Z1));
%Time and Freq plot
figure;
subplot(2,1,1);
plot(t,Z1);
title('m1(t) in Time domain');
xlabel ('Time');
ylabel('Audio Signal');
subplot(2,1,2)
plot(freq,abs(Z1T)); 
title('m1(t) in Frequency domain');
xlabel ('Hz'); 
ylabel('Magnitude');
audiowrite('One.wav',Z1,700000);
%===============================================
%M2 Demodulation

Z2 = amdemod(M2,Fc2,Fs);
Z2T = real(fft(Z2));
%sound(Z2,Fs);

%Time and Freq plot
figure;
subplot(2,1,1);
plot(t,Z2);
title('m2(t) in Time domain');
xlabel ('Time');
ylabel('Audio Signal');
subplot(2,1,2)
plot(freq,abs(Z2T)); 
title('m2(t) in Frequency domain');
xlabel ('Hz'); 
ylabel('Magnitude'); 
audiowrite('Two.wav',Z2,730000);
%===============================================
%M3 Demodulation

Z3 = amdemod(M3,Fc3,Fs);
Z3T = real(fft(Z3));
%sound(Z3,Fs);

%Time and Freq plot
figure;
subplot(2,1,1);
plot(t,Z3);
title('m3(t) in Time domain');
xlabel ('Time');
ylabel('Audio Signal');
subplot(2,1,2)
plot(freq,abs(Z3T)); 
title('m3(t) in Frequency domain');
xlabel ('Hz'); 
ylabel('Magnitude'); 
audiowrite('Three.wav',Z3,760000);
%===============================================
%M4 Demodulation

Z4 = amdemod(M4,Fc4,Fs);
Z4T = real(fft(Z4));

%Time and Freq plot
figure;
subplot(2,1,1);
plot(t,Z4);
title('m4(t) in Time domain');
xlabel ('Time');
ylabel('Audio Signal');
subplot(2,1,2)
plot(freq,abs(Z4T)); 
title('m4(t) in Frequency domain');
xlabel ('Hz'); 
ylabel('Magnitude'); 
audiowrite('Four.wav',Z4,970000);
%===============================================
%M5 Demodulation

Z5 = amdemod(M5,Fc5,Fs);
Z5T = real(fft(Z5));

%Time and Freq plot
figure;
subplot(2,1,1);
plot(t,Z5);
title('m5(t) in Time domain');
xlabel ('Time');
ylabel('Audio Signal');
subplot(2,1,2)
plot(freq,abs(Z5T)); 
title('m5(t) in Frequency domain');
xlabel ('Hz'); 
ylabel('Magnitude'); 
audiowrite('Five.wav',Z5,750000);
%==========================================================================

figure;
pspectrum([M1 M2 M3 M4 M5],Fs);

%==========================================================================

