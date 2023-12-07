clc
close all
clearvars

%%% PT 1

A = readlines('Day1_input.txt');
answer = 0;
for ii = 1:size( A, 1 )

    line = A( ii, : );
    C = regexp(line,'[0-9]','match');

    if length(C) > 1
        temp = str2double( append( C(1), C(end) ) );
    elseif  length(C) == 1
        temp = str2double( append( C(1), C(1) ) );
    else 
        temp = 0;
    end
    %pause
    answer = answer + temp;

end

%%% PT2
answer = 0;
checkNumbers = [ "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"];

for ii = 1:size( A, 1 )

    line = A( ii, : );
    line = lower(line);
    %line = convertStringsToChars(line);
    
    nums = [];
    % Find number numbers and add to list
    [numNumNums, numNumInds] = regexp(line,'[0-9]', 'match');

    if ~isempty(numNumInds)
        numNumNums = str2double( numNumNums );
        nums = [numNumInds; numNumNums];
    end

    % Find written numbers and add to list
    for jj = 1:9
        stringNumInd = strfind( line, checkNumbers(jj) );  
        if ~isempty( stringNumInd )
            stringNumNum = jj*ones( size( stringNumInd ) );
            nums = cat( 2, nums, [stringNumInd; stringNumNum]);  
        end
    end

    % Sort by indices of the numbers
    if ~isempty( nums) 
        [XSorted, I] = sort( nums( 1, : ) );

        sortedNums = nums( 2, : );
        sortedNums = sortedNums( I );
    end
    
    sortedNums = string( sortedNums );
    
    if length( sortedNums ) > 1
        temp = str2double( append( sortedNums(1), sortedNums(end) ) );
    elseif  length( sortedNums ) == 1
        temp = str2double( append( sortedNums(1), sortedNums(1) ) );
    else 
        temp = 0;
    end

%   temp
  %pause
    answer = answer + temp;

end


