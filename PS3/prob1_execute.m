clc
clear all
fileID = fopen('war.txt','r');
formatSpec = '%c';
reference = fscanf(fileID,formatSpec);

fileID = fopen('encoded.txt','r');
formatSpec = '%c';
encoded = fscanf(fileID,formatSpec);
[decoded,numits]=lastname_firstname_hw3_prob1(encoded,reference)