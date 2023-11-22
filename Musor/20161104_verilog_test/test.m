clear;

system('make batch');

fid=fopen('cnt.txt', 'r'); cnt = fscanf(fid, '%d', inf)'; fclose(fid);
fid=fopen('sum.txt', 'r'); sum = fscanf(fid, '%d', inf)'; fclose(fid);

plot([cnt; sum]')
