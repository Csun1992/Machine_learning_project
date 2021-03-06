% 3-layer Neural Network for group1
n=3;

lambda=0.1;
train=group1(1:ceil(length(group1)*2/3),:)';
y1_train=y1(1:ceil(length(group1)*2/3))';


test=group1(ceil(length(group1)*2/3):length(group1),:)';
y1_test=y1(ceil(length(group1)*2/3):length(group1))';



sigma=sqrt(0.1/max(sum(train.^2)));
w3_1=normrnd(0,sigma,5,n);%initialize first-layer weight 
                             % here the number row equals number of 
                             % inputs plus one bias term
                             
w3_2=normrnd(0,sigma,n+1,2);%initialize second-layer weight

w3_3=normrnd(0,sigma,n,1);


Ein1=10;
g1=0*w3_1;%initialize first-layer gradient
g2=0*w3_2;%initialize the second-layer gradient
g3=0*w3_3;
p2=150000;%iteration upper bound

xL=zeros(1,length(y1_train));% the predicted result vector
eta=0.1;%descent rate

tic
i=0;
while Ein1>0.01 && p2>0
   Ein1=0;
   for j=1:length(y1_train)
       x0=[1;train(:,j)];
       s1=w3_1'*x0;
       x1=[1;tanh(s1)];

       s2=w3_2'*x1;
       x2=[1;tanh(s2)];
       s3=w3_3'*x2;
       
       x3=tanh(s3);
       xL(j)=sign(x3);

       lambda3=2*(x3-y1_train(j))*(1-x3^2);%1 by 7291
       t=1-x2.^2;
       wl=w3_3*lambda3;
       lambda2=t(2:n).*wl(2:n);%2 by 7291
       
       t=1-x1.^2;
       wl=w3_2*lambda2;
       lambda1=t(2:4).*wl(2:4);
       

       Ein1=Ein1+sum((x3-y(j))^2)/length(y1_train);
       %backward propagation
       
       
       w3_1=w3_1-eta*(x0*lambda1')/length(y1_train);
       w3_2=w3_2-eta*(x1*lambda2')/length(y1_train);
       w3_3=w3_3-eta*(x2*lambda3')/length(y1_train);
       
       i=i+1;

       
  
   
   end
       
        p2=p2-1
end
toc;
t2=toc;

Ein1=sum(y1_train~=xL)/length(xL);






xval1=zeros(1,length(y1_test));
for j=1:length(y1_test)
       x0=[1;test(:,j)];
       s1=w3_1'*x0;
       x1=[1;tanh(s1)];

       s2=w3_2'*x1;
       x2=[1;tanh(s2)];
       s3=w3_3'*x2;
       x3=tanh(s3);
       
       xval1(:,j)=sign(x3);
end
Eout1=sum(xval1~=y1_test)/length(y1_test);


group1inerror=Ein1
group1outerror=Eout1
group1classtrain=xL;
group1classtest=xval1;
group1train=train;
group1test=test;
group1_y_train=y1_train;
group1_y_test=y1_test;

group1_1=w3_1;
group1_2=w3_2;
group1_3=w3_3;

