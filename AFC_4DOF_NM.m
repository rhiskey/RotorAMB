%% ������ ��� ������� �� ��� � 4 ��������� ������� ������� �������


%% ������� ������
clc
clear all
close all
% ��������� ��� ������ �������
Eps=1e-5; %����� ������ ����� ��������
d_x=1e-8; %����������
%��������� ������� ��� ������� � 4�� ��������� �������
E=eye(8,8); 
Dx=d_x*E;

% var_IC_4DOF; % �������� ����������
IC_4DOF_new;
% options = odeset('AbsTol',1e-10);
options=[];

% ������� �� � �����
% for omega = 0.1 :0.1:0.5 
% omega=[2000:100:2100];
% nu=5000:10:1e4; % �������
nu = 0:100:4000;
% nu=(2*pi)/nu;
 tend =0.00001;
Tend=tend/St;
% tend=tend/St;
for nuNum =1 : length(nu) %old
% nuNum=0; %NEW

% for i_diode=0.1:2:50
%     nu=exp(i_diode*10);  %NEW
%     nuNum=nuNum+1   %NEW
%     tend=2*pi/nu(nuNum); %������������� �����
%     tend=tend/St;
%     T_scale=60/nu;
%     tend=tend/T_scale;
%     tend=2*pi/nu(nuNum);
%     tend=(60*tend)/nu;
    Xinit=x0(:);   
    EPS=1;
    J=zeros(8,8); %�������
%     p=(2*pi)/nu(nuNum);
    p_dim=nu*2*pi/Sw; %OLD
%     p_dim(nuNum)=nu*2*pi/Sw;

%     p_dim=nu/Sw;
%     omega_dim=omega;
%      omega=(2*pi*nu)/30;
%      p_dim=nu*2*pi/Sw;
     
     par=[Px_dim, Py_dim, Ax_dim, Ay_dim, Mx_dim, ...
     My_dim, Bx_dim, By_dim, p_dim(nuNum), e_dim,...
     omega_dim, gamma_dim, P1, omega_square, Pk, ...
     i0_dim, iax_dim, iay_dim, ibx_dim, iby_dim,...
     delta_dim, P2, a1_dim, a2_dim];
 
    while EPS>Eps
        [T, X] = ode23s(@ODE_MAGLEV_4DOF, [t0, Tend] , Xinit, options, par, C, Hs, G, Hd); %ode45
        Xend=X(end,:)'; %!!!!!!!!!!
        defect=(Xend-Xinit);
        disp('Freq = ') 
         disp(nu(nuNum)) %OLD:
%           disp (nuNum)
        for j=1:8
            [T1, x] = ode23s(@ODE_MAGLEV_4DOF, [t0, Tend] , Xinit+Dx(:,j), options, par, C, Hs, G, Hd);  %ode45
            xend=x(end,:)';%�������� ��������� ��� ����������� �������
            J(:,j)=(xend-Xend)/d_x;
%             disp(j)
        end
        DX=-inv(J-E)*defect;
        EPS=norm(DX);
        Xinit=Xinit+DX;    
        Amplitude (nuNum) = ((max(X(:,1))-min(X(:,1)))/2)^2; % ��������� �����������
        Amplitude2 (nuNum) = ((max(X(:,2))-min(X(:,2)))/2)^2; % ��������� �����������
        Amplitude4 (nuNum)=(Amplitude2 (nuNum)+(Amplitude (nuNum)))^(1/2); 
        
        Amplitude5 (nuNum) = (max(X(:,3))-min(X(:,3)))/2; % ��������� �����
        Amplitude6 (nuNum) = (max(X(:,4))-min(X(:,4)))/2; % ��������� �����
        Amplitude7(nuNum)=(Amplitude5 (nuNum)+(Amplitude6 (nuNum)))^(1/2); 
        disp('Amplitude ������� = ')
%         Amplitude4= Amplitude4/Sx;
        disp(Amplitude4 (nuNum))
        disp('Amplitude ���� = ')
         disp(Amplitude7 (nuNum))
        
    end
end

    %���
    %set freq = 0.1 Hz, �������� �������  ���� max amlitude 
    %     ���
    %set freq = 0.1 Hz, �������� �������  ���� ����


%% ��� - ������ ��� ������ ����������� ���������: (a ��� nu)
% Sw=100; %������� ������� ��������
% omega=omega/Sw;
% 

% figure('Name','��� ��� ������� ��������','Position', [100 100 900 600]);
% nu_interp = nu(1) : 0.001* (1 + nu(end) -nu(1)) : nu(end);
% Amplitude7_interp = interp1 (nu, Amplitude7,nu_interp, 'PCHIP');%Shape-preserving piecewise cubic interpolation. The interpolated value at a query point is based on a shape-preserving piecewise cubic interpolation of the values at neighboring grid points.	
% plot ( nu, Amplitude7, 'b', nu_interp , Amplitude7_interp , 'LineWidth', 1.5)
% grid on
% xlab = xlabel('\nu');
% ylab = ylabel('\alpha');
% set( [gca, xlab, ylab ], 'FontSize', 12);

% Amplitude4= Amplitude4/Sx;
% nu=(omega*30)/(2*pi);

figure('Name','��� ��� �������� ��������','Position', [100 100 900 600]);
nu_interp = nu(1) : 0.001* (1 + nu(end) -nu(1)) : nu(end);
Amplitude_interp = interp1 (nu, Amplitude4/Sx,nu_interp , 'PCHIP');%Shape-preserving piecewise cubic interpolation. The interpolated value at a query point is based on a shape-preserving piecewise cubic interpolation of the values at neighboring grid points.	
plot ( nu, Amplitude4, 'o', nu_interp , Amplitude_interp , 'LineWidth', 1.5)
grid on
xlab = xlabel('\nu');
ylab = ylabel('\itA');
set( [gca, xlab, ylab ], 'FontSize', 12);

figure('Name','��� ��� ������� ��������','Position', [100 100 900 600]);
nu_interp = nu(1) : 0.001* (1 + nu(end) -nu(1)) : nu(end);
Amplitude_interp = interp1 (nu, Amplitude7,nu_interp , 'PCHIP');%Shape-preserving piecewise cubic interpolation. The interpolated value at a query point is based on a shape-preserving piecewise cubic interpolation of the values at neighboring grid points.	
plot ( nu, Amplitude7, 'o', nu_interp , Amplitude_interp , 'LineWidth', 1.5)
grid on
xlab = xlabel('\nu');
ylab = ylabel('\itA');
set( [gca, xlab, ylab ], 'FontSize', 12);


% figure
% omega_interp = omega(1) : 0.001* (1 + omega(end) -omega(1)) : omega(end);
% Amplitude_interp = interp1 (omega, Amplitude5,omega_interp , 'PCHIP');%Shape-preserving piecewise cubic interpolation. The interpolated value at a query point is based on a shape-preserving piecewise cubic interpolation of the values at neighboring grid points.	
% plot ( omega, Amplitude5, 'o', omega_interp , Amplitude_interp , 'LineWidth', 1.5)
% grid on
% xlab = xlabel('\omega');
% ylab = ylabel('\itA');
% set( [gca, xlab, ylab ], 'FontSize', 12);
