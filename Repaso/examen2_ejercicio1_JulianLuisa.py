"""
Examen 2 MOS, ejercicio 1

Ejercicio basado en el archivo multiobjetivoHopsCosts_sumasPonderadas.py:
    Script que calcula el Frente de Pareto (metodo de suma ponderada) de dos funciones objetivo del modelo matematico.
    Autor original: Germán Montoya
    Modificado por: Julián Mora y Luisa Fuentes

Según lo visto en clase, la diferencia más grande entre el método de suma ponderada y el método eConstraint es
que, para eConstraint, en la función objetivo solo se deja una función y la otra se pone de restricción con un épsilon,
el cuál se va variando para obtener el frente de pareto. El épislon se obtiene dependiendo de la función, en este caso
será el número máximo de saltos que se pueden tener, más un valor de tolerancia.   

@author: Julián Mora y Luisa Fuentes
"""


##############################################################################
#####################        LIBRERÍAS        ################################
##############################################################################

#Plot Imports
import matplotlib.pyplot as plt

#Pyomo Imports (Modelo Matematico)
from pyomo.environ import *
from pyomo.opt import SolverFactory

##############################################################################
#####################        FUNCIONES        ################################
##############################################################################

#FUNCION ELIMINAR COMPONENTE
#Se deja igual, puesto a que sin esto no funciona el modelo
def delete_component(Model, comp_name):

        list_del = [vr for vr in vars(Model)
                    if comp_name == vr
                    or vr.startswith(comp_name + '_index')
                    or vr.startswith(comp_name + '_domain')]

        list_del_str = ', '.join(list_del)
        print('Deleting model components ({}).'.format(list_del_str))

        for kk in list_del:
            Model.del_component(kk)


##############################################################################
#####################        MODELO           ################################
##############################################################################

#Esto se deja igual

#Configuración Iteraciones----------------------------------------------------
numIteraciones=11 
iteraciones=range(numIteraciones)
w2_vec=[]
for i in iteraciones:
    valorIter1=i/(numIteraciones-1)
    w2_vec.append(valorIter1)
    
w1=0    
w2=0
    
#Creación Modelo--------------------------------------------------------------
Model = ConcreteModel()

#sets & parameters------------------------------------------------------------
numNodes = 5
Model.N=RangeSet(1,numNodes)

#hops-----------------------------------------------------------------------
Model.h =Param(Model.N, Model.N, mutable=True)

for i in Model.N:
    for j in Model.N:
        Model.h[i,j] = 999


Model.h[1,2] = 1
Model.h[1,3] = 1
Model.h[2,5] = 1
Model.h[3,4] = 1
Model.h[4,5] = 1

#costos-----------------------------------------------------------------------
Model.c =Param(Model.N, Model.N, mutable=True)

for i in Model.N:
    for j in Model.N:
        Model.c[i,j] = 999

Model.c[1,2] = 10
Model.c[1,3] = 5
Model.c[2,5] = 10
Model.c[3,4] = 5
Model.c[4,5] = 5

#origen y destino-----------------------------------------------------------------------
        
s = 1
d = 5
        

#variables--------------------------------------------------------------------
            
#Variable binaria que indica si el enlace (i,j) es seleccionado para hacer parte 
#del camino que va del nodo fuente al nodo destino.
Model.x = Var(Model.N,Model.N, domain=Binary)


# # OBJECTIVE FUNCTIONS*************************************************************

#Función hops
Model.f1 = sum(Model.x[i,j] * Model.h[i,j] for i in Model.N for j in Model.N)

#Función de costos
Model.f2 = sum(Model.x[i,j] * Model.c[i,j] for i in Model.N for j in Model.N)


#Proceso para ejecutar varias veces el modelo matemático con el fin de aplicar el método de eConstraint.


cont=-1
f1_vec=[]
f2_vec=[]

#Definir el épsilon que va a ir disminuyendo
#En este caso es 5, porque es el número máximo de hops que se pueden tener (3) más un valor de tolerancia

e = 5
for k in w2_vec:
    cont=cont+1
    w2=w2_vec[cont]
    w1=1-w2
    
    #Función objetivo general
    #Por el método eConstraint, se deja solo una función, en este caso la función de costos
    Model.O_z = Objective(expr= Model.f2, sense=minimize)
    

    #Las Restricciones se dejan igual, el único cambio es añadir la restricción de la función de hops
    ##Restricción nodo origen
    def source_rule(Model,i):
        if i==s:
            return sum(Model.x[i,j] for j in Model.N)==1
        else:
            return Constraint.Skip

    Model.source=Constraint(Model.N, rule=source_rule)
        
    #Restricción nodo destino
    def destination_rule(Model,j):
        if j==d:
            return sum(Model.x[i,j] for i in Model.N)==1
        else:
            return Constraint.Skip

    Model.destination=Constraint(Model.N, rule=destination_rule)
    
    #Restricción nodo intermedio
    def intermediate_rule(Model,i):
        if i!=s and i!=d:
            return sum(Model.x[i,j] for j in Model.N) - sum(Model.x[j,i] for j in Model.N)==0
        else:
            return Constraint.Skip

    Model.intermediate=Constraint(Model.N, rule=intermediate_rule)

    #Restricción de la función de hops
    def hops_rule(Model):
        return Model.f1 <= e
    
    Model.hops=Constraint(rule=hops_rule)
    

    
    ##Así nos corría el modelo debido a cómo quedó instalado glpsol en nuestro computador, ej: Julián
    solver_path = "C:/Users/julia/anaconda3/envs/newenv/Library/bin/glpsol"
    solver = SolverFactory('glpk', executable=solver_path)
    solver.solve(Model)

    #Así estaba el código originalmente
    #SolverFactory('glpk').solve(Model)
    
    valorF1=value(Model.f1)
    valorF2=value(Model.f2)
    f1_vec.append(valorF1)
    f2_vec.append(valorF2)
    
    delete_component(Model, 'O_z')
    delete_component(Model, 'source')
    delete_component(Model, 'destination')
    delete_component(Model, 'intermediate')
    delete_component(Model, 'hops')
    
    #Se disminuye el épsilon para formar el frente de Pareto,
    #puesto que la idea es decrementarlo hasta que sea infactible.
    e -= 1

    #end for

plt.plot(f1_vec,f2_vec,'o-.');
plt.title('Frente Óptimo de Pareto');
plt.xlabel('F1')
plt.ylabel('F2')

plt.grid(True);
plt.show()

