function [pred] = predictcentre(centre,popul)
    fz=2;
    c=size(centre,1);
    n=size(popul,2);
    m=size(popul,1);
    U=zeros([c,m]);
    for i = 1:c
        for j = 1:m
            nume = euclidean(centre(i,:),popul(j,:));
            tot=0;
            flag=0;
            for p = 1:c
                temp=euclidean(centre(p,:),popul(j,:));
                if(temp==0)
                    flag=1;
                    if p==i
                        U(i,j)=1;
                    else
                        U(i,j)=0;
                    end
                    break;
                else
                    tot=tot+((nume/temp)^(2/(fz-1)));
                end
            end
            if flag==0
                U(i,j)=1/tot;
            end
        end
    end
    pred = zeros([1, m]);
    for i = 1:m
       [temp, pred(i)]=max(U(:, i));
    end
end