dataDir = '/Users/kkithome/Desktop/clps 0950/clps-950-group-project/eeg/ds004902';

relevantFiles = dir(fullfile(dataDir, '**', ...
    '*electrodes.tsv'));

numFiles = length(relevantFiles);
numRows = ceil(sqrt(numFiles));
numCols = ceil(numFiles/numRows);

figure;


for i = 1:length(relevantFiles)

    filePath = fullfile(relevantFiles(i).folder, relevantFiles(i).name);
    data = readtable(filePath,"FileType","text", "Delimiter", '\t');

    x = data.x;
    y = data.y;
    z = data.z;

    subplot(numRows, numCols, i)
    scatter3(x, y, z, 'filled');
    xlabel('X-axis');
    ylabel('Y-axis');
    zlabel('Z-axis');
    title(['Plot' num2str(i)]);
    grid on;

end




