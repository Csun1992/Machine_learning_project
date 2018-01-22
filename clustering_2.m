    
    n=4;

    m=[unemp,inflation,fedrate,market];
    random1=randi(length(m),1,1);
    k1=m(random1,:); % generate the first center randomly
    kt1=repmat(k1,length(m),1);% repeat k1 length(m) times vertically for 
                           % subtraction
    

    k=[k1;zeros(n-1,4)];
    
    index=[time(random1);zeros(n-1,1)];

    Distance=[sum((m-kt1).^2,2),zeros(length(m),n-1)];
    for i=2:n %Find out the rest of the centers
    
        dist=min(Distance(:,1:i-1),[],2);
    
        prob=dist/sum(dist);
    
        t=find(mnrnd(1,prob));
    
        ki=m(t,:);
    
        
        k(i,:)=ki;
    
        index(i)=time(t);
    
        kti=repmat(ki,length(m),1);
    
        Distance(:,i)=sum((m-kti).^2,2);
    end
  

    D=zeros(length(m),n);% distance of each point to corresponding centers


    for i=1:n %Cluster
        kti=repmat(k(i,:),length(m),1);
        D(:,i)=sum((m-kti).^2,2);
    
    end

    [T,I]=min(D,[],2);
    group=cell(1,n);

    
    for i=1:n
        group{i}=[time(find(I==i)),m(find(I==i),:)];
    end
    
   
    min([length(group{1}) length(group{2}) length(group{3}) length(group{4})])
    
    
    clf;
hold on;

n=4;
colors='krbm';
shapes='od*<';
for i=1:n
    cluster=group{i};
    
    color=colors(mod(i,length(colors))+1);
    shape=shapes(mod(i,length(colors))+1);
    plot(cluster(:,1),cluster(:,5),[color,shape]);
end

datetick('x','yy/mm');
xlabel('Date');

ylabel('Market Return');

title('4 Clusters');

  