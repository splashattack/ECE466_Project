close all
clear all


[x,Fs] = audioread('E2_Guitar_82Hz.wav');

%Average the two channels into a single channel
x_L = x(1:length(x),1);
x_R = x(1:length(x),2);
x = (x_L + x_R)/2;

t = 0:1/Fs:10;


%% Overall Spectrum and Estimation(No Windowing)

N = (length(x)+1)/2;
f = (Fs/2)/N*(0:N-1);
indxs = find(f>1 & f<300);
X = goertzel(x,indxs);

[maxValue, maxIdx] = max(abs(X));
f_est = round(f(maxIdx));

figure
plot(f(indxs),abs(X)/length(X), 'lineWidth', 2)

title('Overall Signal Spectrum')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
grid

%% Estimation with Windowing
window_time = 0.1; %(s)
window_samples = Fs*window_time;

for i = 1:window_samples:length(x)-window_samples
    x_window = x(i:i+(window_samples-1));
    
    N = (length(x_window)+1)/2;
    f = (Fs/2)/N*(0:N-1);
    indxs = find(f>1 & f<300);
    X = goertzel(x_window,indxs);
    
    [maxValue,maxIdx] = max(abs(X));
    f_est(i:i+window_samples) = round(f(maxIdx));
end

figure
subplot(211)
plot(1:length(x),x)
title('Original Signal')
xlabel('samples(n)')
ylabel('Amplitude')
xlim([0 length(x)])

subplot(212)
plot(1:length(f_est),f_est, 'lineWidth',2)
title('Windowed Frequency Estimation')
ylabel('Frequency(Hz)')
xlim([0 length(x)])
ylim([0 100])
grid
