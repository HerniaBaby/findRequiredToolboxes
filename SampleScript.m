% Note:
% Embedding findRequiredToolboxes function within your own script will add "Simulink" to the list of required toolboxes.

clc, clear;
disp('This is Sample Code')

txt = findRequiredToolboxes(fullfile(pwd,"SampleScript.m"));
fprintf('This code needs %s \n',txt)