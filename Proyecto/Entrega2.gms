*************************************************************************
***      Entrega 2 - Escenario 1                                      ***
***                                                                   ***
***      Autores: Julián Mora - Luisa Fuentes                         ***
*************************************************************************

Sets
i nodos  /SD1, ML2, ML5, W1, W4, W5, W6, S12, R1, R2, S1, S2, TX1, TX3, TX5, V2, V1, C2, C1, LL0, LL3, RGD0, RGD1, AU1, G1, G3, B1, B3, B4, O1,O3, Q1, Q3/
o origen /ML5/
d destino /W6/
v horas /6:30, 8:00, 9:30, 11:00, 12:30, 14:00, 15:30, 17:00, 18:30/
m pisos maximos /ML2 10, W1 9/
s salida /18:00/
alias(j,i);


Parameter g(i) distancia en X de cada nodo i
         / 1 20, 2 22, 3 9, 4 3, 5 21, 6 29,  14/  ;
Parameter h(i) distancia en Y de cada nodo i 7
         / 1 6, 2 1, 3 2, 4 25, 5 10, 6 2, 7 12/  ;
Parameter k(j) distancia en X de cada nodo j
         / 1 20, 2 22, 3 9, 4 3, 5 21, 6 29, 7 14/  ;
Parameter m(j) distancia en Y de cada nodo j
         / 1 6, 2 1, 3 2, 4 25, 5 10, 6 2, 7 12/  ;

Parameter distancia(i,j);

D('SD1','ML2')=220;
D('SD1','W1')=270;
D('SD1','AU1')=150;
D('ML2','ML5')=15;
D('ML2','W1')=50;
D('ML5','W5')=220;
D('W5','W4')=5;
D('W1','W4')=15;
D('W5','W6')=5;
D('W6','V1')=40;
D('V1','V2')=5;
D('V2','S2')=60;
D('S2','S1')=5;
D('S1','R1')=30;
D('R1','TX1')=20;
D('TX1','TX3')=10;
D('TX3','TX5')=10;
D('R1','R2')=5;
D('R2','TX3')=30;
D('R1','S12')=30;
D('S12','W6')=110;
D('R1','W6')=130;
D('Q1','Q3')=10;
D('Q1','O3')=60;
D('W1','LL0')=70;
D('AU1','RGD0')=60;
D('AU1','RGD1')=90;
D('RGD0','RGD1')=5;
D('RGD1','LL0')=110;
D('RGD1','B1')=100;
D('LL0','LL3')=15;
D('LL3','B3')=50;
D('LL3','C1')=50;
D('B3','B1')=10;
D('B3','B4')=5;
D('C1','B4')=30;
D('C1','O1')=50;
D('C1','C2')=5;
D('C2','O1')=40;
D('O1','B4')=80;
D('Q1','B4')=130;
D('O1','O3')=10;
D('B1','G3')=10;
D('G1','G3')=10;
D('C2','W6')=100;
D('C1','W4')=100;






Table a(i,j)
       1   2   3   4   5   6   7
1      0   1   1   0   1   1   1
2      1   0   1   0   1   1   1
3      1   1   0   0   1   1   1
4      0   0   0   0   0   0   1
5      1   1   1   0   0   1   1
6      1   1   1   0   1   0   1
7      1   1   1   1   1   1   0
;

loop(i,
    loop(j,
       if ((a(i,j) eq 1),
          distancia(i,j)=sqrt(sqr((g(i)-k(j)))+sqr((h(i)-m(j))));
       else
          distancia(i,j)=999;
       );
     );
);


Variables
  x(i,j)   Indica si se activa el nodo o no
  z   Funcion obj
  ;

Binary variable  x(i,j);

Equations

objectiveFunction
sourceNode
destinationNode
intermediateNode
;

objectiveFunction                                 .. z =e= sum((i,j),x(i,j)*distancia(i,j));
sourceNode(i)$(ord(i)=4)                          .. sum((j),x(i,j)) =e= 1;
destinationNode(j)$(ord(j)=6)                     .. sum((i),x(i,j)) =e= 1;
intermediateNode(i)$(ord(i)<>4 and ord(i) ne 6)   .. sum((j), x(i,j)) - sum((j),x(j,i)) =e= 0;




Model Ejercicio4 /all/;
option mip=CPLEX;
Solve Ejercicio4 using mip minimizing z;

Display z.l;
Display x.l;
