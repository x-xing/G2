function out = g2trifit(x,t,n)
y = g2triconv(x,t);

out = sum((y-n).^2);%+sum((x(2)-30).^2)/1e4;
