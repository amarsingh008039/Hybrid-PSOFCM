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