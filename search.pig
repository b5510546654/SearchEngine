A = LOAD 'GTBTXT/*.txt' using PigStorage('\n','-tagFile');
B = RANK A;
X = FILTER B BY ($2 matches '$line');
DUMP X;