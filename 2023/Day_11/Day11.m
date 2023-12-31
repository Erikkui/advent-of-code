clc
close all
clearvars

rawdata = readlines( 'day11_data.txt' );
rawdata = char( rawdata );

[N, M] = size( rawdata );

data = zeros(N);
duplicateRows = [];
duplicateCols = [];
for ii = 1:N
    row = rawdata( ii, : );
    col = rawdata( :, ii );
    if all( row(1) == row )
        duplicateRows( end+1 ) = ii;
    end
    if all( col(1) == col )
        duplicateCols( end+1 ) = ii;
    end

    for jj = 1:M
        elem = rawdata( ii, jj );
        if elem == '.'
            data( ii, jj ) = 0;
        elseif elem == '#'
            data( ii, jj ) = 1;
        end
    end
end

for ii = 1:length( duplicateRows )
    dupInd = duplicateRows(ii);

    zeroes = zeros( 1, M );
    upside = data( 1:dupInd, : );
    downside = data( dupInd+1:end, : );

    data = [ upside; zeroes; downside ];
    duplicateRows = duplicateRows + 1;
    N = N + 1;
end

for ii = 1:length( duplicateCols )
    dupInd = duplicateCols(ii);

    zeroes = zeros( N, 1 );
    leftSide = data( :, 1:dupInd );
    rightSide = data( :, dupInd+1:end );

    data = [ leftSide, zeroes, rightSide ];
    duplicateCols = duplicateCols + 1;
    M = M + 1;
end

[galRows, galCols] =  find( data == 1 );
pairNums = ( 1:length( galRows ) )';
galInds = [ galRows, galCols, pairNums ];

pairs = nchoosek(pairNums, 2);
pairs = [ galInds( pairs( :, 1 ), 1:2 ), galInds( pairs( :, 2 ), 1:2 ) ];

steps = zeros( size( pairs, 1 ), 1 );
for ii = 1:size( pairs, 1 )
    rowStep = abs( pairs( ii, 1 ) - pairs( ii, 3) ); 
    colStep = abs( pairs( ii, 2 ) - pairs( ii, 4) ); 
    steps(ii) = rowStep + colStep;
end

sum(steps)






