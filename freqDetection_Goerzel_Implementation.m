close all
clear all

Fs = 44100;
t = 0:1/Fs:2;
sample_window = 0.1*Fs;
x = sin(2*pi*t*100) + 0.5 * sin(2*pi*t*200);

[x,Fs] = audioread('E2_Guitar_82Hz.wav');

%Average the two channels into a single channel
x_L = x(1:length(x),1);
x_R = x(1:length(x),2);
x = (x_L + x_R)/2;


%% Overall Spectrum and Estimation(No Windowing)
N = (length(x)+1)/2;
M = Fs;
f = (Fs/2)/N*(0:N-1);
indxs = find(f>1 & f<300);

%Goertzel Implementation
for i = 1:sample_window:length(x)-sample_window
    
    f_spectrum = zeros(1,300);
    for target_freq =  1:300;
        k = round(0.5+(N*target_freq/Fs));
        w = (2*pi/N)*k; 
        cosine = cos(w);
        sine = sin(w);
        coeff = 2*cosine;
        Q0 = 0;
        Q1 = 0;
        Q2 = 0;
        for j = 1:sample_window
            Q0 = coeff * Q1 - Q2 + x((i-1)+j);
            Q2 = Q1;
            Q1 = Q0;
        end
        magnitudeSquared = Q1 * Q1 + Q2 * Q2 - Q1 * Q2 * coeff;
        magnitude = sqrt(magnitudeSquared);
    
        f_spectrum(target_freq) = magnitude;
    end
    [Max_amplitude,f_est(i:i+sample_window)] = max(f_spectrum);
end


figure
plot(1:300,f_spectrum, 'lineWidth', 2)

title('Overall Signal Spectrum')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
grid

figure
plot(f_est, 'lineWidth', 2)
title('Overall Signal Spectrum')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
xlim([0 100])
grid