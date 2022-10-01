% Question 3 inputs


% room(r1;r2;r3).
% time(firstDayAm; firstDayPm; secondDayAm; secondDayPm).
% session(a;b;c;d;e;f;g;h;i;j;k).

room(r1).
time(firstDayAm; firstDayPm; secondDayAm; secondDayPm).
session(a;b;c;d).
precede(c,a; a,d; d,b; c,b).

