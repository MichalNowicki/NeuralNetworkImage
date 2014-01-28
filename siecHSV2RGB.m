% This script assumes these variables are defined:
%
%   input - input data.
%   output - target data.

inputs = output;
targets = output2;

% Create a Fitting netHSV2RGBwork
hiddenLayerSize = hiddenSizeHSV2RGB;
netHSV2RGB = fitnet(hiddenLayerSize);

% Choose Input and Output Pre/Post-Processing Functions
% For a list of all processing functions type: help nnprocess
netHSV2RGB.inputs{1}.processFcns = {'removeconstantrows','mapminmax'};
netHSV2RGB.outputs{2}.processFcns = {'removeconstantrows','mapminmax'};


% Setup Division of Data for Training, Validation, Testing
% For a list of all data division functions type: help nndivide
netHSV2RGB.divideFcn = 'dividerand';  % Divide data randomly
netHSV2RGB.divideMode = 'sample';  % Divide up every sample
netHSV2RGB.divideParam.trainRatio = 70/100;
netHSV2RGB.divideParam.valRatio = 15/100;
netHSV2RGB.divideParam.testRatio = 15/100;

% For help on training function 'trainlm' type: help trainlm
% For a list of all training functions type: help nntrain
netHSV2RGB.trainFcn = 'trainlm';  % Levenberg-Marquardt

% Choose a Performance Function
% For a list of all performance functions type: help nnperformance
netHSV2RGB.performFcn = 'mse';  % Mean squared error

% Choose Plot Functions
% For a list of all plot functions type: help nnplot
netHSV2RGB.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
  'plotregression', 'plotfit'};


% Train the netHSV2RGBwork
netHSV2RGB.trainParam.goal = cel_nauki;
netHSV2RGB.trainParam.epochs = ilosc_cylki_uczacych;
[netHSV2RGB,tr] = train(netHSV2RGB,inputs,targets);

% Test the netHSV2RGBwork
outputs = netHSV2RGB(inputs);
errors = gsubtract(targets,outputs);
performance = perform(netHSV2RGB,targets,outputs)

% Recalculate Training, Validation and Test Performance
trainTargets = targets .* tr.trainMask{1};
valTargets = targets  .* tr.valMask{1};
testTargets = targets  .* tr.testMask{1};
trainPerformance = perform(netHSV2RGB,trainTargets,outputs)
valPerformance = perform(netHSV2RGB,valTargets,outputs)
testPerformance = perform(netHSV2RGB,testTargets,outputs)

% View the netHSV2RGBwork
%view(netHSV2RGB)

% Plots
% Uncomment these lines to enable various plots.
%figure, plotperform(tr)
%figure, plottrainstate(tr)
%figure, plotfit(netHSV2RGB,inputs,targets)
%figure, plotregression(targets,outputs)
%figure, ploterrhist(errors)