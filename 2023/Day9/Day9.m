clc
close all
clearvars

rawdata = char( readlines('day9_input.txt') );

data = [];

for ii = 1:size( rawdata, 1 )

    line = char( rawdata( ii, : ) );
    line = strtrim( line );
    line = str2double( split( line, ' ' )' );
    
    data( end + 1, : ) = line;

end

newNums = []; 
for ii = 1:size( data, 1 )

    row = data( ii, : );

    extrapolatedNum = getExtrapolatedNum( row );
    newNums( end+1 ) = extrapolatedNum;

end

format long
answer1 = sum( newNums )

%%% Part 2
data = flip( data, 2 );
newNums = []; 
for ii = 1:size( data, 1 )

    row = data( ii, : );

    extrapolatedNum = getExtrapolatedNum( row );
    newNums( end+1 ) = extrapolatedNum;

end

answer2 = sum( newNums )





function newNum = getExtrapolatedNum( row )

    if sum( row ) == 0
       newNum = 0;
    else

        temp_row = diff( row )
        lastNums = [ row(end), temp_row(end) ]

        while true

            if all( temp_row == 0 )
                
                newNum = sum( lastNums )
                % for ii = 2:length( lastNums )
                % 
                %     newNum = lastNums(ii) + newNum
                % 
                % end
                break
            else
                temp_row = diff( temp_row ) 
                lastNums( end+1 ) = temp_row(end)
            end
        end
    end

end