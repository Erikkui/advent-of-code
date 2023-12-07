clc
close all
clearvars

A = readlines('Day2_input.txt');

colors = ["red", "green", "blue"];
colorcodes = [1, 2, 3 ];
constraints = [12:14];

goodGameIDs = [];
minimumCubeSets = [];
% Loop games
for ii = 1:size( A, 1 )
    minCube = zeros( 1, 3 );

    line = convertStringsToChars( A( ii, :) );
    doubledot = strfind( line, ":" );
    %pause
    line = line( doubledot+1:end);
    
    roundInds = strfind( line, ";" );
    roundInds = [1, roundInds+1, length( line )];

    %rounds = length( roundInds);

    % Loop through round of one game
    pass = [0];
    for jj = 2:length( roundInds )
        roundInd1 = roundInds( jj-1 );
        roundInd2 = roundInds( jj );

        round_temp = line( roundInd1+1:roundInd2 );
        %round_temp( round_temp == ' ') = [];
        round_temp( round_temp == ';') = [];
        round_temp = strtrim(  round_temp )
        
        % Codes for colors
        for kk = 1:3
                color = colors(kk);
                round_temp = strrep( round_temp, color, num2str(kk) );
        end

        round_temp = strtrim( split( round_temp, ",") )
        round_temp = str2double( split( round_temp, ' ', 2) )

        % Check if round is ok
        for kk = 1:size( round_temp, 1 )
            
            cubes = round_temp( kk, 1 )
            color = round_temp( kk, 2 )     
            maxCubes = constraints( color )
            
            if cubes <= maxCubes
                pass(end+1) = 0;    % Good round
            else
                pass(end+1) = 1;
            end

            if minCube( color ) <= cubes
                minCube( color ) = cubes;
            end

        end
                  
    end

    if sum( pass ) == 0
        goodGameIDs(end+1) = ii;
    end

    minimumCubeSets( ii, :) = minCube;

end

powers = minimumCubeSets(:, 1) .* minimumCubeSets(:, 2) .* minimumCubeSets(:, 3);

powersum = sum( powers)










