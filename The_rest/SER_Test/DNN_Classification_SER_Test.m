[~, XTrain, YTrain_categorical, ~, ~, ~, ~, ~] = Data_Generation(0.95, 30, 10000);

% Set up layers

DNN_Classification_Layers = [
    imageInputLayer([256 1 1],"Name","imageinput")
    fullyConnectedLayer(500,"Name","fc_1")
    reluLayer("Name","relu_1")  
    fullyConnectedLayer(250,"Name","fc_2")
    reluLayer("Name","relu_2")
    fullyConnectedLayer(120,"Name","fc_3")
    reluLayer("Name","relu_3")
    fullyConnectedLayer(16,"Name","fc_4")
    softmaxLayer("Name","softmax")
    classificationLayer('Name','classification')];

% Option settings
Options = trainingOptions('adam', ...
    'MaxEpochs',24, ...
    'MiniBatchSize',10, ...
    'InitialLearnRate',5e-4, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropFactor',0.4, ...
    'LearnRateDropPeriod',3, ...
    'Shuffle','every-epoch', ...
    'Verbose',1, ...
    'L2Regularization',0.005, ...
    'Plots','training-progress');

% Train Network
[DNN_Trained, info] = trainNetwork(XTrain, YTrain_categorical, DNN_Classification_Layers, Options);
[~, XTest, YTest_categorical, ~, ~, ~, ~, ~] = Data_Generation(1, 5, 10000);

Ypred = classify(DNN_Trained, XTest);

SER = sum(Ypred ~= YTest_categorical) ./ numel(YTest_categorical);
