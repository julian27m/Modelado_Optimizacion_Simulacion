"""
*************************************************************************
***      Proyecto - Entrega 2                                         ***
***      Luisa Fuentes - Julián Mora                                  ***
*************************************************************************
"""

from pyomo.environ import *
from pyomo.opt import SolverFactory

Model = ConcreteModel()

# Sets
Model.i = Set(initialize=['SD1', 'ML2', 'ML5', 'W1', 'W4', 'W5', 'W6', 'S12', 'R1', 'R2', 'S1', 'S2', 'TX1', 'TX3', 'TX5', 'V2', 'V1', 'C2', 'C1', 'LL0', 'LL3', 'RGD0', 'RGD1', 'AU1', 'G1', 'G3', 'B1', 'B3', 'B4', 'O1','O3', 'Q1', 'Q3'])
Model.j = Set(initialize=['SD1', 'ML2', 'ML5', 'W1', 'W4', 'W5', 'W6', 'S12', 'R1', 'R2', 'S1', 'S2', 'TX1', 'TX3', 'TX5', 'V2', 'V1', 'C2', 'C1', 'LL0', 'LL3', 'RGD0', 'RGD1', 'AU1', 'G1', 'G3', 'B1', 'B3', 'B4', 'O1','O3', 'Q1', 'Q3'])
Model.horas = Set(initialize = ['6:25', '6:26', '6:27', '6:28', '6:29', '6:30', '6:31', '6:32', '6:33', '6:34', '6:35', '7:55', '7:56', '7:57', '7:58', '7:59', '8:00', '8:01', '8:02', '8:03', '8:04', '8:05', '9:25', '9:26', '9:27', '9:28', '9:29', '9:30', '9:31', '9:32', '9:33', '9:34', '9:35', '10:55', '10:56', '10:57', '10:58', '10:59', '11:00', '11:01', '11:02', '11:03', '11:04', '11:05', '12:25', '12:26', '12:27', '12:28', '12:29', '12:30', '12:31', '12:32', '12:33', '12:34', '12:35', '13:55', '13:56', '13:57', '13:58', '13:59', '14:00', '14:01', '14:02', '14:03', '14:04', '14:05', '15:25', '15:26', '15:27', '15:28', '15:29', '15:30', '15:31', '15:32', '15:33', '15:34', '15:35', '16:55', '16:56', '16:57', '16:58', '16:59', '17:00', '17:01', '17:02', '17:03', '17:04', '17:05', '18:25', '18:26', '18:27', '18:28', '18:29', '18:30', '18:31', '18:32', '18:33', '18:34', '18:35'])


# Variables

Model.si_no = Var(Model.i,Model.j,within=Binary)

# Parameters
p = {'SD1':10, 'ML2':10, 'ML5':10, 'W1':9, 'W4':9, 'W5':9, 'W6':9, 'S12': 4, 'R1': 2,  'V1':21, 'AU1':4}
hora = '8:00'
origen='W1'
destino='TX5'

D={}
t={}
for i in Model.i:
    for j in Model.j:
        D[(i,j)]=999
        D[(j,i)]=999
            
        
for (i, j), distance in {
    ('SD1', 'ML2'): 220,('SD1', 'W1'): 270,('SD1', 'AU1'): 150,
    ('ML2', 'ML5'): 15,('ML2', 'W1'): 50,('ML5', 'W5'): 50,('W5', 'W4'): 5,
    ('W1', 'W4'): 15,('W5', 'W6'): 5,('W6', 'V1'): 40,('V1', 'V2'): 5,('V2', 'S2'): 60,
    ('S2', 'S1'): 5,('S1', 'R1'): 30,('R1', 'TX1'): 20,('TX1', 'TX3'): 10,('TX3', 'TX5'): 10,
    ('R1', 'R2'): 5,('R2', 'TX3'): 30,('R1', 'S12'): 30,('S12', 'W6'): 110,('R1', 'W6'): 130,
    ('Q1', 'Q3'): 10,('Q1', 'O3'): 60,('W1', 'LL0'): 70,('AU1', 'RGD0'): 60,('AU1', 'RGD1'): 90,
    ('RGD0', 'RGD1'): 5,('RGD1', 'LL0'): 110,('RGD1', 'B1'): 100, ('LL0', 'LL3'): 15,
    ('LL3', 'C1'): 50,('B3', 'B1'): 10,('B3', 'B4'): 5,('C1', 'B4'): 30,('C1', 'O1'): 50,
    ('C2', 'O1'): 40,('O1', 'B4'): 80,('Q1', 'B4'): 130,('O1', 'O3'): 10,('B1', 'G3'): 10,
    ('C2', 'W6'): 100,('C1', 'W4'): 100,('G1', 'G3'): 10,('C1', 'C2'): 5,('LL3', 'B3'): 50,
}.items():
    D[(i, j)] = distance
    D[(j, i)] = distance

#print(D)
pisos_desplazados = 0
for i in Model.i:
    for j in Model.j:
        if  D[(i,j)]==999:
                t[(i,j)]=999
        else:
            if i[:-1] != j[:-1] and i!=j :
                t[(i,j)] = D[(i,j)] / 5
                
            elif i == j:
                t[(i,j)] = 999
            else:
                pisos_desplazados = abs(int(i[-1])-int(j[-1]))   
                #print("entró uwu")
                for key, value in p.items():
                    #revisar los pisos maximos del edificio
                    if key == i:
                        pisos_maximo = value
                        tiempo_asc = 0
                        #Está en hoi,jj,iikira pico
                        if hora in Model.horas:
                            
                            #Como está en hora pico, el ascensor se demora más
                            #10 segundos por piso, hacer dos recorridos completos pasando por cada piso
                            tiempo_asc = 20 * pisos_maximo
                        else:
                            #No está en hora pico, el ascensor no se demora mucho
                            tiempo_asc = pisos_desplazados * 5

                #No toma el ascensor, toma las escaleras, entonces se demora 7 segundos en subir cada piso
                tiempo_esc = pisos_desplazados*7
                t[(i,j)] = min(tiempo_asc,tiempo_esc)

                #if tiempo_asc<tiempo_esc:
                    #print("Escogío el ascensor")
                #else:
                    #print("Escogío las escaleras")

# Equations
Model.obj = Objective(expr=sum((t[i,j])*Model.si_no[i,j] for i in Model.i for j in Model.j),sense=minimize)


def source_node_rule(Model,i):
    if i == origen:
        return sum(Model.si_no[i,j] for j in Model.j) == 1
    else:
        return Constraint.Skip

Model.source_node = Constraint(Model.i,rule=source_node_rule)

def destination_node_rule(Model,j):
    if j == destino:
        return sum(Model.si_no[i,j] for i in Model.i) == 1
    else:
        return Constraint.Skip

Model.destination_node = Constraint(Model.j,rule=destination_node_rule)

def intermediate_node_rule(Model,i):
    if i != origen and i != destino:
        return sum(Model.si_no[(i,j)] for j in Model.j) - sum(Model.si_no[(j,i)] for j in Model.j) == 0
    else:
        return Constraint.Skip
    
Model.intermediate_node = Constraint(Model.i,rule=intermediate_node_rule)

def noRepLink(Model,i,j):
    if i != origen and i != destino:
        return sum([Model.si_no[i,j], Model.si_no[j,i]]) <= 1
    else:
        return Constraint.Skip
    
Model.noRepLink = Constraint(Model.i,Model.j,rule=noRepLink)

# Solve
SolverFactory('glpk').solve(Model)
Model.si_no.display()
for key, value in {k:v for k,v in Model.si_no.items() if v() == 1}.items():
    print(key, value())
#print(D)
# Print the results