%This script makes a simple calculation of normalised 2D Reynolds shear stress from the output
%vectors of PIVlab. 

%In order for this to work, both u component and v component must be
%calculated within PIVlab and exported as a .mat file.

%The u_filtered and v_filtered variables are used - velocity
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

%Calculate mean velocity in U direction

totalU=0;
totalV=0;
n=360; %Update to reflect number of frames

for m=1:n

    totalU=u_filtered{m}+totalU;
    totalV=v_filtered{m}+totalV;
end

meanU=totalU./n;
meanV=totalV./n;

depthU=mean(meanU,2);
squareU=depthU.*depthU;


%Calculate Reynolds' shear stress

sumUV=0;

for l=1:n
    
    sumUV=sumUV+(((u_filtered{l})-meanU)).*(((v_filtered{l})-meanV));

end

RSS=sumUV./n;

RSSdepth=mean(RSS,2);

RSSnorm=RSSdepth./squareU;

%Write all results from the workspace back into the file that we imported at the start

save(fullFileName,'RSSnorm','-append')
