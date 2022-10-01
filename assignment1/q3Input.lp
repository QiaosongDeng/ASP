% Question 3 inputs



% room(r1;r2;r3).
% time(firstDayAm; firstDayPm; secondDayAm; secondDayPm).
% session(a;b;c;d;e;f;g;h;i;j;k).
% precede(e,j). precede(f,k). precede(d,k). schedule(a, firstDayAm, r2).


% Answer: schedule(c,firstDayAm,r1) schedule(a,firstDayPm,r1) schedule(d,secondDayAm,r1) schedule(b,secondDayPm,r1)
% room(r1).
% time(firstDayAm; firstDayPm; secondDayAm; secondDayPm).
% session(a;b;c;d).
% precede(c,a; a,d; d,b; c,b).


room(r1;r2;r3).
time(firstDayAm; firstDayPm; secondDayAm; secondDayPm).
session(a;b;c;d;e;f;g;h;i;j;k).
precede(a,b; b,c; c,d).
precede(e,f; f,g; g,h).
precede(i,j; j,k).

