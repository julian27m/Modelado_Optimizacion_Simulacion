*************************************************************************
***      Lab 1 - Ejercicio 3                                          ***
***                                                                   ***
***      Autores: Julián Mora - Luisa Fuentes                         ***
*************************************************************************

Sets
i procesadorOrigen /UNO, DOS, TRES/
j procesadorDestino  /D1, D2, D3, D4/
;
Parameter g(i) cantidad de procesos a suministrar por cada procesador i
         / UNO 300, DOS 500, TRES 200/  ;
Parameter h(j) cantidad de procesos demandada por cada procesador j
         / D1 200, D2 300, D3 100, D4 400/  ;


Table c(i,j) costos
       D1   D2   D3   D4
UNO    8    6    10   9
DOS    9    12   13   7
TRES   14   9    16   5;

Variables
  x(i,j) cant procesos desde i a j
  z   Funcion obj
  ;

Positive variable x(i,j);

Equations

objectiveFunction
ProcesosOriginadosPorOrigen
ProcesosOriginadosPorDestino
;

objectiveFunction                           .. z =e= sum((i,j), c(i,j)*x(i,j));

ProcesosOriginadosPorOrigen  (i)            .. sum(j, x(i,j)) =e= g(i);
ProcesosOriginadosPorDestino (j)            .. sum(i, x(i,j)) =e= h(j);


Model Ejercicio3 /all/;
option mip=CPLEX;
Solve Ejercicio3 using mip minimizing z;

Display x.l;
Display z.l;
