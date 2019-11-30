function [ForceOrMoment] = getForceOnRPMandFlow(RPM_comb, plotdata, RPM_find, flag)


%% Fit: 
[xData, yData] = prepareCurveData( RPM_comb, plotdata );

% Set up fittype and options.
ft = 'splineinterp';

% Fit model to data.
fitresult = fit( xData, yData, ft, 'Normalize', 'on' );

% find point
index=find(xData==RPM_find);
Y_point = feval(fitresult,RPM_find);


if flag ~= 0
    %See graphically
    hold on

    h = plot( fitresult, xData, yData );
    h1 = plot(fitresult, RPM_find, Y_point, 'o');
    legend( '�������� �������', '���������� ������������','�������� �������','���������� ������������', 'Location', 'best', 'Interpreter', 'none' );
    % plot(fitresult,X_point, Y_point, 'o');
    % curvefit(RPM_find);
    xlabel( 'RPM', 'Interpreter', 'none' );
    if flag == 1
    %     figure('Name','����������� ���� �� ������� �� �������� �������')
        ylabel( 'Force, N', 'Interpreter', 'none' );
    elseif flag == 2
    %     figure('Name','����������� ������� �� ������� �� �������� �������')
        ylabel( 'Moment, N*m', 'Interpreter', 'none' );  
    else
    ylabel( 'Force/Moment', 'Interpreter', 'none' );  
    end
    grid on
    hold off
    ForceOrMoment = fitresult;
end


ForceOrMoment = Y_point;

