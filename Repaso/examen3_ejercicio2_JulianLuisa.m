clc, clear all, close all

% Parcial 3 - Ejercicio 2
% Julian y Luisa
% 5 es el numero mínimo de telefonos con los que se obtiene un porcentaje
% del 100% de aceptacion de llamadas

%Inicializacion de parámetros y variables
NMAX=100;
Na=0; %número de llamadas
Nb=0; %número de llamadas aceptadas
Nc=0; %número de llamadas finalizadas
N_llamDen=0; %número de llamdas denegadas
n = 5; %el numero de telefonos disponibles en el callcenter



%inicialización del tiempo.
t=0;

%vectores para mostrar grafica al final de la simulación
vec_t=[]; %almacena el valor del tiempo en cada iteración
vec_porcLlamAcep=[]; %almacena el porcentaje de llamadas aceptadas a medida que avanza el tiempo

%Programacion del evento inicial
evt.t=unidrnd(10);
evt.type='A';

%Programacion en la cola de eventos
evtQueue=evt;

%Asignacion telefonos Free
l = 0;
dict_Free = struct();

while l<n
    clave = sprintf('free%d', l);
    dict_Free.(clave) = 1;
    l = l + 1;
end 
dict_Free
llaves = fieldnames(dict_Free); 
%Desarrollo de la simulacion
while length(evtQueue)>0
    evtAct=evtQueue(1);
    evtQueue(1)=[];

    t=evtAct.t;

    %Procesamiento del evento
    if evtAct.type=='A'
        %Modificacion de variables
        Na=Na+1;

        %Programacion de nuevos eventos
        newEvt.t=t;
        newEvt.type='B';
        evtQueue=[evtQueue newEvt];
        if Na<NMAX
            newEvt.t=t+unidrnd(10);
            newEvt.type='A';
            evtQueue=[evtQueue newEvt];
        end
        %fprintf('Ocurre evento A: Llamada nueva \n');
    end

    if evtAct.type=='B'
        %Modificacion de variables
        
        for i = 1:numel(llaves)
            llave = llaves{i}; % Obtener la clave actual
            valor = dict_Free.(llave); % Obtener el valor correspondiente a la clave
            %fprintf('Clave: %s, Valor: %d\n', clave, valor); % Mostrar la clave y el valor
            llave, valor
            if valor==1
                dict_Free.(llave) = 0;
                Nb=Nb+1;
                newEvt.t=t+unidrnd(20);
                newEvt.type='C';
                evtQueue=[evtQueue newEvt];
                break
            end
        end
        
    end

    if evtAct.type=='C'
        for j = 1:numel(llaves)
            llave = llaves{j}; % Obtener la clave actual
            valor = dict_Free.(llave); % Obtener el valor correspondiente a la clave
            %fprintf('Clave: %s, Valor: %d\n', clave, valor); % Mostrar la clave y el valor
            
            if valor ==0
                Nc=Nc+1;
                dict_Free.(llave) = 1;
                break
            end
        end
    end

    vec_t=[vec_t t];
    porcLlamAcep=(Nb/Na)*100;
    vec_porcLlamAcep=[vec_porcLlamAcep porcLlamAcep];

    %Variables de estado actuales
    %fprintf('T=%f -> Na=%d, Nb=%d, Free=%d, Free2=%d PorcLlamAcep=%2d \n',t, Na, Nb, Free,Free2, porcLlamAcep);

    %Organizacion de la cola de eventos
    flag=1;
    while flag==1
        flag=0;
        for i=1:(length(evtQueue)-1)
            if evtQueue(i).t>evtQueue(i+1).t
                temp=evtQueue(i);
                evtQueue(i)=evtQueue(i+1);
                evtQueue(i+1)=temp;
                flag=1;
            end
        end
    end
    %Mostrado de la cola de eventos:
    %fprintf('\nCola de eventos:\n');
    for i=1:length(evtQueue)
        %fprintf('Evento %s en t=%f\n',evtQueue(i).type,evtQueue(i).t);
    end
    %fprintf('----------------\n');
    %pause(1);
end

figure
plot(vec_t,vec_porcLlamAcep, '-o')
title('Desempeño del Callcenter');
xlabel('Tiempo [min]');
ylabel('% de aceptación de llamadas');
ylim([0 110])


