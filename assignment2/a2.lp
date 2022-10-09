room(r1,p1). room(r1,p2). room(r1,p3). room(r1,p4). % 4 locations in room r1
room(r2,q1). room(r2,q2). % 2 locatoins in room r2
at(monkey,r1,p2,0). %monkey is in room r1 at location p2 initially
%at(chair, r2,q1,0). %chair is in room r2 at location q1 initially
%at(bananas,r1,p4,0). %bananas are in room r1 at p4 initially
%door(r1,p2,r2,q1,closed,0). %there is a door adjacent p2 of r1 and q1 of r2 which is closed initially (p2 and q1 are "door locations")

#show walk/5.
#show at/4.

time(0..100).


% actions

{walk(monkey, Room, P1, P2, T)}:-
%monkey walks from P1 to P2 in Room at time T.
    room(Room,P1),
    room(Room,P2),
    time(T),
    at(monkey,Room,P1,T).

%pick_up(monkey,Room,P,T):-
%monkey picks up the chair, both of which are at position P of Room, at T.


%put_down(monkey,Room,P,T):-
%monkey puts down the chair at position P of Room, at T.

%climb(monkey, Room,P, T):-
%monkey climbs to the chair, both of which are at position P of Room at T. 



%fluents


at(monkey,Room,P2,T+1):-
%at the same room, monkey walks from p1 to p2
    room(Room,P1),
    room(Room,P2),
    time(T),    
    at(monkey,Room,P1,T),
    walk(monkey, Room, P1, P2, T).

goal :- at(monkey,r1, p1, _).
:- not goal.    
    