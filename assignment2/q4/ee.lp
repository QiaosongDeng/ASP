% needs 8 steps.

#const steps=8.
#const maxcap=1.

person(p0).
person(p1).

floor(0..5).

at(p0,2,0).
at(p1,4,0).

at(lift1,0,0).
at(lift2,0,0).

capacity(lift1,0,0).
capacity(lift2,0,0).

goal(T):- at(p0,5,T), at(p1,3,T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

state(0..steps).

%action

{board(P,lift1,F,T)}:-
   state(T), person(P), floor(F),
   at(P,F,T),
   at(lift1,F,T),
   not affected(lift1,T),
   not goal(T),
   capacity(lift1,Cap,T),
   Cap < maxcap.


%effects
capacity(lift1,Cap+1,T):-
    board(P,lift1,F,T),
    capacity(lift1,Cap,T).

%frame axioms

    %capacity inheritence


%constraints things that shouldn't happen

    %one people cant appear in different elevators/floors




