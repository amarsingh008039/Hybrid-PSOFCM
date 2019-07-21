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