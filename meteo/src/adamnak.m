clc;
clear all;
close all;

%% ================ Part 1: Tune hyeerparams ================
%% Setup the parameters you will use for this exercise
num_labels = 2;             % 2 labels, from 0 to 1   
lambdas = [0];
hidden_layer_size = 60;
maxIter = 3000;
v = [7:36, 44:69, 77:102];
input_layer_size  = length(v);              % input feats
output_file_name = strcat('../output/adamnak.txt');

%% =========== Part 2: Loading Data =============

% Load Training Data
fprintf('Loading Data ...\n')

data = load('../input/convdate_mem_train_reorg.txt');
X_train = data(:, v);
y_train = data(:, size(data,2));
y_train = ones(size(y_train)) + y_train;

data = load('../input/convdate_mem_dev_reorg.txt');
X_dev = data(:, v);
y_dev = data(:, size(data,2));
y_dev = ones(size(y_dev)) + y_dev;

data = load('../input/convdate_mem_test_reorg.txt');
X_test = data(:, v);
y_test = data(:, size(data,2));
y_test = ones(size(y_test)) + y_test;

m_train = size(X_train, 1);


%% ================ Part 3: Train data ================

lambda = lambdas(1);

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

fprintf('hidden_layer: %d \t lambda: %d \t maxIter: %d\n', ...
   hidden_layer_size, lambda, j);
[cost, acc_t, acc_d, nn_params] = train(initial_nn_params, input_layer_size, ...
   hidden_layer_size, num_labels, X_train, y_train, ...
   X_dev, y_dev, lambda, maxIter);

%    following lambda factor
m = size(X_train, 1);
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
     hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
     num_labels, (hidden_layer_size + 1));
J_reg = lambda/2/m * (sum(sum(Theta1.^2)) + sum(sum(Theta2.^2)));

result = [[hidden_layer_size lambda j cost(length(cost)) J_reg acc_t acc_d]];
initial_nn_params = nn_params;
dlmwrite(output_file_name, result);

n1 = 'theta1';
n2 = 'theta2';
s = struct(n1, Theta1, n2, Theta2);

thetafile = '../output/thetas.mat';
save(thetafile, 's');



