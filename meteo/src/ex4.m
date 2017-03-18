
%% Initialization
clear ; close all; clc

%% Setup the parameters you will use for this exercise
hidden_layer_size = 46;                     % 25 hidden units
maxIter = 1500;                             % max iters
lambda = 0;                                 %
num_labels = 2;                             % 10 labels, from 1 to 10   
                                            % (note that we have mapped "0" to label 10)
v = [6:36];
input_layer_size  = length(v);              % 20x20 Input Images of Digits

%% =========== Part 1: Loading and Visualizing Data =============
%  We start the exercise by first loading and visualizing the dataset. 
%  You will be working with a dataset that contains handwritten digits.
%

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')

data = load('train_f.txt');
% X_train = [data(:,col1) data(:,col2) data(:,col3) data(:,col4)];
X_train = data(:, v);
y_train = data(:, size(data,2));
y_train = ones(size(y_train)) + y_train;

data = load('dev_f.txt');
% X_dev = [data(:,col1) data(:,col2) data(:,col3) data(:,col4)];
X_dev = data(:, v);
y_dev = data(:, size(data,2));
y_dev = ones(size(y_dev)) + y_dev;

data = load('test_f.txt');
% X_test = [data(:,col1) data(:,col2) data(:,col3) data(:,col4)];
X_test = data(:, v);
y_test = data(:, size(data,2));
y_test = ones(size(y_test)) + y_test;

m_train = size(X_train, 1);

% fprintf('Program paused. Press enter to continue.\n');
% pause;


%% ================ Part 2: Loading Parameters ================
% In this part of the exercise, we load some pre-initialized 
% neural network parameters.

%% ================ Part 3: Compute Cost (Feedforward) ================
%  To the neural network, you should first start by implementing the
%  feedforward part of the neural network that returns the cost only. You
%  should complete the code in nnCostFunction.m to return cost. After
%  implementing the feedforward to compute the cost, you can verify that
%  your implementation is correct by verifying that you get the same cost
%  as us for the fixed debugging parameters.
%
%  We suggest implementing the feedforward cost *without* regularization
%  first so that it will be easier for you to debug. Later, in part 4, you
%  will get to implement the regularized cost.
%
fprintf('\nFeedforward Using Neural Network ...\n')

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];


%% =================== Part 8: Training NN ===================
%  You have now implemented all the code necessary to train a neural 
%  network. To train your neural network, we will now use "fmincg", which
%  is a function which works similarly to "fminunc". Recall that these
%  advanced optimizers are able to train our cost functions efficiently as
%  long as we provide them with the gradient computations.

%
fprintf('\nTraining Neural Network... \n')

%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.

options = optimset('MaxIter', maxIter);


% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, X_train, y_train, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% fprintf('Program paused. Press enter to continue.\n');
% pause;


%% ================= Part 9: Visualize Weights =================
%  You can now "visualize" what the neural network is learning by 
%  displaying the hidden units to see what features they are capturing in 
%  the data.

fprintf('\nVisualizing Neural Network... \n')

%   displayData(Theta1(:, 2:end));

% fprintf('\nProgram paused. Press enter to continue.\n');
% pause;

%% ================= Part 10: Implement Predict =================
%  After training the neural network, we would like to use it to predict
%  the labels. You will now implement the "predict" function to use the
%  neural network to predict the labels of the training set. This lets
%  you compute the training set accuracy.

pred = predict(Theta1, Theta2, X_dev);

fprintf('\nDev Set Accuracy: %f\n', mean(double(pred == y_dev)) * 100);

pred2 = predict(Theta1, Theta2, X_train);

fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred2 == y_train)) * 100);


