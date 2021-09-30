%This script makes a simple calculation of normalised turbulence intensity in the u direction from the output
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

%Calculate TI in u direction

n=350;

squareU=0;

totalU=0;


for m=1:n

    totalU=u_original{m}+totalU;
   
end

meanU=totalU/n;

widthU=mean(meanU,2);

for j=1:n

    squareU=(((u_original{j})-meanU).^2)+squareU;

end

msU=squareU./n;

rmsU=((msU).^0.5);

TIu=rmsU./widthU;

TImean=mean(TIu,2);

%Write all results from the workspace back into the file that we imported at the start

save(fullFileName,'TImean','-append')

