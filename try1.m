data=load('iris.mat');
[a b]=size(data.iris);
X=data.iris(:,1:(b-1));
Y=data.iris(:,b);
k=3;
n=150;
j=1;
iter =70;

vector=zeros(30);
x=zeros(10,150);
y=zeros(40,4);
p=zeros(1,150);
c=zeros(3,4);
for i=1:7
  printf("%d GlobalBest\n",i)
  [pred_hyb,centre1]= HPSOFCMtry(k,X,iter);
  x(i,:)=pred_hyb;
  y(j:j+2,:)=centre1;
  j=j+3;
  [vector(i)]=inc(X,centre1,pred_hyb);
  fprintf('\n%d Intra cluster distance\n',i);
  vector(i);
endfor
best=min(vector)(1);
best
j=find(vector==best);
fprintf('\nBest Predicted Clusters\n');
p=x(j)
i=1+(j-1)*3;
c=y(i:(i+2),:);
plotting(p,X,c,"Best");
worst=max(vector)(1);
worst
j=find(vector==worst);
fprintf('\nworst Predicted Clusters\n');
p=x(j)
i=1+(j-1)*3;
c=y(i:(i+2),:);
plotting(p,X,c,"Worst");
avg=mean(vector)(1);
avg
dev=std(vector)(1);
dev