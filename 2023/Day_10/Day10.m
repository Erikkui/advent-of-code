clc
close all
clearvars

rawdata = readlines( 'example1.txt' );
rawdata = char( rawdata );


data = parseData( rawdata );


[M, N] = size( data );
isLoopMatrix = logical( zeros( M, N ) );
for ii = 1:M
    for jj = 1:N
        elem = data( ii, jj );
        
        if elem ~= 88 && elem ~= 99
            neighbourInds = findNeighbours( ii, jj, M, N );
            neighbours = [];
            for nn = 1:size( neighbourInds, 1 )
                neigRow = neighbourInds( nn, 1 );
                neigCol = neighbourInds( nn, 2 );
                neighbours( end+1 ) = data( neigRow, neigCol );     
            end

            isInLoop = loopCheck( elem, ii, jj, data )
            
            if isInLoop
                isLoopMatrix( ii, jj ) = 1
                pause
            % else
            %     data( ii, jj ) = 0;
            end  
        end
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
                data( ii, jj ) = 99;
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
                data( ii, jj ) = 88;
            end
        end
    end
end
