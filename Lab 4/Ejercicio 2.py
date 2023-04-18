'''
*************************************************************************
***      Lab 4 - Ejercicio 2                                          ***
***                                                                   ***
***      Autores: Julián Mora - Luisa Fuentes                         ***
*************************************************************************
'''

from pyomo.environ import *
from pyomo.opt import SolverFactory

import sys
import os

#os.system("clear")

#sys.exit("Stopped")


# Model
model = ConcreteModel()

#SETS AND PARAMETERS**********************************************************
i = [1, 2, 3, 4, 5, 6]
j = [1, 2, 3, 4, 5, 6]

d = 15

t = {
    (1,1): 0, (1,2): 10, (1,3): 20, (1,4): 30, (1,5): 30, (1,6): 20,
    (2,1): 10, (2,2): 0, (2,3): 25, (2,4): 35, (2,5): 20, (2,6): 10,
    (3,1): 20, (3,2): 25, (3,3): 0, (3,4): 15, (3,5): 30, (3,6): 20,
    (4,1): 30, (4,2): 35, (4,3): 15, (4,4): 0, (4,5): 15, (4,6): 25,
    (5,1): 30, (5,2): 20, (5,3): 30, (5,4): 15, (5,5): 0, (5,6): 14,
    (6,1): 20, (6,2): 10, (6,3): 20, (6,4): 25, (6,5): 14, (6,6): 0,
}





#VARIABLES*********************************************************************
model.x = Var(i, domain=Binary)


#OBJECTIVE FUNCTION************************************************************
model.z = Objective(expr=sum(model.x[i] for i in i), sense=minimize)


# CONSTRAINTS******************************************************************
def todo_cubierto_rule(model, i):
    return sum(model.x[j] for j in j if t[i, j] <= d) >= 1

model.todo_cubierto = Constraint(i, rule=todo_cubierto_rule)



#APPLYING THE SOLVER************************************************************
SolverFactory('glpk').solve(model)
model.display()

