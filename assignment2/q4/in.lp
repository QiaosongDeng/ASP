% test case 1
% needs 4 steps.

% #const steps=4.
% #const maxcap=2.

% person(p0).
% person(p1).

% floor(0..5).

% at(p0,2,0).
% at(p1,4,0).

% at(lift1,0,0).
% at(lift2,0,0).

% capacity(lift1,0,0).
% capacity(lift2,0,0).

% goal(T):- at(p0,5,T), at(p1,2,T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test case 2, comparing to test 1, increases capacity to 3 and adds two people
% needs 8 steps.

#const steps=8.
#const maxcap=3.

person(p0).
person(p1).
person(p2).
person(p3).

floor(0..5).

at(p0,2,0).
at(p1,4,0).
at(p2,3,0).
at(p3,1,0).

at(lift1,0,0).
at(lift2,0,0).

capacity(lift1,0,0).
capacity(lift2,0,0).

goal(T):- at(p0,5,T), at(p1,2,T),at(p2,0,T),at(p3,5,T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test case 3, comparing to test 2, decreases capacity to 1.
% needs 8 steps.

% #const steps=8.
% #const maxcap=1.

% person(p0).
% person(p1).
% person(p2).
% person(p3).

% floor(0..5).

% at(p0,2,0).
% at(p1,4,0).
% at(p2,3,0).
% at(p3,1,0).

% at(lift1,0,0).
% at(lift2,0,0).

% capacity(lift1,0,0).
% capacity(lift2,0,0).

% goal(T):- at(p0,4,T), at(p1,2,T),at(p2,0,T),at(p3,5,T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% test case 3, comparing to test 2, decreases capacity to 0.
% UNSATISFIABLE, because the max capacity is 0.

% #const steps=100. %even we give it 100 steps, it cant solve because no capacity.
% #const maxcap=0.

% person(p0).
% person(p1).
% person(p2).
% person(p3).

% floor(0..5).

% at(p0,2,0).
% at(p1,4,0).
% at(p2,3,0).
% at(p3,1,0).

% at(lift1,0,0).
% at(lift2,0,0).

% capacity(lift1,0,0).
% capacity(lift2,0,0).

% goal(T):- at(p0,4,T), at(p1,2,T),at(p2,0,T),at(p3,5,T).
