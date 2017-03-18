train = load('convdate_train.txt');
dev = load('convdate_dev.txt');
test = load('convdate_test.txt');
%%

%histogram(sqrt(train(:,42).^2 + train(:,43).^2))
%histogram(train(:,42).^2 + train(:,43).^2)
%histogram(train(:,46).^(0.5))
%histogram(train(:,47).^2 + train(:,48).^2)
%histogram((train(:,47) + train(:,48)).^(1/3))
histogram(train(:,49).^(0.25))


