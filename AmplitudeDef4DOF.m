function [ Ampl ] = AmplitudeDef4DOF( displ )
%AMPLITUDEDEF Summary of this function goes here
%   Detailed explanation goes here

k_CutOff = 0.8; % к-т времени перехода на установившийся режим
displ_Range = displ ( floor(k_CutOff * end) : end ); % Время установившегося режима
Ampl = max (abs (displ_Range) ) - mean (displ_Range) ; % Амплитуда перемещений на установившемся режиме

end

