

%parent(Parent,Child)
%male(Person)
%married(Person, Person)
%female(Person)
%divorced(Person, Person)
/*Parent F1*/
parent('Queen Elizabeth II', 'Prince Charles').
parent('Queen Elizabeth II', 'Princess Anne').
parent('Queen Elizabeth II', 'Prince Andrew').
parent('Queen Elizabeth II', 'Prince Edward').
parent('Prince Phillip', 'Prince Charles').
parent('Prince Phillip', 'Princess Anne').
parent('Prince Phillip', 'Prince Andrew').
parent('Prince Phillip', 'Prince Edward').

/*Parent F2*/
parent('Princess Diana', 'Prince William').
parent('Princess Diana', 'Prince Harry').
parent('Prince Charles', 'Prince William').
parent('Prince Charles', 'Prince Harry').

parent('Captain Mark Phillips', 'Peter Phillips').
parent('Captain Mark Phillips', 'Zara Phillips').
parent('Princess Anne', 'Peter Phillips').
parent('Princess Anne', 'Zara Phillips').

parent('Sarah Fergurson', 'Princess Beatrice').
parent('Sarah Fergurson', 'Princess Eugenie').
parent('Prince Andrew', 'Princess Beatrice').
parent('Prince Andrew', 'Princess Eugenie').

parent('Sophie Rhys-jones', 'James Viscount Severn').
parent('Sophie Rhys-jones', 'Lady Louise Mountbatten-Windsor').
parent('Prince Edward', 'James Viscount Severn').
parent('Prince Edward', 'Lady Louise Mountbatten-Windsor').

/*Parent F3*/
parent('Prince William', 'Prince George').
parent('Prince William', 'Princess Charlotte').
parent('Kate Middleton', 'Prince George').
parent('Kate Middleton', 'Princess Charlotte').

parent('Autumn Kelly', 'Savanah Phillips').
parent('Autumn Kelly', 'Isla Phillips').
parent('Peter Phillips', 'Savanah Phillips').
parent('Peter Phillips', 'Isla Phillips').

parent('Zara Phillips', 'Mia Grace Tindall').
parent('Mike Tindall', 'Mia Grace Tindall').


/*male*/
male('Prince Phillip').
male('Prince Charles').
male('Captain Mark Phillips').
male('Timothy Laurence').
male('Prince Andrew').
male('Prince Edward').
male('Prince William').
male('Prince Harry').
male('Peter Phillips').
male('Mike Tindall').
male('James Viscount Severn').
male('Prince George').
male('Mia Grace Tindall').

/*Female*/
female('Queen Elizabeth II').
female('Princess Diana').
female('Camilla Parker Bowles').
female('Princess Anne').
female('Sarah Ferguson').
female('Sophie Rhys-jones').
female('Kate Middleton').
female('Autumn Kelly').
female('Zara Phillips').
female('Princess Beatrice').
female('Princess Eugenie').
female('Lady Louise Mountbattern-Windsor').
female('Princess Charlotte').
female('Savannah Phillips').
female('Isla Phillips').



/*married(Person, Person)*/

married('Queen Elizabeth II', 'Prince Phillip').
married('Prince Charles', 'Camilla Parker Bowles').
married('Princess Anne', 'Timothy Laurence').
married('Sophie Rhys-jones', 'Prince Edward').
married('Prince William', 'Kate Middleton').
married('Autumn Kelly', 'Peter Phillips').
married('Zara Phillips', 'Mike Tindall').

married('Prince Phillip', 'Queen Elizabeth II').
married('Camilla Parker Bowles', 'Prince Charles').
married('Timothy Laurence', 'Princess Anne').
married('Prince Edward', 'Sophie Rhys-jones').
married('Kate Middleton', 'Prince William').
married('Peter Phillips', 'Autumn Kelly').
married('Mike Tindall', 'Zara Phillips').

/*divorced(Person, Person)*/

divorced('Princess Diana', 'Prince Charles').
divorced('Captain Mark Phillips', 'Princess Anne').
divorced('Sarah Ferguson', 'Prince Andrew').

divorced('Prince Charles', 'Princess Diana').
divorced('Princess Anne', 'Captain Mark Phillips').
divorced('Prince Andrew', 'Sarah Ferguson').

husband(Person, Wife) :-
    married(Person, Wife),
    male(Person).

wife(Person, Husband) :-
    married(Person, Husband),
    female(Person).

father(Parent, Child) :-
    parent(Parent, Child),
    male(parent).

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

grandparent(GP, GC) :-
    parent(GP, Child),
    parent(Child, GC).

grandmother(GM, GC) :-
    mother(GM, Child),
    parent(Child, GC).

grandfather(GF, GC) :-
    father(GF, Child),
    parent(Child, GC).

grandchild(GC, GP) :-
    grandparent(GP, GC).

grandson(GS, GP) :-
    grandparent(GP, GS),
    male(GS).

granddaughter(GD, GP) :-
    grandparent(GP, GD),
    female(GD).

sibling(Person1, Person2) :-
    parent(Parent, Person1),
    parent(Parent, Person2),
    Person1 \= Person2.

brother(Person, Sibling) :-
    sibling(Person, Sibling),
    male(Person).

sister(Person, Sibling) :-
    sibling(Person, Sibling),
    female(Person).

aunt(Person, NieceNephew) :-
    female(Person),
    sibling(Person, Sibling),
    parent(Sibling, NieceNephew).

uncle(Person, NieceNephew) :-
    male(Person),
    sibling(Person, Sibling),
    parent(Sibling, NieceNephew).

niece(Person, AuntUncle) :-
    female(Person),
    parent(Parent, Person),
    sibling(Parent, AuntUncle).

nephew(Person, AuntUncle) :-
    male(Person),
    parent(Parent, Person),
    sibling(Parent, AuntUncle).