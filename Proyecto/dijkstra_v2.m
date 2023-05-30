function [sp, spcost] = dijkstra_v2(t, origen, destino)
    % Obtener el número de nodos
    num_nodos = size(t, 1);
    nodos = {'SD1', 'ML2', 'W1', 'AU1', 'ML5', 'W5', 'W4', 'W6', 'V1', 'V2', 'S2', 'S1', 'R1', 'TX1', 'TX3', 'TX5', 'R2', 'S12', 'Q1', 'Q3', 'O3', 'LL0', 'RGD0', 'RGD1', 'B1', 'LL3', 'C1', 'B3', 'B4', 'O1', 'C2', 'G3', 'G1'};


    % Inicializar distancias y visitados
    distancias = Inf(1, num_nodos);
    visitados = false(1, num_nodos);

    % El nodo de origen tiene distancia cero
    distancias(strcmp(origen, nodos)) = 0;

    % Bucle principal
    for i = 1:num_nodos
        % Encontrar el nodo no visitado con la distancia mínima actual
        nodo_actual = obtener_nodo_minimo(distancias, visitados);
        visitados(nodo_actual) = true;

        % Si se ha alcanzado el destino, terminar
        if strcmp(nodos{nodo_actual}, destino)
            break;
        end

        % Actualizar las distancias de los nodos vecinos no visitados
        for j = 1:num_nodos
            if ~visitados(j) && t(nodo_actual, j) < Inf
                nueva_distancia = distancias(nodo_actual) + t(nodo_actual, j);
                if nueva_distancia < distancias(j)
                    distancias(j) = nueva_distancia;
                end
            end
        end
    end

    % Construir el camino más corto y su costo
    if isinf(distancias(strcmp(destino, nodos)))
        sp = [];
        spcost = Inf;
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
    end
end

function nodo_minimo = obtener_nodo_minimo(distancias, visitados)
    % Obtener el nodo no visitado con la distancia mínima actual
    distancias_temp = distancias;
    distancias_temp(visitados) = Inf;
    [~, nodo_minimo] = min(distancias_temp);
end
