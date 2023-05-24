% Examen 2 MOS, ejercicio 3
%
% Ejercicio basado en el archivo ejNRaphson.m:
%    Modificado por: Julián Mora y Luisa Fuentes
    
clc, clear all, close all

syms z x y;

z=(1-x).^2 + 100*(y-x.^2).^2;

figure
ezsurf(x,y,z)
hold on;

x_i=[0 10];  %valor inicial

grad_z=gradient(z); %gradiente de la función
grad_z_eval_double = double(subs(grad_z,[x y],x_i)); %gradiente evaluado en el punto de arranque  


hess_z = hessian(z); %hessiano de la función

convergencia=0.001;  % convergencia

a=0.1;

cont=1;
while norm(grad_z_eval_double)>convergencia
    cont=cont+1;       

    grad_z_eval_double = double(subs(grad_z,[x y],x_i)); %gradiente evaluado en el punto   
    hess_z_eval_double =  double(subs(hess_z,[x y],x_i)); %hessiano evaluado en el punto

    hess_grad = inv(hess_z_eval_double)*grad_z_eval_double;
    a_hess_grad = a*hess_grad;


    x_i_new=x_i - a_hess_grad; %Expresión de Newton Raphson: x(i+1) = x(i) - a*H(f(xi))^-1*grad(f(xi))
    x_i=diag(x_i_new);  %Actualizamos el x_i
    x_i = x_i';
    z_i=double(subs(z,[x y],x_i)); %Evaluamos el x_i en la f(x) para graficar posteriormente
    
    plot3(x_i(1),x_i(2),z_i, 'or','MarkerSize', 5,'Color',[0,1,1]) % dibujar el punto actual
    
end

x_coord = x_i(1)
y_coord = x_i(2)

plot3(x_i(1),x_i(2),z_i, 'o', 'MarkerSize', 12,'Color',[1,0,0],'MarkerFaceColor',[1,0,0],'MarkerEdgeColor',[1,0,0])


