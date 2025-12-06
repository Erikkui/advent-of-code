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
    path = "2025/day-06/input.txt"
    rawdata = read_txt( path )

end
