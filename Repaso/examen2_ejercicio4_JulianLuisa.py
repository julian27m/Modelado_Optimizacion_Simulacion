x1_dado=3 #Coeficiente de x1
x2_dado=2 #Coeficiente de x2

def simplex(lista_FEVs):
    dict_adyacentes = {}
    puntos_ord = sorted(lista_FEVs,  key=lambda t: (t == (0, 0), t[0], -t[1]))

    print(puntos_ord)

    # Calcular los puntos adyacentes
    for i in range(len(puntos_ord)):
        punto_act = puntos_ord[i]
        punto_ant = puntos_ord[i - 1]
        punto_sig = puntos_ord[(i + 1) % len(puntos_ord)]

        # Verificar si el punto anterior es adyacente
        if punto_ant[0] != punto_act[0] or punto_ant[1] != punto_act[1]:
            if punto_act not in dict_adyacentes:
                dict_adyacentes[punto_act] = []
            dict_adyacentes[punto_act].append(punto_ant)

        # Verificar si el punto siguiente es adyacente
        if punto_sig[0] != punto_act[0] or punto_sig[1] != punto_act[1]:
            if punto_act not in dict_adyacentes:
                dict_adyacentes[punto_act] = []
            dict_adyacentes[punto_act].append(punto_sig)

    #print(dict_adyacentes)
    z_max=0.0
    x1_max=0.0
    x2_max=0.0
    for llave in dict_adyacentes:
        x1=llave[0]
        x2=llave[1]
        z=(x1_dado*x1) + (x2_dado*x2)
        #print(z,"actual")
        lista_adyacentes_key= dict_adyacentes.get(llave)
        for adyacente in lista_adyacentes_key:
            es_mejor=False
            z_ady=(x1_dado*adyacente[0]) + (x2_dado*adyacente[1])
            #print(z_ady,adyacente[0], adyacente[1])
            if z_ady>=z:
                es_mejor=True
                if z_ady>=z_max:
                    z_max=z_ady
                    x1_max=adyacente[0]
                    x2_max=adyacente[1]
            #print( z_max, x1_max, x2_max  ,"max por ady" )
        if  es_mejor==False :  
            #print( z_max,x1_max,x2_max)
            return ('z: '+ str(z_max),'x1: '+ str(x1_max),'x2: '+ str(x2_max))
     
#lista_FEVs=[(0,0), (4,0), (3,1.5), (2,2), (1,2), (0,1)] 
#lista_FEVs=[(0,0), (0,6), (2,6), (4,3), (4,0)]
lista_FEVs=[(0,0), (40,0), (20,60), (40,20), (0,80)]#coordenadas de cada uno de los vértices del espacio de soluciones factibles
print(simplex(lista_FEVs))