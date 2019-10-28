function [ Ampl ] = AmplitudeDef4DOF( displ )
%AMPLITUDEDEF Summary of this function goes here
%   Detailed explanation goes here

k_CutOff = 0.8; % �-� ������� �������� �� �������������� �����
displ_Range = displ ( floor(k_CutOff * end) : end ); % ����� ��������������� ������
Ampl = max (abs (displ_Range) ) - mean (displ_Range) ; % ��������� ����������� �� �������������� ������

end

