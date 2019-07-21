
%functions
function [aid]=FCM()
  %Load Data
  data=load('D:\FCM\FCM\iris.mat');
  X=data.iris(:,1:4);
  Y=data.iris(:,5);
  noc=3;
  n=150;
  m = 2.25;
  f=4;
  e=0.000001;
  
  U=rand([3,150]);
  for j = 1:150
      U(:, j) = U(:, j)./sum(U(:, j));
  endfor
  c=zeros(3,4);
  Up=zeros(3,150);
  cp=zeros(3,4);
  Up=U;
  c=clustercentre(U,X,f,m,noc);
%  z=1;
  while (1)
    U=update(m,c,X,noc,n);
    cp=c;
    c=clustercentre(U,X,f,m,noc);
    J=0;
    for i = 1:noc
      for j = 1:n
        J=J+((Up(i,j)^m)*(euclidean(c(i,:),X(j,:))^2));
      end
    end
%   printf("%d iteration J = %f\n",z,J)
%   z=z+1;
    max_diff=max(max(abs(U-Up)));
    if(max_diff<e||cp==c)
      break;
    endif   
    Up=U;
  endwhile
  printf(" J = %f\n",J)
%  U
%  c
  predictions=zeros(1,n);
  for i=1:n
    [M,predictions(i)]=max(U(:,i));
  end 
  %predictions
  %Y
  fmeasure(Y,noc,predictions');
  [aid] = inc(X,c,predictions);
  maxU = max(U);
  index1 = find(U(1,:) == maxU);
  index2 = find(U(2,:) == maxU);
  index3 = find(U(3,:) == maxU);
  plot(X(index1,1),X(index1,2),'ob')
  hold on
  plot(X(index2,1),X(index2,2),'or')
  hold on
  plot(X(index3,1),X(index3,2),'og')
  plot(c(1,1),c(1,2),'xb','MarkerSize',15,'LineWidth',3)
  plot(c(2,1),c(2,2),'xr','MarkerSize',15,'LineWidth',3)
  plot(c(3,1),c(3,2),'xg','MarkerSize',15,'LineWidth',3)
  hold off  
endfunction 

%================================================================================ 
#{
function c=clustercentre(U,X,f,m,noc)

  for i = 1:noc
          c(i, :) = sum((X(:, :).*repmat(U(i, :)'.^m, 1, f)),1)./sum(U(i, :).^m);
  end
endfunction
#}
%==========================================
%{
function [d] = euclidean(x, Y)
           S = size(Y);
           d = sum((repmat(x, S(1),1)-Y).^2, 2);
           d = sqrt(d);
end
%}
%===========================================
#{
function U=update(m,c,X,noc,n)

        for i = 1:noc
            for j = 1:n
                nume = euclidean(c(i,:),X(j,:));
                tot=0;
                flag=0;
                for p = 1:noc
                    temp=euclidean(c(p,:),X(j,:));
                    if(temp==0)
                        flag=1;
                        if p==i
                            U(i,j)=1;
                        else
                            U(i,j)=0;
                        end
                        break;
                    else
                        tot=tot+((nume/temp)^(2/(m-1)));
                    end
                end
                if flag==0
                    U(i,j)=1/tot;
                end
            end
        end
        
       
end
#}
%=========================================
function  fmeasure(Y,tot_c,pred)
  cm=zeros(tot_c,tot_c);
  pre=zeros(1,3);
  rec=zeros(1,3);
  f=zeros(1,3);
  for i= 1:size(Y)
    a=pred(i);
    b=Y(i);
    cm(a,b)=cm(a,b)+1;
  endfor  
%  cm
  for i=1:tot_c
    s=sum(cm(i,:));
    pre(i)=cm(i,i)/s;
  end  
  for i=1:tot_c
    s=sum(cm(:,i));
    rec(i)=cm(i,i)/s;
  end    
%  precision=sum(pre)/tot_c;
%  recall=sum(rec)/tot_c;
%  fscore=(precision*recall)/(precision+recall);
%  fscore
  f=2*((pre.*rec)./(pre+rec));   
endfunction
%=========================================================================
%{
function [val1] = inc(X,c,pred)
    val=0;val1=0;
    for i = 1:(size(c,1))
        comp=(pred==i);
        pos=find(comp);
        for j= 1:(size(pos,1))
            val=val+sum((c(i,:)-X(j,:)).^2);
        end
        val=sqrt(val);
        val1=val1+val;
        val=0;
    end
    val1=val1/3;
end
}%
%MAIN

