%% ������� ������������ ����������

t0 = 0; tend =0.001; %�, ����� ��� ��������
%---------------------------------------

%%������������� x0
%%
%-----��������� ���������------------------
nu=1e4; % rpm 1e4 ������� �������� ��������� � ��.��� = w=omega
p=0;  % ��, ������� �������� �����������, ���������
% w=1017; % s^-1, ������� �������� ������ � 1017 ���/c �������� 10000 ��/���
w=(pi*nu)/30;
omega=w; %��������������
omega_square=w^2;
T0 = 2*pi / 1; % ������ ����������� ���������

a1=9*1e-3; %�, ����� ��������� ���1
a2=9*1e-3; %�, ����� ��������� ���2
lm=0.004; %�, ����� �.���������
l=22*1e-3; % m,����� ������
r=7.7*1e-3; % m,������ ������
h=0.2*1e-3; % m, ����� ����� ������� � ���
% tolsh=0.003; %��, ������� ������ ������

e=0; %4.27*1e-7; % m, �������������� ???

delta_dim=h; %��������� ������������ �������� ������
h=0.2*1e-3; % m, ����� ����� ������� � ���
m=(12.42*1e-3)/4;%��,����� �.�. ????
cm=6000;%�*�^-1 ��������� ����������������
m2=12.42*1e-3; %��, ����� ������

gamma=2.15*1e-5; %2.15*1e-5; %m2*e^2; %��������, ��� m- ����� ������! 2.15*1e-5 ���
cw=0.91; %����������� ������������� ����� ����� � �����
etta=0.003;% ��*� ,������������ �������� ����� ��*�
P_e=100;% ��, �������� ������������� ���������???
R_e=40; %��, ������������� ������� ???????
Iz=3.78*1e-7; % ��*�^2, ������ ������� �������  ������ ������������ ������ ����
Ix=6.9*1e-7; %kg*m^2 ������ ������� �������  ������ ������������ ��� X
ksi2=0.3926991; %��� ,���� ���������� ��������� ���� �� ���������/����������� ������ 22,5�
mu0=4*pi*1e-7; %�*��*�^(-2)*�^(-2), ��������� ���������� 
n=100; %����� ������ ������� ????????
A=1e-6; %�^2, ������� ������� , ��������� �������� ?????

ka=(mu0*n^2*A)*cos(ksi2)/2;%�������������� �������� �.�.  0.202
ka=0.202;

kb=ka;%�� �������

%����������� ���� ��� � ��������������� ������������
i0=0;%0.000001;  %A,i_0=i_max/2 ???
ia.x=0; %�, ���� �������� � ���� ���������  ?????
ia.y=0; %�, ���� �������� ????
ib.x=0; %�, ���� �������� ????
ib.y=0; %�, ���� ��������????

%������� ���������� � �������
Mx=0; %0.03;% �*�, ????????
My=Mx;
Px=Mx/2/r; %�,
Py=Px;

%��������� ������� ��������
Ax=1e-3; %1e-3; %m
Ay=Ax; %m
Bx=2*Ax; %m
By=2*Ax; %m

%-----------��������------------------
Si=0.2;%������� ����� ???????? ������ �� P_e/R_e
Sl=l; %  ������� �����
Sf=h*cm; %  ������� ����  
Sm=2*pi*nu*r^3*l*etta/(30*h); %������� �������� Ix*(h/l)*cm/m

% St=60/nu;
% St=2*pi/omega; %������� ������� 60/nu
St=sqrt(m/cm); %������� �� �������
Sw=1/St; %������� ������� ��������
Sx=h; %������� ���������� ����������� ��� 
Sbeta=h/l; %������� ������� ���������� 

%%---------- ��������� �������----------
x1=h/2;
y1=h/4;
alpha1=0; %0.02 -max ���� ������� ������
beta1=0; %0.015
vx1=0; %0.1
vy1=0; %0.2
om1=0;
om2=0;

% Sx=h; %������� ���������� ����������� ��� 
% Sbeta=1*e-2; %������� ������� ���������� ????????????
% 
x1=x1/Sx;
y1=y1/Sx;
alpha1=alpha1/Sbeta;
beta1=beta1/Sbeta;
om1=om1/Sw;
om2=om2/Sw;

x0 = [x1, y1, alpha1, beta1,...
    vx1, vy1 , om1, om2]; % [4 �����., 4 ����.] 8 ����������

%------------������� � ������������ ���������--------
r_dim=r/Sl; 
h_dim=h/Sl;
l_dim=l/Sl;
lm_dim=lm/Sl;

Px_dim=Px/Sf;
Py_dim=Py/Sf;
Mx_dim=Mx/Sm;
My_dim=My/Sm;
Ax_dim=Ax/Sf;
Ay_dim=Ay/Sf;
Bx_dim=Bx/Sm;
By_dim=By/Sm;

delta_dim=delta_dim/Sx;
e_dim=e/Sx;

% Fax_dim=Fax/Sf;
% Fay_dim=Fay/Sf;
% Fbx_dim=Fbx/Sf;
% Fby_dim=Fby/Sf;

%t_dim=t/St;
a1_dim=a1/Sl;
a2_dim=a2/Sl;

omega_dim=omega/Sw;
p_dim=p/Sw;
gamma_dim=gamma/Sbeta;

%������������ ����
i0_dim=i0/Si;
iax_dim=ia.x/Si;
iay_dim=ia.y/Si;
ibx_dim=ib.x/Si;
iby_dim=ib.y/Si;

%-----------�������� �������------------------
Pn=(2*pi*cw*etta*r_dim^3*l^2*l_dim)/(h_dim*(m*cm)^(1/2)); %������������� 1.48*1e-7
P1=Iz/Ix; %0.548 P1=
P2=(m*l^2)/Ix; %8.714
Pk=ka*P_e/(cm*R_e*delta_dim^3); %�������������� ��������� ��� 10^5

%%----------���������� �������---------------

%������������
km=((lm_dim)^2)/(3*(a1_dim+a2_dim)^2); %����������� ������������
Km=((a1_dim)^2+(a2_dim)^2)*(1+km)-2*a1_dim*a2_dim*(1-km);
%������� ���������
C=[ 1 0 0 (-a1_dim+a2_dim)/2;
    0 1 (a1-a2)/2 0;
    0 (P2*(a1_dim-a2_dim))/2 (P2*Km)/4 0;
    (P2*(-a1_dim+a2_dim))/2 0 0 (P2*Km)/4];
%������������ �����
Hs=[0 0 0 Pn;
    0 0 -Pn 0;
    0 0 0 0;
    0 0 0  0];
%��������������� �������
G=[0 0 0 0;
    0 0 0 0;
    0 0 0 -P1;
    0 0  P1 0];
%
Hd=[0 0 -Pn 0;
    0 0 0 -Pn;
    0 0 0 0;
    0 0 0 0];

%������� ��������
Zb=[1 0 0 -a1_dim;
    0 1 a1_dim 0;
    1 0 0 a2_dim;
    0 1 -a2_dim 0];
%---------------------------------


%-----------TEST---------------------------
% a = .3*1 : 0.01 : 1.5; % �-� ������������������ ��������� ���� ����
a = 0.3;
%nu = 0.1: 0.1: 1.4; % ������� �����������
kp = [0.1 : 0.1 : 1.2]; % �-� �������������� �������� = kp_dim/(4*i0^2*k)
% ��������� �������� ����������� (��), � ������� ����������� ������� nu
T0 = 2*pi / 1; % ������ ����������� ���������
aext = 0.2; % ���� �������, � ������� ������� ��
for nuNum = 1 : length(nu)
    
    Text = 2*pi / nu(nuNum); % ������ ��
    pulseT{ nuNum } = [0 : Text : tend]; % ������� �������, � ������� ���������� ������� �����������
    width(nuNum) = aext* Text ; % ������ �������� �������� � ����� T0 ��� Text ??? -> ��������� vs �����������
    
    % ������� ������� ����������� - ���������������� � ������ �������
    % ������� ����
    pulseT{ nuNum } = 0;
    width(nuNum) = 0;
end
%% 
% FOR PD-Controller

% k.sab, k.iab - ������������ ����������, m2-����� ������
%����� ��������:
% P.a=(-2*k.sab/k.iab);
% P.a=P.b;
% D.a=(sqrt(-m2*k.sab/2)/k.iab);
% D.a=D.b;
% P_cont=[P.a 0 0 0;0 P.b 0 0; 0 0 P.a 0; 0 0 0 P.b];
% D_cont=[D.a 0 0 0;0 D.b 0 0;0 0 D.a 0; 0 0 0 D.b];