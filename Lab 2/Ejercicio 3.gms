*************************************************************************
***      Lab 2 - Ejercicio 3                                          ***
***                                                                   ***
***      Autores: Julián Mora - Luisa Fuentes                         ***
*************************************************************************

Sets
i zonas  /1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12/
j zonasA /1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12/
;

Table a(i,j)
       1   2   3   4   5   6   7   8   9   10   11   12
1      1   1   1   0   1   0   0   0   0   0    0    0
2      1   1   0   0   0   0   0   0   0   0    0    0
3      1   0   1   1   1   1   1   1   0   0    0    0
4      0   0   1   1   1   1   0   0   0   0    1    0
5      1   1   1   1   1   0   0   0   0   1    1    0
6      0   0   1   1   0   1   0   1   0   0    1    0
7      0   0   1   0   0   0   1   1   0   0    0    1
8      0   0   1   0   0   1   1   1   1   0    1    1
9      0   0   0   0   0   0   0   1   1   1    1    1
10     0   0   0   0   1   0   0   0   1   1    1    0
11     0   0   0   1   1   1   0   1   1   1    1    0
12     0   0   0   0   0   0   1   1   1   0    0    1;

Variables
  x(i)   Indica si se incluye la antena o no
  z   Funcion obj
  ;

Binary variable  x(i);

Equations

objectiveFunction
TodasCubiertas
;

objectiveFunction         .. z =e= sum(i,x(i));
TodasCubiertas(j)          .. sum(i,x(i)*a(i,j)) =g= 1;




Model Ejercicio3 /all/;
option mip=CPLEX;
Solve Ejercicio3 using mip minimizing z;

Display z.l;
Display x.l;
