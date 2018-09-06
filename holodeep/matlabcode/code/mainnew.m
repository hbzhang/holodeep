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

%[status, x, dense_to_one_hot, original_image] = system(('python ../../tensorflow-cifar-10/loadbatchdata.py') );

%lat = h5disp('example.h5','/g4/lat')

%h5create('myfile.h5','/DS1',[10 20])

hinfo = h5info('../../tensorflow-cifar-10/train.hkl')
%traindata = h5readatt('../../tensorflow-cifar-10/train.hkl','/', 'data_0/data_0');

hdf5read(hinfo.Groups.Groups(1).Attributes.value);

%traindata = H5F.open('../../tensorflow-cifar-10/train.hkl')

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
