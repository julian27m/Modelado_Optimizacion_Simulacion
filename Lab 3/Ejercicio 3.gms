*************************************************************************
***      Lab 3 - Ejercicio 3                                          ***
***                                                                   ***
***      Autores: Julián Mora - Luisa Fuentes                         ***
*************************************************************************

Sets
i cancion  /1, 2, 3, 4, 5, 6, 7, 8/
j tipo /BluesRock, RockAndRoll/
k duracion /2,3,4,5/
alias(p,i)

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

  a(i) esta en lado A del disco
  b(i) esta en lado B del disco
  z   Funcion obj
  ;


Binary variable a(i),b(i);

Equations

objectiveFunction
SiEsANoEsB
DuracionLadoAPlus
DuracionLadoBPlus
DuracionLadoAMinus
DuracionLadoBMinus
LadoA2Blues
LadoB2Blues
LadoAAlmenos3Rock
Si1EnA5NoEnA
Si2y4EnA1EnB
;

objectiveFunction                    .. z =e= sum(i,d(i));
SiEsANoEsB(i)                        .. 1 - b(i) =g= a(i);
DuracionLadoAPlus                    .. sum(i, d(i)*a(i)) =l= 16;
DuracionLadoBPlus                    .. sum(i, d(i)*b(i)) =l= 16;
DuracionLadoAMinus                   .. sum(i, d(i)*a(i)) =g= 14;
DuracionLadoBMinus                   .. sum(i, d(i)*b(i)) =g= 14;
LadoA2Blues(j)$(ord(j)=1)            ..sum(i,t(i,j)*a(i)) =e= 2;
LadoB2Blues(j)$(ord(j)=1)            ..sum(i,t(i,j)*b(i)) =e= 2;
LadoAAlmenos3Rock(j)$(ord(j)=2)      ..sum(i,t(i,j)*a(i)) =g= 3;
Si1EnA5NoEnA                         .. 1 - a('5') =g= a('1');
Si2y4EnA1EnB                         .. b('1') =g= a('2')+a('4')-1 ;


Model Ejercicio3 /all/;
option mip=CPLEX;
Solve Ejercicio3 using mip maximizing z;

Display z.l;
Display a.l;
Display b.l;
