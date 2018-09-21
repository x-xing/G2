function out = myg2(x,t)
out= x(1)*exp(-abs(t-x(2))/x(3))+x(4);