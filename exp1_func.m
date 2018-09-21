function out = exp1_func(x,t,n)
y= x(1)*exp(-(t-x(2))/x(3))+x(4);
out = sum((y-n).^2);
