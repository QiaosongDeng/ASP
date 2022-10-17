%Test cases' inputs. 
{element(0;1;2;3;4)}. %enter the multiset S into the element().
:- not sum(9). %enter the target sum into the sum().



%Don't change this.
sum(SUM):- SUM=#sum{X:element(X)}.
 