using ProgressBars

function read_txt(path)
    open(path, "r") do f
    rawdata = readlines(f)
    return rawdata
    end
end

function parse_input(rawdata)
    ranges = []
    ids = []
    for (ii, line) in enumerate( rawdata )
        if contains( line, "-")
            line = split( line, "-" )
            line = parse.( Int, line )
            push!( ranges, line )
        elseif isempty( line )
            continue
        else
            id = line = parse( Int, line )
            append!( ids, id )
        end
    end

    return ranges, ids
end


function silver()
    path = "2025/day-05/input.txt"
    rawdata = read_txt( path )
    ranges, ids = parse_input( rawdata )

    N_fresh = 0
    for (ii, id) in enumerate( ids )
        for (jj, range) in enumerate( ranges )
            if id >= range[1] && id <= range[2]
                N_fresh += 1
                break
            end
        end
    end

    println( N_fresh )
end

# silver()


function gold()
    path = "2025/day-05/input.txt"
    rawdata = read_txt( path )
    ranges, _ = parse_input( rawdata )

    ranges_aux = deepcopy( ranges )
    N_fresh = 0
    flag = false
    while flag == false
        flag = true
        for (ii, range) in ProgressBar( enumerate( ranges ) )
            for (jj, rangeesus) in enumerate( ranges_aux[ ii+1:end ] )
                if range[2] < rangeesus[1] || range[1] > rangeesus[2] # Range is outside comparison range
                    continue
                elseif range[1] <= rangeesus[1] && range[2] >= rangeesus[2]  # Comparison range is completely inside range
                    flag = false
                    continue
                elseif range[1] >= rangeesus[1] && range[2] <= rangeesus[2] # Range is completely inside comaprison range
                    ranges[ii] = rangeesus
                    flag = false
                else    # Ranges partially overlap
                    if range[2] >= rangeesus[1] && range[1] < rangeesus[1]
                        range[2] = rangeesus[1] - 1
                        ranges[ii] = range
                    elseif range[1] >= rangeesus[1] && range[1] < rangeesus[2] && range[2] > rangeesus[2]
                        range[1] = rangeesus[2] + 1
                    end
                end
            end
        end
        unique!( ranges )
        ranges = reverse( ranges )
        ranges_aux = deepcopy( ranges )
    end

    for range in ranges
        range_length = range[2] - range[1] + 1
        N_fresh += range_length
    end

    println( N_fresh )
end

gold()
