*************************************************************************
***      Lab 1 - Ejercicio 1                                          ***
***                                                                   ***
***      Autores: Julián Mora - Luisa Fuentes                         ***
*************************************************************************

Sets
i artículos /A, B, C, D, E/;

Parameter g(i) valor de cada objeto i
         / A 12, B 5, C 9, D 6, E 4/  ;
Parameter h(i) peso de cada objeto i
         / A 9, B 2, C 2, D 1, E 3/  ;

Variables
  x(i) determina si puede llevar el artículo en la mochila
  z   Funcion obj
  ;

Binary variable x;

Equations

objectiveFunction
pesos;

objectiveFunction                           .. z =e= sum(i,(g(i)*x(i)));
pesos                                       .. sum(i,(h(i)*x(i))) =l= 10;



Model Ejercicio1 /all/;
option mip=CPLEX;
Solve Ejercicio1 using mip maximizing z;

Display x.l;
Display z.l;
