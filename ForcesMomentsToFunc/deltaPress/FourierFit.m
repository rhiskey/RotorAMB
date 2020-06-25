function [fitresult, gof] = FourierFit(AorticTime, AorticPressure)
%CREATEFIT1(AORTICTIME,AORTICPRESSURE)
%  Create a fit.
%
%  Data for 'FourierFit' fit:
%      X Input : AorticTime
%      Y Output: AorticPressure
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.

%  Auto-generated by MATLAB on 20-Apr-2020 16:10:06


%% Fit: 'FourierFit'.
[xData, yData] = prepareCurveData( AorticTime, AorticPressure );

% Set up fittype and options.
ft = fittype( 'fourier4' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.StartPoint = [0 0 0 0 0 0 0 0 0 0.00851957329787062];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'FourierFit' );
h = plot( fitresult, xData, yData );
legend( h, 'AorticPressure vs. AorticTime', 'FourierFit', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
xlabel( 'AorticTime', 'Interpreter', 'none' );
ylabel( 'AorticPressure', 'Interpreter', 'none' );
grid on

