%
%STRATUP.M   이 프로그램은 matlab을 처음 실행하였을 때,
%주어진 작업 디렉토리로 들어가게 하는 m-file이다.
%단, 주어진 작업 디렉토리를 여기서는,
%C:\MATLAB\R2007a\Limspace라고 가정 하였다.
%만일, 다른 디렉토리를 원한 다면, 우선 해당 디렉토리를 
%만들고, Line16에 있는 mbookPATH에 
%해당 디렉토리를 지정해 주면 된다.
%
%2007, 4, 24       By Lim Jong_Su
%

fprintf('Welcome to the Matlab7 By Lim Jong Su\n')

Friend = computer;
if strcmp(Friend,'PCWIN');
   mbookPATH = 'C:\MATLAB\R2007a\Limspace';  
else
   disp('I don''t recognize this computer; ')
   disp('The new directory not set')
end

if strcmp(Friend,'PCWIN')
   path(mbookPATH,path)
   addpath(mbookPATH)
   cd(mbookPATH)
   disp('Pathnames Successfully Set')
end
   
disp(['Your matlab version : ' num2str(version)])