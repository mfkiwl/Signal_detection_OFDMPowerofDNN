% Power of Deep Learning for Channel Estimation and Signal Detection in OFDM Systems

function [DNN_Trained, Training_Info] = Train_DNN(XTrain, YTrain, XValidation, YValidation, Training_Set_Rate)

% Set up layers
Layers = [
    sequenceInputLayer(256,"Name","sequence")
    fullyConnectedLayer(500,"Name","fc_1")
    reluLayer("Name","relu_1")
    fullyConnectedLayer(250,"Name","fc_2")
    reluLayer("Name","relu_2")
    fullyConnectedLayer(120,"Name","fc_3")
    reluLayer("Name","relu_3")
    fullyConnectedLayer(16,"Name","fc_4")
    %softmaxLayer("Name","softmax")
    %classificationLayer("Name","classoutput")];
    regressionLayer("Name","regressionoutput")];

% Option settings
ValidationFrequency = ceil(1 / (1 - Training_Set_Rate));

Options = trainingOptions('rmsprop', ...
    'MaxEpochs',13, ...
    'MiniBatchSize',10, ...
    'InitialLearnRate',1e-3, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropFactor',0.8, ...
    'LearnRateDropPeriod',2, ...
    'ValidationData',{XValidation,YValidation}, ...
    'ValidationFrequency',ValidationFrequency, ...
    'Shuffle','every-epoch', ...
    'Verbose',1, ...
    'L2Regularization',0.003, ...
    'Plots','training-progress');

% Train Network
[DNN_Trained, Training_Info] = trainNetwork(XTrain,YTrain,Layers,Options);
%save('DNN_Trained.mat','DNN_Trained');
end