%data = load('C:\photofinish temporary data.raw');
data = load  ('F:\Xing\Dropbox\Data\Coincidence\g2 triggered, no filtering, full pump, 14;45;57, 4-26-2011.raw');

data = data/1000;

for ind = 1:4
    subplot(2,2,ind);
    time = -100:5*ind:100;
    hist(data,time);
    xlabel('Arrival time difference (ns)');
    ylabel('Number of counts');
    t1 = sprintf('BIN = %d ns',ind*5);
    title(t1);
end

