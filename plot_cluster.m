clf;
hold on;

n=4;
colors='krbm';
symbols='o<d*';
for i=1:n
    cluster=group{i};
    
    color=colors(mod(i,length(colors))+1);
    symbol=symbols(mod(i,length(colors))+1);
    plot(cluster(:,1),cluster(:,5),[color,symbol]);
end

datetick('x','yy/mm');
xlabel('Date','fontsize',14);

ylabel('Market Return','fontsize',14);

title('4 Clusters');
