function [sp, spcost, P] = dijkstra_v2(t, origen, destino)
% This is an implementation of the dijkstra's algorithm, which finds the 
% minimal cost path between two nodes. It's supoussed to solve the problem on 
% possitive weighted instances.

% the inputs of the algorithm are:
%farthestNode: the farthest node to reach for each node after performing
% the routing;
% n: the number of nodes in the network;
% s: source node index;
% destino: destination node index;

%For information about this algorithm visit:
%http://en.wikipedia.org/wiki/Dijkstra%27s_algorithm

%This implementatios is inspired by the Xiaodong Wang's implememtation of
%the dijkstra's algorithm, available at
%http://www.mathworks.com/matlabcentral/fileexchange
%file ID 5550

%Author: Jorge Ignacio Barrera Alviar. April/2007
nodos = {'SD1', 'ML2', 'W1', 'AU1', 'ML5', 'W5', 'W4', 'W6', 'V1', 'V2', 'S2', 'S1', 'R1', 'TX1', 'TX3', 'TX5', 'R2', 'S12', 'Q1', 'Q3', 'O3', 'LL0', 'RGD0', 'RGD1', 'B1', 'LL3', 'C1', 'B3', 'B4', 'O1', 'C2', 'G3', 'G1'};


n=size(t,1);
S(1:n) = 0;     %s, vector, set of visited vectors
dist(1:n) = Inf;   % it stores the shortest distance between the source node and any other node;
prev(1:n) = n+1;    % Previous node, informs about the best previous node known to reach each  network node 

dist(origen) = 0;

P=1;
flag1=1;
while flag1==1
    while sum(S)~=n
        candidate=[];
        for i=1:n
            if S(i)==0
                candidate=[candidate dist(i)];
            else
                candidate=[candidate Inf];
            end
        end
        
        %ger: detectar que no hay path
        contInf=0;
        for i=1:length(candidate)
            if candidate(i)==Inf
                contInf=contInf+1;
            end
        end
        contInf
        length(t)
        if contInf == length(t) && S(find(strcmp(destino, nodos))) == 0
            P = 0;
            break;
        end
        if contInf == length(t) && S(find(strcmp(destino, nodos))) == 1             
            P = 1;
            break;
        end
        
        
        [u_index u]=min(candidate);
        S(u)=1;
        for i=1:n
            if(dist(u)+t(u,i))<dist(i)
                dist(i)=dist(u)+t(u,i);
                prev(i)=u;
            end
        end
    end
    
    if P==0
        sp=0;
        spcost=0;
        break;
    end
    
    
    sp = [destino];
    
    while sp(1) ~= s
        if prev(sp(1))<=n
            sp=[prev(sp(1)) sp];
        else
            error;
        end
    end;
    spcost = dist(destino);
    flag1=0;
end