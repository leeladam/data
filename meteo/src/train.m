function [cost, acc_train, acc_dev, nn_params] = train(initial_nn_params, ...
                               input_layer_size, ...
                               hidden_layer_size, ...
                               num_labels, ...
                               X_train, y_train, ...
                               X_dev, y_dev, ...
                               lambda, maxIter)

    options = optimset('MaxIter', maxIter);

    % Create "short hand" for the cost function to be minimized
    costFunction = @(p) nnCostFunction(p, ...
                                       input_layer_size, ...
                                       hidden_layer_size, ...
                                       num_labels, X_train, y_train, lambda);

    % Now, costFunction is a function that takes in only one argument (the
    % neural network parameters)
    
    %[nn_params, cost] = fmincg_run(costFunction, initial_nn_params, options);
     [nn_params, cost] = fmincg(costFunction, initial_nn_params, options);

    % Obtain Theta1 and Theta2 back from nn_params
    Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                     hidden_layer_size, (input_layer_size + 1));

    Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                     num_labels, (hidden_layer_size + 1));
       
    pred = predict(Theta1, Theta2, X_train);

    acc_train = mean(double(pred == y_train)) * 100;   
    
    pred = predict(Theta1, Theta2, X_dev);

    acc_dev = mean(double(pred == y_dev)) * 100;   
end