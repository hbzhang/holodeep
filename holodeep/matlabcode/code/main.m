function main()

clear all
close all

mysavedtrain = '../../tensorflow-cifar-10/data_set/rawmatlaboutput'; %gets directory
mysavedtest = '../../tensorflow-cifar-10/data_set/rawtestmatlaboutput'; %gets directory
myDirTrain = '../../tensorflow-cifar-10/data_set/raw'; %gets directory
myDirTest = '../../tensorflow-cifar-10/data_set/rawtest'; %gets directory
myFilesTrain = dir(fullfile(myDirTrain,'*.png')); %gets all txt files in struct
myFilesTest = dir(fullfile(myDirTest,'*.png')); %gets all txt files in struct

%s = system( sprintf('python ../loadbatch.py "%s"', arg1) );

s = system( sprintf('python3 python/loadbatch.py') );


for k = 1:length(myFilesTrain)
  baseFileName = myFilesTrain(k).name;
  fullFileName = fullfile(myDirTrain, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  %num = importdata(fullFileName);   %or readtable
  osh(baseFileName,fullFileName,mysavedtrain);
  % all of your actions for filtering and plotting go here
end


for k = 1:length(myFilesTest)
  baseFileName = myFilesTest(k).name;
  fullFileName = fullfile(myDirTest, baseFileName);
  fprintf(1, 'Now reading %s\n', fullFileName);
  %num = importdata(fullFileName);   %or readtable
  osh(baseFileName,fullFileName,mysavedtest);
  % all of your actions for filtering and plotting go here
end
