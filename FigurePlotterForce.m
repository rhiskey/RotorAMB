function  FigurePlotterForce( T,Fa,Fext, parNum )
%FIGUREPLOTTER Summary of this function goes here
%   Detailed explanation goes here
figure

color_arr = {'b','r','k','g','y','m','c'};
colorNum = parNum  - floor(parNum / length(color_arr)) * length(color_arr);
if colorNum ==0
    colorNum =  1;
end
color = char(color_arr(1:colorNum));
plot(T, Fa, 'Color',color(colorNum), 'LineWidth', 1.5); hold on;
plot( T, Fext, 'k')
% Настройки графиков
grid on
xlab = xlabel('\tau');
ylab = ylabel('\itF_a, \itF_e_x_t');
set( [gca, xlab, ylab ], 'FontSize', 12);
minLim = min ( min(min(Fa,[],2)), min(min(Fext,[],2)));
maxLim = max ( max(max(Fa,[],2)), max(max(Fext,[],2)));
set(gca,'XLim',[min(min(T,[],2)),max(max(T,[],2))]*(1),...
    'YLim', [minLim, maxLim]*(1.5) );
legend('\itF_a','\itF_e_x_t')
clear parNum

end

