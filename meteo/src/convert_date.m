clear all;
close all;
clc;

Train = load('train_mem.txt');
Dev = load('dev_mem.txt');
Test = load('test_mem.txt');

hp = [0 31 28 31 30 31 30 31 31 30 31 30];

%%train
Month = Train(:,103);
Day = Train(:,104);
Hour = Train(:,105);

v_train = [];

for i = 1 : length(Month)
    tmp = sum(hp(1:Month(i))) + Day(i);
    v_train = [v_train; tmp];
end



t1_train = sin((2*pi*v_train)/365);
t2_train = cos((2*pi*v_train)/365);
t3_train = sin((2*pi*Hour)/24);
t4_train = cos((2*pi*Hour)/24);

%%dev
Month = Dev(:,103);
Day = Dev(:,104);
Hour = Dev(:,105);

v_dev = [];

for i = 1 : length(Month)
    tmp = sum(hp(1:Month(i))) + Day(i);
    v_dev = [v_dev; tmp];
end

t1_dev = sin((2*pi*v_dev)/365);
t2_dev = cos((2*pi*v_dev)/365);
t3_dev = sin((2*pi*Hour)/24);
t4_dev = cos((2*pi*Hour)/24);


%%test
Month = Test(:,103);
Day = Test(:,104);
Hour = Test(:,105);

v_test = [];

for i = 1 : length(Month)
    tmp = sum(hp(1:Month(i))) + Day(i);
    v_test = [v_test; tmp];
end

t1_test = sin((2*pi*v_test)/365);
t2_test = cos((2*pi*v_test)/365);
t3_test = sin((2*pi*Hour)/24);
t4_test = cos((2*pi*Hour)/24);

%%write columns into files

[Train_new, Dev_new, Test_new] = append_new_variable(t1_train, t1_dev, t1_test, Train, Dev, Test, 'convdate_mem');
[Train_new, Dev_new, Test_new] = append_new_variable(t2_train, t2_dev, t2_test, Train_new, Dev_new, Test_new, 'convdate_mem');
[Train_new, Dev_new, Test_new] = append_new_variable(t3_train, t3_dev, t3_test, Train_new, Dev_new, Test_new, 'convdate_mem');
[Train_new, Dev_new, Test_new] = append_new_variable(t4_train, t4_dev, t4_test, Train_new, Dev_new, Test_new, 'convdate_mem');

%[Train_new, Dev_new, Test_new] = append_new_variable(v_train, v_dev, v_test, Train, Dev, Test, 'convdate365');
