clear all;
close all;
clc;

train = load('convdate_train.txt');
dev = load('convdate_dev.txt');
test = load('convdate_test.txt');

%%Training
v1_train = sqrt(train(:,39 + 3).^2 + train(:,40 + 3).^2);
v2_train = train(:,43 + 3).^0.5;
v3_train = (train(:,44 + 3)+train(:,45 + 3));
v4_train = train(:,46 + 3).^0.25;
v5_train = sqrt(train(:,48 + 3).^2 + train(:,49 + 3).^2);
v6_train = sqrt(train(:,52 + 3).^2 + train(:,53 + 3).^2);

%%Dev
v1_dev = sqrt(dev(:,39 + 3).^2 + dev(:,40 + 3).^2);
v2_dev = dev(:,43 + 3).^0.5;
v3_dev = (dev(:,44 + 3)+dev(:,45 + 3));
v4_dev = dev(:,46 + 3).^0.25;
v5_dev = sqrt(dev(:,48 + 3).^2 + dev(:,49 + 3).^2);
v6_dev = sqrt(dev(:,52 + 3).^2 + dev(:,53 + 3).^2);

%%Test
v1_test = sqrt(test(:,39 + 3).^2 + test(:,40 + 3).^2);
v2_test = test(:,43 + 3).^0.5;
v3_test = (test(:,44 + 3)+test(:,45 + 3));
v4_test = test(:,46 + 3).^0.25;
v5_test = sqrt(test(:,48 + 3).^2 + test(:,49 + 3).^2);
v6_test = sqrt(test(:,52 + 3).^2 + test(:,53 + 3).^2);

%%writing new matrices
[Train_new, Dev_new, Test_new] = append_new_variable(v1_train, v1_dev, v1_test, train, dev, test, 'newvaris2');
[Train_new, Dev_new, Test_new] = append_new_variable(v2_train, v2_dev, v2_test, Train_new, Dev_new, Test_new, 'newvaris2');
[Train_new, Dev_new, Test_new] = append_new_variable(v3_train, v3_dev, v3_test, Train_new, Dev_new, Test_new, 'newvaris2');
[Train_new, Dev_new, Test_new] = append_new_variable(v4_train, v4_dev, v4_test, Train_new, Dev_new, Test_new, 'newvaris2');
[Train_new, Dev_new, Test_new] = append_new_variable(v5_train, v5_dev, v5_test, Train_new, Dev_new, Test_new, 'newvaris2');
[Train_new, Dev_new, Test_new] = append_new_variable(v6_train, v6_dev, v6_test, Train_new, Dev_new, Test_new, 'newvaris2');

