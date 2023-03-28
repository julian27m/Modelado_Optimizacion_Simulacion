*************************************************************************
***      Lab 1 - Ejercicio 2                                          ***
***                                                                   ***
***      Autores: Julián Mora - Luisa Fuentes                         ***
*************************************************************************

Sets
i empleados /UNO, DOS, TRES, CUATRO/
j trabajos  /T1, T2, T3, T4/


Table c(i,j) tiempo por empleados
       T1   T2   T3   T4
UNO    14   5    8    7
DOS    2    12   6    5
TRES   7    8    3    9
CUATRO 2    4    6    10 ;

Variables
  x(i,j) determina si el empleado tiene trabajo asignado
  z   Funcion obj
  ;

Binary variable x;

Equations

objectiveFunction
EmpleadoConTrabajo
TrabajoConEmpleado;

objectiveFunction                           .. z =e= sum((i,j),(c(i,j)*x(i,j)));
EmpleadoConTrabajo(j)                            .. sum((i), x(i,j)) =e= 1;
TrabajoConEmpleado(i)                             .. sum((j), x(i,j)) =e= 1;


Model Ejercicio2 /all/;
option mip=CPLEX;
Solve Ejercicio2 using mip minimizing z;

Display x.l;
Display z.l;
