%%
dir1 = 'E:\Dropbox\Data\Coincidence\20121005\sig-sig\';
flist = dir([dir1,'*600s-0.1*.raw']);
A = [];
for d = 1:length(flist)
    A = [A; load([dir1,flist(d).name])];
end

%%
bin_size = 2;%nano seconds
taxis=(-100:bin_size:100)*1e3;
num_of_bin = 200/bin_size;
[n t]=hist(A,taxis);
t = t/1000;
%plot(t,n);
[maxc ind_t0]=max(n);
p0 = [maxc-mean(n), t(ind_t0), 30, mean(n)];%,0.4,2,0];
%start = [100, -20, 30, 40,0.3,2,0];
options=optimset('MaxFunEvals', 1e5, 'MaxIter',1e5,'TolFun',1e-8); 
vec=find(abs(t)-90<0);
t1=t(vec);
n1=n(vec);
errorbar(t1,n1,sqrt(n1),'b.');
%plot(t1,n1)

p = fminsearch(@g2fit_func, p0, options, t1, n1);
hold on;
t2=min(t1):max(t1);
plot(t2, p(1)*exp(-abs(t2-p(2))/p(3))+p(4), 'r','linewidth', 2);
hold off;
g20=p(1)/p(4)+1;
xlabel('Delay (ns)');
ylabel('Un-normalized G^{(2)}(\tau)');
title(['Signal-signal correlation, g^{(2)}(0)=' num2str(g20,3) ', pump=1.5mW']);

% lb = [0 min(t) 0 0];
% ub = [max(n) max(t) max(t) max(n)];
% [p resnorm residual] = lsqcurvefit(@myg2,p0,t1,n1,lb,ub,options);
% hold on;
% t2=min(t1):max(t1);
% plot(t2, myg2(p,t2), 'g','linewidth', 2);
% hold off;
% p(1)/p(4)+1
[p r J Sigma ]= nlinfit(t1,n1,@myg2,p);
ci = nlparci(p,r,'covar',Sigma);
%lower bound of 95% confidence interval
dg2l = g20*sqrt((ci(1,1)/p(1)-1)^2+(ci(4,1)/p(4)-1)^2)
dg2u = g20*sqrt((ci(1,2)/p(1)-1)^2+(ci(4,2)/p(4)-1)^2)
