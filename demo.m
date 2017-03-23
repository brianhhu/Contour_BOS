%{
Basic demo of a recurrent neural network that performs contour integration and border ownership
assignment. Simply run demo.m to start. This code was inspired by the code for the paper "Mechanisms
of perceptual organization provide auto-zoom and auto-localization for attention to objects," which
was written by Stefan Mihalas (Johns Hopkins University, 2011). Parts of this code are also borrowed
with permission from Danny Jeck, who rewrote Stefan's original code. If you have questions about the
code, feel free to contact me at: bhu6 (AT) jhmi (DOT) edu.
%}

clc
addpath('mfiles');

%% 1) Contour integration

% Run the model on a 1-bar contour (noise)
cont_1 = testScript(0,'contour',1,1,0,0,0,0,0);

% Run the model on a 7-bar contour
cont_7 = testScript(0,'contour',1,7,0,0,0,0,0);

% Run the model on a jittered contour
cont_jit = testScript(0,'jitter',1,7,0,0,0,0,0);

% Display results


%% 2) Border ownership assignment

% Run the model on a square image without attention
square_nonoise = testScript(0,'figure',0,0,0,0,0,0,0);

% Run the model on a noisy square input with attention
square_noise_att = testScript(0,'figure',0,0,0,0,1,0,1);

% Display results