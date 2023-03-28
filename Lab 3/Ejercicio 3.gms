*************************************************************************
***      Lab 3 - Ejercicio 3                                          ***
***                                                                   ***
***      Autores: Julián Mora - Luisa Fuentes                         ***
*************************************************************************

Sets
i cancion  /1, 2, 3, 4, 5, 6, 7, 8/
j tipo /BluesRock, RockAndRoll/
k duracion /2,3,4,5/
w lado /A,B/

Parameter d(i) cancionDuracion
         / 1 4, 2 5, 3 3, 4 2, 5 4, 6 3, 7 5, 8 4/  ;

Table t(i,j) cancionTipo
       BluesRock     RockAndRoll
1      1             0
2      0             1
3      1             0
4      0             1
5      1             0
6      0             1
7      0             0
8      1             1
;


Variables
  x(i,w)   cancion que se escoge para cada lado
  z   Funcion obj
  ;

Binary variable  x(i);

Equations

objectiveFunction
DuracionLados
DuracionLadosAlto

;

objectiveFunction         .. z =e= sum(i,x(i));
DuracionLados(w)          .. sum(i,(x(i,w))*d(i)) =g= 14;
DuracionLadosAlto(w)          .. sum(i,(x(i,w))*d(i)) =l= 16;



Model Ejercicio3 /all/;
option mip=CPLEX;
Solve Ejercicio3 using mip minimizing z;

Display z.l;
Display x.l;
