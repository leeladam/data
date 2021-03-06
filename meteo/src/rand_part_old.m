function [Learning Testing Validation] = rand_part(X, y, conc)
    ind1 = (y == 1);
    tmp = rand(size(ind1));
    rind1 = ind1 .* tmp;
    
    X_orig = X;
    
    X_mins = min(X, [], 1);    
    tmp1 = repmat(X_mins, size(X, 1), 1);
    X = X - tmp1;
    X_maxs = max(X, [], 1);
    tmp2 = repmat(X_maxs, size(X, 1), 1);
    X = X ./ (tmp2 / 2) - ones(size(X));
    
    ind_learning_pos = (rind1 > 0 & rind1 <= 0.6);
    ind_testing_pos = (rind1 > 0.6 & rind1 <= 0.8);
    ind_validation_pos = (rind1 > 0.8 & rind1 <= 1);
    
    num_learning = sum(ind_learning_pos);
    ind2 = (y == 0);
    rind2 = ind2 .*tmp;
    rat1 = num_learning / sum(ind2);
    ind_learning_neg = (rind2 > 0 & rind2 <= rat1);
    num_testing = sum(ind_testing_pos);
    rat2 = (num_learning + num_testing) / sum(ind2);
    ind_testing_neg = (rind2 > rat1 & rind2 <= rat2);
    num_validation = 4 * sum(ind_validation_pos);
    
    rat3 = (num_learning + num_testing + num_validation) / sum(ind2);
    ind_validation_neg = (rind2 > rat2 & rind2 <= rat3);

    ind_learning = logical(ind_learning_pos + ind_learning_neg);
    ind_testing = logical(ind_testing_pos + ind_testing_neg);
    ind_validation = logical(ind_validation_pos + ind_validation_neg);
    
    Learning = [X(ind_learning,:) X_orig(ind_learning,:) conc(ind_learning) y(ind_learning)];
    Testing = [X(ind_testing,:) X_orig(ind_testing,:) conc(ind_testing) y(ind_testing)];
    Validation = [X(ind_validation,:) X_orig(ind_validation,:) conc(ind_validation) y(ind_validation)];
    
    dlmwrite('train_mem.txt', Learning);
    dlmwrite('dev_mem.txt', Testing);
    dlmwrite('test_mem.txt', Validation);
    
    
end