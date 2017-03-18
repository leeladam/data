clc;
clear all;
close all;

%% ================ Part 1: Tune hyeerparams ================
%% Setup the parameters you will use for this exercise
num_labels = 2;             % 2 labels, from 0 to 1   
lambdas = [0];
hidden_layer_size_max = 46;
%itersMin = 20;
iterStep = 100;
itersMax = 6000;
layerStepSize = 5;
v = [1:4 6:31];
input_layer_size  = length(v);              % input feats


%% =========== Part 2: Loading Data =============

% Load Training Data
fprintf('Loading Data ...\n')

v = [1:4 6:31];

data = load('train.txt');
% X_train = [data(:,col1) data(:,col2) data(:,col3) data(:,col4)];
X_train = data(:, v);
y_train = data(:, size(data,2));
y_train = ones(size(y_train)) + y_train;

data = load('dev.txt');
% X_dev = [data(:,col1) data(:,col2) data(:,col3) data(:,col4)];
X_dev = data(:, v);
y_dev = data(:, size(data,2));
y_dev = ones(size(y_dev)) + y_dev;

data = load('test.txt');
% X_test = [data(:,col1) data(:,col2) data(:,col3) data(:,col4)];
X_test = data(:, v);
y_test = data(:, size(data,2));
y_test = ones(size(y_test)) + y_test;

m_train = size(X_train, 1);


%% ================ Part 3: Train data ================

result = [];

for hidden_layer_size = 1:layerStepSize:hidden_layer_size_max
    
    for i = 1:length(lambdas)
        lambda = lambdas(i);
        
        initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
        initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

        initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

        for j = iterStep:iterStep:itersMax
           maxIter = iterStep;

           fprintf('hidden_layer: %d \t lambda: %d \t maxIter: %d\n', ...
               hidden_layer_size, lambda, j);
           [cost, acc_t, acc_d, nn_params] = train(initial_nn_params, input_layer_size, ...
               hidden_layer_size, num_labels, X_train, y_train, ...
               X_dev, y_dev, lambda, maxIter);
           
           result = [result; [hidden_layer_size lambda j cost(length(cost)) acc_t acc_d]];
           initial_nn_params = nn_params;
        end
        dlmwrite('result.txt', result);
    end
end


%% ================ Part 4: Saving results ================

dlmwrite('result.txt', result);


