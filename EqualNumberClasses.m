function [Input,FinalTarget] = EqualNumberClasses(P,Trg)

%Getting Ictal initial and end positions.
Ictal = find(Trg == 1);
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

%Getting number of ictal samples to fill the Array with zeros.
number_ictal = 0;
for i=1:length(start_ictal)
    number_ictal = number_ictal + (end_ictal(i) - start_ictal(i)) + 1 ;
end

FinalTarget = zeros(number_ictal*4,4);
Input = zeros(number_ictal*4,29);
pos = 1;

%Target and Input
for i=1:length(start_ictal)
    n_cur_ictal = end_ictal(i) - start_ictal(i) + 1;
    %interictal
    FinalTarget(pos:pos + n_cur_ictal -1,1) = 1;
    Input(pos:pos + n_cur_ictal -1,:) = P(start_ictal(i) - 601 - n_cur_ictal:start_ictal(i) - 601 -1 ,:);
    %Pre-Ictal
    pos = pos + n_cur_ictal;
    FinalTarget(pos:pos + n_cur_ictal -1,2) = 1;
    Input(pos:pos + n_cur_ictal -1,:) = P(start_ictal(i) - n_cur_ictal:start_ictal(i) -1 ,:);
    %Ictal
    pos = pos + n_cur_ictal;
    FinalTarget(pos:pos + n_cur_ictal -1,3) = 1;
    Input(pos:pos + n_cur_ictal -1,:) = P(start_ictal(i):end_ictal(i),:);
    %Pos-Ictal
    pos = pos + n_cur_ictal;
    FinalTarget(pos:pos + n_cur_ictal -1,4) = 1;
    Input(pos:pos + n_cur_ictal -1,:) = P(end_ictal(i) + 1:end_ictal(i) + 1 + n_cur_ictal - 1,:);
    pos = pos + n_cur_ictal;
end