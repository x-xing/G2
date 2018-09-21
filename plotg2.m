%filtered with F cavity
%A = load  ('F:\xing\Dropbox\Data\Coincidence\filtered coin 23;3;10, 9-2-2010.raw');
%A = load  ('F:\xing\Dropbox\Data\Coincidencecoin_test_007.txt');A= A*1000;
A = load('E:\xing\Dropbox\Data\Coincidence\20121005\Trig-sig-sig\Calibration by Photofinish\CableA+Exten_Bin0delay 21;44;4, 10-5-2012.raw');

% folder = 'E:\Dropbox\Data\Coincidence\QCDMA\QnF\5basis\timetagged\';
% A=[];
% dirListing = dir([folder '*.raw']);
% for d = 5%1:length(dirListing)
%     fileid = fullfile(folder,dirListing(d).name); 
%     A = [A;load(fileid)];
% end


%% Plot the filtered G2 here for different bins
% subplot(2,2,1);
% [n t]=hist(A,5);
% t=t/1000+1;
% bar(t,n);
% subplot(2,2,2);
% [n t]=hist(A,10);
% t=t/1000+1;
% bar(t,n);
% subplot(2,2,3);
% [n t]=hist(A,50);
% t=t/1000+1;
% bar(t,n);
% subplot(2,2,4);
% [n t]=hist(A,200);
% t=t/1000+1;
% bar(t,n);

%% Plot the filtered spectrum
bin_size = 0.22%nano seconds
taxis=(-100:bin_size:100)*1e3;
[n t]=hist(A,taxis);
t = t/1000;
%plot(t,n);
[maxc ind_t0]=max(n);
start = [maxc-mean(n), -20, 20, mean(n)];%,0.4,2,0];
%start = [100, -20, 30, 40,0.3,2,0];
options=optimset('Display','final','MaxFunEvals', 1e5, 'MaxIter',1e5,'TolFun',1e-6); 
vec=find(abs(t)-50<0);
t1=t(vec);
n1=n(vec);
%n1=smooth(n(vec))';
%plot(t1,n1,'b');
hold on;
errorbar(t1,n1,sqrt(n1),'b.');

peval =@(x,t) x(1)*exp(-abs(t-x(2))/x(3))+x(4);
resid =@(x,t,n) sum((peval(x,t)-n).^2)+abs(x(3)-25).^2*1e3;
param = fminsearch(resid, start, options, t1, n1);

t2=min(t1):max(t1);
plot(t2, param(1)*exp(-abs(t2-param(2))/param(3))+param(4), 'r','linewidth', 2);
param(5)=0.24;
%plot(t1, param(1)*(1+2*param(5)*sin(param(6)*t1+param(7))).^2.*exp(-abs(t1-param(2))/param(3))+param(4), 'r','linewidth', .5);
hold off;
xlabel('Two photon arrival time difference (ns)');
ylabel('Coincidence counts in 45 min');
title('Coincidence');
msg1=sprintf('%3.2f*exp(-|t-%3.2f|/%3.2f)+%3.2f',param([1 2 3 4]));
%msg2=sprintf('%3.2f*(1+2*%3.2f*sin(%3.2f*t)+%3.2f)^2*exp(-|t-%3.2f|/%3.2f)
%+%3.2f',param([1 5 6 7 2 3 4]));msg1=[msg1, msg2];
legend('data','fit')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TWO SIDE FIT %%%%%%%%%%%%%
%%
% plot(t1,n1);
% t11 = t1(1:25);
% n11 = n1(1:25);
% t12 = t1(26:end);
% n12 = n1(26:end);
% n=n11;
% start = [max(n)-mean(n), 25, 30, min(n)];
% param1 = fminsearch(@exp1_func, start, options, t11, n11);
% n=n12;
% start = [max(n)-mean(n), 30, 30, min(n)];
% param2 = fminsearch(@exp2_func, start, options, t12, n12);
% hold on;
% t2=min(t11):max(t11);
% param = param1;
% plot(t2, param(1)*exp(-(t2-param(2))/param(3))+param(4), 'r','linewidth', 2);
% param = param2;
% t2=min(t12):max(t12);
% plot(t2, param(1)*exp((t2-param(2))/param(3))+param(4), 'r','linewidth', 2);
% hold off;
