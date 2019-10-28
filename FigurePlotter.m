function  FigurePlotter( T, X, Fa, parNum )
%FIGUREPLOTTER Summary of this function goes here
%   Detailed explanation goes here

figure
subplot(2,1,1)

color_arr = {'b','r','k','g','y','m','c'};
colorNum = parNum  - floor(parNum / length(color_arr)) * length(color_arr);
if colorNum ==0
    colorNum =  1;
end
color = char(color_arr(1:colorNum));
plot(T, X,'Color',color(colorNum), 'LineWidth', 1.5); hold on;
plot(T, Fa, 'k', 'LineWidth', 1.2)
% Настройки графиков
grid on
xlab = xlabel('\tau');
ylab = ylabel('\itx, \itF');
set( [gca, xlab, ylab ], 'FontSize', 12);
legend('Перемещение','Магнитная сила')
set(gca,'XLim',[0,max(max(T,[],2))]*(1+.0),...
                'YLim',[min(min(X(:,1),[],2)),max(max(X(:,1),[],2))]*(1.4));
clear parNum

end

