clc
close all
clearvars

rawdata = readlines('Day7_input.txt');

handArray = [];
bidArray =  [];
origInds = [];
for ii = 1:size( rawdata, 1 )

    line = rawdata( ii, : );
    line = split( line, ' ' );
    
    hand_orig = char( line(1) );
    hand = zeros( size( hand_orig ) );
    for jj = 1:5
        elem = hand_orig(jj)
        if elem == 'A'
            hand(jj) = 14;
        elseif elem == 'K'
            hand(jj) = 13;
        elseif elem == 'Q'
            hand(jj) = 12;
        elseif elem == 'J'
            hand(jj) = 11;
        elseif elem == 'T'
            hand(jj) = 10;
        else
            hand(jj) = str2double( elem );
        end
    end
    handArray( end+1, : ) = hand;
    bidArray( end+1 ) = str2double( line(2) );
    origInds( end+1 ) = ii;

end

%
strengthArray = {};
strengthArray{end+1} = [];
strengthArray{end+1} = [];
strengthArray{end+1} = [];
strengthArray{end+1} = [];
strengthArray{end+1} = [];
strengthArray{end+1} = [];
strengthArray{end+1} = [];

for ii = 1:length( handArray )

    hand = handArray( ii, : );
    
    % hand.hand
    % [C, ia, ic] = unique( hand.hand )
    % accumarray( ic, hand.hand )

    % Determining the strength of the hand
    strength = determineStrength( hand )
  %  pause
    if  strcmp( strength, 'five' )
        strengthArray{7}(end+1) = ii;
    elseif strcmp(strength, 'four')
        strengthArray{6}(end+1) = ii;
    elseif strcmp(strength, 'full')
        strengthArray{5}(end+1) = ii;
    elseif strcmp(strength, 'three')
        strengthArray{4}(end+1) = ii;
    elseif strcmp(strength, '2pair')
        strengthArray{3}(end+1) = ii;
    elseif strcmp(strength, 'pair')
        strengthArray{2}(end+1) = ii;
    elseif strcmp(strength, 'high')
        strengthArray{1}(end+1) = ii;
    end
end

trueHandOrder = [];
trueHandIndOrder = [];
trueBidOrder = [];
for ii = 1:length( strengthArray )
   
    handsInds = strengthArray{ii};
    
    if isempty( handsInds )
        continue
    end

    hands = handArray( handsInds, : );
    tempInds = origInds( handsInds );
    tempBids = bidArray( handsInds );
    
    hands( hands == 11 ) = 1;
    [sortedHands, sortedInds] = sortrows( hands, 1:5, 'ascend');
    
    trueHandOrder = cat( 1, trueHandOrder, sortedHands );
    trueHandIndOrder = cat( 1, trueHandIndOrder, tempInds( sortedInds )' );
    trueBidOrder = cat( 1, trueBidOrder, tempBids( sortedInds )' );
    
end

solution = sum( [1:length( trueBidOrder )]' .* trueBidOrder )


function strength = determineStrength( hand )

    cards = hand;

    if length( unique( cards ) ) == 1   
            strength = 'five';

    elseif sum( cards == 11 ) == 0

        if length( unique( cards ) ) == 2   
            C = unique( cards );
            if sum( cards == C(1) ) == 4 || sum( cards == C(2) ) == 4
                strength = 'four';
            else
                strength = 'full';
            end
        elseif length( unique( cards ) ) == 3 
            C = unique( cards );
            if sum( cards == C(1) ) == 3 || sum( cards == C(2) ) == 3 || sum( cards == C(3) ) == 3 
                strength = 'three';
            else
                strength = '2pair';
            end
        elseif length( unique( cards ) ) == 4
            strength = 'pair';
        elseif length( unique( cards ) ) == 5
            strength = 'high';
        end

    elseif sum( cards == 11 ) == 1
        
        if length( unique( cards ) ) == 2
            strength = 'five';
        elseif length( unique( cards ) ) == 3
            C = unique( cards );
            if sum( cards == C(1) ) == 3 || sum( cards == C(2) ) == 3 || sum( cards == C(3) ) == 3 
                strength = 'four';
            else
                strength = 'full';
            end
        elseif length( unique( cards ) ) == 4
            strength = 'three';
        elseif length( unique( cards ) ) == 5
            strength = 'pair';
        end

    elseif sum( cards == 11 ) == 2
        
        if length( unique( cards ) ) == 2
            strength = 'five';
        elseif length( unique( cards ) ) == 3
            strength = 'four';
        elseif length( unique( cards ) ) == 4
            strength = 'three';
        end

    elseif sum( cards == 11 ) == 3

        if length( unique( cards ) ) == 2
            strength = 'five';
        elseif length( unique( cards ) ) == 3
            strength = 'four';
        end
    elseif sum( cards == 11 ) == 4
        strength = 'five';
    end

end