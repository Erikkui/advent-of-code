clc
close all
clearvars

A = readlines('Day3_input');

A = char(A);

%data = strrep( data, '.', 'NaN')

M = size( A, 1 );
N = size( A, 2 );

data = zeros( M, N );

for ii = 1:M
    for jj = 1:N
        entry = A( ii, jj );
        if entry == '.'
            newEntry = NaN;
            data( ii, jj ) = newEntry;
        elseif entry == '*'
            newEntry = Inf;
            data( ii, jj ) = newEntry;
        elseif isempty( str2num( entry ) )
            newEntry = -Inf;
            data( ii, jj ) = newEntry;
        elseif ~isempty( str2num( entry ) )
            newEntry = str2double( entry );
            data( ii, jj ) = newEntry;
        end

    end
end

partNumbers = [];
partInds = [ 0, 0 ];
gears = [];

for ii = 1:M
    for jj = 1:N
        elem = data( ii, jj );
        if elem == -Inf

            neighbours = getNeighbours( ii, jj, M, N );

            for nn = 1:size( neighbours, 1 )
                nInds = neighbours( nn, : );
                part_i = data( nInds(1), nInds(2) );
                     
                if part_i >= 0 && part_i <= 9
                    numberStruct = getPartNumber( nInds, data, N );

                    if sum( ismember( numberStruct.inds, partInds, 'rows' ) ) == 0
                        partNumbers( end+1 ) = numberStruct.partNumber;
                        partInds( end+1, : ) = numberStruct.inds;
                    end

                end

            end
        elseif elem == Inf
            
            neighbours = getNeighbours( ii, jj, M, N );
            gearParts = 0;
            for nn = 1:size( neighbours, 1 )
                nInds = neighbours( nn, : );
                part_i = data( nInds(1), nInds(2) );
                     
                if part_i >= 0 && part_i <= 9
                    numberStruct = getPartNumber( nInds, data, N );

                    if sum( ismember( numberStruct.inds, partInds, 'rows' ) ) == 0
                        partNumbers( end+1 ) = numberStruct.partNumber;
                        partInds( end+1, : ) = numberStruct.inds;
                        gearParts = gearParts + 1;
                    end

                end
            end

            if gearParts == 2
                gears( end+1 ) = partNumbers(end)*partNumbers( end-1 );
            end

        end
    end
end

partnumber = partNumbers( 2:end, : );

numberSum = sum( partNumbers )
gearSum = sum( gears )

function partStruct = getPartNumber( inds, data, N )

    number = data( inds(1), inds(2) );
    colInd = inds(2);

    if inds(2)-1 >= 1
        newNum = data( inds(1), inds(2)-1 );
        if newNum >= 0 && newNum <= 9 && ~isnan( newNum )
            number = number + 10*newNum;
            colInd = colInd - 1;
            if inds(2)-2 >= 1
                newNum = data( inds(1), inds(2)-2 );
                if newNum >= 0 && newNum <= 9 && ~isnan( newNum)
                    number = number + 100*newNum;
                    colInd = colInd - 1;
                end
            end
        end
    end

    if inds(2)+1 <= N
        newNum = data( inds(1), inds(2)+1 );
        if newNum >= 0 && newNum <= 9 && ~isnan( newNum)
            number = 10*number + newNum;      
            if inds(2)+2 <= N
                newNum = data( inds(1), inds(2)+2 );
                if newNum >= 0 && newNum <= 9 && ~isnan( newNum)
                    number = 10*number + newNum;
                end
            end
        end
    end

    partStruct.inds = [ inds(1), colInd];
    partStruct.partNumber = number;
end


function neighbours = getNeighbours( row, col, nRows, nCols)
    
    rows = [row];
    cols = [col];
    neighbours = [];

    if row < nRows
        rows(end+1) = row + 1;
    end
    if row > 1
        rows(end+1) = row - 1;
    end
    if col < nCols
        cols(end+1) = col + 1;
    end
    if col > 1
        cols(end+1) = col - 1;
    end

    for ii = 1:length( rows )
        for jj = 1:length( cols )
            neighbours( end+1, : ) = [ rows(ii), cols(jj) ];    
        end
    end
    
    neighbours( 1, : ) = [];
    


end


% 512426 TESTATTU
% 534226
% 544664


