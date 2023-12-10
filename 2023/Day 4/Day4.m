%%
clc
close all
clearvars

A = readlines('Day4_input');

winningSum = 0;
winningNumberAmount = 0;
% Loop games
for ii = 1:size( A, 1 )
    
    line = A( ii, : );
    [winning, playing] = parseNumberLine( line );
    
    exponent = 0;
    for jj = 1:length( playing )
        if sum( ismember( playing(jj), winning ) ) ~= 0
            exponent = exponent + 1;
        end
    end

    if exponent  > 0
        sumPart = 2^( exponent - 1);
        winningSum = winningSum + sumPart;
        winningNumberAmount = winningNumberAmount + exponent;
    elseif exponent == 1
        winningSum = winningSum + 1;
        winningNumberAmount = winningNumberAmount + 1;
    else

    end
end

%%
clc
close all
clearvars

A = readlines('Day4_input');

cardNums = [];
cards = {};
for ii = 1:size( A, 1 )
    
    line = A( ii, : );
    [winning, playing] = parseNumberLine( line );

    cardNums(end+1) = 1;
    cards{end+1, 1} = winning';
    cards{end, 2} = playing';

end

cardNum_new = size( A, 1 );
cardNum_orig = cardNum_new;
rowInd = 0;

check1 = 0;
check2 = 0;
counting = 1;
for rowInd = 1:cardNum_orig
    
    winning = cards{ rowInd, 1 };
    playing = cards{ rowInd, 2 };

    newRow = 0;
    for jj = 1:length( playing )
        if sum( ismember( playing(jj), winning ) ) ~= 0
            newRow = newRow + 1;
        end
    end

    if newRow > 0
        newRow
        cardNums( rowInd+1:rowInd+newRow ) = cardNums( rowInd+1:rowInd+newRow ) + cardNums( rowInd )
        %pause
    end

end

ismember( cards{17, 2}, cards{17, 1} )

sum( cardNums )


%%

function [winningNumbers, playNumbers] = parseNumberLine( line )

    line = convertStringsToChars( line );
    doubledot = strfind( line, ":" );
    
    line = line( doubledot+2:end);

    verticalLineInd = strfind( line, "|" );

    winningNumbers = line( 1:verticalLineInd-2);
    playNumbers = line( verticalLineInd+2:end);

    winningNumbers = strrep( winningNumbers, '  ', ' ');
    playNumbers = strrep( playNumbers, '  ', ' ');

    winningNumbers = strtrim( winningNumbers );
    playNumbers = strtrim( playNumbers );

    winningNumbers = str2double( split( winningNumbers, ' ' ) );
    playNumbers = str2double( split( playNumbers, ' ' ) );

end


