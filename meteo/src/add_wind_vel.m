clc;
clear all;
close all;

Train =load('train.txt');
Dev =load('dev.txt');
Test =load('test.txt');

v_train = Train(:,31+7).^2 + Train(:,31+8).^2;
v_dev = Dev(:,31+7).^2 + Dev(:,31+8).^2;
v_test = Test(:,31+7).^2 + Test(:,31+8).^2;
str = 'wind2';

[Train_new, Dev_new, Test_new] = append_new_variable(v_train, v_dev, v_test, Train, Dev, Test, str);

