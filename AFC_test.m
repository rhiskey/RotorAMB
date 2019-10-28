lpFilt = designfilt('lowpassfir','PassbandFrequency',0.25, ...
         'StopbandFrequency',0.35,'PassbandRipple',0.5, ...
         'StopbandAttenuation',65,'DesignMethod','kaiserwin');
fvtool(lpFilt)
dataIn = rand(1000,1);
dataOut = filter(lpFilt,dataIn);

b = fir1(80,0.5,kaiser(81,8));
freqz(b,1);
% [h,w] = freqz(b,a,l,'whole')