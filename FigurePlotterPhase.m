function  FigurePlotterPhase( X,Y, parNum )
%FIGUREPLOTTER Summary of this function goes here
%   Detailed explanation goes here
subplot(2,1,2)

color_arr = {'b','r','k','g','y','m','c'};
colorNum = parNum  - floor(parNum / length(color_arr)) * length(color_arr);
if colorNum ==0
    colorNum =  1;
end
color = char(color_arr(1:colorNum));
plot(X, Y, 'Color',color(colorNum), 'LineWidth', 1.5); hold on;
% Настройки графиков
grid on
xlab = xlabel('\itx');
ylab = ylabel('\itdx/dt');
set( [gca, xlab, ylab ], 'FontSize', 12);
set(gca,'XLim',[min(min(X,[],2)),max(max(X,[],2))]*(1.5),...
                'YLim',[min(min(Y,[],2)),max(max(Y,[],2))]*(1.5));
clear parNum

end

