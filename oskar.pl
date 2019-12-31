/* Oskar's cube is a 3D maze puzzle.
   We use (x,y,z) co-ordinates.
   Hold cube with red face towards you and green face upwards.
   Printed "2"s will be at front-top-left corner.
   x increases towards you.
   y increases to the right.
   z increases downwards.
   i.e. (0,0,_) is top-left corner of red face.
   and (0,_,0) is far back-left corner of green face. */

/* red face */
r(0,0,_). r(0,1,_). r(0,2,_). r(0,3,_). r(0,4,_). r(0,5,_). r(0,6,_).           r(0,8,_).
r(1,0,_).           r(1,2,_).                               r(1,6,_).           r(1,8,_).
r(2,0,_).           r(2,2,_). r(2,3,_). r(2,4,_).           r(2,6,_). r(2,7,_). r(2,8,_).
r(3,0,_).                               r(3,4,_).                               r(3,8,_).
r(4,0,_). r(4,1,_). r(4,2,_).           r(4,4,_).           r(4,6,_).           r(4,8,_).
                                        r(5,4,_).           r(5,6,_).           r(5,8,_).
r(6,0,_).           r(6,2,_). r(6,3,_). r(6,4,_). r(6,5,_). r(6,6,_).           r(6,8,_).
r(7,0,_).           r(7,2,_).                                                   r(7,8,_).
r(8,0,_). r(8,1,_). r(8,2,_).           r(8,4,_). r(8,5,_). r(8,6,_). r(8,7,_). r(8,8,_).

/* green face */
g(_,0,0). g(_,1,0). g(_,2,0). g(_,3,0). g(_,4,0). g(_,5,0). g(_,6,0). g(_,7,0). g(_,8,0).
                    g(_,2,1).                                                   g(_,8,1).
g(_,0,2).           g(_,2,2). g(_,3,2). g(_,4,2). g(_,5,2). g(_,6,2).           g(_,8,2).
g(_,0,3).           g(_,2,3).
g(_,0,4). g(_,1,4). g(_,2,4).           g(_,4,4). g(_,5,4). g(_,6,4).           g(_,8,4).
g(_,0,5). g(_,4,5).                               g(_,8,5).
g(_,0,6). g(_,1,6). g(_,2,6).           g(_,4,6).           g(_,6,6).           g(_,8,6).
                    g(_,2,7).           g(_,4,7).           g(_,6,7).           g(_,8,7).
g(_,0,8). g(_,1,8). g(_,2,8). g(_,3,8). g(_,4,8). g(_,5,8). g(_,6,8). g(_,7,8). g(_,8,8).

/* purple face */
p(0,_,0). p(1,_,0). p(2,_,0). p(3,_,0). p(4,_,0).           p(6,_,0). p(7,_,0). p(8,_,0).
p(2,_,1).                                                                       p(8,_,1).
p(0,_,2).           p(2,_,2). p(3,_,2). p(4,_,2). p(5,_,2). p(6,_,2). p(7,_,2). p(8,_,2).
p(0,_,3).                                                                       p(8,_,3).
p(0,_,4).           p(2,_,4). p(3,_,4). p(4,_,4). p(5,_,4). p(6,_,4).           p(8,_,4).
p(0,_,5).           p(2,_,5).                               p(6,_,5).           p(8,_,5).
p(0,_,6). p(1,_,6). p(2,_,6). p(3,_,6). p(4,_,6).           p(6,_,6). p(7,_,6). p(8,_,6).
                                        p(4,_,7).           p(6,_,7).
p(0,_,8). p(1,_,8). p(2,_,8). p(3,_,8). p(4,_,8).           p(6,_,8). p(7,_,8). p(8,_,8).

move((X0,Y,Z),(X1,Y,Z),"down")    :- X1 is X0+1, r(X1,Y,Z), g(X1,Y,Z), p(X1,Y,Z).
move((X0,Y,Z),(X1,Y,Z),"up")      :- X1 is X0-1, r(X1,Y,Z), g(X1,Y,Z), p(X1,Y,Z).
move((X,Y0,Z),(X,Y1,Z),"right")   :- Y1 is Y0+1, r(X,Y1,Z), g(X,Y1,Z), p(X,Y1,Z).
move((X,Y0,Z),(X,Y1,Z),"left")    :- Y1 is Y0-1, r(X,Y1,Z), g(X,Y1,Z), p(X,Y1,Z).
move((X,Y,Z0),(X,Y,Z1),"forward") :- Z1 is Z0+1, r(X,Y,Z1), g(X,Y,Z1), p(X,Y,Z1).
move((X,Y,Z0),(X,Y,Z1),"back")    :- Z1 is Z0-1, r(X,Y,Z1), g(X,Y,Z1), p(X,Y,Z1).

findpath((X,Y,Z),(X,Y,Z),_,[]).
findpath((X0,Y0,Z0),(X1,Y1,Z1),Visited,[(X2,Y2,Z2,Move)|Moves]) :- move((X0,Y0,Z0),(X2,Y2,Z2),Move),
	\+ member((X2,Y2,Z2),Visited),
	findpath((X2,Y2,Z2),(X1,Y1,Z1),[(X2,Y2,Z2)|Visited],Moves).

findpath(X,Y,Moves) :- findpath(X,Y,[X],Moves).

disp([]).
disp([H|T]) :- print(H), nl, disp(T).

/* Find path from circle to square */
?- findpath((8,4,0),(2,2,6),X), disp(X).

/* Find path from square to circle */
/* ?- findpath((2,2,6),(8,4,0),X), disp(X). */
