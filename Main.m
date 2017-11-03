function Main(FileName,FilePath,trainRatio,testRatio,valRatio,NNtype,trainf,hiddenlayer,trainingset)

%Filename for net and results saving.
saveName = "TrainedNN\";

if( (trainRatio + testRatio) ~= 100 )
    disp('Training values are not valid. Exiting...');
    return
end

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
   %44202
   %63502
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
elseif (trainingset == 2)
    %Handler:
    %300 points Interictal for each Ictal phase.
    %600 points PreIctal for each Ictal phase.
    %Normal Ictal points.
    %300 points Post-Ictal for each Ictal phase
    [P,T] = LowInterIctalPoints(P,T);
else
    %Raw data if wanna test. It's not recommended because the objective of the
    %project is to have a NN to detect Pre-Ictals , Ictals. The result will be
    %a incredible NN for detecting normal brain state (interictal).
    T = RawTarget(T);
end

%if training method is not with 100% we have to divide it.
if(trainRatio ~= 100)
    [InputTrainingSet,TargetTrainingSet,InputTestingSet,TargetTestingSet] = DivideTestingRatio(P,T,trainRatio,testRatio); 
    InputTrainingSet=InputTrainingSet.';
    TargetTrainingSet = TargetTrainingSet.';
    InputTestingSet = InputTestingSet.';
    TargetTestingSet = TargetTestingSet.';
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
    if(trainRatio ~= 100)
        net = train(net,InputTrainingSet,TargetTrainingSet, 'useGPU', 'yes');
    else
        net = train(net,P,T, 'useGPU', 'yes');
    end
elseif(NNtype == 2) %Recurrent NN
    disp("Setting up recurrent Network! Please wait a few seconds to train...");
    net = layrecnet(1:2, hiddenlayer);
    saveName = saveName + "ecnet_";
    net.trainParam.epochs = 1000;
    net.divideParam.trainRatio=trainRatio/100;
    net.divideParam.testRatio=testRatio/100;
    net.divideParam.valRatio=valRatio/100;
    net.trainFcn = trainfunction;
    if(trainRatio ~= 100)
        net = train(net,InputTrainingSet,TargetTrainingSet, 'useGPU', 'yes');
    else
        net = train(net,P,T, 'useGPU', 'yes');
    end
else %Elman feedforward NN (it's a recurrent NN with the addition of layer recurrent connections with tap delays
    disp("Setting up Elman Network! Please wait a few seconds to train...");
    net = elmannet(1:2, hiddenlayer);
    saveName = saveName + "elman_";
    net.trainParam.epochs = 1000;
    net.divideParam.trainRatio=trainRatio/100;
    net.divideParam.testRatio=testRatio/100;
    net.divideParam.valRatio=valRatio/100;
    net.trainFcn = trainfunction;
    if(trainRatio ~= 100)
        net = train(net,InputTrainingSet,TargetTrainingSet, 'useGPU', 'yes');
    else
        net = train(net,P,T, 'useGPU', 'yes');
    end
end

%Testing with Raw Dataset
if(trainRatio ~= 100)
    outSim = sim(net,InputTestingSet);
    [Sensivity,Specificity,Preictal_accuracy,Ictal_accuracy,Accuracy] = Performance(outSim,TargetTestingSet);
else
    outSim = sim(net,rawP);
    [Sensivity,Specificity,Preictal_accuracy,Ictal_accuracy,Accuracy] = Performance(outSim,rawT);
end

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