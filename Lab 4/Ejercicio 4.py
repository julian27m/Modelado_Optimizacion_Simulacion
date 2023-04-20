'''
*************************************************************************
***      Lab 4 - Ejercicio 4                                          ***
***                                                                   ***
***      Autores: Julián Mora - Luisa Fuentes                         ***
*************************************************************************
'''
from __future__ import division
from pyomo.environ import *

from pyomo.opt import SolverFactory

import sys
import os

os.system("cls")

#sys.exit("Stopped")

Model = ConcreteModel()

# SETS & PARAMETERS********************************************************************
numNodes=7
N=RangeSet(1, numNodes)

    #distancia en X de cada nodo i 
Model.a=Param(N, mutable=True)
Model.a[1] = 20
Model.a[2] = 22
Model.a[3] = 9
Model.a[4] = 3
Model.a[5] = 21
Model.a[6] = 29
Model.a[7] = 14

    #distancia en Y de cada nodo i 
Model.b=Param(N, mutable=True)
Model.b[1] = 6
Model.b[2] = 1
Model.b[3] = 2
Model.b[4] = 25
Model.b[5] = 10
Model.b[6] = 2
Model.b[7] = 12

    #distancia en X de cada nodo j
Model.c=Param(N, mutable=True)
Model.c[1] = 20
Model.c[2] = 22
Model.c[3] = 9
Model.c[4] = 3
Model.c[5] = 21
Model.c[6] = 29
Model.c[7] = 14

    #distancia en Y de cada nodo j
Model.d=Param(N, mutable=True)
Model.d[1] = 6
Model.d[2] = 1
Model.d[3] = 2
Model.d[4] = 25
Model.d[5] = 10
Model.d[6] = 2
Model.d[7] = 12

hayEnlace={(1,1):0, (1,2):1, (1,3):1, (1,4):0, (1,5):1, (1,6):1, (1,7):1,\
           (2,1):1, (2,2):0, (2,3):1, (2,4):0, (2,5):1, (2,6):1, (2,7):1,\
           (3,1):1, (3,2):1, (3,3):0, (3,4):0, (3,5):1, (3,6):1, (3,7):1,\
           (4,1):0, (4,2):0, (4,3):0, (4,4):0, (4,5):0, (4,6):0, (4,7):1,\
           (5,1):1, (5,2):1, (5,3):1, (5,4):0, (5,5):0, (5,6):1, (5,7):1,\
           (6,1):1, (6,2):1, (6,3):1, (6,4):0, (6,5):1, (6,6):0, (6,7):1,\
           (7,1):1, (7,2):1, (7,3):1, (7,4):1, (7,5):1, (7,6):1, (7,7):0}

Model.h =Param(N,N, mutable=True)

for i in N:
    for j in N:
        if hayEnlace[(i,j)]==1:
            Model.h[i,j]= sqrt(((Model.a[i]-Model.c[j])**2)+((Model.b[i]-Model.d[j])**2))

        else:
            Model.h[i,j]=999
       
        
# VARIABLES****************************************************************************
Model.x = Var(N,N, domain=Binary)

# OBJECTIVE FUNCTION*******************************************************************
Model.obj = Objective(expr = sum(Model.x[i,j]* Model.h[i,j] for i in N for j in N ))

# CONSTRAINTS**************************************************************************
def sourceNode(Model,i): 
        if i==4:
            return sum(Model.x[i,j] for j in N)==1
        else:
            return Constraint.Skip
    
Model.source=Constraint(N, rule=sourceNode)

def destinationNode(Model,j): 
        if j==6:
            return sum(Model.x[i,j] for i in N)==1
        else:
            return Constraint.Skip
    
Model.destination=Constraint(N, rule=destinationNode)

def intermediateNode(Model,i): 
        if i!=4 and i!=6:
            return (sum(Model.x[i,j] for j in N) - sum(Model.x[j,i] for j in N))==0
        else:
            return Constraint.Skip
    
Model.intermediate=Constraint(N, rule=intermediateNode)

SolverFactory('glpk').solve(Model)
Model.display()