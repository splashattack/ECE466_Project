close all
clear all

Fs = 44100;
t = 0:1/Fs:10;
x = sin(2*pi*t*100) + 0.5 * sin(2*pi*t*200);


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
window_time = 1; %(s)
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

plot(t/Fs,f_est, 'lineWidth', 2)

title('Windowed Signal Spectrum')
xlabel('Frequency (Hz)')
ylabel('Amplitude')
grid