function Main(userdataset,groupdataset,FileName,FilePath);

% disp("userdata: " + userdataset);
% disp("groupdata: " + groupdataset);
% disp("Filename:" + FileName);
% disp("FIlePath:" + FilePath);

%600 points before de first 1 is a preictal and 300 points after the last 1
%is a postictal.

%Handle data for training.

%Loading Dataset;
if(FileName == "null")
   A = load('Dataset\44202.mat');
   P = A.FeatVectSel;
   T = A.Trg;
%    B = load('Dataset\63502.mat');
else
   C = load(fullfile(FilePath, FileName));
   P = C.FeatVectSel;
   T = C.Trg;
end

%Creating NN



