function Main(FileName,FilePath,trainRatio,testRatio,valRatio,NNtype,trainf,hiddenlayer,trainingset)

% disp("userdata: " + userdataset);
% disp("groupdata: " + groupdataset);
% disp("Filename:" + FileName);
% disp("FIlePath:" + FilePath);

% 1 - traincgp | 2 - trainscg | 3- traincgb
if(trainf == 1)
    trainfunction = 'traincgp';
elseif(trainf == 2)
    trainfunction = 'trainscg';
else
    trainfunction = 'traincgb';
end


%Handle data for training. %TODO Other dataset.
%Loading Dataset;
if(FileName == "null")
   A = load('Dataset\44202.mat');
   P = A.FeatVectSel;
   T = A.Trg;
%  B = load('Dataset\63502.mat');
else
   C = load(fullfile(FilePath, FileName));
   P = C.FeatVectSel;
   T = C.Trg;
end

%Handle Target output for Classes.
if(trainingset == 1)
    %getting best entropy -> number of all classes are equal.
    [P,T] = EqualNumberClasses(P,T);
else
    %Raw data if wanna test. It's not recommended because the objective of the
    %project is to have a NN to detect Pre-Ictals , Ictals. The result will be
    %a incredible NN for detecting normal brain state (interictal).
    T = handleTarget(T);
end

%Transpose Input and Target.
T = T.';
P = P.';

%Creating NN
if(NNtype == 1) % normal feedfoward NN
    disp("Setting up Normal Feed Network! Please wait a few seconds to train...");
    net = feedforwardnet(hiddenlayer);
    net.trainParam.epochs = 1000;
    net.divideParam.trainRatio=trainRatio/100;
    net.divideParam.testRatio=testRatio/100;
    net.divideParam.valRatio=valRatio/100;
    net.trainFcn = trainfunction;
    net = train(net,P,T, 'useGPU', 'yes');
elseif(NNtype == 2) %Recurrent NN
    disp("Setting up recurrent Network! Please wait a few seconds to train...");
    net = layrecnet(1:2, hiddenlayer);
    net.trainParam.epochs = 1000;
    net.divideParam.trainRatio=trainRatio/100;
    net.divideParam.testRatio=testRatio/100;
    net.divideParam.valRatio=valRatio/100;
    net.trainFcn = trainfunction;
    net = train(net,P,T, 'useGPU', 'yes');
else %Elman feedforward NN (it's a recurrent NN with the addition of layer recurrent connections with tap delays
    disp("Setting up Elman Network! Please wait a few seconds to train...");
    net = elmannet(1:2, hiddenlayer);
    net.trainParam.epochs = 1000;
    net.divideParam.trainRatio=trainRatio/100;
    net.divideParam.testRatio=testRatio/100;
    net.divideParam.valRatio=valRatio/100;
    net.trainFcn = trainfunction;
    net = train(net,P,T, 'useGPU', 'yes');
end

%Testing with Raw Dataset

A = load('Dataset\44202.mat');
outSim = sim(net,A.FeatVectSel.');
% [sensi, speci, PreicPerc, IctalPerc, AC] = calcPerform(outSim, T);

save nn_test.mat



%TODO: Sensitivity e Specifity

% Output:
% 1- Class inter-ictal, corresponding to the normal brain state (output of the classifier NN 1 0 0 0).
% 2- Class Pré-Ictal, a seizure is coming (output of the NN 0 1 0 0).
% 3- Class Ictal, a seizure is happening (output of the NN 0 0 1 0).
% 4- Class Pos-Ictal, a seizure has just finished (output of the NN 0 0 0 1).