% This script assumes these variables are defined:
%
%   input - input data.
%   output - target data.

inputs = double(input);
targets = output;

% Create a Fitting netRGB2HSVwork
hiddenLayerSize = hiddenSizeHSV2RGB;
netRGB2HSV = fitnet(hiddenLayerSize);

% Choose Input and Output Pre/Post-Processing Functions
% For a list of all processing functions type: help nnprocess
netRGB2HSV.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
netRGB2HSV.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};


% Setup Division of Data for Training, Validation, Testing
% For a list of all data division functions type: help nndivide
netRGB2HSV.divideFcn = 'dividerand';  % Divide data randomly
netRGB2HSV.divideMode = 'sample';  % Divide up every sample
netRGB2HSV.divideParam.trainRatio = 70/100;
netRGB2HSV.divideParam.valRatio = 15/100;
netRGB2HSV.divideParam.testRatio = 15/100;

% For help on training function 'trainlm' type: help trainlm
% For a list of all training functions type: help nntrain
netRGB2HSV.trainFcn = 'trainlm';  % Levenberg-Marquardt

% Choose a Performance Function
% For a list of all performance functions type: help nnperformance
netRGB2HSV.performFcn = 'mse';  % Mean squared error

% Choose Plot Functions
% For a list of all plot functions type: help nnplot
netRGB2HSV.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};


% Train the netRGB2HSVwork
netRGB2HSV.trainParam.goal = cel_nauki;
netRGB2HSV.trainParam.epochs = ilosc_cylki_uczacych;
[netRGB2HSV,tr] = train(netRGB2HSV,inputs,targets);

% Test the netRGB2HSVwork
outputs = netRGB2HSV(inputs);
errors = gsubtract(targets,outputs);
performance = perform(netRGB2HSV,targets,outputs)

% Recalculate Training, Validation and Test Performance
trainTargets = targets .* tr.trainMask{1};
valTargets = targets  .* tr.valMask{1};
testTargets = targets  .* tr.testMask{1};
trainPerformance = perform(netRGB2HSV,trainTargets,outputs)
valPerformance = perform(netRGB2HSV,valTargets,outputs)
testPerformance = perform(netRGB2HSV,testTargets,outputs)

% View the netRGB2HSVwork
%view(netRGB2HSV)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, plotfit(netRGB2HSV,inputs,targets)
%figure, plotregression(targets,outputs)
%figure, ploterrhist(errors)