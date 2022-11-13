%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#show board/4.
#show unboard/4.
#show up/4.
#show down/4.
%#show at/3.

state(0..steps).
cap(0..maxcap).

%action

{board(lift1,P,F,T)}:-
    state(T), person(P), floor(F), cap(Cap),
    at(P,F,T),
    at(lift1,F,T),
    not affected(lift1,T),
    not goal(T),
    capacity(lift1,Cap,T),
    %not capacityChanging(lift1,T),
    Cap < maxcap.
{board(lift2,P,F,T)}:-
    state(T), person(P), floor(F), cap(Cap),
    at(P,F,T),
    at(lift2,F,T),
    not affected(lift2,T),
    not goal(T),
    capacity(lift2,Cap,T),
    %not capacityChanging(lift2,T),
    Cap < maxcap.    

{unboard(lift1,P,F,T)}:-
    state(T), person(P), floor(F),
    in(lift1,P,T),
    at(lift1,F,T),
    not affected(lift1,T),
    %not capacityChanging(lift1,T),
    not goal(T).    
{unboard(lift2,P,F,T)}:-
    state(T), person(P), floor(F),
    in(lift2,P,T),
    at(lift2,F,T),
    not affected(lift2,T),
    %not capacityChanging(lift2,T),
    not goal(T). 

{up(lift1,From,To,T)}:-
%  state(T), floor(From), floor(To),
   above(To,From),
   at(lift1,From,T),
   not goal(T).
{up(lift2,From,To,T)}:-
%  state(T), floor(From), floor(To),
   above(To,From),
   at(lift2,From,T),
   not goal(T).

{down(lift1,From,To,T)}:-
%  state(T), floor(From), floor(To),
   above(From,To),
   at(lift1,From,T),
   not goal(T).
{down(lift2,From,To,T)}:-
%  state(T), floor(From), floor(To),
   above(From,To),
   at(lift2,From,T),
   not goal(T).

above(From,To):-
   floor(From), floor(To),  % From and To are unsafe if commented out
   From > To.

%affected
change(P,T):- board(lift1,P,F,T).
change(P,T):- board(lift2,P,F,T).

change(P,T):- unboard(lift1,P,F,T).
change(P,T):- unboard(lift2,P,F,T).

affected(lift1,T):-
   state(T), floor(From), floor(To),
   up(lift1,From,To,T).
affected(lift2,T):-
   state(T), floor(From), floor(To),
   up(lift2,From,To,T).   

affected(lift1,T):-
   state(T), floor(From), floor(To),
   down(lift1,From,To,T).
affected(lift2,T):-
   state(T), floor(From), floor(To),
   down(lift2,From,To,T). 

capacityChanging(lift1,T):-
    board(lift1,P,F,T),
    state(T), floor(From), person(P).
capacityChanging(lift2,T):-
    board(lift2,P,F,T),
    state(T), floor(From), person(P).

capacityChanging(lift1,T):-
    unboard(lift1,P,F,T),
    state(T), floor(From), person(P).
capacityChanging(lift2,T):-
    unboard(lift2,P,F,T),
    state(T), floor(From), person(P).        

capacity(lift1,Cap+1,T+1):-
    cap(Cap),
    board(lift1,P,F,T),
    capacity(lift1,Cap,T).
capacity(lift2,Cap+1,T+1):-
    cap(Cap),
    board(lift2,P,F,T),
    capacity(lift2,Cap,T).

capacity(lift1,Cap-1,T+1):-
    cap(Cap),
    unboard(lift1,P,F,T),
    capacity(lift1,Cap,T). 
capacity(lift2,Cap-1,T+1):-
    cap(Cap),
    unboard(lift2,P,F,T),
    capacity(lift2,Cap,T).        

%effects

at(lift1,To,T+1):-
    state(T), floor(From), floor(To),
    up(lift1,From,To,T).
at(lift2,To,T+1):-
    state(T), floor(From), floor(To),
    up(lift2,From,To,T).    

at(lift1,To,T+1):-
    state(T), floor(From), floor(To),
    down(lift1,From,To,T).
at(lift2,To,T+1):-
    state(T), floor(From), floor(To),
    down(lift2,From,To,T).  

in(lift1,P,T+1):-
    state(T), floor(F), person(P),
    board(lift1,P,F,T).
in(lift2,P,T+1):-
    state(T), floor(F), person(P),
    board(lift2,P,F,T).

at(P,F,T+1):-
    state(T), floor(F), person(P),
    unboard(lift1,P,F,T).    
at(P,F,T+1):-
    state(T), floor(F), person(P),
    unboard(lift2,P,F,T).

%frame axioms
at(P,F,T+1):-
   state(T), person(P), floor(F),
   not change(P,T),
   at(P,F,T).

in(lift1,P,T+1):-
   state(T), person(P),
   not change(P,T),
   in(lift1,P,T).
in(lift2,P,T+1):-
   state(T), person(P),
   not change(P,T),
   in(lift2,P,T).   

at(lift1,F,T+1):-
   state(T), floor(F),
   not affected(lift1,T),
   at(lift1,F,T).
at(lift2,F,T+1):-
   state(T), floor(F),
   not affected(lift2,T),
   at(lift2,F,T).

    %capacity inheritence
capacity(lift1,Cap,T+1):-
    person(P),floor(F),state(T),cap(Cap),
    not capacityChanging(lift1,T),
    capacity(lift1,Cap,T).
capacity(lift2,Cap,T+1):-
    person(P),floor(F),state(T),cap(Cap),
    not capacityChanging(lift2,T),
    capacity(lift2,Cap,T).



%constraints things that shouldn't happen
:- up(lift1,From,To,T), up(lift1,From,To1,T), 
    To != To1,floor(To), floor(To1), floor(From).%one elevator cant run in 2 directions
:- up(lift2,From,To,T), up(lift2,From,To1,T), 
    To != To1,floor(To), floor(To1), floor(From).%one elevator cant run in 2 directions

:- up(lift1,From,To,T), up(lift1,From1,To,T), 
    From != From1,floor(To), floor(From1), floor(From).%one elevator cant from two floors
:- up(lift2,From,To,T), up(lift2,From1,To,T), 
    From != From1,floor(To), floor(From1), floor(From).%one elevator cant from two floors

:- down(lift1,From,To,T), down(lift1,From,To1,T), 
    To != To1,floor(To),floor(To1), floor(From).
:- down(lift2,From,To,T), down(lift2,From,To1,T), 
    To != To1,floor(To),floor(To1), floor(From).

:- down(lift1,From,To,T), down(lift1,From1,To,T), 
    From != From1,floor(From1), floor(To), floor(From).
:- down(lift2,From,To,T), down(lift2,From1,To,T), 
    From != From1,floor(From1), floor(To), floor(From).

:- up(lift1,From,To,T), down(lift1,From,To1,T), To != To1,
   floor(To1), floor(To), floor(From).%one elevator cant go up and down at the same time
:- up(lift2,From,To,T), down(lift2,From,To1,T), To != To1,
   floor(To1), floor(To), floor(From).%one elevator cant go up and down at the same time

    %one people cant appear in different elevators/floors
:-  floor(F),state(T),person(P),
    board(lift1,P,F,T),board(lift2,P,F,T).

:- capacity(lift1,Cap1,T), capacity(lift1,Cap2,T), Cap1 != Cap2,
    state(T), cap(Cap1),cap(Cap2).  
:- capacity(lift2,Cap1,T), capacity(lift2,Cap2,T), Cap1 != Cap2,
    state(T), cap(Cap1),cap(Cap2). 

% :- board(lift1,P1,F,T),board(lift1,P2,F,T),
%     state(T),floor(F),person(P1),person(p2). 
% :- board(lift2,P1,F,T),board(lift2,P2,F,T),
%     state(T),floor(F),person(P1),person(p2). 

% :- unboard(lift1,P1,F,T),unboard(lift1,P2,F,T),
%     state(T),floor(F),person(P1),person(p2). 
% :- unboard(lift2,P1,F,T),unboard(lift2,P2,F,T),
%     state(T),floor(F),person(P1),person(p2).    


%goal
goal(T+1):- goal(T), state(T).
goal:- goal(T), state(T).
:- not goal.



