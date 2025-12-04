function read_txt(path)
    open(path, "r") do f
    rawdata = readlines(f)
    return rawdata
    end
end

function parse_input(rawdata)
    roll_map = Array{Int8}( undef, length( rawdata[1] ), length( rawdata) )
    for (ii, line) in enumerate( rawdata )
        line = replace( line, "."=>"0", "@"=>"1" )
        line = split( line, "" )
        line = parse.( Int, line )
        roll_map[ ii, : ] = line
    end

    return roll_map
end

function check_neighbors( roll_map, row, col )

end

function silver()
    path = "2025/day-04/test_input.txt"
    rawdata = read_txt( path )
    roll_map = parse_input( rawdata )

    roll_count = 0
    rows, cols = size( roll_map )
    for row in 1:rows
        for col in 1:cols
            point_neighbors = 0
            point = roll_map[ row, col ]
            if point == 0
                continue
            else
                for ii in -1:1
                    for jj in -1:1
                        row_neigh = row + ii
                        col_neigh = col + jj
                        if ( row_neigh < 1 || row_neigh > rows ) || ( col_neigh < 1 || col_neigh > cols ) || ( ii == 0 && jj == 0 ) # Check array bounds and staying in the same place
                            continue
                        else
                            neighbor = roll_map[ row + ii, col + jj ]
                            if neighbor == 1    # Is a paper roll
                                point_neighbors += 1
                            end

                            if point_neighbors > 3  # Too many roll neighbors?
                                break
                            end
                        end
                    end
                end
            end

            if point_neighbors < 4
                roll_count += 1
            end
        end
    end

    println("Rolls: ", roll_count)
end
# silver()


function gold() #Baiscally silver, but change rolls to 0 after the map has been checked, and start over
    path = "2025/day-04/input.txt"
    rawdata = read_txt( path )
    roll_map = parse_input( rawdata )

    rows, cols = size( roll_map )
    removed = falses( rows, cols )
    roll_count = 0
    while true
        roll_count_iteration = 0
        for row in 1:rows
            for col in 1:cols
                point_neighbors = 0
                point = roll_map[ row, col ]
                if point == 0
                    continue
                else
                    for ii in -1:1
                        for jj in -1:1
                            row_neigh = row + ii
                            col_neigh = col + jj
                            if ( row_neigh < 1 || row_neigh > rows ) || ( col_neigh < 1 || col_neigh > cols ) || ( ii == 0 && jj == 0 ) # Check array bounds and staying in the same place
                                continue
                            else
                                neighbor = roll_map[ row + ii, col + jj ]
                                if neighbor == 1    # Is a paper roll
                                    point_neighbors += 1
                                end

                                if point_neighbors > 3  # Too many roll neighbors?
                                    break
                                end
                            end
                        end
                    end
                end

                if point_neighbors < 4
                    roll_count_iteration += 1
                    removed[ row, col ] = true
                end
            end
        end
        if roll_count_iteration == 0
            break
        else
            roll_count += roll_count_iteration
            roll_map[ removed ] .= 0
        end
    end

    println("Rolls: ", roll_count)
end
gold()
