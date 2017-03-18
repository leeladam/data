data = load('convdate_mem_train_reorg.txt');
train_pred = [data pred2-ones(size(pred2))];

data = load('convdate_mem_dev_reorg.txt');
dev_pred = [data pred-ones(size(pred))];

data = load('convdate_mem_test_reorg.txt');
test_pred = [data pred3-ones(size(pred3))];