function [ForceOrMoment] = getForceOnRPMandFlow(RPM_comb, plotdata, RPM_find)


%% Fit: 
[xData, yData] = prepareCurveData( RPM_comb, plotdata );

% Set up fittype and options.
ft = 'splineinterp';

% Fit model to data.
fitresult = fit( xData, yData, ft, 'Normalize', 'on' );

% find point
index=find(xData==RPM_find);
% Y_point = yData(index);
% get point from fit
% Y_point = fitresult(RPM_find);
Y_point = feval(fitresult,RPM_find);
% X_point = fitresult(Y_point);
% index2 = find(fitresult(RPM_find))

hold on
%See graphically
h = plot( fitresult, xData, yData );
h1 = plot(fitresult, RPM_find, Y_point, 'o');
legend( '»сходные частоты', ' убическа€ интерпол€ци€','«аданна€ частота',' убическа€ интерпол€ци€', 'Location', 'best', 'Interpreter', 'none' );
% plot(fitresult,X_point, Y_point, 'o');
% curvefit(RPM_find);
xlabel( 'RPM', 'Interpreter', 'none' );
ylabel( 'Force or Moment', 'Interpreter', 'none' );
grid on
hold off

ForceOrMoment = Y_point;
% Plot fit with data.
% figure( 'Name', ' убическа€ интерпол€ци€' );
% h = plot( fitresult, xData, yData );
% legend( h, 'plotdata vs. RPM', ' убическа€ интерпол€ци€', 'Location', 'NorthEast', 'Interpreter', 'none' );
% % Label axes
% xlabel( 'RPM_comb', 'Interpreter', 'none' );
% ylabel( 'plotdata', 'Interpreter', 'none' );
% grid on
% 

