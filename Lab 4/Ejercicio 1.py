'''
*************************************************************************
***      Lab 4 - Ejercicio 1                                          ***
***                                                                   ***
***      Autores: Julián Mora - Luisa Fuentes                         ***
*************************************************************************
'''

from __future__ import division
from pyomo.environ import *

from pyomo.opt import SolverFactory

import sys
import os

#os.system("clear")

#sys.exit("Stopped")

Model = ConcreteModel()

# SETS & PARAMETERS********************************************************************
numOrigenes=3
numDestinos=2

N=RangeSet(1, numOrigenes)
M=RangeSet(1, numDestinos)
Model.T={'Kernel','Usuario'}

cost={(1,1):300, (1,2):500,\
      (2,1):200, (2,2):300,\
      (3,1):600, (3,2):300}

tiposOrigen={(1,'Kernel'):60, (1,'Usuario'):80,\
             (2,'Kernel'):80, (2,'Usuario'):50,\
             (3,'Kernel'):50, (3,'Usuario'):50}

tiposDestino={(1,'Kernel'):100, (1,'Usuario'):60,\
              (2,'Kernel'):90, (2,'Usuario'):120}

# VARIABLES****************************************************************************
Model.x = Var(N,M,Model.T, domain=NonNegativeIntegers)

# OBJECTIVE FUNCTION*******************************************************************
Model.obj = Objective(expr = sum(Model.x[i,j,k]*cost[i,j] for i in N for j in M for k in Model.T))

# CONSTRAINTS**************************************************************************
def TotalProcesosOrigen(Model,i,k): 
        return sum(Model.x[i,j,k] for j in M)==tiposOrigen[(i,k)]
    
Model.origen=Constraint(N,Model.T, rule=TotalProcesosOrigen)

def TotalProcesosDestino(Model,j,k): 
        return sum(Model.x[i,j,k] for i in N)==tiposDestino[(j,k)]
    
Model.destino=Constraint(M,Model.T, rule=TotalProcesosDestino)
    
# APPLYING THE SOLVER******************************************************************
SolverFactory('glpk').solve(Model)

Model.display()




