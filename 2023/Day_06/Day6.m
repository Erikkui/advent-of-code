clc
close all
clearvars

% Part 1
Time =  [ 59     70     78     78 ];
Distance = [ 430   1218   1213   1276 ];
syms t_but

numberOfWays = [];
for ii = 1:length( Time )
    t_tot = Time(ii);
    d_w = Distance(ii);

    f(t_but) = t_but^2 - t_tot*t_but + d_w

    sols = double( solve( f == 0) )
    sols( 1:end ) = [ ceil( sols(1) ), floor( sols(2) ) ] ;

    numberOfWays(end+1) = diff( sols ) + 1


end

puzzleSol = prod( numberOfWays )

% Part 2
Time = str2double( strrep( num2str( Time ), ' ', '' ) );
Distance = str2double( strrep( num2str( Distance ), ' ', '' ) );

f(t_but) = t_but^2 - Time*t_but + Distance

sols = double( solve( f == 0) )
sols( 1:end ) = [ ceil( sols(1) ), floor( sols(2) ) ] 

diff( sols ) + 1
