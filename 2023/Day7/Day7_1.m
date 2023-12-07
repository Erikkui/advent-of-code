clc
close all
clearvars

rawdata = readlines('Day7_input.txt');

handArray = [];
for ii = 1:size( rawdata, 1 )

    line = rawdata( ii, : );
    line = split( line, ' ' );
    
    hand_orig = char( line(1) );
    hand = zeros( size( hand_orig ) );
    for jj = 1:5
        elem = hand_orig(jj);
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
            hand(jj) = str2num( elem );
        end
    end
    handArray(end+1).hand = hand;
    handArray(end).bid = str2double( line(2) );
    handArray(end).originalIndex = ii;

end

strengthArray = {};
strengthArray{end+1} = [];
strengthArray{end+1} = [];
strengthArray{end+1} = [];
strengthArray{end+1} = [];
strengthArray{end+1} = [];
strengthArray{end+1} = [];
strengthArray{end+1} = [];

for ii = 1:length( handArray )

    hand = handArray(ii);
    
    % hand.hand
    % [C, ia, ic] = unique( hand.hand )
    % accumarray( ic, hand.hand )

    % Determining the strength of the hand
    strength = determineStrength( hand )
  %  pause
    if  strcmp( strength, 'five' )
        strengthArray{7}(end+1) = hand.originalIndex;
    elseif strcmp(strength, 'four')
        strengthArray{6}(end+1) = hand.originalIndex;
    elseif strcmp(strength, 'full')
        strengthArray{5}(end+1) = hand.originalIndex;
    elseif strcmp(strength, 'three')
        strengthArray{4}(end+1) = hand.originalIndex;
    elseif strcmp(strength, '2pair')
        strengthArray{3}(end+1) = hand.originalIndex;
    elseif strcmp(strength, 'pair')
        strengthArray{2}(end+1) = hand.originalIndex;
    elseif strcmp(strength, 'high')
        strengthArray{1}(end+1) = hand.originalIndex;
    end
end

allHands = [ handArray.hand ];
allHands = reshape( allHands, 5, [] )';
inds = [ handArray.originalIndex ]';
bids = [ handArray.bid ]';

trueHandOrder = [];
trueHandIndOrder = [];
trueBidOrder = [];
for ii = 1:length( strengthArray )
   
    handsInds = strengthArray{ii};
    
    if isempty( handsInds )
        continue
    end

    hands = allHands( handsInds, : );
    tempInds = inds( handsInds );
    tempBids = bids( handsInds );

    [sortedHands, sortedInds] = sortrows( hands, 1:5, 'ascend');
    
    trueHandOrder = cat( 1, trueHandOrder, sortedHands );
    trueHandIndOrder = cat( 1, trueHandIndOrder, tempInds( sortedInds ) );
    trueBidOrder = cat( 1, trueBidOrder, tempBids( sortedInds ) );
    
end

solution = sum( [1:length( trueBidOrder )]' .* trueBidOrder )


function strength = determineStrength( hand )

    cards = hand.hand;
    if length( unique( cards ) ) == 1   
        strength = 'five';
    elseif length( unique( cards ) ) == 2   
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
end


