clear all;
close all;
clc;

Train = load('train.txt');
Dev = load('dev.txt');
Test = load('test.txt');

m = size(Train, 2);
m1 = (m-2)/2;
m2 = m1*2;

ind = [2 4 6:31];

v = [ind, ind+m1*(ones(size(ind))),  m-1, m];

Train_new = Train(:,v);
Dev_new = Dev(:,v);
Test_new = Test(:,v);

dlmwrite('train_mod.txt', Train_new);
dlmwrite('dev_mod.txt', Dev_new);
dlmwrite('test_mod.txt', Test_new);
