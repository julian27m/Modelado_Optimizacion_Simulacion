*************************************************************************
***      Lab 3 - Ejercicio 1                                          ***
***                                                                   ***
***      Autores: Julián Mora - Luisa Fuentes                         ***
*************************************************************************

Sets
i jugador  /1, 2, 3, 4, 5, 6, 7/
j rol /Ataque, Defensa, Centro/
k caracteristica /Control, Disparo, Rebotes, Defensas/

Parameter g(j) carac
         / Ataque 2, Defensa 4, Centro 1/  ;

Table r(i,j) roles
       Ataque   Defensa   Centro
1      1        0         0
2      0        0         1
3      1        1         0
4      0        1         1
5      1        1         0
6      0        1         1
7      1        1         0
;

Table c(i,k) caracteristicas
       Control   Disparo   Rebotes   Defensas
1      3         3         1         3
2      2         1         3         2
3      2         3         2         2
4      1         3         3         1
5      3         3         3         3
6      3         1         2         3
7      3         2         2         1
;

Variables
  x(i)   Indica si se elige al jugador como titular
  z   Funcion obj
  ;

Binary variable  x(i);

Equations

objectiveFunction
cincoJugadores
rolesJugadores
promediosJugadores
cond1
;

objectiveFunction                            .. z =e= sum((i),x(i)*c(i,'Defensas'));
cincoJugadores                               .. sum((i),x(i)) =e= 5;
rolesJugadores(j)                            .. sum((i),r(i,j)*x(i)) =g= g(j);
promediosJugadores(k)$(ord(k)<>4)       .. sum((i),c(i,k)*x(i))/5 =g= 2;
cond1                                    .. 1-x('3')=g=x('2');


Model Ejercicio4 /all/;
option mip=CPLEX;
Solve Ejercicio4 using mip maximizing z;

Display z.l;
Display x.l;
