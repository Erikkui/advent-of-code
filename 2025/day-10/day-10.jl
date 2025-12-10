function read_txt(path)
    open(path, "r") do f
    rawdata = readlines(f)
    return rawdata
    end
end

function parse_input(rawdata)
    chars = [ '[', ']', '(', ')', '{', '}' ]
    lights = Vector{ BitVector }( undef, 0 )
    buttons = Vector{ Vector{ BitVector } }( undef, 0 )
    joltages = Vector{ Vector{Int} }( undef, 0 )
    for line in rawdata
        line = string.( split( line, " " ) )

        lights_ii = strip( line[1], chars )
        lights_ii = split( lights_ii, "" )
        lights_ii = replace( lights_ii, "." => "0", "#" => "1" )
        lights_ii = parse.( Int, lights_ii )
        push!( lights, BitVector(lights_ii) )

        buttonvec_temp = Vector{ Vector{Int} }( undef, 0 )
        for button_ii in line[2:end-1]
            button_temp = BitVector( zeros( length(lights_ii) ) )
            button_ii = strip( button_ii, chars )
            if length( button_ii ) > 1
                button_ii = split( button_ii, "," )
                button_ii = parse.( Int, button_ii ) .+ 1
            else
                button_ii = Int[ parse( Int, button_ii ) ] .+ 1
            end
            button_temp[ button_ii ] .= true
            push!( buttonvec_temp, button_temp )
        end
        push!( buttons, buttonvec_temp)

        joltages_ii = strip( line[3], chars )
        joltages_ii = split( joltages_ii, "," )
        joltages_ii = parse.( Int, joltages_ii )
        push!( joltages, joltages_ii )
    end
    return lights, buttons, joltages
end


function silver()
    path = "2025/day-10/test_input.txt"
    rawdata = read_txt( path )
    lights, buttons, _ = parse_input( rawdata )


end

silver()
