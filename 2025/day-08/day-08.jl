function read_txt(path)
    open(path, "r") do f
    rawdata = readlines(f)
    return rawdata
    end
end

function parse_input(rawdata)
    rows, cols = length( rawdata ), 3
    box_coords = Matrix{Int}( undef, rows, cols )
    for (ii, row) in enumerate( rawdata )
        row = split( row, "," )
        row = parse.( Int, row )
        box_coords[ ii, : ] = row
    end
    return box_coords
end


function get_connections( dists_all, dists_inds, connections_needed )
    N_dists = length( dists_all[1] )

    D = vcat( dists_all... )
    sorted_inds = sortperm(D)

    circuit_starts = [ repeat( [ind], N_dists + 1 - ind ) for ind in 1:N_dists ]
    circuit_starts = vcat( circuit_starts... )

    dist_inds = vcat( dists_inds... )

    connections = dist_inds[ sorted_inds[ 1:connections_needed ] ]
    circuit_inds = circuit_starts[ sorted_inds[1:connections_needed ] ]

    circuits = [ [circ, con] for (circ, con) in zip( circuit_inds, connections) ]

    return circuits
end


function silver()
    path = "2025/day-08/input.txt"
    rawdata = read_txt( path )
    coords = parse_input( rawdata )

    n_coords = size( coords, 1 )
    dists_all = Vector{ Vector{Int} }( undef, n_coords )
    dists_inds = Vector{ Vector{Int} }( undef, n_coords )
    for (ii, point) in enumerate( eachrow(coords) )
        points_temp = @view coords[ ii+1:end, : ]
        dists_ii = [ sum( (point .- point_jj).^2 ) for point_jj in eachrow( points_temp ) ]
        dists_all[ii] = dists_ii
        dists_inds[ii] = collect( ii+1:size( coords, 1 ) )
    end
    deleteat!( dists_all, n_coords )
    deleteat!( dists_inds, n_coords )

    connections_needed = 1000
    connections = get_connections( dists_all, dists_inds, connections_needed )

    connection_compare = deepcopy( connections )
    result_connections = []
    deleteat!( connection_compare, 1 )
    ind = 1
    while true
        union_found = false
        connection_ii = connections[ ind ]
        delete_list = Int[]
        for jj in eachindex( connection_compare )
            test_connection = connection_compare[jj]
            test_set = union( connection_ii, test_connection )
            if length( test_set ) < length( connection_ii ) + length( test_connection )
                connection_ii = copy(test_set)
                push!( delete_list, jj )
                union_found = true
            end
        end
        deleteat!( connection_compare, delete_list )
        connections[ ind ] = connection_ii
        if !union_found
            ind += 1
            push!( result_connections, connection_ii )
            # connection_compare = deepcopy( connections[ind+1:end] )
            # deleteat!( connection_compare, delete_list+1 )
            if ind >= length( connections )
                break
            end
        end
    end

    lengths = length.( connections )
    lengths = sort( lengths, rev = true )
    println( prod( lengths[1:3]) )
end

# silver()



# function check_cycle( mapmat, start )
#     visited = similar( mapmat )
#     visited[ start ] = 1
#     while true
#         next .+= [ 0, 1 ]
#         if mapmat[ next ] == 1

#     end

# end

# function connect_all( dists_all, dists_inds )
#     N_dists = length( dists_all[1] )

#     D = vcat( dists_all... )
#     sorted_inds = sortperm(D)

#     circuit_starts = [ repeat( [ind], N_dists + 1 - ind ) for ind in 1:N_dists ]
#     circuit_starts = vcat( circuit_starts... )

#     dist_inds = vcat( dists_inds... )

#     print_inds = sorted_inds[ end-15:end ]
#     println( D[print_inds], "\n", circuit_starts[print_inds], "\n", dist_inds[print_inds] )

#     answer_inds = [0, 0]
#     mapmat = zeros( Int, N_dists+1, N_dists+1 )
#     start = [ circuit_starts[sorted_inds[1]], dist_inds[sorted_inds[1]] ]
#     connects = Matrix{Int}(undef, 2, 0 )
#     for ii in eachindex(D)
#         ind = sorted_inds[ii]
#         start = circuit_starts[ind]
#         eend =  dist_inds[ind]
#         connects = hcat( connects, [start; eend] )
#         if
#     end

#     return answer_inds
# end

# function gold()
#     path = "2025/day-08/test_input.txt"
#     rawdata = read_txt( path )
#     coords = parse_input( rawdata )

#     n_coords = size( coords, 1 )
#     dists_all = Vector{ Vector{Int} }( undef, n_coords )
#     dists_inds = Vector{ Vector{Int} }( undef, n_coords )
#     for (ii, point) in enumerate( eachrow(coords) )
#         points_temp = @view coords[ ii+1:end, : ]
#         dists_ii = [ sum( (point .- point_jj).^2 ) for point_jj in eachrow( points_temp ) ]
#         dists_all[ii] = dists_ii
#         dists_inds[ii] = collect( ii+1:size( coords, 1 ) )
#     end
#     deleteat!( dists_all, n_coords )
#     deleteat!( dists_inds, n_coords )

#     connect_all( dists_all, dists_inds )
# end

# gold()
