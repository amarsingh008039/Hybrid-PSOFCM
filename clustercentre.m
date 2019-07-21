function c=clustercentre(U,X,f,m,noc)

  for i = 1:noc
          c(i, :) = sum((X(:, :).*repmat(U(i, :)'.^m, 1, f)),1)./sum(U(i, :).^m);
  end
endfunction