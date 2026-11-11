function text_hnd= mytext(x,y,varargin)
%
% Mytext.m     varargin.m함수의 사용 방법을 보여주는 함수.
% 1998, 12, 17  By Lim Jong Su
%
clf;  	% 현재 active 상태에 있는 figure Object의 하위 graphics Object
        	% 들을 모두 지운다.
plot(x,y);
text_hnd=text(varargin{:});   % text Object의 handle을 돌려줍니다.