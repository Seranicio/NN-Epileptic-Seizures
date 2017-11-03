function [InputTrainingSet,TargetTrainingSet,InputTestingSet,TargetTestingSet] =  DivideTestingRatio(P,Trg,trainR,testR)

%Getting Ictal initial and end positions.
Ictal = find(Trg(:,3) == 1);
pos = 1;
start_ictal(pos) = Ictal(1);
for i=1:length(Ictal)-1
   if(Ictal(i+1) - Ictal(i) ~= 1)
       end_ictal(pos) = Ictal(i);
       pos = pos +1 ;
       start_ictal(pos) = Ictal(i+1);
   end
end
end_ictal(pos) = Ictal(length(Ictal));

numberIctalTrain = floor(length(end_ictal) * (trainR / 100));
n_cur_ictal = end_ictal(numberIctalTrain) - start_ictal(numberIctalTrain) + 1;

%Quick Fix for Post-Ictal inclusion.
if( Trg(end_ictal(numberIctalTrain) + n_cur_ictal + 1 ,4) == 1)
    n_cur_ictal = 300;
end


InputTrainingSet = P ( 1 : end_ictal(numberIctalTrain) + n_cur_ictal, : );
TargetTrainingSet = Trg (  1 : end_ictal(numberIctalTrain) + n_cur_ictal, :);

InputTestingSet = P ( end_ictal(numberIctalTrain) +1 + n_cur_ictal: end , :);
TargetTestingSet = Trg( end_ictal(numberIctalTrain) +1 + n_cur_ictal: end, :);