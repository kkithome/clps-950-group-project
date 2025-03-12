dataDir = '/Users/kkithome/Desktop/clps 0950/clps-950-group-project/eeg/ds004902'; % personal path to directory that contains data

relevantFiles = dir(fullfile(dataDir, '**', ...
    '*electrodes.tsv')); % extracts all files that end in electrodes.tsv

numFiles = length(relevantFiles); % asssigns variable to the number of relevant files
numRows = ceil(sqrt(numFiles)); % generates number of rows needed to plot each file
numCols = ceil(numFiles/numRows); % generates number of columns

figure;


for i = 1:length(relevantFiles) % creates a scatterplot for each relevant File

    filePath = fullfile(relevantFiles(i).folder, relevantFiles(i).name); % get the filePath for each relevant file
    data = readtable(filePath,"FileType","text", "Delimiter", '\t'); % reads the data in the relevant file

    x = data.x; % extracts the x-coordinate
    y = data.y; % extracts the y-coordinate
    z = data.z; % extracts the z-coordinate

    subplot(numRows, numCols, i)
    scatter3(x, y, z, 'filled');
    xlabel('X-axis');
    ylabel('Y-axis');
    zlabel('Z-axis');
    title(['Plot' num2str(i)]);
    grid on;

end




