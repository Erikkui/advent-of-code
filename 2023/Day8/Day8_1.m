clc
close all
clearvars

rawdata = readlines('Day8_input.txt');

guide_txt = char( rawdata( 1, : ) );

guide = zeros( size( guide_txt ) );
for ii = 1:length( guide_txt )    
    elem = guide_txt(ii);
    if elem == 'L'
        guide(ii) = 1;
    else
        guide(ii) = 2;
    end
end

node0s = [];
leftCoords = [];
rightCoords = [];
for ii = 3:size( rawdata, 1 )

    line = rawdata( ii, : );
    line = strrep( line, ' =', '' );
    line = strrep( line, '(', '' );
    line = strrep( line, ')', '' );
    line = strrep( line, ',', '' );
    
    row = split( line, ' ');

    node0s = cat( 1, node0s, char( row(1) ) );
    leftCoords = cat( 1, leftCoords, char( row(2) ) );
    rightCoords = cat( 1, rightCoords, char( row(3) ) );

end

steps = 0;
guideInd = 1;
[~, node0ind] = ismember( 'AAA', node0s, 'rows' );
node0 = node0s( node0ind, : );
while true
    
    if guideInd <= length( guide )

        LR = guide( guideInd );

        if LR == 1
            node0 = leftCoords( node0ind, : );
            steps = steps + 1;
          % pause
        else
            node0 = rightCoords( node0ind, : );
            steps = steps + 1;
          %  pause
        end

        [~, node0ind] = ismember( node0, node0s, 'rows' );
        node0 = node0s( node0ind(1), : );

        guideInd = guideInd + 1;

       % pause

        if strcmp( node0, 'ZZZ' )
            break
        end

    else
        guideInd = 1;
    end

end

steps




