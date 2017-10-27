function finalTarget=RawTarget(Trg)

%600 points before de first 1 is a preictal and 300 points after the last 1 is a postictal.
% Ictal is when user is having a epilepsi attack.

% pos_target = [[1 0 0 0];[0 1 0 0];[0 0 1 0];[0 0 0 1]];
%             interictal | Pré-ictal | Ictal | Pos-Ictal

Ictal = find(Trg == 1);

pos = 1;
beginning_ictal(pos) = Ictal(1);

for i=1:length(Ictal)-1
   if(Ictal(i+1) - Ictal(i) ~= 1)
       final_ictal(pos) = Ictal(i);
       pos = pos +1 ;
       beginning_ictal(pos) = Ictal(i+1);
   end
end

final_ictal(pos) = Ictal(length(Ictal));

%Filling array with interictal
finalTarget = zeros(length(Trg),4);
finalTarget(:,1) = 1;

%Filling array with Pré-ictal
for i=1:length(beginning_ictal)
    finalTarget(beginning_ictal(i)-600-1:beginning_ictal(i)-1,2) = 1;
    finalTarget(beginning_ictal(i)-600-1:beginning_ictal(i)-1,1) = 0;
end

%Filling array with Pos-Ictal
for i=1:length(final_ictal)
    finalTarget(final_ictal(i)+1:final_ictal(i) + 301,4) = 1;
    finalTarget(final_ictal(i)+1:final_ictal(i) + 301,1) = 0;
end

%Filling array with Ictal
for i=1:length(beginning_ictal)
    finalTarget(beginning_ictal(i):final_ictal(i),3) = 1;
    finalTarget(beginning_ictal(i):final_ictal(i),1) = 0;
end