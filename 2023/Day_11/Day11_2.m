clc
close all
clearvars
format long

rawdata = readlines( 'day11_data.txt' );
rawdata = char( rawdata );

[N, M] = size( rawdata );
expandment = 1000000;

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
            data( ii, jj ) = 1;
        elseif elem == '#'
            data( ii, jj ) = Inf;
        end
    end
end

%
for ii = 1:length( duplicateRows )
    dupInd = duplicateRows(ii);
    data( dupInd, : ) = expandment*ones( 1, M );    
end

for ii = 1:length( duplicateCols )
    dupInd = duplicateCols(ii);
    data( :, dupInd ) = expandment*ones( N, 1 );      
end


%
[galRows, galCols] =  find( data == Inf );
pairNums = ( 1:length( galRows ) )';
galInds = [ galRows, galCols, pairNums ];

pairs = nchoosek(pairNums, 2);
pairs = [ galInds( pairs( :, 1 ), 1:2 ), galInds( pairs( :, 2 ), 1:2 ) ];

steps = zeros( size( pairs, 1 ), 1 );
for ii = 1:size( pairs, 1 )
    pair1 = pairs( ii, 1:2 );
    pair2 = pairs( ii, 3:4 );
    rowMin = min( pair1(1), pair2(1) );
    rowMax = max( pair1(1), pair2(1) );
    colMin = min( pair1(2), pair2(2) );
    colMax = max( pair1(2), pair2(2) );

    rowStepsInds = rowMin:rowMax-1;
    colStepsInds = colMin:colMax-1;

    rowStep = data( rowMin, colStepsInds );
    colStep = data( rowStepsInds, colMin );

    totRowSteps = sum( rowStep( rowStep < Inf ) ) + sum( rowStep == Inf );
    totColSteps = sum( colStep( colStep < Inf ) ) + sum( colStep == Inf );
   
    %pause
    % clc
    steps(ii) = totRowSteps + totColSteps;
end

sum(steps)





