function plotting(p,X,c,M)
  
  index1 = find(p==1);
  index2 = find(p==2);
  index3 = find(p==3);
  plot(X(index1,1),X(index1,2),'ob')
  hold on
  plot(X(index2,1),X(index2,2),'or')
  hold on
  plot(X(index3,1),X(index3,2),'og')
  plot(c(1,1),c(1,2),'xb','MarkerSize',15,'LineWidth',3)
  plot(c(2,1),c(2,2),'xr','MarkerSize',15,'LineWidth',3)
  plot(c(3,1),c(3,2),'xg','MarkerSize',15,'LineWidth',3)
  hold off
  title(M);