function read_txt(path)
    open(path, "r") do f
    rawdata = readlines(f)
    return rawdata
    end
end

function parse_input(rawdata)

    return box_coords
end


function silver()
    path = "2025/day-11/input.txt"
    rawdata = read_txt( path )
    _ = parse_input( rawdata )

end
