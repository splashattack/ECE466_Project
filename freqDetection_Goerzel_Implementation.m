close all
clear all

Fs = 44100;
t = 0:1/Fs:2;
x = sin(2*pi*t*100) + 0.5 * sin(2*pi*t*200);



%% Overall Spectrum and Estimation(No Windowing)
N = (length(x)+1)/2;
M = Fs;
f = (Fs/2)/N*(0:N-1);
indxs = find(f>1 & f<300);

%Goertzel Implementation
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
    for i = 1:M
        Q0 = coeff * Q1 - Q2 + x(i);
        Q2 = Q1;
        Q1 = Q0;
    end
    magnitudeSquared = Q1 * Q1 + Q2 * Q2 - Q1 * Q2 * coeff;
    magnitude = sqrt(magnitudeSquared);
    
    f_spectrum(target_freq) = magnitude; 
end


figure
plot(1:300,f_spectrum, 'lineWidth', 2)

title('Overall Signal Spectrum')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
grid