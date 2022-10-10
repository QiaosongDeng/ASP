

room(r1,p1). room(r1,p2). room(r1,p3). room(r1,p4). % 4 locations in room r1
room(r2,q1). room(r2,q2). % 2 locatoins in room r2
at(monkey,r1,p1,0). %monkey is in room r1 at location p2 initially
%at(chair, r2,q1,0). %chair is in room r2 at location q1 initially
%at(bananas,r1,p4,0). %bananas are in room r1 at p4 initially
door(r1,p2,r2,q1,closed,0). %there is a door adjacent p2 of r1 and q1 of r2 which is closed initially (p2 and q1 are "door locations")

#show walk/5.
#show walk/6.
#show at/4.
#show openDoor/6.
#show closeDoor/6.
%#show door/6.
%#show goal/1.

time(0..5).


% actions

{walk(monkey, Room, P1, P2, T)}:-
%monkey walks from P1 to P2 in Room at time T.
    room(Room,P1),
    room(Room,P2),
    P1 != P2,
    time(T),

    at(monkey,Room,P1,T),
    not opening(monkey,T), %monkey cant move when he is busy
    not closing(monkey,T),
    not goal(T).

{openDoor(monkey, Room1, P1, Room2, P2, T)}:-
%monkey at (Room1, P1) opens the door connecting (Room1, P1) and (Room2, P2).
    room(Room1, P1),
    room(Room2, P2),
    time(T),
    
    door(Room1, P1, Room2, P2, closed, T),
    at(monkey,Room1,P1,T),
    not closing(monkey,T),
    not goal(T).

{walk(monkey,Room1, P1, Room2, P2, T)}:-
%monkey walk from (Room1, P1) to (Room2, P2)
    room(Room1, P1),
    room(Room2, P2),
    time(T),

    door(Room1, P1, Room2, P2,opened,T),
    at(monkey,Room1,P1,T),
    not opening(monkey,T), %monkey cant move when he is busy
    not closing(monkey,T),
    not goal(T).

{closeDoor(monkey, Room1, P1, Room2, P2, T)}:-
%monkey at (Room1, P1) closes the door connecting (Room1, P1) and (Room2, P2).
    room(Room1, P1),
    room(Room2, P2),
    time(T),
    
    door(Room1, P1, Room2, P2, opened, T),
    at(monkey,Room1,P1,T),
    not opening(monkey,T),
    not goal(T).


%pick_up(monkey,Room,P,T):-
%monkey picks up the chair, both of which are at position P of Room, at T.


%put_down(monkey,Room,P,T):-
%monkey puts down the chair at position P of Room, at T.

%climb(monkey, Room,P, T):-
%monkey climbs to the chair, both of which are at position P of Room at T. 



%fluents

opening(monkey,T):-
    openDoor(monkey, _, _, _, _, T).

closing(monkey,T):-
    closeDoor(monkey, _, _, _, _, T).    

at(monkey,Room,P2,T+1):-
%change's monkey position when monkey walks from p1 to p2 at the same room
    room(Room,P1),
    room(Room,P2),
    P1 != P2,
    time(T), 

    at(monkey,Room,P1,T),
    walk(monkey, Room, P1, P2, T).

door(Room1, P1, Room2, P2, opened, T+1):-
%change the door's property if the door is opened.
    room(Room1,P1),
    room(Room2,P2),
    time(T), 

    at(monkey,Room1,P1,T),
    openDoor(monkey, Room1, P1, Room2, P2, T).


door(Room2, P2, Room1, P1, opened, T):-
%one side of the door is opened, the other side must be opened.
    room(Room1,P1),
    room(Room2,P2),
    time(T),

    door(Room1, P1, Room2, P2, opened, T).

door(Room2, P2, Room1, P1, closed, T):-
%one side of the door is closed, the other side must be closed.
    room(Room1,P1),
    room(Room2,P2),
    time(T), 

    door(Room1, P1, Room2, P2, closed, T).   

at(monkey,Room2,P2,T+1):-
%change's monkey position when monkey walks from (Room1,P1) to (Room2,P2).
    room(Room1,P1),
    room(Room2,P2),
    time(T),

    at(monkey,Room1,P1,T),
    walk(monkey,Room1, P1, Room2, P2, T).

at(monkey, Room, Place, T+1):-
%monkey stays at the same place when opening.
    at(monkey, Room, Place, T),
    opening(monkey,T).

at(monkey, Room, Place, T+1):-
%monkey stays at the same place when closing.
    at(monkey, Room, Place, T),
    closing(monkey,T).    

door(Room1, P1, Room2, P2, closed, T+1):-
%change the door's property if the door is closed.
    room(Room1,P1),
    room(Room2,P2),
    time(T), 

    at(monkey,Room1,P1,T),
    closeDoor(monkey, Room1, P1, Room2, P2, T).


door(Room1, P1, Room2, P2, opened, T+1):-
%keep door OPEN in the Time(T+1) if it is not closed now.
    room(Room1,P1),
    room(Room2,P2),
    time(T), 

    door(Room1, P1, Room2, P2, opened, T),
    not closeDoor(monkey, Room1, P1, Room2, P2, T),
    not closeDoor(monkey, Room2, P2, Room1, P1, T),
    not goal(T).%if goal is achieved, dont keep anymore

door(Room1, P1, Room2, P2, closed, T+1):-
%keep door closed in the Time(T+1) if it is not openend now.
    room(Room1,P1),
    room(Room2,P2),
    time(T), 

    door(Room1, P1, Room2, P2, closed, T),
    not openDoor(monkey, Room1, P1, Room2, P2, T),
    not openDoor(monkey, Room2, P2, Room1, P1, T),
    not goal(T).%if goal is achieved, dont keep anymore

%dont set a action as a goal.
goal(T) :- 
        at(monkey,r2,q2,T).
        %door(r1, p2, r2, q1, opened, T).
goal(T+1):-  time(T), goal(T).            
goal :- time(T), goal(T).
:-  not goal.

%The monkey cant go in two directions at the same time.
:-  time(T), 
    room(Room, From),
    room(Room,Place1), 
    room(Room,Place2),
    From != Place1,
    From != Place2,
    Place1 != Place2,
    walk(monkey, Room, From, Place1, T),
    walk(monkey, Room, From, Place2, T).

:-  time(T), 
    room(Room1, From),
    room(Room1,Place1), 
    room(Room2,Place2),
    From != Place1,
    Room1 != Room2,
    walk(monkey, Room1, From, Room2, Place2, T),
    walk(monkey, Room1, From, Place1, T).

:-  time(T), 
    room(Room1, From),
    room(Room2, Place1), 
    room(Room3, Place2), 
    Room1 != Room2,
    Room2 != Room3,
    Room3 != Room1,
    walk(monkey, Room1, From, Room2, Place1, T),
    walk(monkey, Room1, From, Room3, Place2, T).
     