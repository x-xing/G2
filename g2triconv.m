function out = g2triconv(x,t)
w = 20;
lim = max(t)+w/2;
t1=-lim:0.1:lim;
y1= 1-x(1)*exp(-abs(t1)/x(2));

%convolution with a 10ns coincidence window.
y2 = conv(y1,ones(1,w*10)/w/10);
%sample every step(t) to recover the y value.
ind = linspace(length(y2)/2,length(y2)-w*10,length(t));
out = y2(round(ind));