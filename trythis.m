clf;
gscatter(time1(ceil(length(group{1})*2/3):length(group{1})),group1test(4,:)',(xval1==y1_test),'br','xo')
datetick('x','yy/mm')

xlabel('Date')
ylabel('Market Return')
title('Group 1 Classification Performance with Regularization')

legend off