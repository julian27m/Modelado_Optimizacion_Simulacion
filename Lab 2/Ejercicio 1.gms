
*************************************************************************
***      Lab 2 - Ejercicio 1                                          ***
***                                                                   ***
***      Autores: Julián Mora - Luisa Fuentes                         ***
*************************************************************************

Sets
i procesadorOrigen /UNO, DOS, TRES/
j procesadorDestino  /D1, D2/
k tipoProceso /Kernel, Usuario/
;


Table c(i,j) costos
       D1   D2
UNO    300  500
DOS    200  300
TRES   600  300;

Table o(i,k) procesos que dispone el origen i
       Kernel   Usuario
UNO    60       80
DOS    80       50
TRES   50       50;

Table d(j,k) procesos que dispone el destino j
       Kernel   Usuario
D1    100       60
D2    90       120;


Variables

  w(i,j,k) cantidad de procesos tipo k de i a j
  z   Funcion obj
  ;

Positive variable w(i,j,k) ;

Equations

objectiveFunction

TotalProcesosOrigen
TotalProcesosDestino
;

objectiveFunction                           .. z =e= sum((i,j,k), c(i,j)*w(i,j,k));


TotalProcesosOrigen(i,k)                          .. sum(j,w(i,j,k)) =e=  o(i,k);
TotalProcesosDestino(j,k)                         .. sum(i,w(i,j,k)) =e=  d(j,k);


Model Ejercicio1 /all/;
option mip=CPLEX;
Solve Ejercicio1 using mip minimizing z;

Display w.l;
Display z.l;
