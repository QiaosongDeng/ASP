% Question 3 ASP
% schedule(a, firstDayAm, r2)


#show schedule/3.
%#show precede/2.
%#show finished/1.
%#show unfinished/0.

{schedule(Session,Time,Room)} :-
    session(Session),
    time(Time),
    room(Room).

% At the same location and the same time, there is only one session
Session1 = Session2 :- 
    schedule(Session1,Time1,Room1),
    schedule(Session2,Time2,Room2),
    Time1 = Time2,
    Room1 = Room2.

% One session can only have one time 
Time1 = Time2 :-
    schedule(Session1,Time1,Room1),
    schedule(Session2,Time2,Room2),
    Session1 = Session2.

% One session can only have one location
Room1 = Room2 :- 
    schedule(Session1,Time1,Room1),
    schedule(Session2,Time2,Room2),
    Session1 = Session2.

% if precede(Session1,Session2) is ture and two sessions are diff, 
% there must be Time1 < Time2
Time1 < Time2 :- 
    schedule(Session1,Time1,Room1),
    schedule(Session2,Time2,Room2),
    precede(Session1,Session2),
    Session1 != Session2.


% all sessions must be arranged.
finished(Session):- schedule(Session,Time,Room), 
    session(Session),
    time(Time),
    room(Room). 

unfinished :- 
    not finished(Session),
    session(Session). 

:- unfinished.
       