% Parameters for sine wave
Fs = 44100;              % Sampling frequency (44100 Hz)
f = 1000;                % Frequency (1000 Hz)
T = 2;                   % Duration of the sine wave in seconds
t = 0:1/Fs:T-1/Fs;       % Time vector for the sine wave
x = sin(2 * pi * f * t); % Sine wave equation

% Reading the audio file
[y, fs] = audioread('iii.mp3');

% Normalized audio signal
y = y / max(abs(y)); % Normalize to range [-1, 1]

% Time vector for the audio signal
t_audio = (0:length(y)-1) / fs; 

% Plotting in time-domain
figure;
hold on; 
plot(t, x, 'b', 'DisplayName', 'Sine Wave (1000 Hz)');
plot(t_audio, y, 'r', 'DisplayName', 'Normalized Audio Signal');
xlabel('Time [s]');
ylabel('Amplitude');
title('1000 Hz Sine Wave vs Audio Signal in Time-Domain');
legend;
xlim([1 1.009]);
grid on;
hold off; 

% Frequency domain
n_x = Fs/2; % Resolution of 2 Hz
n_y = fs/2;

% FFT
X = fft(x, n_x);
Y = fft(y, n_y);

% Magnitude
mag_X = abs(X);
mag_Y = abs(Y);

% Magnitude in dB
mag_X_dB = 20 * log10(mag_X);
mag_Y_dB = 20 * log10(mag_Y);

% Normalized magnitude in dB
mag_X_dB = mag_X_dB - max(mag_X_dB);
mag_Y_dB = mag_Y_dB - max(mag_Y_dB);

% Frequency vectors
F_x = (0:n_x-1)*(Fs/n_x);
F_y = (0:n_y-1)*(fs/n_y);

% Plotting in frequency-domain
figure;
hold on;
plot(F_x, mag_X_dB, 'b', 'DisplayName', '1000 Hz Sine Wave');
plot(F_y, mag_Y_dB, 'r', 'DisplayName', 'Audio signal');
xlabel('Frequency [Hz]');
ylabel('Magnitude [dB]');
title('1000 Hz Sine Wave vs Audio Signal in Frequency-Domain');
legend;
xlim([0, 3000]);
grid on;
hold off;