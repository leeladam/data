% vectors must be columns!
function [Train_new, Dev_new, Test_new] = append_new_variable(v_train, v_dev, v_test, Train, Dev, Test, str)
% tmp = strcat(str, '_train.txt')
% Train = load(tmp);
% 
% tmp = strcat(str, '_dev.txt')
% Dev = load(tmp);
% 
% tmp = strcat(str, '_test.txt')
% Test = load(tmp);

concat =[v_train; v_dev; v_test];

%%normalisation
concat = concat - (min(concat) * ones(size(concat)));
concat = concat ./ ((max(concat) * ones(size(concat))) / 2) -ones(size(concat));

%give back vectors

v_train_norm = concat(1:length(v_train));
v_dev_norm = concat(length(v_train)+1:length(v_train)+length(v_dev));
v_test_norm = concat(length(v_train)+length(v_dev)+1 : length(concat));

%%only for already normalised data

v_train_norm = v_train;
v_dev_norm = v_dev;
v_test_norm = v_test;

%%

%get the new matrices
Train_new = [Train(:, 1:(size(Train,2)-2)/2), ...
                v_train_norm, ...
                    Train(:, (size(Train,2)-2)/2 + 1:size(Train,2)-2), ...
                        v_train, ...
                            Train(:, size(Train,2)-1:size(Train,2))];
                        
Dev_new = [Dev(:, 1:(size(Dev,2)-2)/2), ...
                v_dev_norm, ...
                    Dev(:, (size(Dev,2)-2)/2 + 1:size(Dev,2)-2), ...
                        v_dev, ...
                            Dev(:, size(Dev,2)-1:size(Dev,2))];
Test_new = [Test(:, 1:(size(Test,2)-2)/2), ...
                v_test_norm, ...
                    Test(:, (size(Test,2)-2)/2 + 1:size(Test,2)-2), ...
                        v_test, ...
                            Test(:, size(Test,2)-1:size(Test,2))];

    tmp = strcat(str, '_train.txt');
    dlmwrite(tmp, Train_new);
    
    tmp = strcat(str, '_dev.txt');
    dlmwrite(tmp, Dev_new);
    
    tmp = strcat(str, '_test.txt');
    dlmwrite(tmp, Test_new);
end