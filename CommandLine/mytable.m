function mytable(n,m)
f2 = figure('position',[200 200 350 350]);
set(f2,'name','Table','numbertitle','off','Color','w');
hTable = uitable(f2);
columnHeaders = {'Node no.', 'Deflection'};
tableData(:,1) = 1:n^2;
tableData(:,2) = m;
set(hTable,'ColumnName',columnHeaders);
set(hTable,'data',tableData);