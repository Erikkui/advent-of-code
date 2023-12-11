clc
close all
clearvars

rawdata = readlines( 'day10_data.txt' );
rawdata = char( rawdata );

data = parseData( rawdata );

[M, N] = size( data );
[iStart, jStart] =  find( data == Inf )
nextTile = NaN;

[loopTileInds, loopMatrix] = findLoopInds( iStart, jStart, data );
    
loopTileInds( :, 3 ) = loopTileInds( :, 3 ) - 1;

farthest = ceil( loopTileInds( end, 3 )/2 )
solvedPath = loopMatrix.*data
solvedPath( loopTileInds( 1, 1 ), loopTileInds( 1, 2 ) ) = -10;
imagesc( solvedPath )

function [ loopTileInds, loopMatrix ] = findLoopInds( row, col, data )

    firstStep = determineFirstStep( row, col, data );

    loopTileInds = [ row, col, 1 ];
    loopMatrix = logical( zeros( size( data ) ) );
    loopMatrix( row, col ) = true;
   % loopMatrix( firstStep(1), firstStep(2) ) = true

    tileNumber = 1;
    elem = data( firstStep(1), firstStep(2) );

    oldRow = row;
    oldCol = col;
    nextRow = firstStep(1);
    nextCol = firstStep(2);
    while true   

        if elem == 13
            tileNumber = tileNumber + 1;
            loopTileInds( end+1, : ) = [ nextRow, nextCol, tileNumber ];
            loopMatrix( nextRow, nextCol ) = true;
            if nextRow < oldRow
                oldRow = nextRow;
                nextRow = nextRow - 1;
                nextCol = oldCol;
                oldCol = nextCol;
                elem = data( nextRow, nextCol );
            else
                oldRow = nextRow;
                nextRow = nextRow + 1;
                nextCol = oldCol;
                oldCol = nextCol;
                elem = data( nextRow, nextCol );
            end
%pause

        elseif elem == 42
            tileNumber = tileNumber + 1;
            loopTileInds( end+1, : ) = [ nextRow, nextCol, tileNumber ];
            loopMatrix( nextRow, nextCol ) = true;
            if nextCol < oldCol
                oldCol = nextCol;
                nextCol = nextCol - 1;
                nextRow = oldRow;
                elem = data( nextRow, nextCol );
            else
                oldCol = nextCol;
                nextCol = nextCol + 1;
                nextRow = oldRow;
                oldRow = nextRow;
                elem = data( oldRow, nextCol );
            end
%pause
        elseif elem == 12
            tileNumber = tileNumber + 1;
            loopTileInds( end+1, : ) = [ nextRow, nextCol, tileNumber ];
            loopMatrix( nextRow, nextCol ) = true;
            if nextRow > oldRow
                oldRow = nextRow;
                nextCol = oldCol + 1;
                elem = data( nextRow, nextCol );
            else
                oldRow = nextRow;
                nextRow = oldRow - 1;
                oldCol = nextCol;
                nextCol = oldCol;
                elem = data( nextRow, nextCol );
            end
%pause
        elseif elem == 14
            tileNumber = tileNumber + 1;
            loopTileInds( end+1, : ) = [ nextRow, nextCol, tileNumber ];
            loopMatrix( nextRow, nextCol ) = true;
            if nextRow > oldRow
                oldCol = nextCol;
                nextCol = nextCol - 1;
                oldRow = nextRow;
                nextRow = oldRow;
                elem = data( nextRow, nextCol );
            else
                oldRow = nextRow;
                nextRow = nextRow - 1;
                oldCol = nextCol;
                nextCol = oldCol;
                elem = data( nextRow, nextCol );
            end
%pause
        elseif elem == 34
            tileNumber = tileNumber + 1;
            loopTileInds( end+1, : ) = [ nextRow, nextCol, tileNumber ];
            loopMatrix( nextRow, nextCol ) = true;
            if nextRow < oldRow
                oldCol = nextCol;
                nextCol = nextCol - 1;
                oldRow = nextRow;
                %nextRow = oldRow
                elem = data( nextRow, nextCol );
            else
                oldRow = nextRow;
                nextRow = nextRow + 1;
                oldCol = nextCol;
                nextCol = oldCol;
                elem = data( nextRow, nextCol );
            end
%pause
        elseif elem == 32
            tileNumber = tileNumber + 1;
            loopTileInds( end+1, : ) = [ nextRow, nextCol, tileNumber ];
            loopMatrix( nextRow, nextCol ) = true;
            if nextRow < oldRow
                oldCol = nextCol;
                nextCol = nextCol + 1;
                oldRow = nextRow;
                nextRow = oldRow;
                elem = data( nextRow, nextCol );
            else
                oldRow = nextRow;
                nextRow = oldRow + 1;
                oldCol = nextCol   ;    
                nextCol = oldCol;
                elem = data( nextRow, nextCol );
            end
%pause
        elseif elem == Inf
            break
        end

    end
end


function firstStep = determineFirstStep( row, col, data )
    
    if row < size( data, 1 )
        top = data( row-1, col );
    end
    if row > 1
        bottom = data( row+1, col );
    end
    if col > 1
        left = data( row, col-1 );
    end
    if col < size( data, 2 )
        right = data( row, col+1 );
    end

    if top == 13 || top == 34 || top == 32
        firstStep = [ row-1, col ];
    elseif bottom == 13 || bottom == 12 || bottom == 14
        firstStep = [ row+1, col ];
    elseif left == 42 || left == 12 || left == 32
        firstStep = [ row, col+1 ];
    else
        firstStep = [ row, col-1 ];
    end

end


function isInLoop = loopCheck( elem, ii, jj, data )
    
    north = @(connect) connect(1) == '3' || strcmp( connect, '13' );
    south = @(connect) connect(1) == '1' || strcmp( connect, '13' );
    east = @(connect) connect(2) == '4' || strcmp( connect, '42' );
    west = @(connect) connect(2) == '2' || strcmp( connect, '42' );

    if elem == 13
        if ii == 1 || ii == size( data, 1 )
            isInLoop = false;
        else
            connect1 = num2str( data( ii+1, jj ) );
            connect2 = num2str( data( ii-1, jj ) );

            if north( connect1 ) + south( connect2 ) == 2
                isInLoop = true; 
            else 
                isInLoop = false;
            end
        end
    end

    if elem == 42
        if jj == 1 || jj == size( data, 2 )
            isInLoop = false;
        else
            connect1 = num2str( data( ii, jj-1 ) );
            connect2 = num2str( data( ii, jj+1 ) );
            
            if west( connect1 ) + east( connect2 ) == 2
                isInLoop = true; 
            else 
                isInLoop = false;
            end
        end
    end

    if elem == 12
        if ii == 1 || jj == size( data, 2 )
            isInLoop = false;
        else
            connect1 = num2str( data( ii-1, jj ) );
            connect2 = num2str( data( ii, jj+1 ) );

            if north( connect1 ) + east( connect2 ) == 2
                isInLoop = true; 
            else 
                isInLoop = false;
            end
        end
    end

    if elem == 14
        if ii == 1 || jj == 1
            isInLoop = false;
        else
            connect1 = num2str( data( ii-1, jj ) );
            connect2 = num2str( data( ii, jj-1 ) );

            if north( connect1 ) + west( connect2 ) == 2
                isInLoop = true; 
            else 
                isInLoop = false;
            end
        end
    end

    if elem == 34
        if ii == size( data, 1) || jj == 1
            isInLoop = false;
        else
            connect1 = num2str( data( ii+1, jj ) );
            connect2 = num2str( data( ii, jj-1 ) );

            if south( connect1 ) + west( connect2 ) == 2
                isInLoop = true; 
            else 
                isInLoop = false;
            end
        end
    end

    if elem == 32
        if ii == 1 || jj == size( data, 2 )
            isInLoop = false;
        else
            connect1 = num2str( data( ii+1, jj ) );
            connect2 = num2str( data( ii, jj+1 ) );

            if south( connect1 ) + east( connect2 ) == 2
                isInLoop = true; 
            else 
                isInLoop = false;
            end
        end
    end

end


function neighbourInds = findNeighbours( row, col, nRows, nCols)
    
    neighbourInds = [];

    if row < nRows
        neighbourInds( end+1, : ) = [ row+1, col ];
    end
    if row > 1
        neighbourInds( end+1, : ) = [ row-1, col ];
    end
    if col < nCols
        neighbourInds( end+1, : ) = [ row, col+1 ];
    end
    if col > 1
        neighbourInds( end+1, : ) = [ row, col-1 ];
    end

end


function data = parseData( rawdata )
    [M, N] = size( rawdata );
    data = zeros( M, N );
    for ii = 1:M
        for jj = 1:N
            elem = rawdata( ii, jj );
            if elem == 'S'
                data( ii, jj ) = Inf;
            elseif elem == '|'
                data( ii, jj ) = 13;
                
            elseif elem == '-'
                data( ii, jj ) = 42;
    
            elseif elem == 'L'
                data( ii, jj ) = 12;
    
            elseif elem == 'J'
                data( ii, jj ) = 14;
    
            elseif elem == '7'
                data( ii, jj ) = 34;
    
            elseif elem == 'F'
                data( ii, jj ) = 32;
    
            elseif elem == '.'
                data( ii, jj ) = 0;
            end
        end
    end
end
