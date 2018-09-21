dir1 = 'E:\xing\Dropbox\Data\Coincidence\20121005\Trig-sig-sig\';

flist = dir([dir1,'3chan_300s_coin10*.txt']);
dly = zeros(1,length(flist));
g2 = dly;
G2 = g2;
errg2=g2;
for d=1:length(flist)
    fname = flist(d).name;
    cnt = load([dir1,fname]);
    dly(d) = str2double(fname((end-5):(end-4)));
    if fname(end-4) == '6'
        dly(d)=dly(d)+44;
    end
    sumcnt = sum(cnt);
    % c123*T/c12/c13/tau/4
    g2(d) = prod(sumcnt([1 9]))/prod(sumcnt(7:8))/20e-9/4;
    G2(d) = sum(cnt(:,9)./cnt(:,1));
    % c123*T^2/c1/c2/c3/tau^2/16
    %g2(d) = sumcnt(9)/prod(sumcnt([3 4 6]))/20e-9^2/16*sumcnt(1)^2;
    sqcnt = sqrt(sumcnt);
    errg2(d) = g2(d)*sqrt(sum(1./sqcnt(7:9).^2));    
end

%%
norm = g2(end);
g2 = g2/norm;
errg2=errg2/norm;
figure(1);
errorbar(dly,g2,errg2,'b.');
hold on;
p0 = [0.5 20];
p = fminsearch(@g2trifit, p0, [], dly, g2);
dly1=0:1:110;
plot(dly1, g2triconv(p,dly1), 'r','linewidth', 2);
g20=1-p(1);
xlabel('Delay (ns)');
ylabel('g^{(2)}(\tau)');
title(['Signal-signal correlation g^{(2)}(0)=' num2str(g20,2)]);
y1 =1-p(1)*exp(-abs(dly1)/p(2));
%plot(dly1,y1,'g','linewidth', 1);
legend('data','fit: \tau_{coin} = 10ns')
hold off;
%%
figure(2);
p1 = [0.7 30];
dly2 = -100:1:100;
y2 =1-p1(1)*exp(-abs(dly2)/p1(2));
y3 = conv(y2,ones(1,20)/20);
y3(1:5)=[];
dly3 = -0:1:100;
y4 = g2triconv(p1,dly3);
y4 = [y4(end:-1:2) y4];
plot(y4, 'r','linewidth', 2);
hold on;plot(y3);plot(y2,'k');hold off;

figure(4);
errorbar(dly,G2,sqrt(G2),'b.');hold on;
fng2th = @(p,x) p(1)*exp(-x/p(2))+p(3);
myfn = @(p,x,y) sum((fng2th(p,x)-y).^2);
p0 = [3e3 20 1.5e3];
p = fminsearch(myfn, p0, [], dly, G2);
plot(dly,fng2th(p,dly),'r');hold off;
title('Tripple coincidence counts');
legend('data','fit');
xlabel('Delay (ns)');
ylabel('Coincidence in 300s');

[p r J Sigma ]= nlinfit(dly,G2,fng2th,p);
ci = nlparci(p,r,'covar',Sigma);
pf=mean(ci,2);
delp=ci(:,2)-pf;
vg2 = 1+pf(1)/pf(3);
delg2=sqrt(sum((delp./pf).^2)-(delp(2)/pf(2)).^2)*vg2;
disp(['g2=' num2str(vg2) '+/-' num2str(delg2)]);