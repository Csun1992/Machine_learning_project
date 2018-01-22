% 2-layer Neural Network for group1

train=group1(1:ceil(length(group1)*2/3),:)';
y1_train=y1(1:ceil(length(group1)*2/3))';


test=group1(ceil(length(group1)*2/3):length(group1),:)';
y1_test=y1(ceil(length(group1)*2/3):length(group1))';


n=3;
sigma=sqrt(0.1/max(sum(train.^2)));
w2_1=normrnd(0,sigma,5,n);%initialize first-layer weight 
                             % here the number row equals number of 
                             % inputs plus one bias term
                             
w2_2=normrnd(0,sigma,n+1,1);%initialize second-layer weight
Ein1=10;
g1=0*w2_1;%initialize first-layer gradient
g2=0*w2_2;%initialize the second-layer gradient
p2=10000;%iteration upper bound

xL=zeros(1,length(y1_train));
eta=0.1;%descent rate

tic
i=0;
while Ein1>0.1 
   Ein1=0;
   for j=1:length(y1_train)
       x0=[1;train(:,j)];
       s1=w2_1'*x0;
       x1=[1;tanh(s1)];

       s2=w2_2'*x1;
       x2=tanh(s2);
       xL(j)=x2;

       lambda2=2*(sign(x2)-y1_train(j))*(1-x2^2);%1 by 7291
       t=1-x1.^2;
       wl=w2_2*lambda2;
       lambda1=t(2:n+1).*wl(2:n+1);%2 by 7291

       Ein1=Ein1+sum((xL(j)-y(j))^2)/length(y1_train);

       g1=g1+(x0*lambda1');
       g2=g2+(x1*lambda2');
       w2_1=w2_1-eta*g1/length(y1_train);
       w2_2=w2_2-eta*g2/length(y1_train);
       i=i+1;

       
  
   
   end
 
end
toc;
t2=toc;
x2=sign(xL);




one=ones(1,length(y1_test));
x0_test=[one;test]; %input column vectors 


xval2=zeros(1,length(y1_test));
for j=1:length(y1_test)
       x0=x0_test(:,j);
       s1=w2_1'*x0;
       x1=[1;tanh(s1)];

       s2=w2_2'*x1;
       x2=tanh(s2);
       xval2(:,j)=sign(x2);
end
Eout1=sumsqr(xval2-y1_test)/length(y1_test);

