%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Test cases' input 1

#const target=9. 
{element(0;1;2;3;4)}. 

%Result is correct, there are two answers:
% Answer: 1
% sum(9) element(2) element(3) element(4)
% Answer: 2
% sum(9) element(0) element(2) element(3) element(4)
% SATISFIABLE

% Models       : 2

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Test cases' input 2

% #const target=40. 
% {element(0;1;2;3;4)}. 

%Result is correct, there is no answer becaue the the maximum sum of these elements are 9:
% UNSATISFIABLE

% Models       : 0

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Test cases' input 3

% #const target=248. 
% {element(0;1;2;3;4;5;6;7;8;9;10;20;30;40;50;60;70;80;90;100)}. 

%Result is correct
% Answer: 1
% element(2) element(6) element(20) element(30) element(40) element(50) element(100) sum(248)
% SATISFIABLE

% Models       : 1+