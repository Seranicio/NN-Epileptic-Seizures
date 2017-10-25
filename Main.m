function Main(FileName,FilePath,trainRatio,testRatio,valRatio,NNtype,trainf,hiddenlayer)

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


%Handle data for training.
%Loading Dataset;
if(FileName == "null")
   A = load('Dataset\44202.mat');
   P = A.FeatVectSel;
   P = P.';
   T = A.Trg;
%  B = load('Dataset\63502.mat');
else
   C = load(fullfile(FilePath, FileName));
   P = C.FeatVectSel;
   P = P.';
   T = C.Trg;
end

%Handle Target output for Classes.
T = handleTarget(T);
T = T.';

%Creating NN
if(NNtype == 1) % normal feedfoward NN
    disp("Setting up Normal Feed Network! Please wait a few seconds to begin training...");
    net = feedforwardnet(hiddenlayer);
    net.trainParam.epochs = 1000;
    net.divideParam.trainRatio=trainRatio/100;
    net.divideParam.testRatio=testRatio/100;
    net.divideParam.valRatio=valRatio/100;
    net.trainFcn = trainfunction;
    net = train(net,P,T, 'useGPU', 'yes');
%     outSim = sim(net,Test);
%     [sensi, speci, PreicPerc, IctalPerc] = calcPerform(outSim, TT);
elseif(NNtype == 2) %Recurrent NN
    disp("Setting up recurrent Network! Please wait a few seconds to begin training...");
    net = layrecnet(1:2, hiddenlayer);
    view(net)
    net.trainParam.epochs = 1000;
    net.divideParam.trainRatio=trainRatio/100;
    net.divideParam.testRatio=testRatio/100;
    net.divideParam.valRatio=valRatio/100;
    net.trainFcn = trainfunction;
    net = train(net,P,T, 'useGPU', 'yes');
%     outSim = sim(net,Test);
%     [sensi, speci] = calcPerform(outSim, TT);
else %Elman feedforward NN (it's a recurrent NN with the addition of layer recurrent connections with tap delays
    disp("Setting up Elman Network! Please wait a few seconds to begin training...");
    net = elmannet(1:2, hiddenlayer);
    net.trainParam.epochs = 1000;
    net.divideParam.trainRatio=trainRatio/100;
    net.divideParam.testRatio=testRatio/100;
    net.divideParam.valRatio=valRatio/100;
    net.trainFcn = trainfunction;
    net = train(net,P,T, 'useGPU', 'yes');
end

save nn_test.mat



%TODO: Sensitivity e Specifity

% Output:
% 1- Class inter-ictal, corresponding to the normal brain state (output of the classifier NN 1 0 0 0).
% 2- Class Pré-Ictal, a seizure is coming (output of the NN 0 1 0 0).
% 3- Class Ictal, a seizure is happening (output of the NN 0 0 1 0).
% 4- Class Pos-Ictal, a seizure has just finished (output of the NN 0 0 0 1).