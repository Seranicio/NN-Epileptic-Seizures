function Main(userdataset,groupdataset,FileName,FilePath,trainRatio,testRatio,valRatio,NNtype)

% disp("userdata: " + userdataset);
% disp("groupdata: " + groupdataset);
% disp("Filename:" + FileName);
% disp("FIlePath:" + FilePath);

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
% net = layrecnet(1:2, 29); %https://www.mathworks.com/help/nnet/ref/layrecnet.html
% net.trainFcn = 'trainscg';
if(NNtype == 1) % normal feed 
    disp("normal");
    net = feedforwardnet(29,'trainscg');
    net = configure(net,P,T);
    net.trainParam.epochs = 1000;
    net.trainParam.goal = 0.00001;
    net.divideParam.trainRatio=trainRatio/100;
    net.divideParam.testRatio=testRatio/100;
    net.divideParam.valRatio=valRatio/100;
    net = train(net,P,T, 'useGPU', 'yes');
%     outSim = sim(net,Test);
%     [sensi, speci, PreicPerc, IctalPerc] = calcPerform(outSim, TT);
else
    net = layrecnet(1:2, 29);
    net.trainFcn = 'trainscg';
    net.trainParam.epochs = 1000;
    net.divideParam.trainRatio=trainRatio/100;
    net.divideParam.testRatio=testRatio/100;
    net.divideParam.valRatio=valRatio/100;
    net = train(net,P,T, 'useGPU', 'yes');
%     outSim = sim(net,Test);
%     [sensi, speci] = calcPerform(outSim, TT);
end

save nn_test.mat

%TODO: Sensitivity e Specifity

% Output:
% 1- Class inter-ictal, corresponding to the normal brain state (output of the classifier NN 1 0 0 0).
% 2- Class Pré-Ictal, a seizure is coming (output of the NN 0 1 0 0).
% 3- Class Ictal, a seizure is happening (output of the NN 0 0 1 0).
% 4- Class Pos-Ictal, a seizure has just finished (output of the NN 0 0 0 1).