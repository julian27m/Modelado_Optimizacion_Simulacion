*************************************************************************
***      Lab 2 - Ejercicio 4                                          ***
***                                                                   ***
***      Autores: Juli�n Mora - Luisa Fuentes                         ***
*************************************************************************

Sets
i nodos  /1, 2, 3, 4, 5, 6, 7/
alias(j,i);


Parameter g(i) distancia en X de cada nodo i
         / 1 20, 2 22, 3 9, 4 3, 5 21, 6 29, 7 14/  ;
Parameter h(i) distancia en Y de cada nodo i
         / 1 6, 2 1, 3 2, 4 25, 5 10, 6 2, 7 12/  ;
Parameter k(j) distancia en X de cada nodo j
         / 1 20, 2 22, 3 9, 4 3, 5 21, 6 29, 7 14/  ;
Parameter m(j) distancia en Y de cada nodo j
         / 1 6, 2 1, 3 2, 4 25, 5 10, 6 2, 7 12/  ;

Parameter distancia(i,j);

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
