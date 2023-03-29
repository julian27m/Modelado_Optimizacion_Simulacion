*************************************************************************
***      Lab 3 - Ejercicio 2                                          ***
***                                                                   ***
***      Autores: Julián Mora - Luisa Fuentes                         ***
*************************************************************************

Sets
i pueblo  /1, 2, 3, 4, 5, 6/

alias(j,i)

Parameter
d tiempo max entre pueblos /15/

Table t(i,j) tiempo_pueblos
       1     2     3     4     5     6
1      0     10    20    30    30    20
2      10    0     25    35    20    10
3      20    25    0     15    30    20
4      30    35    15    0     15    25
5      30    20    30    15    0     14
6      20    10    20    25    14    0
;



Variables
  x(i)   Indica si se incluye la estación o no
  z   Funcion obj
  ;

Binary variable  x(i);

Equations

objectiveFunction
TodoCubierto

;

objectiveFunction         .. z =e= sum(i,x(i));
TodoCubierto(i)          .. sum(j$(t(i,j)<=d),x(j)) =g= 1;



Model Ejercicio2 /all/;
option mip=CPLEX;
Solve Ejercicio2 using mip minimizing z;

Display z.l;
Display x.l;
