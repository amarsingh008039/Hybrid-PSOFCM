close ('ALL');
clear;
clc;
 

vector=zeros(30);
for i=1:10
  printf("%d\n",i)
  [vector(i)]=FCM();
endfor
best=min(vector)(1);
best
worst=max(vector)(1);
worst
avg=mean(vector)(1);
avg
dev=std(vector)(1);
dev