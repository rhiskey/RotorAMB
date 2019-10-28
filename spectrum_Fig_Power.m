function [fg,Yg, Pow_eta] = spectrum_Fig_Power(t,x,Ntrand,Fig,eta_Power)

%‘”Ќ ÷»я [f,Y] = spectr(t,x,Ntrand) возврашает
%   вектор частот f от 0 до чаcтоты Ќайквиста и
%   вектор амплитуд Y
%   для сигнала X(t), 
%   полученного из заданного сигнала x(t)
%   вычитанием полиномиального тренда степени Ntrand
%   X(t) = x(t)-Trand(t,Ntrand).
%   fe - частота отсчета сигнала x(t)
%   eta_Power*100 - дол€ енергии сигнала (в процентах),
%       которой соответствует представленный амплитудный спектр
%   ¬ектор t должен иметь постоянный шаг dt
%   EXAMPLE:
% f=20;t=0:.001:2;c=2*pi;x=sin(c*f*t)+2*sin(2*c*f*t+.2)+randn(size(t));
% [f,Y] = spectrum_Fig_Power(t,x,0,1,1);

 MEAN=mean(x);x=x-MEAN;
 
 P=polyfit(t,x,Ntrand); Trand=polyval(P,t);
 
 X=x-Trand;
 
 N=length(X); Nf=round(N/2);
 
 dt=mean(diff(t));
 
 % „астота опроса
 fe=1/dt;

 % Ѕыстрое преобразование ‘урье
 fftX=fft(X);     

 % јмплитуды гармоник Y(i) для частот f(i) = i*1/(max(t)-min(t)
 
 A=abs(fftX);
 Y=A(1:Nf)/Nf; LY=length(Y);
  % —пектр частот
 f=[0:Nf-1]*fe/N; %%%%%%%%%%%%%%%%%%%%
 
 Pow_Y=sum(Y.*Y);
 Pow_eta=0;
 j=0;
%  while Pow_eta<=eta_Power*Pow_Y
%      j=j+1;
%      if j==LY
%          break
%      else
%          Pow_eta=Pow_eta+Y(j)*Y(j);
%      end
%  end
%  fg=f(1:j);Yg=Y(1:j);
fnum = 10;
for j = 1 : fnum
    Pow_eta=Pow_eta+Y(j)*Y(j);
end
fg=f(1:fnum);Yg=Y(1:fnum);
     

%  % ѕредставление
%  if Fig==0
%      return
%  else
%      figure('Name',' signal presentation')
%      subplot(2,1,1)
%      plot(t,Trand)
%      xlabel('\bft, [s]')
%      ylabel(['\bfTrand[t, ',int2str(Ntrand),']'])
% 
%      subplot(2,1,2)
%      plot(t,X)
%      xlabel('\bft, [s]')
%      ylabel(['\bfx - Trand[t, ',int2str(Ntrand),']'])
%  
%      figure('Name','F F T (x(t)-Trand(t))')
%      subplot(2,1,1)
%      plot(t,X)
%      xlabel('\bft, [s]')
%      ylabel(['\bfx - Trand[t, ',int2str(Ntrand),']'])
%      title(['\bf',num2str(eta_Power*100),' % of Signal Power presented'] )
%     
%      subplot(2,1,2)   
% %      h=stem(fg*2*pi,Yg,'fill');
%      h=stem(fg,Yg,'fill');
%      set(get(h,'BaseLine'),'LineStyle','-');
%      set(h,'MarkerFaceColor','red');
% %      xlabel('\bfFrequence, [1/s]')
%      xlabel('\bfFrequence, [Hz]')
%      ylabel('\bfMagnitude[x]')
%      title(['\bfa_{ 0} = ',num2str(MEAN)],'HorizontalAlignment','Right');
%      grid
 end

