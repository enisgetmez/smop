:- discontiguous rank/2.
:- discontiguous shape/2.
:- discontiguous let/2.
:- dynamic let/2.
:- dynamic symtab/2.
 
prog([
   let(solver, matlab_function(ai,af,w)),
   let(nBlocks, matlab_max(matlab_ravel(ai))),
   let([m,n], matlab_size(ai)),
   let(ii, [0, 1, 0,-1]),
   let(jj, [1, 0,-1, 0]),
   let(a,  ai),
   let(mv, [])]).

resolve(A) :-
    atom(A),
    !,
    writeln(A).
    %assertz(is_ref(A)).

resolve(A) :-
    number(A),
    !,
    writeln(A).

resolve(let(A,B)) :-
    !,
    resolve(B),
    lhs_resolve(A),
    writeln(let).

resolve([]) :-
    !,
    writeln("[]").

resolve([A|B]) :-
    !,
    resolve(A),
    resolve(B).

resolve(A) :-
    compound(A),
    !,
    compound_name_arguments(A,B,C),
    resolve(B),
    resolve(C),
    write(B), length(C,N), writeln(N).
%--------------------------------
lhs_resolve(A) :-        % A=...
    atom(A),
    !,
    writeln(A).
%    assertz(is_def(A)).

%lhs_resolve(A) :-
%    number(A).

lhs_resolve(let(A,B)) :- % A=B...
    !,
    resolve(B),
    lhs_resolve(A),
    writeln(letl).

lhs_resolve([]) :-
    !,
    writeln("[]").

lhs_resolve([A|B]) :-
    !,
    lhs_resolve(A),
    lhs_resolve(B).

lhs_resolve(A) :-        % A(B)= ...
    compound(A),
        !,
    compound_name_arguments(A,B,C),
    lhs_resolve(B),
    resolve(C),
    writeln(B).

% vim : syntax=prolog