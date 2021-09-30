%This script makes a simple calculation of depth mean velocity (temporally and horizontally averaged) from the output
%vectors of PIVlab. 

%In order for this to work, u component must be
%calculated within PIVlab and exported as a .mat file.

%The u_filtered variable is used - velocity
% must be validated before PIVlab export

%Outputs are appended to the original results file

%Call dialog box to ask for input file and establish save location for the
%outputs

startingFolder=pwd;

defaultFileName= fullfile(startingFolder, '*.*');
[baseFileName,folder]=uigetfile(defaultFileName, 'Select a file');
if baseFileName ==0
    return
end

fullFileName=fullfile(folder,baseFileName);

load(fullFileName)
    
n=100;%Update with number of frames

%Calculate depth averaged velocity
totalU=0;

for m=1:n

    totalU=u_filtered{m}+totalU;
   
end

meanU=totalU/n;

depthU=mean(meanU,2);

%Write all results from the workspace back into the file that we imported at the start

save(fullFileName,'depthU','-append')



