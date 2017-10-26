function Performance(outSim,T)

% for sensitivity and specificity
True_Positives = 0;
False_Negatives = 0;
True_Negatives = 0;
False_Positives = 0;

%Pre-Ictal and Ictal
true_Preictal = 0;
total_Preictal = 0;
true_Ictal = 0;
total_Ictal = 0;
accuracy = 0; % for InterIctal and Pos-Ictal.

for i=1:length(outSim)
    %Acertou InterIctal and Pos-Ictal
    if outSim(1,i) > outSim(2,i) && outSim(1,i) > outSim(3,i) && outSim(1,i) > outSim(4,i) && T(1,i) == 1
        accuracy = accuracy + 1;
    end
    if outSim(4,i) > outSim(1,i) && outSim(4,i) > outSim(3,i) && outSim(4,i) > outSim(2,i) && T(4,i) == 1
        accuracy = accuracy + 1;
    end
    %Acertou Pre-Ictal e Ictal
    if outSim(3,i) > outSim(1,i) && outSim(3,i) > outSim(2,i) && outSim(3,i) > outSim(4,i) && T(3,i) == 1
        True_Positives = True_Positives + 1;
    elseif outSim(2,i) > outSim(1,i) && outSim(2,i) > outSim(3,i) && outSim(2,i) > outSim(4,i) && T(2,i) == 1
        True_Positives = True_Positives + 1;
    %Acertou que nao é Pre-Ictal ou Ictal.
    elseif (outSim(3,i) < outSim(1,i) || outSim(3,i) < outSim(2, i) || outSim(3,i) < outSim(4,i)) && T(3,i) ~= 1
        True_Negatives = True_Negatives + 1;
    elseif (outSim(2,i) < outSim(1,i) || outSim(2,i) < outSim(3, i) || outSim(2,i) < outSim(4,i)) && T(2,i) ~= 1
        True_Negatives = True_Negatives + 1;
    end
    %Falhou Pre-Ictal e Ictal. Pensa que era Pre-Ictal ou Ictal mas nao era
    if outSim(3,i) > outSim(1,i) && outSim(3,i) > outSim(2,i) && outSim(3,i) > outSim(4,i) && T(3,i) ~= 1
        False_Positives = False_Positives + 1;
    elseif outSim(2,i) > outSim(1,i) && outSim(2,i) > outSim(3,i) && outSim(2,i) > outSim(4,i) && T(2,i) ~= 1
        False_Positives = False_Positives + 1;
    %Falhou que nao era Pre-Ictal ou Ictal. Rede pensa que nao era
    %Pre-Ictal ou Ictal mas era.
    elseif (outSim(3,i) < outSim(1,i) && outSim(3,i) < outSim(2,i) && outSim(3,i) < outSim(4,i)) && T(3,i) ==1
        False_Negatives = False_Negatives + 1;
    elseif (outSim(2,i) < outSim(1,i) && outSim(2,i) < outSim(3,i) && outSim(2,i) < outSim(4,i)) && T(2,i) ==1
        False_Negatives = False_Negatives + 1;
    end
    
    %TODO
end

% if(find(outSim(i,:) == max(outSim(i,:))) == 1 && T(i,1) == 1)
%         accuracy = accuracy + 1;