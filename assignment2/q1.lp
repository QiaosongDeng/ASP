% Planning in Answer Set Programming: the classic Monkey-Bananas Problem.

%Instruction:
%type clingo a2.lp -c n="steps constraint" in the command line. 
%special rule: 
%monkey can open door or close door when carrying the chair.

#show walk/5.
#show walk/6.
%#show at/4.
#show openDoor/6.
#show closeDoor/6.
#show pick_up/4.
#show put_down/4.
#show climb/4.
#show bananas/2.
%#show door/6.
%#show goal/1.
%#show goal/0.
%#show chair/3.
%#show chair/2.

time(0..n).%type clingo a2.lp -c n="steps constraint" in the command line. 


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
    not pickingUp(monkey,T),
    not puttingDown(monkey,T),
    not climbing(monkey,T),
    not goal(T).

{openDoor(monkey, Room1, P1, Room2, P2, T)}:-
%monkey at (Room1, P1) opens the door connecting (Room1, P1) and (Room2, P2).
    room(Room1, P1),
    room(Room2, P2),
    time(T),
    
    door(Room1, P1, Room2, P2, closed, T),
    at(monkey,Room1,P1,T),
    not closing(monkey,T),
    not pickingUp(monkey,T),
    not puttingDown(monkey,T),
    not climbing(monkey,T),
    not goal(T).

{walk(monkey,Room1, P1, Room2, P2, T)}:-
%monkey walk from (Room1, P1) to (Room2, P2)
    room(Room1, P1),
    room(Room2, P2),
    Room1 != Room2,
    time(T),

    door(Room1, P1, Room2, P2,opened,T),
    at(monkey,Room1,P1,T),
    not opening(monkey,T), %monkey cant move when he is busy
    not closing(monkey,T),
    not pickingUp(monkey,T),
    not puttingDown(monkey,T),
    not climbing(monkey,T),
    not goal(T).

{closeDoor(monkey, Room1, P1, Room2, P2, T)}:-
%monkey at (Room1, P1) closes the door connecting (Room1, P1) and (Room2, P2).
    room(Room1, P1),
    room(Room2, P2),
    time(T),
    
    door(Room1, P1, Room2, P2, opened, T),
    at(monkey,Room1,P1,T),
    not opening(monkey,T),
    not pickingUp(monkey,T),
    not puttingDown(monkey,T),
    not climbing(monkey,T),
    not goal(T).


{pick_up(monkey,Room,P,T)}:-
%monkey picks up the chair, both of which are at position P of Room, at T.
    room(Room, P),
    time(T),

    at(monkey, Room, P, T),
    at(chair, Room, P, T),
    chair(Room,P,T),
    not opening(monkey,T),
    not closing(monkey,T),
    not puttingDown(monkey,T),
    not climbing(monkey,T),
    not goal(T).


{put_down(monkey,Room,P,T)}:-
%monkey puts down the chair at position P of Room, at T.
    room(Room, P),
    time(T),

    at(monkey, Room, P, T),
    at(chair, Room, P, T),
    chair(on_monkey,T),
    not opening(monkey,T),
    not closing(monkey,T),
    not pickingUp(monkey,T),
    not climbing(monkey,T),
    not goal(T).

{climb(monkey, Room,P, T)}:-
%monkey climbs to the chair, both of which are at position P of Room at T.
    room(Room,P),
    time(T),

    at(monkey, Room, P, T),
    at(chair, Room, P, T),
    chair(Room,P,T),
    at(bananas, Room, P,T),
    not opening(monkey,T),
    not closing(monkey,T),
    not puttingDown(monkey,T),
    not pickingUp(monkey,T),
    not surroundingDoorsOpened(Room,T),
    not goal(T).



%fluents

opening(monkey,T):-
    openDoor(monkey, _, _, _, _, T).

closing(monkey,T):-
    closeDoor(monkey, _, _, _, _, T). 

pickingUp(monkey,T):-
    pick_up(monkey, _, _, T).      

puttingDown(monkey,T):-
    put_down(monkey, _, _, T).

climbing(monkey,T):-
    climb(monkey, _, _, T).

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

at(monkey, Room, Place, T+1):-
%monkey stays at the same place when picking up chair.
    at(monkey, Room, Place, T),
    pickingUp(monkey,T).

at(monkey, Room, Place, T+1):-
%monkey stays at the same place when putting Down chair.
    at(monkey, Room, Place, T),
    puttingDown(monkey,T).

at(chair, Room, Place, T):-
    chair(on_monkey, T),
    at(monkey, Room, Place, T).

at(chair, Room, Place, T):-
    chair(Room, Place, T).

at(monkey, Room, Place, T+1):-
%monkey stays at the same place when climbing.
    at(monkey, Room, Place, T),
    climbing(monkey,T).

at(bananas, Room, Place, T+1):-
%bananas stays at the same place if monkey doesn't reach it.
    time(T),
    at(bananas, Room, Place, T).



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
%keep door closed in the Time(T+1) if it is not opened now.
    room(Room1,P1),
    room(Room2,P2),
    time(T), 

    door(Room1, P1, Room2, P2, closed, T),
    not openDoor(monkey, Room1, P1, Room2, P2, T),
    not openDoor(monkey, Room2, P2, Room1, P1, T),
    not goal(T).%if goal is achieved, dont keep anymore

chair(on_monkey,T+1):-
    time(T),

    pick_up(monkey, _, _,T).

chair(on_monkey,T+1):-
    time(T),

    chair(on_monkey, T),
    not put_down(monkey, _, _,T).

chair(Room, P, T+1):-
    time(T),

    put_down(monkey, Room, P, T).

chair(Room, P, T+1):-
    time(T),

    chair(Room, P, T),
    not pick_up(monkey, Room, P,T).

chair(Room, P, T):-
    time(T),

    at(chair, Room, P,T),
    not chair(on_monkey, T).

bananas(on_monkey, T+1):-

    climbing(monkey,T).
    
surroundingDoorsOpened(Room,T):-
    door(Room, _, _, _, opened, T).


%dont set a action as a goal.
goal(T) :- 
        %at(monkey,r1,p4,T),
        %chair(r1,p4,T).
        %door(r1, p2, r2, q1, opened, T).
        bananas(on_monkey,T).
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
     