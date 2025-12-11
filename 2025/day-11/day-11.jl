function read_txt(path)
    open(path, "r") do f
    rawdata = readlines(f)
    return rawdata
    end
end

function parse_input(rawdata)
    nodes_temp = []
    edges_temp = Vector{ Vector{Any} }( undef, 0 )
    for ii in axes( rawdata, 1 )
        row = rawdata[ii]
        row = split( row, " " )
        node = row[1]
        node = replace( node, ":"=> "" )
        push!( nodes_temp, node )
        push!( edges_temp, row[2:end] )
    end

    edges = Dict{Int, Any}()
    nodes = collect( 1:length(nodes_temp) )
    you = nothing
    for (ii, node) in zip( nodes, nodes_temp )
        if node == "you"
            you = ii
        end
        for edge_ii in edges_temp
            replace!( edge_ii, node => ii )
            if "out" in edge_ii
                replace!( edge_ii, "out" => nodes[end]+1 )
            end
        end
        edges[ii] = edges_temp[ii]
    end

    return nodes, edges, you
end


function silver()
    path = "2025/day-11/input.txt"
    rawdata = read_txt( path )
    nodes, edges, you = parse_input( rawdata )

    out_paths = 0
    out = nodes[end] + 1
    to_visit = edges[ you ]
    # visited = Int[ you ]
    while !( isempty( to_visit ) )
        next = to_visit[1]
        deleteat!( to_visit, 1 )
        if next == out
            out_paths += 1
        else
            connections = edges[ next ]
            to_visit = vcat( connections, to_visit )
        end
    end
    println( out_paths )
end

# silver()


function parse_input_gold(rawdata)
    nodes_temp = []
    edges_temp = Vector{ Vector{Any} }( undef, 0 )
    for ii in axes( rawdata, 1 )
        row = rawdata[ii]
        row = split( row, " " )
        node = row[1]
        node = replace( node, ":"=> "" )
        push!( nodes_temp, node )
        push!( edges_temp, row[2:end] )
    end

    edges = Dict{Int, Any}()
    nodes = collect( 1:length(nodes_temp) )
    svr, fft, dac = nothing, nothing, nothing
    for (ii, node) in zip( nodes, nodes_temp )
        if node == "svr"
            svr = ii
        end
        if node == "fft"
            fft = ii
        end
        if node == "dac"
            dac = ii
        end
        for edge_ii in edges_temp
            replace!( edge_ii, node => ii )
            if "out" in edge_ii
                replace!( edge_ii, "out" => nodes[end]+1 )
            end
        end
        edges[ii] = edges_temp[ii]
    end

    return nodes, edges, svr, fft, dac
end


function gold()
    txt_path = "2025/day-11/input.txt"
    rawdata = read_txt( txt_path )
    nodes, edges, svr, fft, dac = parse_input_gold( rawdata )

    out_paths = 0
    out = nodes[end] + 1
    to_visit = edges[ svr ]
    crossroads = Int[]
    n_crossroads = Int[]
    crossroads_counters = []
    path = Int[ svr ]
    push!( crossroads, length( path ) )
    push!( n_crossroads, length( edges[ 1 ] ) )
    push!( crossroads_counters, 1 )
    while !( isempty( to_visit ) )
        next = to_visit[1]
        println( path )
        sleep(0.2)
        if next in path
            continue
        else
            push!( path, next )
            if next == out
                if fft in path && dac in path
                    out_paths += 1
                end
                if crossroads_counters[end] < n_crossroads[end]
                    crossroads_counters[end] += 1
                else
                    for ii in length(crossroads):-1:1
                        if crossroads_counters[ii] == n_crossroads[ii]
                            crossroads = crossroads[1:ii-1]
                            n_crossroads = n_crossroads[1:ii-1]
                            crossroads_counters = crossroads_counters[1:ii-1]
                        else
                            break
                        end
                    end
                    if !(isempty(crossroads_counters))
                        crossroads_counters[end] += 1
                    end
                end
                if !(isempty(crossroads))
                    path = path[ 1:crossroads[end] ]
                end

                deleteat!( to_visit, 1 )
            else
                connections = edges[ next ]
                if length( connections ) > 1
                    push!( crossroads, length( path ) )
                    push!( n_crossroads, length( connections ) )
                    push!( crossroads_counters, 1 )
                end
                deleteat!( to_visit, 1 )
                to_visit = vcat( connections, to_visit )
                to_visit = setdiff( to_visit, path )
            end
        end
    end

    println( out_paths )
end

@views gold()
