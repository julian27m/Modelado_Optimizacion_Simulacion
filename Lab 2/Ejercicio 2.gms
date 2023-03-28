*************************************************************************
***      Lab 2 - Ejercicio 2                                          ***
***                                                                   ***
***      Autores: Julián Mora - Luisa Fuentes                         ***
*************************************************************************

Sets
i tipoTecnica  /S,NS,DL,RL/
j cientificos /C1, C2, C3, C4, C5, C6/
;

Table a(i,j)
       C1   C2   C3   C4   C5   C6
S      85   88   87   82   91   86
NS     78   77   77   76   79   78
DL     82   81   82   80   86   81
RL     84   84   88   83   84   85
;

Variables
  x(i,j)   Indica si un cientifico ya tiene trabajo
  z   Funcion obj
  ;

Binary variable  x(i,j);

Equations

objectiveFunction
CientificoCompety
CientificoNoRepe
;

objectiveFunction         .. z =e= sum((i,j),(a(i,j)*x(i,j)));
CientificoCompety(i)     .. sum((j), x(i,j)) =e= 1;
CientificoNoRepe(j)     .. sum((i), x(i,j)) =l= 1;




Model Ejercicio2 /all/;
option mip=CPLEX;
Solve Ejercicio2 using mip maximizing z;

Display z.l;
Display x.l;
