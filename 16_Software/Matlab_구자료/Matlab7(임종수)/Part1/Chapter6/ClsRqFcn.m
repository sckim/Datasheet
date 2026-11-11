%
% Figure Object의 CloseRequestFcn propertyname에 대한 propertyvalue.
%

selection = questdlg('Close Specified Figure?',...
                     'Close Request Function',...
                     'Yes','No','Yes');
switch selection,
   case 'Yes',
     delete(gcf)
   case 'No'
     return
end
