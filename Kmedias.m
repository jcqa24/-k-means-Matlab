function Kmedias(elementos1,paro) 

global elementos;
global n;
global cambios;
global atrib;
global clusters;
global k;
global distancias;

elementos  = elementos1;

n = size(elementos,2);
%numero de atributos de cada elemento 
atrib = size(elementos{1},2);
%Nnumero de clusters
k = 2;
clusters = 1:k;

distancias = zeros(n,k);

CalculoCentroides()

cambios = 1;
i =1;
couni =0;


while(i <= n && couni <= paro);
    couni = couni+1;
    cambios = 0;
    elementos{i} = CalculoDistancias(elementos{i},i);
    if cambios == 1
        CalculoCentroides();
    else
        i = i +1;
    end
   
end

disp('Los grupos generados por el algoritmo K-Medias fueron los siguientes:');

for i=1:n
    disp(elementos{i});
end

end


function X = CalculoDistancias(X,i)
    
      global cambios;
      global centroides;
      global distancias;
      global atrib;
      global k;
      
      for j=1:k
          for m=1:atrib-1;
             distancias(i,j) = distancias(i,j) + ((X(m)-centroides(j,m))^2);
          end
      end
            
      if(X(atrib)==1)
          if( distancias(i,2) < distancias(i,1))
              cambios  =1;
               X(atrib)= 2;
           end
       else
           if(distancias(i,1) < distancias(i,2))
               cambios  =1;
               X(atrib) = 1 ;
           end
      end
    end



 function CalculoCentroides()

    global elementos;
    global n;
    global atrib;
    global centroides;
    global k;

    centroides = zeros(k,atrib-1);
    
    contadorc = zeros(1,k);
    
    for i=1:n
        aux = elementos{i};
        if aux(atrib) == 1
            contadorc(1,1) = contadorc(1,1) +1;
            for p=1:atrib-1
                centroides(1,p) = centroides(1,p) + aux(p);
            end;
        else
            contadorc(1,2) = contadorc(1,2) +1;
            for p=1:atrib-1
                centroides(2,p) = centroides(2,p) + aux(p);
            end
        end        
    end
   
  for i=1:k
      for j=1:atrib-1
        centroides(k,j) = centroides(k,j) / contadorc(1,k);
      end
  end

end


