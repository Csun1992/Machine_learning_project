
%generate data from Jan. 1999 - Feb. 2017 for clustering

M=csvread('monthly data goog.csv');
goog_ret=M(:,8);
U=dlmread('unemployment rate.txt');
U=U';
u=U(:);
unemp=u(1:length(u)-10);
inflation=dlmread('inflation.txt');
fedrate=dlmread('fedrate.txt');
market=dlmread('market.txt');
market=fliplr(market);


% Data preprocessing, normalizing the data
unemp=(unemp-mean(unemp))./sqrt(var(unemp));
inflation=(inflation-mean(inflation))./sqrt(var(inflation));
fedrate=(fedrate-mean(fedrate))./sqrt(var(fedrate));
market=(market-mean(market))./sqrt(var(market));



% Create time index for the market info
l=zeros(12,27);
for i=1:27
l(:,i)=datenum(1989+i,1:12,28)';
end

l=l(:);
time=fliplr([l;datenum(2017,01,28);datenum(2017,02,28)]);%time index


%Combining the data together by indexing the data points by time
Data=[time;unemp;inflation;fedrate;market];