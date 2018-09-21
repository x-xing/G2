A = load('D:\xing\My Dropbox\Data\Coincidence\filtered coin 23;3;10, 9-2-2010-forMatlab.txt');
% ind = find(A(:,2)==360797)
% A=A(1:(ind-1),:);
data = mean(A);
errors = sqrt(var(A));
msg=sprintf('\nsingels A: %3.2f +/- %3.2f', data(1),errors(1));
disp(msg);
msg=sprintf('singels B: %3.2f +/- %3.2f', data(2),errors(2));
disp(msg);
msg=sprintf('coin AB: %3.2f +/- %3.2f', data(3),errors(3));
disp(msg);
