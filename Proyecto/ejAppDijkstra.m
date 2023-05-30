clc;
clear;
close all;

hora = '9:30';
p = struct('SD1', 10, 'ML2', 10, 'ML5', 10, 'W1',9, 'W4',9, 'W5',9, 'W6', 9, 'S12', 4, 'R1', 4, 'R2', 4, 'S1', 4, 'S2', 4, 'TX1', 7, 'TX3', 7, 'TX5', 7, 'V2', 2, 'V1', 2, 'C2', 7,'C1', 7, 'LL0', 3, 'LL3', 3, 'RGD0', 7, 'RGD1', 7, 'AU1', 3, 'G1', 3, 'G3', 3, 'B1', 4, 'B3', 4, 'B4', 4, 'O1', 3, 'O3', 3, 'Q1', 8, 'Q3', 8);
keys = fieldnames(p);  % Obtiene los nombres de los campos
values = struct2cell(p);  % Obtiene los valores de los campos

horas= ['6:25', '6:26', '6:27', '6:28', '6:29', '6:30', '6:31', '6:32', '6:33', '6:34', '6:35', '7:55', '7:56', '7:57', '7:58', '7:59', '8:00', '8:01', '8:02', '8:03', '8:04', '8:05', '9:25', '9:26', '9:27', '9:28', '9:29', '9:30', '9:31', '9:32', '9:33', '9:34', '9:35', '10:55', '10:56', '10:57', '10:58', '10:59', '11:00', '11:01', '11:02', '11:03', '11:04', '11:05', '12:25', '12:26', '12:27', '12:28', '12:29', '12:30', '12:31', '12:32', '12:33', '12:34', '12:35', '13:55', '13:56', '13:57', '13:58', '13:59', '14:00', '14:01', '14:02', '14:03', '14:04', '14:05', '15:25', '15:26', '15:27', '15:28', '15:29', '15:30', '15:31', '15:32', '15:33', '15:34', '15:35', '16:55', '16:56', '16:57', '16:58', '16:59', '17:00', '17:01', '17:02', '17:03', '17:04', '17:05', '18:25', '18:26', '18:27', '18:28', '18:29', '18:30', '18:31', '18:32', '18:33', '18:34', '18:35'];

matriz_costo = {};

% Definir los nodos
nodos = {'SD1', 'ML2', 'W1', 'AU1', 'ML5', 'W5', 'W4', 'W6', 'V1', 'V2', 'S2', 'S1', 'R1', 'TX1', 'TX3', 'TX5', 'R2', 'S12', 'Q1', 'Q3', 'O3', 'LL0', 'RGD0', 'RGD1', 'B1', 'LL3', 'C1', 'B3', 'B4', 'O1', 'C2', 'G3', 'G1'};

% Crear la matriz vacía
matriz_costo = Inf(length(nodos));

% Asignar los valores proporcionados
matriz_costo(strcmp(nodos, 'SD1'), strcmp(nodos, 'ML2')) = 220;
matriz_costo(strcmp(nodos, 'SD1'), strcmp(nodos, 'W1')) = 270;
matriz_costo(strcmp(nodos, 'SD1'), strcmp(nodos, 'AU1')) = 150;
matriz_costo(strcmp(nodos, 'ML2'), strcmp(nodos, 'ML5')) = 15;
matriz_costo(strcmp(nodos, 'ML2'), strcmp(nodos, 'W1')) = 50;
matriz_costo(strcmp(nodos, 'ML5'), strcmp(nodos, 'W5')) = 50;
matriz_costo(strcmp(nodos, 'W5'), strcmp(nodos, 'W4')) = 5;
matriz_costo(strcmp(nodos, 'W1'), strcmp(nodos, 'W4')) = 15;
matriz_costo(strcmp(nodos, 'W5'), strcmp(nodos, 'W6')) = 5;
matriz_costo(strcmp(nodos, 'W6'), strcmp(nodos, 'V1')) = 40;
matriz_costo(strcmp(nodos, 'V1'), strcmp(nodos, 'V2')) = 5;
matriz_costo(strcmp(nodos, 'V2'), strcmp(nodos, 'S2')) = 60;
matriz_costo(strcmp(nodos, 'S2'), strcmp(nodos, 'S1')) = 5;
matriz_costo(strcmp(nodos, 'S1'), strcmp(nodos, 'R1')) = 30;
matriz_costo(strcmp(nodos, 'R1'), strcmp(nodos, 'TX1')) = 20;
matriz_costo(strcmp(nodos, 'TX1'), strcmp(nodos, 'TX3')) = 10;
matriz_costo(strcmp(nodos, 'TX3'), strcmp(nodos, 'TX5')) = 10;
matriz_costo(strcmp(nodos, 'R1'), strcmp(nodos, 'R2')) = 5;
matriz_costo(strcmp(nodos, 'R2'), strcmp(nodos, 'TX3')) = 30;
matriz_costo(strcmp(nodos, 'R1'), strcmp(nodos, 'S12')) = 30;
matriz_costo(strcmp(nodos, 'S12'), strcmp(nodos, 'W6')) = 110;
matriz_costo(strcmp(nodos, 'R1'), strcmp(nodos, 'W6')) = 130;
matriz_costo(strcmp(nodos, 'Q1'), strcmp(nodos, 'Q3')) = 10;
matriz_costo(strcmp(nodos, 'Q1'), strcmp(nodos, 'O3')) = 60;
matriz_costo(strcmp(nodos, 'W1'), strcmp(nodos, 'LL0')) = 70;
matriz_costo(strcmp(nodos, 'AU1'), strcmp(nodos, 'RGD0')) = 60;
matriz_costo(strcmp(nodos, 'AU1'), strcmp(nodos, 'RGD1')) = 90;
matriz_costo(strcmp(nodos, 'RGD0'), strcmp(nodos, 'RGD1')) = 5;
matriz_costo(strcmp(nodos, 'RGD1'), strcmp(nodos, 'LL0')) = 110;
matriz_costo(strcmp(nodos, 'RGD1'), strcmp(nodos, 'B1')) = 100;
matriz_costo(strcmp(nodos, 'LL0'), strcmp(nodos, 'LL3')) = 15;
matriz_costo(strcmp(nodos, 'LL3'), strcmp(nodos, 'C1')) = 50;
matriz_costo(strcmp(nodos, 'B3'), strcmp(nodos, 'B1')) = 10;
matriz_costo(strcmp(nodos, 'B3'), strcmp(nodos, 'B4')) = 5;
matriz_costo(strcmp(nodos, 'C1'), strcmp(nodos, 'B4')) = 30;
matriz_costo(strcmp(nodos, 'C1'), strcmp(nodos, 'O1')) = 50;
matriz_costo(strcmp(nodos, 'C2'), strcmp(nodos, 'O1')) = 40;
matriz_costo(strcmp(nodos, 'O1'), strcmp(nodos, 'B4')) = 80;
matriz_costo(strcmp(nodos, 'Q1'), strcmp(nodos, 'B4')) = 130;
matriz_costo(strcmp(nodos, 'O1'), strcmp(nodos, 'O3')) = 10;
matriz_costo(strcmp(nodos, 'B1'), strcmp(nodos, 'G3')) = 10;
matriz_costo(strcmp(nodos, 'C2'), strcmp(nodos, 'W6')) = 100;
matriz_costo(strcmp(nodos, 'C1'), strcmp(nodos, 'W4')) = 100;
matriz_costo(strcmp(nodos, 'G1'), strcmp(nodos, 'G3')) = 10;
matriz_costo(strcmp(nodos, 'C1'), strcmp(nodos, 'C2')) = 5;
matriz_costo(strcmp(nodos, 'LL3'), strcmp(nodos, 'B3')) = 50;

t=[];
tiempo_asc = 0;
tiempo_esc = 0;

 for i = 1:length(nodos)
    for j = 1:length(nodos)
        
        if (matriz_costo(i,j) == Inf) 
            t(i,j)=Inf;
        else  
            if ~strcmp(nodos{i}(1:end-1), nodos{j}(1:end-1)) && ~strcmp(nodos{i}, nodos{j})
                t(i,j) = matriz_costo(i,j)/0.833333333;
            else
                pisos_desplazados = abs(str2double(nodos{i}(end)) - str2double(nodos{j}(end)));
                for key =1:numel(keys)
                    value = values{key};
                    key_name = keys{key};
                    if strcmp(key_name, nodos{i})
                        pisos_maximo = value;
                        tiempo_asc = 0;
                        if (ismember(hora, horas))
                            tiempo_asc = 20 * pisos_maximo;
                        else
                            tiempo_asc = pisos_desplazados * 5;
                        end
                    end
                end 
                tiempo_esc = pisos_desplazados*6;
                t(i,j) = min(tiempo_asc,tiempo_esc);
            end
        end
    end
 end    

%Convertimos el grafo dirigido en no-dirigido.             
for i=1:length(t)
    for j=1:length(t)
        if t(i,j) < inf 
            t(j,i)=t(i,j);
        end
    end
end          

origen='ML5';
destino='W6';
[sp, spcost] = dijkstra_v2(t, origen, destino)  %sp: shortest path, spcost: shortest path cost