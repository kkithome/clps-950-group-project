data = "/Users/kkithome/Desktop/clps 0950/clps-950-group-project/eeg/ds004902/sub-01/ses-1/eeg/sub_02_ses-1_electrodes.tsv"; ... "FileType", "text",  "Delimiter", "\t";

x = data.x;
y = data.y;
z = data.z;

scatter3(x, y, z, 'filled');
