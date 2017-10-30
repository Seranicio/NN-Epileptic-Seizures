function Main(FileName,FilePath,trainRatio,testRatio,valRatio,NNtype,trainf,hiddenlayer,trainingset)

%Filename for net and results saving.
saveName = "TrainedNN\";


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
   A = load('Dataset\63502.mat');
   P = A.FeatVectSel;
   T = A.Trg;
else
   C = load(fullfile(FilePath, FileName));
   P = C.FeatVectSel;
   T = C.Trg;
end

rawP = P.';
rawT = RawTarget(T); %Raw target dataset.
rawT = rawT.';

%Handle Target output for Classes.
if(trainingset == 1)
    %getting best entropy -> number of all classes are equal.
    [P,T] = EqualNumberClasses(P,T);
else
    %Raw data if wanna test. It's not recommended because the objective of the
    %project is to have a NN to detect Pre-Ictals , Ictals. The result will be
    %a incredible NN for detecting normal brain state (interictal).
    T = RawTarget(T);
end

%Transpose Input and Target.
T = T.';
P = P.';

%Creating NN
if(NNtype == 1) % normal feedfoward NN
    disp("Setting up Normal Feed Network! Please wait a few seconds to train...");
    net = feedforwardnet(hiddenlayer);
    saveName = saveName + "feedfo_";
    net.trainParam.epochs = 1000;
    net.divideParam.trainRatio=trainRatio/100;
    net.divideParam.testRatio=testRatio/100;
    net.divideParam.valRatio=valRatio/100;
    net.trainFcn = trainfunction;
    net = train(net,P,T, 'useGPU', 'yes');
elseif(NNtype == 2) %Recurrent NN
    disp("Setting up recurrent Network! Please wait a few seconds to train...");
    net = layrecnet(1:2, hiddenlayer);
    saveName = saveName + "ecnet_";
    net.trainParam.epochs = 1000;
    net.divideParam.trainRatio=trainRatio/100;
    net.divideParam.testRatio=testRatio/100;
    net.divideParam.valRatio=valRatio/100;
    net.trainFcn = trainfunction;
    net = train(net,P,T, 'useGPU', 'yes');
else %Elman feedforward NN (it's a recurrent NN with the addition of layer recurrent connections with tap delays
    disp("Setting up Elman Network! Please wait a few seconds to train...");
    net = elmannet(1:2, hiddenlayer);
    saveName = saveName + "elman_";
    net.trainParam.epochs = 1000;
    net.divideParam.trainRatio=trainRatio/100;
    net.divideParam.testRatio=testRatio/100;
    net.divideParam.valRatio=valRatio/100;
    net.trainFcn = trainfunction;
    net = train(net,P,T, 'useGPU', 'yes');
end

%Testing with Raw Dataset
outSim = sim(net,rawP);
[Sensivity,Specificity,Preictal_accuracy,Ictal_accuracy,Accuracy] = Performance(outSim,rawT);

%setting global variable for ResultsGUI... (only way i know how to send
%results there).
global sens;
global spec;
global Preictal;
global Ictal;
global Acc;
sens = floor(Sensivity * 100);
spec = floor(Specificity * 100);
Preictal = floor(Preictal_accuracy);
Ictal = floor(Ictal_accuracy);
Acc = floor(Accuracy);
ResultsGUI;

%Saving Results;
saveName = saveName + trainfunction + "_H=" + hiddenlayer;
fileID = fopen(saveName + "_Stats.txt",'w');
fprintf(fileID,"Sensitivity: %d%%\nSpecificity: %d%%\nPre-Ictals Accuracy: %d%%\nIctals Accuracy: %d%%\nAccuracy: %d%%",sens,spec,Preictal,Ictal,Acc);
fclose(fileID);
save(saveName+".mat",'net');