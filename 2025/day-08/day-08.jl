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


function connect_all( dists_all, ind_starts, ind_ends )
    sorted_dist_inds = sortperm( dists_all )
    unique_boxes = unique( ind_starts )
    ii = 1
    connections = Matrix{Int}( undef, 2, 0 )
    wanted_pair = nothing
    shortest_loop = false
    all_visited = false
    asdfg = false
    stop_search = false
    while !(stop_search)
        min_ind = sorted_dist_inds[ii]
        start = ind_starts[ min_ind ]
        finish = ind_ends[ min_ind ]
        connections = hcat( connections, [ start; finish ] )
        unique_connected = unique( connections[:] )

        queue = Vector{Int}( undef, 0 )
        visited = similar( queue )
        append!( visited, start, finish )

        to_visit_1 = findall( isequal(start), connections[1, 1:end-1] )
        to_visit_1 = connections[ 2, to_visit_1 ]

        to_visit_2 = findall( isequal(start), connections[2, 1:end-1] )
        to_visit_2 = connections[ 1, to_visit_2 ]
        union!( queue, to_visit_1..., to_visit_2... )

        while !(isempty( queue ) )
            next = queue[1]
            deleteat!( queue, 1 )
            push!( visited, next )

            to_visit_1 = findall( isequal(next), connections[1, 1:end-1] )
            to_visit_2 = findall( isequal(next), connections[2, 1:end-1] )

            to_visit_1 = connections[ 2, to_visit_1 ]
            to_visit_2 = connections[ 1, to_visit_2 ]

            queue = union( to_visit_1, to_visit_2, queue )
            # println(queue)
            setdiff!( queue, visited )
            if finish in to_visit_1 || finish in to_visit_2
                shortest_loop = true
            end

            if issetequal( visited, unique_connected )
                all_visited = true
            end

            if issetequal( unique_connected, unique_boxes )
                asdfg = true
            end

            if shortest_loop && all_visited && asdfg
                stop_search = true
                wanted_pair = [start, finish]
                break
            else
                shortest_loop = false
                all_visited = false
                asdg = false
            end
        end
        ii += 1
    end
    println(ii)
    return wanted_pair
end

function gold()
    path = "2025/day-08/input.txt"
    rawdata = read_txt( path )
    coords = parse_input( rawdata )

    n_coords = size( coords, 1 )
    dists_all = Vector{ Vector{Int} }( undef, n_coords )
    ind_ends = Vector{ Vector{Int} }( undef, n_coords )
    for (ii, point) in enumerate( eachrow(coords) )
        points_temp = @view coords[ ii+1:end, : ]
        dists_ii = [ sum( (point .- point_jj).^2 ) for point_jj in eachrow( points_temp ) ]
        dists_all[ii] = dists_ii
        ind_ends[ii] = collect( ii+1:size( coords, 1 ) )
    end
    deleteat!( dists_all, n_coords )
    deleteat!( ind_ends, n_coords )
    ind_starts = [ repeat( [ind], n_coords + 1 - ind ) for ind in 1:n_coords ]

    dists_all = vcat( dists_all... )
    ind_ends = vcat( ind_ends... )
    ind_starts = vcat( ind_starts... )

    wanted_pair_inds = connect_all( dists_all, ind_starts, ind_ends )
    pair = coords[ wanted_pair_inds, : ]
    answer = prod( pair[:, 1] )

    check = findfirst( isequal( sum( (coords[11, :] .- coords[13, :]).^2 )), dists_all )

    println( check )

    println( wanted_pair_inds )
    println( pair )
    println( answer )
end

gold()
