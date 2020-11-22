% parent(Parent,Child)
% male(Person)
% female(Person)
% married(Person, Person)
% divorced(Person, Person)
% engaged(Person, Person)
% -------------------------------
% Parent F1
parent('Rebecca Bell', 'Jennifer Howard').
parent('Rebecca Bell', 'Lawrence Howard').
parent('Rebecca Bell', 'Morrison Howard').
parent('Rebecca Bell', 'Lawrence Howard').
parent('Rebecca Bell', 'Malone Howard').
parent('Stephen Howard', 'Jennifer Howard').
parent('Stephen Howard', 'Lawrence Howard').
parent('Stephen Howard', 'Morrison Howard').
parent('Stephen Howard', 'Lawrence Howard').
parent('Stephen Howard', 'Malone Howard').

% Parent F2
parent('Jennifer Howard', 'Robert Gray').
parent('Jennifer Howard', 'Evelyn Gray').
parent('Jennifer Howard', 'Juan Gray').
parent('Andrew Gray', 'Robert Gray').
parent('Andrew Gray', 'Evelyn Gray').
parent('Andrew Gray', 'Juan Gray').

parent('Phillip Thomas', 'Kelly Thomas').
parent('Phillip Thomas', 'Diana Thomas').
parent('Lawrence Howard', 'Kelly Thomas').
parent('Lawrence Howard', 'Diana Thomas').

parent('Christine Diaz', 'Terry Howard').
parent('Morrison Howard', 'Terry Howard').

parent('Jean Garcia', 'Louise Howard').
parent('Jean Garcia', 'Teresa Howard').
parent('Lawrence Howard', 'Louise Howard').
parent('Lawrence Howard', 'Teresa Howard').

% Parent F3
parent('Evelyn Gray', 'Anne Ramirez').
parent('Evelyn Gray', 'Kelly Ramirez').
parent('Dennis Ramirez', 'Anne Ramirez').
parent('Dennis Ramirez', 'Kelly Ramirez').

parent('Juan Gray', 'Cheryl Gray').
parent('Anna Roberts', 'Cheryl Gray').

parent('Kelly Thomas', 'Edward Cook').
parent('Brian Cook', 'Edward Cook').

parent('Diana Thomas', 'Ronald Phillips').
parent('Jason Phillips', 'Ronald Phillips').

parent('Teresa Howard', 'Eric Green').
parent('Teresa Howard', 'Joshua Green').
parent('Jeremy Green', 'Eric Green').
parent('Jeremy Green', 'Joshua Green').

% Parent F4
parent('Edward Cook', 'Eugene Cook').
parent('Edward Cook', 'Adam Cook').
parent('Emily Flores', 'Eugene Cook').
parent('Emily Flores', 'Adam Cook').

% male
male('Stephen Howard').
male('Andrew Gray').
male('Phillip Thomas').
male('Steve Roberts').
male('Morrison Howard').
male('Lawrence Howard').
male('Malone Howard').
male('Robert Gray').
male('Dennis Ramirez').
male('Juan Gray').
male('Brian Cook').
male('Jason Phillips').
male('Ronald Rogers').
male('Terry Howard').
male('Jeremy Green').
male('Edward Cook').
male('Ronald Phillips').
male('Eric Green').
male('Joshua Green').
male('Eugene Cook').
male('Adam Cook').

% female
female('Rebecca Bell').
female('Jennifer Howard').
female('Lawrence Howard').
female('Christine Diaz').
female('Jean Garcia').
female('Beverly Cook')
female('Marilyn Perry').
female('Evelyn Gray').
female('Anna Roberts').
female('Kelly Thomas').
female('Diana Thomas').
female('Louise Howard').
female('Teresa Howard').
female('Anne Ramirez').
female('Kelly Ramirez').
female('Cheryl Gray').
female('Emily Flores').
female('Mary Bryant').
female('Wanda Young').

% married
married('Rebecca Bell', 'Stephen Howard').
married('Jennifer Howard', 'Andrew Gray').
married('Phillip Thomas', 'Lawrence Howard').
married('Lawrence Howard', 'Beverly Cook').
married('Evelyn Gray', 'Dennis Ramirez').
married('Anna Roberts', 'Juan Gray').
married('Kelly Thomas', 'Brian Cook').
married('Diana Thomas', 'Ronald Rogers').

% divorced
divorced('Lawrence Howard', 'Steve Roberts').
divorced('Morrison Howard', 'Christine Diaz').
divorced('Jean Garcia', 'Lawrence Howard').
divorced('Marilyn Perry', 'Malone Howard').
divorced('Jeremy Green', 'Teresa Howard').
divorced('Edward Cook', 'Emily Flores').

% engaged
engaged('Ronald Phillips', 'Mary Bryant').
engaged('Joshua Green', 'Wanda Young').

% -------------------------------

ancestor(Person, Descendent) :- 
    parent(Person, Descendent).
ancestor(Person, Descendent) :- 
    parent(Person, Child), 
    ancestor(Child, Descendent).

descendent(Person, Ancestor) :- 
    parent(Ancestor, Person).
descendent(Person, Ancestor) :- 
    parent(Ancestor, Parent), 
    descendent(Person, Parent).

fiancee(Person, Fiance) :-
    engaged(Fiance, Person),
    female(Person).

fiance(Person, Fiancee) :-
    engaged(Person, Fiancee),
    male(Person).

husband(Person, Wife) :-
    married(Person, Wife),
    male(Person).

wife(Person, Husband) :-
    married(Person, Husband),
    female(Person).    

stepparent(StepParent, Child) :-
    married(StepParent, Spouse),
    divorced(Spouse, CoParent),
    parent(Spouse, Child),
    parent(CoParent, Child).

stepfather(StepParent, StepChild) :-
    stepparent(StepParent, StepChild),
    male(StepParent).

stepmother(StepParent, StepChild) :-
    stepparent(StepParent, StepChild),
    female(StepParent).

stepchild(StepChild, StepParent) :-
    stepparent(StepParent, StepChild).

stepson(StepChild, StepParent) :-
    stepparent(StepParent, StepChild),
    male(StepChild).

stepdaughter(StepChild, Parent)
    stepparent(StepParent, StepChild),
    female(StepChild).

father(Parent, Child) :-
    parent(Parent, Child),
    male(Parent).

mother(Parent, Child) :-
    parent(Parent, Child),
    female(Parent).

child(Child, Parent) :-
    parent(Parent, Child).

son(Child, Parent) :-
    parent(Parent, Child),
    male(Child).

daughter(Child, Parent) :-
    parent(Parent, Child),
    female(Child).

brother_in_law(BInLaw, SiblingInLaw) :-
    married(Person, SiblingInLaw), 
    brother(BInLaw, Person).
brother_in_law(BInLaw, SiblingInLaw) :-
    sister(Sister, SiblingInLaw), 
    married(BInLaw, Sister).
brother_in_law(BInLaw, SiblingInLaw) :-
    married(Person, SiblingInLaw), 
    sister(Sister, Person), 
    married(BInLaw, Sister).

sister_in_law(SInLaw, SiblingInLaw) :-
    married(Person, SiblingInLaw), 
    sister(SInLaw, Person).
sister_in_law(SInLaw, SiblingInLaw) :-
    brother(Brother, SiblingInLaw),
    married(Brother, SInLaw).
sister_in_law(SInLaw, SiblingInLaw) :-
    married(Person, SiblingInLaw), 
    brother(Brother, Person), 
    married(SInLaw, Brother).    

mother_in_law(MInLaw, ChildInLaw) :-
    female(MInLaw),
    married(Child, ChildInLaw),
    parent(MInLaw, Child).

father_in_law(FInLaw, ChildInLaw) :-
    male(FInLaw),
    married(Child, ChildInLaw),
    parent(FInLaw, Child).

%------------------------------

grandparent(GP, GC) :-
    parent(GP, Child),
    parent(Child, GC).

grandmother(GM, GC) :-
    parent(GM, Child),
    parent(Child, GC),
    female(GM).

grandfather(GF, GC) :-
    parent(GF, Child),
    parent(Child, GC),
    male(GF).

paternal_grandparent(PGP, GC) :-
    parent(PGP, Child),
    father(Child, GC).

paternal_grandmother(PGM, GC) :-
    parent(PGM, Child),
    father(Child, GC),
    female(PGM).

paternal_grandfather(PGF, GC) :-
    parent(PGF, Child),
    father(Child, GC),
    male(PGF).

meternal_grandparent(MGP, GC) :-
    parent(MGP, Child),
    mother(Child, GC).

meternal_grandmother(MGM, GC) :-
    parent(MGM, Child),
    mother(Child, GC),
    female(MGM).

meternal_grandfather(MGF, GC) :-
    parent(MGF, Child),
    mother(Child, GC),
    male(MGF).

grandchild(GC, GP) :-
    grandparent(GP, GC).

grandson(GS, GP) :-
    grandparent(GP, GS),
    male(GS).

granddaughter(GD, GP) :-
    grandparent(GP, GD),
    female(GD).

great_grandparent(GGP, GGC) :-
    parent(GGP, GP),
    parent(GP, P),
    parent(P, GGC).

great_grandmother(GGM, GGC) :-
    parent(GGM, GP),
    parent(GP, P),
    parent(P, GGC),
    female(GGM).

great_grandfather(GGF, GGC) :-
    parent(GGF, GP),
    parent(GP, P),
    parent(P, GGC),
    male(GGF).

great_grandchild(GGC, GGP) :-
    great_grandparent(GGP, GGC).

great_grandson(GGS, GGP) :-
    great_grandparent(GGP, GGS),
    male(GGS).

great_granddaughter(GGD, GGP) :-
    great_grandparent(GGP, GGD),
    female(GGD).

%------------------------------

sibling(Person1, Person2) :-
    parent(Parent, Person1),
    parent(Parent, Person2),
    Person1 \== Person2.

brother(Person, Sibling) :-
    sibling(Person, Sibling),
    male(Person).

sister(Person, Sibling) :-
    sibling(Person, Sibling),
    female(Person).

half_brother(Person, Sibling) :-
    stepparent(StepParent, Sibling),
    parent(StepParent, Person),
    male(Person).

half_sister(Person, Sibling) :-
    stepparent(StepParent, Sibling),
    parent(StepParent, Person),
    female(Person).

aunt(Person, NieceNephew) :-
    female(Person),
    sibling(Person, Sibling),
    parent(Sibling, NieceNephew).

uncle(Person, NieceNephew) :-
    male(Person),
    sibling(Person, Sibling),
    parent(Sibling, NieceNephew).

cousin(Person, Cuz) :-
    uncle(Uncle, Person),
    child(Cuz, Uncle).
cousin(Person, Cuz) :-
    aunt(Aunt, Person),
    child(Cuz, Aunt).

niece(Person, AuntUncle) :-
    female(Person),
    parent(Parent, Person),
    sibling(Parent, AuntUncle).

nephew(Person, AuntUncle) :-
    male(Person),
    parent(Parent, Person),
    sibling(Parent, AuntUncle).
