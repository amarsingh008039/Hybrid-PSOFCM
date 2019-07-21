function [pred, ret] = HPSOFCMtry(k,X,MaxIt)
    %scatter(X(:,1),X(:,2));

    %%problem definition
    nVar=size(X,2);
    Varsize=[k nVar];

    %%parameters
    %nPop=size(X,1); %population size
    nPop=100;
    w=1; %inertia Coefficient
    wdamp=0.99;
    c1=0.5;%personal accn cof
    c2=1.5;%social accn cof

    %%initalization
    empty_particle.Position=[];
    empty_particle.Velocity=[];
    empty_particle.Cost=[];
    empty_particle.Best.Cost=[];
    empty_particle.Best.Position=[];

    particle=repmat(empty_particle,nPop,1); %repeat matrix
    GlobalBest.Cost=-inf;

    for i=1:nPop
        %random solution generation
        temp=randi(nPop,1,k);
            for j=1:k
                particle(i).Position=[particle(i).Position; X(temp(j),:)];
            end
        particle(i).Cost=1/((costfunc(particle(i).Position,X))+1);
        particle(i).Velocity=zeros(size(particle(i).Position));
        particle(i).Best.Position=particle(i).Position;
        particle(i).Best.Cost=particle(i).Cost;
        if particle(i).Best.Cost> GlobalBest.Cost
             GlobalBest=particle(i).Best;
        end
         
    end

    %Applying PSO

    BestCost=zeros(MaxIt,1);
    %%applying PSO
%    plot_cost=size(MaxIt,1);
%    plot_it= [1:MaxIt];
%    plot_count=1;
    it=1;
    while  ((it<=MaxIt))
        for i=1:nPop

            particle(i).Velocity=w*particle(i).Velocity...
                +c1*rand(Varsize).*(particle(i).Best.Position-particle(i).Position)...
                +c2*rand(Varsize).*(GlobalBest.Position-particle(i).Position);
            particle(i).Position=particle(i).Position+particle(i).Velocity;
            particle(i).Cost=1/((costfunc(particle(i).Position,X))+1);
            if(particle(i).Cost>particle(i).Best.Cost)
                particle(i).Best.Cost=particle(i).Cost;
                particle(i).Best.Position=particle(i).Position;
                
              if particle(i).Best.Cost> GlobalBest.Cost
                    GlobalBest=particle(i).Best;
                   % disp(['hello']);
              end
            end
            
        end
       BestCost(it)=GlobalBest.Cost;
       % disp(['Iteration' num2str(it) 'best cost' num2str(GlobalBest.Cost)]);
       % fprintf('Iteration: %d global best cost: %d\n',it,GlobalBest.Cost);
%        plot_cost(plot_count)=(costfunc(GlobalBest.Position,X));
%        plot_count=plot_count+1;
        w=w*wdamp;
        it=it+1;
    end
    fprintf('global best cost: %d\n',GlobalBest.Cost);
    fprintf("Global Best final position :\n");
    GlobalBest.Position
    ret=GlobalBest.Position;
    pred = predictcentre(ret,X);
%{ 
    figure;
    plot(plot_it,plot_cost,'-r','LineWidth',0.5);
    xlabel('Number of iterations');
    ylabel('Cost Function');

    xlabel('Number of iterations');
    ylabel('Cost Function');
    hold on;
    plot(GlobalBest.Position(:,1),GlobalBest.Position(:,2),'rx','LineWidth',2,'MarkerSize',10);
%}
end