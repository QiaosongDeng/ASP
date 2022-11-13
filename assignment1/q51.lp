%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Program discription:
%     Every nonnegative integer can be represented as the sum of 3 complete
%     squares. For example: N = I^2+J^2+K^2.
%     input:
%         n = max value of nonnegative integer.
%     output:
%         three(N,I,J,K).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Test Case 1:
#const n=8.

%Test Case 1:
%#const n=50.

%%Test Case 1:
%#const n=100.


%program
#show three/4.

sqrt(S) :- S = 1..n, S**2 <= n, (S+1)**2 > n.
three(N,I,J,K) :- sqrt(S), N = 1..n, I = 0..S, J = I..S, K = J..S,
    N = I**2+J**2+K**2.