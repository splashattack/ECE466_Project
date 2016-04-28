%generateSampleWaveform - Generates a sample waveform lookup table and outputs in the
%form of a C include file

freq = 70:340;
Fs = 4000;
N = 4000;

k = round(0.5+(N*freq/Fs));
w = (2*pi/N)*k;
cosine = cos(w);
input = 2*cosine;

for i = 1:length(input)
    coeff(i) = GetFixedPoint(input(i), 16, 13);
end
outFile = fopen('coeffs.h','w+');
fprintf(outFile, '//coeffs.h\n');
fprintf(outFile, '//Auto-generated file that includes coefficients for georzel algorithm.\n');
fprintf(outFile, '#ifndef _COEFFS_H\n');
fprintf(outFile, '#define _COEFFS_H\n\n');
fprintf(outFile, 'static const long coeff[%u] =\n', length(coeff));
fprintf(outFile, '{\n');
for n = 1:length(coeff)
    fprintf(outFile, '    %i,\n', coeff(n)*(2^4));
end
fprintf(outFile, '};\n');
fprintf(outFile, '#endif\n\n');
fclose(outFile);