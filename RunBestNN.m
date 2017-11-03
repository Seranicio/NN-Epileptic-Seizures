function RunBestNN(FilePath,FileName)
close;

struct = load(fullfile(FilePath, FileName));
net = struct.net;

A = load('Dataset\44202.mat');
P = A.FeatVectSel;
T = A.Trg;
T = RawTarget(T);  
T = T.';
P = P.';

outSim = sim(net,P);
[Sensivity,Specificity,Preictal_accuracy,Ictal_accuracy,Accuracy] = Performance(outSim,T);

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
