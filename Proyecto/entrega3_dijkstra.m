function [sp, spcost] = entrega3_dijkstra(t, origen, destino)
    
    % Implementación del algoritmo de Dijkstra para encontrar el camino más
    % corto entre dos nodos de la Universidad de los Andes.
    % Basado en la implementación de Jorge Ignacio Barrera Alviar. 2007
    %   %This implementatios is inspired by the Xiaodong Wang's implememtation of
    %   the dijkstra's algorithm, available at
    %   http://www.mathworks.com/matlabcentral/fileexchange
    %   file ID 5550
    
    % Autores: Julian Mora y Luisa Fuentes
    

    % Obtener el número de nodos
    num_nodos = size(t, 1);
    nodos = {'SD1', 'ML2', 'W1', 'AU1', 'ML5', 'W5', 'W4', 'W6', 'V1', 'V2', 'S2', 'S1', 'R1', 'TX1', 'TX3', 'TX5', 'R2', 'S12', 'Q1', 'Q3', 'O3', 'LL0', 'RGD0', 'RGD1', 'B1', 'LL3', 'C1', 'B3', 'B4', 'O1', 'C2', 'G3', 'G1'};

    % Inicializar distancias y visitados
    S(1:num_nodos) = 0; % Vector de nodos visitados
    distancias = Inf(1, num_nodos);
    
    % El nodo de origen tiene distancia cero
    distancias(strcmp(origen, nodos)) = 0;
    
    P = 1;
    flag1 = 1;
    
    while flag1 == 1
        while sum(S) ~= num_nodos
            candidatos = [];
            for i = 1:num_nodos
                if S(i) == 0
                    candidatos = [candidatos distancias(i)];
                else
                    candidatos = [candidatos Inf];
                end
            end
            
            [u_index, u] = min(candidatos);
            S(u) = 1;
            
            for i = 1:num_nodos
                if (distancias(u) + t(u, i)) < distancias(i)
                    distancias(i) = distancias(u) + t(u, i);
                end
            end
        end
        
        if isinf(distancias(strcmp(destino, nodos)))
            sp = [];
            spcost = Inf;
            P = 0;
        else
            nodo_actual = strcmp(destino, nodos);
            sp = destino;
            spcost = distancias(nodo_actual);
            while ~strcmp(origen, nodos{nodo_actual})
                vecinos = find(t(:, nodo_actual) < Inf);
                [~, nodo_anterior] = min(distancias(vecinos));
                nodo_actual = vecinos(nodo_anterior);
                sp = [nodos{nodo_actual} sp];
            end
            P = 1;
        end
        
        flag1 = 0;
    end
end
