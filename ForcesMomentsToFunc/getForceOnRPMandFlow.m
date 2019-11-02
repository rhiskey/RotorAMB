function [ForceOrMoment] = getForceOnRPMandFlow(RPM_comb, plotdata, RPM_find)


%% Fit: 
[xData, yData] = prepareCurveData( RPM_comb, plotdata );

% Set up fittype and options.
ft = 'splineinterp';

% Fit model to data.
fitresult = fit( xData, yData, ft, 'Normalize', 'on' );

% find point
index=find(xData==RPM_find);
Y_point = feval(fitresult,RPM_find);

hold on
%See graphically
h = plot( fitresult, xData, yData );
h1 = plot(fitresult, RPM_find, Y_point, 'o');
legend( 'Исходные частоты', 'Кубическая интерполяция','Заданная частота','Кубическая интерполяция', 'Location', 'best', 'Interpreter', 'none' );
xlabel( 'RPM', 'Interpreter', 'none' );
ylabel( 'Force or Moment', 'Interpreter', 'none' );
grid on
hold off

ForceOrMoment = Y_point;


