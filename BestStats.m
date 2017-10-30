FilePath = "C:\Users\Vian\Documents\ACEvenClasses.xlsx";
[ndata, text, alldata] = xlsread(FilePath);
trainingfunction = alldata(2:end-2,1);
results = alldata(2:end-2,6);
hiddenlayer = ndata(:,1);
feedforward = ndata(:,2);
layecnet = ndata(:,3);
elmannet = ndata(:,4);

NNtype = "";
sensitivity = 0;
specificity = 0;
layer = "";
actfunction = "";
%Best Ictal and Pre-Ictal.
for i=1:length(ndata)/5-1
    disp(i);
    if(sensitivity <= elmannet(1+((i-1)*5)) && specificity <= elmannet(2+((i-1)*5)))
        sensitivity = elmannet(1+((i-1)*5));
        specificity = elmannet((1+1)+((i-1)*5));
        NNtype = "elmannet";
        actfunction = trainingfunction(1+((i-1)*5));
        layer = hiddenlayer(1+((i-1)*5));
    elseif (sensitivity <= feedforward(1+((i-1)*5)) && specificity <= feedforward(2+((i-1)*5)))
        sensitivity = feedforward(1+((i-1)*5));
        specificity = feedforward(2+((i-1)*5));
        NNtype = "feedforward";
        actfunction = trainingfunction(1+((i-1)*5));
        layer = hiddenlayer(1+((i-1)*5));
    elseif (sensitivity <= layecnet(1+((i-1)*5)) && specificity <= layecnet(2+((i-1)*5)))
        sensitivity = layecnet(1+((i-1)*5));
        specificity = layecnet(2+((i-1)*5));
        NNtype = "layecnet";
        actfunction = trainingfunction(1+((i-1)*5));
        layer = hiddenlayer(1+((i-1)*5));
    end
end