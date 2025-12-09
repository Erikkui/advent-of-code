function read_txt(path)
    open(path, "r") do f
    rawdata = readlines(f)
    return rawdata
    end
end

function parse_input(rawdata)
    rows = length( rawdata )
    coords = Matrix{Int}( undef, rows, 2 )
    for ii in 1:rows
        row = rawdata[ii]
        row = parse.( Int, split( row, "," ) )
        coords[ii, :] = row
    end
    return coords
end


function silver()
    path = "2025/day-09/input.txt"
    rawdata = read_txt( path )
    coords = parse_input( rawdata )

    ncoords = size( coords, 1 )
    # Find areas
    areas_all = Vector{Int}( undef, 0 )
    inds_start = similar( areas_all )
    inds_end = similar( areas_all )
    for ii in 1:ncoords
        for jj in ii+1:ncoords
            coord1, coord2 = coords[ii, :], coords[jj, :]
            area = abs.(coord1 .- coord2) .+ 1
            area = prod( area )
            push!( areas_all, area )
            push!( inds_start, ii )
            push!( inds_end, jj )
        end
    end
    deleteat!( areas_all, ncoords )
    deleteat!( inds_start, ncoords )
    deleteat!( inds_end, ncoords )

    max_area = maximum( areas_all )
    println( max_area)
end

# silver()


function create_tilemap( coords )
    ncoords = size( coords, 1 )

    xranges = Vector{}(undef, 0)
    yranges = similar( xranges )
    for ii in 1:ncoords
        coord1, coord2 = nothing, nothing
        if ii == ncoords
            coord1, coord2 = coords[ii, :], coords[1, :]
        else
            coord1, coord2 = coords[ii, :], coords[ii+1, :]
        end
        direction_x = coord2[1] < coord1[1] ? -1 : 1
        direction_y = coord2[2] < coord1[2] ? -1 : 1
        x = coord1[1]:direction_x:coord2[1]
        y = coord1[2]:direction_y:coord2[2]
        push!( xranges, x )
        push!( yranges, y )
    end

    return xranges, yranges
end


function gold()
    path = "2025/day-09/input.txt"
    rawdata = read_txt( path )
    coords = parse_input( rawdata )

    ncoords = size( coords, 1 )

    # Create a map of allowed tiles
    tilemap = create_tilemap( coords )
    # for ii in eachrow( tilemap )
    #     println(ii)
    # end

    # Find areas
    areas_all = Vector{Int}( undef, 0 )
    inds_start = similar( areas_all )
    inds_end = similar( areas_all )
    for ii in 1:ncoords
        for jj in ii+1:ncoords
            coord1, coord2 = coords[ii, :], coords[jj, :]
            area = abs.(coord1 .- coord2) .+ 1

            direction_x = coord2[1] < coord1[1] ? -1 : 1
            direction_y = coord2[2] < coord1[2] ? -1 : 1
            xcoord = coord1[1]:direction_x:coord2[1]
            ycoord = coord1[2]:direction_y:coord2[2]

            flag = false
            for xx in xcoord, yy in ycoord
                col = @view tilemap[ :, xx ]
                row = @view tilemap[ yy, : ]

                outside_y = sum( col ) < 2
                outside_x = sum( row ) < 2
                if outside_y || outside_x
                    flag = true
                    break
                else
                    outside_up = yy < findfirst( isequal(1), col )
                    outside_down = yy > findlast( isequal(1), col )
                    outside_left = xx < findfirst( isequal(1), row )
                    outside_right = xx > findlast( isequal(1), row )
                    if outside_up || outside_down || outside_left || outside_right
                        flag = true
                        break
                    end
                end
            end
            if !(flag)
                area = prod( area )
                push!( areas_all, area )
                push!( inds_start, ii )
                push!( inds_end, jj )
            end
        end
    end
    println( areas_all )
    println( inds_start )
    println( inds_end )

    max_area = maximum( areas_all )
    println( max_area)

end

gold()
