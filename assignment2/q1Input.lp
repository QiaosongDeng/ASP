%Test case 1

% room(r1,p1). room(r1,p2). room(r1,p3). room(r1,p4). % 4 locations in room r1
% room(r2,q1). room(r2,q2). % 2 locatoins in room r2
% at(monkey,r1,p2,0). %monkey is in room r1 at location p2 initially
% at(chair, r2,q1,0). %chair is in room r2 at location q1 initially
% at(bananas,r1,p4,0). %bananas are in room r1 at p4 initially
% door(r1,p2,r2,q1,closed,0). %there is a door adjacent p2 of r1 and q1 of r2 which is closed initially (p2 and q1 are "door locations")
% #const n=8. %step number

% Result is correct:

% clingo version 5.6.1
% Reading from a2.lp
% Solving...
% Answer: 1
% openDoor(monkey,r1,p2,r2,q1,0) walk(monkey,r1,p2,r2,q1,1) pick_up(monkey,r2,q1,2) 
% closeDoor(monkey,r1,p2,r2,q1,4) walk(monkey,r2,q1,r1,p2,3) walk(monkey,r1,p2,p4,5) 
% put_down(monkey,r1,p4,6) climb(monkey,r1,p4,7) bananas(on_monkey,8)
% SATISFIABLE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Test case 2

% room(r1,p1). room(r1,p2). room(r1,p3). room(r1,p4). 
% room(r2,q1). room(r2,q2). room(r2,q3). room(r2,q4).
% room(r3,o1). room(r3,o2). room(r3,o3). room(r3,o4).
% at(monkey,r1,p1,0). 
% at(chair, r2,q4,0). 
% at(bananas,r3,o4,0). 
% door(r1,p2,r2,q1,closed,0). 
% door(r2,q3,r3,o2,closed,0). 
% #const n=12. %step number

% Result is correct:
% clingo version 5.6.1
% Reading from q1.lp ...
% Solving...
% Answer: 1
% walk(monkey,r1,p1,p2,0) openDoor(monkey,r1,p2,r2,q1,1) walk(monkey,r1,p2,r2,q1,2) 
% pick_up(monkey,r2,q4,4) openDoor(monkey,r2,q3,r3,o2,6) walk(monkey,r2,q1,q4,3) 
% walk(monkey,r2,q4,q3,5) closeDoor(monkey,r3,o2,r2,q3,8) walk(monkey,r2,q3,r3,o2,7) 
% walk(monkey,r3,o2,o4,9) put_down(monkey,r3,o4,10) climb(monkey,r3,o4,11) bananas(on_monkey,12)
% SATISFIABLE

%Test case 3, no door between r2 and r3

room(r1,p1). room(r1,p2). room(r1,p3). room(r1,p4). 
room(r2,q1). room(r2,q2). room(r2,q3). room(r2,q4).
room(r3,o1). room(r3,o2). room(r3,o3). room(r3,o4).
at(monkey,r1,p1,0). 
at(chair, r2,q4,0). 
at(bananas,r3,o4,0). 
door(r1,p2,r2,q1,closed,0). 
#const n=12. %step number

% Result is correct, becasue there is no door between r2 and r3, so monkey cant get the banana in r3.
% clingo version 5.6.1
% Reading from q1.lp ...
% Solving...
% UNSATISFIABLE
