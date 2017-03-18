clc;
clear all;
close all;

%% ================ Part 1: Tune hyeerparams ================
%% Setup the parameters
num_labels = 2;                             % 2 labels, from 0 to 1   
lambdas = [0];
hidden_layer_size = 60;
maxIter = 3000;
v = [7:36, 44:69, 77:102];
input_layer_size  = length(v);              % input feats
output_file_name = strcat('../output/preds_with_timestamps.csv');

%% =========== Part 2: Loading Data =============

% Load Training Data
fprintf('Loading Data ...\n')

data_train = load('../input/convdate_mem_train_reorg.txt');
X_train = data_train(:, v);
y_train = data_train(:, size(data_train,2));
y_train = ones(size(y_train)) + y_train;

data_dev = load('../input/convdate_mem_dev_reorg.txt');
X_dev = data_dev(:, v);
y_dev = data_dev(:, size(data_dev,2));
y_dev = ones(size(y_dev)) + y_dev;

data_test = load('../input/convdate_mem_test_reorg.txt');
X_test = data_test(:, v);
y_test = data_test(:, size(data_test,2));
y_test = ones(size(y_test)) + y_test;

load('../output/thetas.mat')
Theta1 = s.theta1;
Theta2 = s.theta2;

%% =========== Part 3: Prediction =============

pred_train = predict(Theta1, Theta2, X_train);
pred_dev = predict(Theta1, Theta2, X_dev);
pred_test = predict(Theta1, Theta2, X_test);

cols = [105:110];

train_res = data_train(:, cols);
train_res = [train_res y_train - ones(size(y_train)) ...
    pred_train-ones(size(pred_train)) zeros(size(train_res, 1), 1)];
train_acc = mean(double(pred_train == y_train)) * 100;
fprintf('Train accuracy: %4.2f %%\n', train_acc);

dev_res = data_dev(:, cols);
dev_res = [dev_res y_dev - ones(size(y_dev)) ...
    pred_dev-ones(size(pred_dev)) ones(size(dev_res, 1), 1)];
dev_acc = mean(double(pred_dev == y_dev)) * 100;
fprintf('Development accuracy: %4.2f %%\n', dev_acc);

test_res = data_test(:, cols);
test_res = [test_res y_test - ones(size(y_test)) ...
    pred_test-ones(size(pred_test)) ones(size(test_res, 1), 1)*2];
test_acc = mean(double(pred_test == y_test)) * 100;
fprintf('Test accuracy: %4.2f %%\n', test_acc);

result = [train_res; dev_res; test_res];
result_ord = sortrows(result, 1);

csvwrite(output_file_name, result_ord);

