function [dx ] = ODE_MAGLEV_4DOF( t, x, par,C,Hs,G,Hd)

%Передаем в Force значение x_1=x(1), alpha_1==x(3), y_1=x(2), beta_1=x(4); == x(1), x(2) , x(3),
%x(4)
% 
F = Force_4DOF(t,par,x(1),x(2),x(3),x(4));
%  F = Force_4DOF(t,par,x(1),x(2));
omega_dim=par(11);

%A = [zeros(4), eye(4); -inv(m)*k, -inv(m)*d];
% A = [zeros(4), eye(4); C+omega_dim*Hs, omega_dim*G+Hd];
A = [zeros(4), eye(4); C+Hs, (omega_dim*G)+(Hd/omega_dim)];
% В-р состояния = [перем; скор] F-внеш силы, P+R+Q

% Вычисляет Z'=AZ+B
Z=[x(1);x(2);x(3);x(4);x(5);x(6);x(7);x(8)];

dx = A*[x(1);x(2);x(3);x(4);x(5);x(6);x(7);x(8)] + [zeros(4,1);F];
% dx = A*[x(1);x(2);x(3);x(4);x(5);x(6);x(7);x(8)];


end
