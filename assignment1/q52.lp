% Permutation pattern matching .

% input : 
%       for some permutation T of 1,... ,n , the set t/2 of
%           pairs (I , E) such that E is the I-th element of T ;
%       for some permutation P of 1,... ,k , the set p/2 of
%           pairs (I , E) such that E is the I-th element of P ;
%       the length k of P .

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Test Case 1: T = (5 ,3 ,1 ,4 ,2) , P = (2 ,3 ,1).

% t(1 ,5; 2 ,3; 3 ,1; 4 ,4; 5 ,2).
% p(1 ,2; 2 ,3; 3 ,1).
% #const k =3.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Test Case 2: T = (5 ,3 ,1 ,4 ,2) , P = (3 ,2 ,1).

% t(1 ,5; 2 ,3; 3 ,1; 4 ,4; 5 ,2).
% p(1 ,3; 2 ,2; 3 ,1).
% #const k =3.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Test Case 3: T = (1,2,3,4,5,6,7,8) , P = (4, 3 ,2 ,1).

% t(1 ,1; 2 ,2; 3 ,3; 4 ,4; 5 ,5; 6, 6; 7, 7; 8, 8).
% p(1 ,4; 2 ,3; 3 ,2; 4, 1).
% #const k =4.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Test Case 4: T = (1,2,3,4,5,6,7,8) , P = (1, 2 ,3 ,4).
t(1 ,1; 2 ,2; 3 ,3; 4 ,4; 5 ,5; 6, 6; 7, 7; 8, 8).
p(1 ,1; 2 ,2; 3 ,3; 4, 4).
#const k =4.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%program

{ subseq(K ,I , E ) : t(I , E )} = 1 :- K = 1..k .
% achieved : for some functions i , e from {1 ,... , k } to
% {1 ,... , n } , the numbers e (1) ,... , e ( k ) are the
% elements of T in positions i (1) ,... , i ( k ).

I1 < I2 :- subseq( K1 , I1 , _ ) , subseq( K2 , I2 , _ ) , K1 < K2 .
% achieved : e (1) ,... , e ( k ) is a subsequence of T .

EP1 < EP2 :- subseq( K1 ,_ , ET1 ) , subseq( K2 ,_ , ET2 ) ,
p( K1 , EP1 ) , p( K2 , EP2 ) , ET1 < ET2 .
% achieved : this subsequence is ordered according to P .

subseq( E ) :- subseq(_ ,_ , E ).
% achieved : subseq /1 = { e (1) ,... , e ( k )}.

#show subseq /1.