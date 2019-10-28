%% Функция определения электромагнитной силы, возникающей в активном магнитном подвесе
function [ F ] = Force_4DOF(t, par, x_1,y_1,alpha_1,beta_1)
% function [ F ] = Force_4DOF(t, par, x_1,y_1)
%На вход
% par=[Px_dim, Py_dim, Ax_dim, Ay_dim, Mx_dim, ...
%      My_dim, Bx_dim, By_dim, p_dim, e_dim,...
%      omega_dim, gamma_dim, P1, omega_square, Pk, ...
%      i0_dim, iax_dim, iay_dim, ibx_dim, iby_dim,...
%      delta_dim, P2, a1_dim, a2_dim];

%Вектор внешних нагрузок
P=[ par(1)+par(3)*sin(par(9)*t); %частота внешних нагрузок p=par(9) 
    par(2)+par(4)*sin(par(9)*t);
    par(5)+par(7)*sin(par(9)*t);
    par(6)+par(8)*sin(par(9)*t);];
%Вектор обобщенных возмущающих сил
Qv=[       par(10)*cos(par(11)*t); %omega=par(11) частота вращения ротора, 
           par(10)*sin(par(11)*t);
           par(12)*(1-par(13))*cos(par(11)*t);
           par(12)*(1-par(13))*sin(par(11)*t)];
       
%Передаюм сюда Pk, i0, ix , ibx, iay, iby, delta, a1, a2;
%Здесь меняются x1,y1,alpha1,beta1
%  x_1=x(1), alpha_1==x(3), y_1=x(2), beta_1=x(4); 
Pk=par(15);
i0=par(16);
iax=par(17);
iay=par(18);
ibx=par(19);
iby=par(20);
delta=par(21);
P2=par(22);
a1=par(23);
a2=par(24);

%%
%Закон управления, изменения токов смещения iax, iay, ibx, iby 

%%
% p = [kp, a, nu]
% parametersExt = [pulseT, width]

%Силы со стороны АМП ------Simulink PID Controller
% Fa.x=Pk*(((i0+iax)/(delta-(x_1-a1*beta_1)))^2-((i0-iax)/(delta+(x_1-a1*beta_1)))^2);
% Fb.x=Pk*(((i0+ibx)/(delta-(x_1+a2*beta_1)))^2-((i0-ibx)/(delta+(x_1+a2*beta_1)))^2);
% Fa.y=Pk*(((i0+iay)/(delta-(y_1+a1*alpha_1)))^2-((i0-iay)/(delta+(y_1+a1*alpha_1)))^2);
% Fb.y=Pk*(((i0+iby)/(delta-(y_1-a2*alpha_1)))^2-((i0-iby)/(delta+(y_1-a2*alpha_1)))^2);
% (omega2/omega)*2*pi*t;

% a_p = 0.0;
% 4 разных частоты, 4 тока 
omega_iAx=30;
omega_iAy=30;
omega_iBx=10;
omega_iBy=10;

i.ax = i0*sin(omega_iAx*t);
i.ay =i0*sin(omega_iAy*t);
i.bx =i0*sin(omega_iBx*t);
i.by =i0*sin(omega_iBy*t);

% c=pid(3);
% step(feedback(c*ss(sys),1));
% c1=pid(3,0,8);
% step(feedback(c1*ss(sys),1));

%%-----притяжение активными магнитами
Fma.ax=Pk*(((i.ax)/(delta-(x_1-a1*beta_1)))^2-((i.ax)/(delta+(x_1-a1*beta_1)))^2);
Fma.ay=Pk*(((i.ay)/(delta-(y_1+a1*alpha_1)))^2-((i.ay)/(delta+(y_1+a1*alpha_1)))^2);
Fma.bx=Pk*(((i.bx)/(delta-(x_1+a2*beta_1)))^2-((i.bx)/(delta+(x_1+a2*beta_1)))^2);
Fma.by=Pk*(((i.by)/(delta-(y_1-a2*alpha_1)))^2-((i.by)/(delta+(y_1-a2*alpha_1)))^2);

% Fma.ax=Pk*(((i.ax)/(delta-x_1))^2-((i.ax)/(delta+x_1))^2);
% Fma.ay=Pk*(((i.ay)/(delta-y_1))^2-((i.ay)/(delta+y_1))^2);
% Fma.bx=Pk*(((i.bx)/(delta-x_1))^2-((i.bx)/(delta+x_1))^2);
% Fma.by=Pk*(((i.by)/(delta-y_1))^2-((i.by)/(delta+y_1))^2);

Pp =101;  %жc
%отталкивание постоянными магнитами ротора
Fmp.ax = Pp*(-((1)/(delta-(x_1-a1*beta_1)))^2+((1)/(delta+(x_1-a1*beta_1)))^2);
Fmp.ay = Pp*(-((1)/(delta-(y_1+a1*alpha_1)))^2+((1)/(delta+(y_1+a1*alpha_1)))^2);
Fmp.bx = Pp*(-((1)/(delta-(x_1+a2*beta_1)))^2+((1)/(delta+(x_1+a2*beta_1)))^2);
Fmp.by = Pp*(-((1)/(delta-(y_1-a2*alpha_1)))^2+((1)/(delta+(y_1-a2*alpha_1)))^2);

% Fmp.ax = Pp*(-((1)/(delta-x_1))^2+((1)/(delta+x_1))^2);
% Fmp.ay = Pp*(-((1)/(delta-y_1))^2+((1)/(delta+y_1))^2);
% Fmp.bx = Pp*(-((1)/(delta-x_1))^2+((1)/(delta+x_1))^2);
% Fmp.by = Pp*(-((1)/(delta-y_1))^2+((1)/(delta+y_1))^2);

Fa.x=Fma.ax+Fmp.ax;
Fb.x=Fma.bx+Fmp.bx;
Fa.y=Fma.ay+Fmp.ay;
Fb.y=Fma.by+Fmp.by;
%%---


% %Вектор сил со стороны ротора привед. к центру масс системы
R=[Fa.x+Fb.x;...
    Fa.y+Fb.y;...
    a1*P2*Fa.y-a2*P2*Fb.y;...
    -a1*P2*Fa.x+a2*P2*Fb.x];

% для нахождения передат ф-ии прикладываем единич силу e^i*w
% omega = par(11);
% R=exp(1i*omega);

%-------- Внешнее возмущение
% if nargin == 5 && ~isempty(find(pulseT ~= 0,1))
%     Fext = 0.3* pulstran (t, pulseT , 'rectpuls', width); % ступенчатый импульс
% elseif nargin ~= 5 || isempty(find(pulseT ~= 0,1))
%     Fext = 0;
% end

%omega^2=par(14)
% Суммарная сила
F = P + R + (par(11)^2)*Qv;
   
%FORCE Summary of this function goes here
%   Detailed explanation goes here
% %   Для начального положения объекта:
%       clear all; var_IC;
%       t = t0: 0.05: tend/2; x = 0; p = [kp a nu(end)];
%       [ F, Fa, Fp ]=Force( t, x, p); plot ( t, Fa, 'LineWidth', 2 );
%       или
%       [ F, Fa, Fp, Fext ]=Force( t, x, p, pulseT{end}, width(end)); plot ( t, Fa, t, Fext, 'LineWidth', 2 ); 



end

