*************************************************************************
***      Lab 3 - Ejercicio 4                                          ***
***                                                                   ***
***      Autores: Julián Mora - Luisa Fuentes                         ***
*************************************************************************

Sets
i tuberiasfil  /Fila1, Fila2, Fila3, Fila4, Fila5/
j tuberiascol /Columna1, Columna2, Columna3, Columna4/
*i tuberiasfil  /A,B,C,D1,D2,D3,E,F,L/
*j tuberiascol /A,B,C,D1,D2,D3,E,F,L/
k tuberias /A,B,C,D,E,F,L/


$ontext

Table t(i,j)
       A   B   C   D1   D2   D3   E   F   L
A      1   1   0   0    0    0    0   0   0
B      1   1   0   1    0    0    0   0   0
C      0   0   1   0    0    0    0   0   0
D1     0   1   0   1    0    0    0   0   0
D2     0   0   0   0    1    0    1   0   0
D3     0   0   0   0    0    1    0   1   0
E      0   0   0   0    1    0    1   0   0
F      0   0   0   0    0    1    0   1   0
L      0   0   0   0    0    0    0   0   1;




$offtext



Table t(i,j)
       Columna1   Columna2   Columna3   Columna4
Fila1  1          1          1          0
Fila2  2          1          1          1
Fila3  2          2          1          1
Fila4  2          2          1          1
Fila5  1          0          1          1;



Variables
  x(i,j)   Indica si se necesita esa losa
*  y(k)     tuberia cubierta
  z   Funcion obj
  ;

Binary variable  x(i,j);

Equations

objectiveFunction
TodasCubiertas
;

objectiveFunction         .. z =e= sum(i,sum(j,x(i,j)));
TodasCubiertas(j)          .. sum(i,x(i,j)*t(i,j)) =e= 1;





Model Ejercicio4 /all/;
option mip=CPLEX;
Solve Ejercicio4 using mip minimizing z;

Display z.l;
Display x.l;
