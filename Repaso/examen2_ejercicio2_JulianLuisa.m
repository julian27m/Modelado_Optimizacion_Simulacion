% Examen 2 MOS, ejercicio 2
%
% Algoritmo para encontrar máximos y mínimos globales en intervalos.
%   Ejercicio basado en el archivo ejNRaphson.m para encontrar minimos y
%   maximos locales
% Autores: Julián Mora y Luisa Fuentes
% Nuestro algoritmo utiliza Newton Raphson para calcular los mínimos y
% máximos locales mientras recorre todo el intervalo. Finalmente, decide
% cuáles de esos puntos críticos deben ser considerados como máximos y
% mínimos globales.
    
clc, clear all, close all

syms f_x x;

f_x = x.^5 - 8*x.^3 + 10*x + 6; %y = x^5-8x^3+10x+6

figure
fplot(f_x,[-2.7 2.7]) %Hago esto para que la gráfica encierre el intervalo
hold on;

x_i = -2.5;  %valor inicial
x_i_f = 2.5; %valor final


d1_f_x=diff(f_x); %primera derivada
d2_f_x=diff(d1_f_x); %segunda derivada


convergencia=0.001;  % convergencia

a=0.1;
criticos = [];
cont=1;

while x_i<x_i_f
    cont=cont+1; 
    d1_f_x_i=double(subs(d1_f_x, x, x_i));
    if abs(d1_f_x_i)<convergencia %punto critico
        d1_f_x_i=double(subs(d1_f_x,x_i)); %Primera derivada evaluada en x_i
        d2_f_x_i=double(subs(d2_f_x,x_i)); %Segunda derivada evaluada en x_i
        if d2_f_x_i<0
            f_x_i=double(subs(f_x,x_i)); %Verificar si es un maximo local
            criticos = [criticos, x_i];
            plot(x_i, f_x_i, 'ro','Color',[0,1,1],'MarkerFaceColor',[0,1,1],'MarkerEdgeColor',[0,1,1])
        else   
            f_x_i=double(subs(f_x,x_i)); %Verificar si es un minimo local
            criticos = [criticos, x_i];
            plot(x_i, f_x_i, 'or','Color',[0,1,1],'MarkerFaceColor',[0,1,1],'MarkerEdgeColor',[0,1,1])
        
        end   
    x_i = x_i+1;
    else
        d1_f_x_i=double(subs(d1_f_x,x_i)); %Primera derivada evaluada en x_i  
        d2_f_x_i=double(subs(d2_f_x,x_i)); %Segunda derivada evaluada en x_i 
        x_i_new=x_i - a*(d1_f_x_i/d2_f_x_i); %Expresión de Newton Raphson: x(i+1) = x(i) - a*f'(x(i))/f''(x(i)) 
        x_i=x_i_new;  %Actualizamos el x_i   
        f_x_i=double(subs(f_x,x_i)); %Evaluamos el x_i en la f(x) para graficar posteriormente
        plot(x_i, f_x_i, 'or')
    end
    
end

x_coor_min_global = max(criticos) %minimo global
y_coor_min_global =double(subs(f_x,x_coor_min_global))


x_coor_max_global = min(criticos) %maximo global
y_coor_max_global = double(subs(f_x,x_coor_max_global))
