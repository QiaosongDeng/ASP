% Question 3 ASP
% schedule(a, firstDayAm, r2)
room(r1;r2).
time(firstDayAm).
session(a;b).

%#show schedule/3.
%#show conflict2/2.

{schedule(Session,Time,Room)} :-
    session(Session),
    time(Time),
    room(Room).

%diff session can't be hold in same time at same place

% conflict1 :-
%     schedule(Session1,Time1,Room1),
%     schedule(Session2,Time2,Room2),
%     Session1 != Session2,
%     Time1 = Time2,
%     Room1 = Room2.

%same session can't be hold twice

conflict2(Session1,Session2) :-
    schedule(Session1,_,_),
    schedule(Session2,_,_),
    Session1 = Session2.

%:- conflict1.
%:- conflict2.

