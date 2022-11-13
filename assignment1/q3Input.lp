%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Test case 0

% room(r1).
% time(firstDayAm; firstDayPm; secondDayAm; secondDayPm).
% session(a;b;c;d;e).
% precede(c,a; a,d; d,b; c,b).

% Test case 0 Results is correct, because we have 5 meetings but there are only 4 periods of time to allocate 

% Answer: UNSATISFIABLE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Test case 1
room(r1).
time(firstDayAm; firstDayPm; secondDayAm; secondDayPm).
session(a;b;c;d).
precede(c,a; a,d; d,b; c,b).

%Test case 1 Results is correct. Caomparing to the test 1, we reduce meeting numbers and restrict their order,
%So there are only 1 answer.

% clingo version 5.6.1
% Reading from q3_revised.lp ...
% Solving...
% Answer: 1
% schedule(c,firstDayAm,r1) schedule(a,firstDayPm,r1) schedule(d,secondDayAm,r1) schedule(b,secondDayPm,r1)
% SATISFIABLE

% Models       : 1
% Calls        : 1
% Time         : 0.003s (Solving: 0.00s 1st Model: 0.00s Unsat: 0.00s)
% CPU Time     : 0.000s

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Test case 2

% room(r1;r2;r3).
% time(firstDayAm; firstDayPm; secondDayAm; secondDayPm).
% session(a;b;c;d;e;f;g;h;i;j;k).
% precede(e,j). precede(f,k). precede(d,k). schedule(a, firstDayAm, r2).

%Test case 2 Results is correct

% clingo version 5.6.1
% Reading from q3_revised.lp ...
% Solving...
% Answer: 1
% schedule(a,firstDayAm,r2) schedule(d,firstDayAm,r1) schedule(f,firstDayPm,r1) schedule(j,secondDayPm,r1) schedule(c,firstDayPm,r2) schedule(i,secondDayAm,r2) schedule(g,secondDayPm,r2) schedule(e,firstDayAm,r3) schedule(h,firstDayPm,r3) schedule(b,secondDayAm,r3) schedule(k,secondDayPm,r3)
% SATISFIABLE

% Models       : 1+
% Calls        : 1
% Time         : 0.006s (Solving: 0.00s 1st Model: 0.00s Unsat: 0.00s)
% CPU Time     : 0.000s

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Test case 3 Input

% room(r1;r2;r3).
% time(firstDayAm; firstDayPm; secondDayAm; secondDayPm).
% session(a;b;c;d;e;f;g;h;i;j;k).
% precede(a,b; b,c; c,d).
% precede(e,f; f,g; g,h).
% precede(i,j; j,k).

%Test case 3 Results is correct

% clingo version 5.6.1
% Reading from q3_revised.lp ...
% Solving...
% Answer: 1
%   schedule(i,firstDayAm,r1) schedule(j,firstDayPm,r1) schedule(g,secondDayAm,r1) 
%   schedule(h,secondDayPm,r1) schedule(a,firstDayAm,r2) schedule(f,firstDayPm,r2) 
%   schedule(c,secondDayAm,r2) schedule(d,secondDayPm,r2) schedule(e,firstDayAm,r3) 
%   schedule(b,firstDayPm,r3) schedule(k,secondDayPm,r3)
% SATISFIABLE

% Models       : 1+
% Calls        : 1
% Time         : 0.007s (Solving: 0.00s 1st Model: 0.00s Unsat: 0.00s)
% CPU Time     : 0.016s