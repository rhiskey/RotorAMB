function FigurePlotterSurf( x, y, z, xlab, ylab, zlab )
%FIGUREPLOTTERSURF Summary of this function goes here
%   Detailed explanation goes here

x_interp = x(1) : 0.005* (1 + x(end) - x(1)) : x(end);
y_interp =  y(1) : 0.005* (1 + y(end) - y(1)) : y(end);
[ x_interp_surf, y_interp_surf ] = meshgrid (x_interp, y_interp );
Amplitude_interp_surf = interp2 (x, y, z, x_interp_surf, y_interp_surf , 'cubic');

% Вывод графика
figure
surf (x_interp_surf, y_interp_surf, Amplitude_interp_surf, 'EdgeColor', 'none','FaceLighting','phong')

set( [gca, xlabel(xlab), ylabel(ylab), zlabel(zlab)], 'FontSize', 12);

end

