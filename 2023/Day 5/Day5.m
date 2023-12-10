clc
close all
clearvars;
format long

A = readlines( 'day5_input.txt' );

% Parse data
seeds = str2double( split( A( 1, : ), ' ' ));
seeds = seeds( ~isnan( seeds ) );

mapArray = [];
for ii = 3:size( A, 1 )
    line = A( ii, : );
    lineArr = str2double( split( line, ' ' ) );

    if isnan( lineArr(1) ) && size( lineArr, 1 ) > 1
        mapArray(end+1).name = line;
        mapArray( end ).mapValues = [];
    elseif ~isnan( lineArr )
        lineArr( 1:end ) = [ lineArr(2), lineArr(1), lineArr(3) ];
        mapArray( end ).mapValues( end+1, : ) = lineArr;
    end
end

for ii = 1:length( mapArray )
    sortedMapValues = sortrows( mapArray(ii).mapValues);
    mapArray(ii).mapValues = sortedMapValues;
end

tic
locations = [];
for ii = 1:length( seeds )
    
    destination = seeds( ii );
    
    for jj = 1:length( mapArray )
        
        map = mapArray(jj);

        destination = findDestination( destination, map );

    end

    locations(end+1) = destination;

end

sortedLocations = sort( locations, "ascend");
sortedLocations(1)
toc

% Part 2
tic
mindist = Inf;
for ii = 1:2:18
    seeds_min = seeds(ii);
    seeds_range = seeds(ii+1);
    seeds_max = seeds_min + seeds_range - 1;
    sourceValues = seeds_min:seeds_max;

    for jj = 1:length( sourceValues )

        destination = sourceValues( jj );

        for kk = 1:length( mapArray )
        
            map = mapArray(kk);
            destination = findDestination( destination, map );

        end

        if destination < mindist
            mindist = destination;
        end

    end

end

toc


function destination = findDestination( sourceValue, map )

    sourceStartMin = map.mapValues(1,1);
    sourceStartMax = map.mapValues( end, 1 );
    sourceMaxRange = map.mapValues( end, 3 );

    if sourceValue < sourceStartMin
        destination = sourceValue;

    elseif sourceValue > sourceStartMax + sourceMaxRange - 1
        destination = sourceValue;
    elseif sourceValue >= sourceStartMax && sourceValue <= sourceStartMax + sourceMaxRange - 1
        sourceStart = map.mapValues( end, 1 );
        destStart = map.mapValues( end, 2 );
        difference = sourceValue - sourceStart;
        destination = destStart + difference;
    else
        ind = find( sourceValue < map.mapValues( :, 1 ), 1 ) - 1;
    
        sourceStart = map.mapValues( ind, 1 );
        destStart = map.mapValues( ind, 2 );
        Range = map.mapValues( ind, 3 );
        
        if sourceValue <= sourceStart + Range - 1
            difference = sourceValue - sourceStart;
            destination = destStart + difference;
        else
            sourceMax = sourceStart + Range - 1;
    
            difference = sourceValue - sourceMax;    
            destination = sourceMax + difference  ;   
        end    

    end

end


% 12208442
% 105934390
% 40283135
% 282277027

