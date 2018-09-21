function out = g2fit_func(x,t,n)
y= x(1)*exp(-abs(t-x(2))/x(3))+x(4);
%y= x(1)*(1+2*x(5)*sin(x(6)*t+x(7))).^2.*exp(-abs(t-x(2))/x(3))+x(4);
out = sum((y-n).^2)+sum(abs(x(2:3)-[-40 20]).^2)*1e5;