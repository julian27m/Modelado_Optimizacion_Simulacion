*************************************************************************
***      Lab 3 - Ejercicio 4                                          ***
***                                                                   ***
***      Autores: Juli�n Mora - Luisa Fuentes                         ***
*************************************************************************

Sets
i lozas  /1-1, 1-2, 1-3, 1-4, 2-1, 2-2, 2-3, 2-4, 3-1, 3-2, 3-3, 3-4, 4-1, 4-2, 4-3, 4-4, 5-1, 5-2, 5-3, 5-4/
j tuberias /A,B,C,D,E,F,L/


Table c(i,j)
       A     B     C     D     E     F     L
1-1    1     0     0     0     0     0     0
1-2    0     0     1     0     0     0     0
1-3    0     0     1     0     0     0     0
1-4    0     0     0     0     0     0     0
2-1    1     1     0     0     0     0     0
2-2    0     0     1     0     0     0     0
2-3    0     0     1     0     0     0     0
2-4    0     0     0     0     0     0     1
3-1    0     1     0     1     0     0     0
3-2    0     0     0     1     1     0     0
3-3    0     0     0     0     1     0     0
3-4    0     0     0     0     0     0     1
4-1    0     0     0     1     0     1     0
4-2    0     0     0     1     1     0     0
4-3    0     0     0     0     1     0     0
4-4    0     0     0     0     0     0     1
5-1    0     0     0     0     0     1     0
5-2    0     0     0     0     0     0     0
5-3    0     0     0     0     0     0     1
5-4    0     0     0     0     0     0     1;


Variables
  x(i)   Indica si se necesita esa losa i-j
  z   Funcion obj
  ;

Binary variable  x(i);

Equations

objectiveFunction

TodasCubiertasSinRepetirTuberia
;

objectiveFunction                     .. z =e= sum((i),x(i));

TodasCubiertasSinRepetirTuberia(j)    ..sum(i,x(i)*c(i,j))=g=1 ;


Model Ejercicio4 /all/;
option mip=CPLEX;
Solve Ejercicio4 using mip minimizing z;

Display z.l;
Display x.l;

