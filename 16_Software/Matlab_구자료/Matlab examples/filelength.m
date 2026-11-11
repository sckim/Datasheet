function [f_size] = filelength(fid)
%
% return file length
%

cur_p = ftell(fid);
fseek(fid,0,1);
end_p = ftell(fid);
fseek(fid,0,-1);
f_size = (end_p-ftell(fid));
fseek(fid, cur_p, -1);