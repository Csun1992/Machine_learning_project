% cluster current state
current=[4.5 2.4 8.24 -0.00039];

U=dlmread('unemployment rate.txt');
U=U';
u=U(:);
unemp=u(1:length(u)-10);
inflation=dlmread('inflation.txt');
fedrate=dlmread('fedrate.txt');
market=dlmread('market.txt');

current=(current-mean([unemp;inflation;fedrate;market]))./sqrt(var([unemp;inflation;fedrate;market]));

for i=1:4
    distance(i)=sum((k(i,:)-current).^2);
end
distance

app_current=[0.0195 0.0576 0.04869 25273400];
x0=(app_current-mean(apple(:,2:5)))./sqrt(var(apple(:,2:5)));
       x0=[1;x0'];
       s1=group1_1'*x0;
       x1=[1;tanh(s1)];

       s2=group1_2'*x1;
       x2=[1;tanh(s2)];
       s3=group1_3'*x2;
       
       x3=tanh(s3);
       sign(x3)