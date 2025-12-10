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


# function create_tilemap( coords )
#     ncoords = size( coords, 1 )
#     max_x = maximum( coords[:, 1] )
#     max_y = maximum( coords[:, 2] )
#     tilemap = BitArray( undef, max_y, max_x )
#     tilemap[ tilemap .== true ] .= false
#     for ii in 1:ncoords
#         coord1, coord2 = nothing, nothing
#         if ii == ncoords
#             coord1, coord2 = coords[ii, :], coords[1, :]
#         else
#             coord1, coord2 = coords[ii, :], coords[ii+1, :]
#         end
#         direction_x = coord2[1] < coord1[1] ? -1 : 1
#         direction_y = coord2[2] < coord1[2] ? -1 : 1
#         x = coord1[1]:direction_x:coord2[1]
#         y = coord1[2]:direction_y:coord2[2]
#         tilemap[ y, x ] .= true
#     end

#     return tilemap
# end

function create_ranges( coords )
    ncoords = size( coords, 1 )

    hor_edges = Dict{Int, Any}()
    vert_edges = similar( xranges )
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
        if length(x) == 1
            vert_edges[ x[1] ] = y
        else
            hor_edges[ y[1] ] = x
        end

    end

    return hor_edges, vert_edges
end


function gold()
    path = "2025/day-09/test_input.txt"
    rawdata = read_txt( path )
    coords = parse_input( rawdata )

    ncoords = size( coords, 1 )

    # Find edges of the area
    hor_edges, vert_edges = create_tilemap( coords )
    # for ii in eachrow( tilemap )
    #     println(ii)
    # end

    # Find areas
    areas_all = Vector{Int}( undef, 0 )
    inds_start = similar( areas_all )
    inds_end = similar( areas_all )
    hor_keys = keys( hor_edges )
    vert_keys = keys( vert_edges )
    for ii in 1:ncoords
        for jj in ii+1:ncoords
            is_ok = false
            rect_edges = Dict{ Int, Any }()
            coord1, coord2 = coords[ii, :], coords[jj, :]
            coord12 = coords[ [ii, jj], : ]

            direction_x = coord2[1] < coord1[1] ? -1 : 1
            direction_y = coord2[2] < coord1[2] ? -1 : 1

            rect_edges[ y[1] ] = direction_x
            rect_edges[ y[end] ] = direction_x
            rect_edges[ x[1] ] = direction_y
            rect_edges[ x[end] ] = direction_y

            # Check horizontal edges of rectangle
            needed_keys = intersect( vert_keys, direction_x )
            if length( needed_keys ) > 0
                for key in needed_keys
                    area_edge = vert_keys[ key ]

                end



            end




            if is_ok
                area = abs.(coord1 .- coord2) .+ 1
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
