function read_txt(path)
    open(path, "r") do f
    rawdata = readlines(f)
    return rawdata
    end
end

function parse_input(rawdata)
    rows = length( rawdata )
    cols = length( rawdata[1] )
    machine = Matrix{Any}( undef, rows, cols )
    for ii in 1:rows
        row = rawdata[ii]
        row= split( row, "" )
        machine[ ii, : ] = row
    end

    return machine
end


function silver()
    path = "2025/day-07/input.txt"
    rawdata = read_txt( path )
    machine = parse_input( rawdata )

    splits = 0
    rows, cols = size( machine )
    start_ind = findfirst( machine[1, :] .!= "." )
    beam_inds = [ start_ind ]

    # Check whether a splitter is found at a line. If found, save splitter's and new beams' indices
    for ii in 2:rows
        row = machine[ ii, : ]
        split_beams = []
        added_inds = []
        for (jj, beam_ind) in enumerate( beam_inds )
            if row[ beam_ind ] == "^"
                append!( added_inds, [beam_ind-1, beam_ind+1] )
                append!( split_beams, jj )
                splits += 1
            end
        end

        # No more beams at splitter column; check only combined (unique) beams
        deleteat!( beam_inds, split_beams )
        append!( beam_inds, added_inds )
        unique!( beam_inds )
    end

    println( splits )
end

# silver()



function gold()
    path = "2025/day-07/input.txt"
    rawdata = read_txt( path )
    machine = parse_input( rawdata )

    timelines = 1
    rows, cols = size( machine )
    start_ind = findfirst( machine[1, :] .!= "." )
    beam_dict = Dict{Int, Int}( start_ind => 1 )

    # Track amount of beams at each relevant column in the dict. Each beam adds additional
    # new timeline at a splitter
    for ii in 2:rows
        row = machine[ ii, : ]
        split_beams = Int[]
        added_inds = zeros( Int, cols )
        for (beam_ind, beam_num) in beam_dict
            if row[ beam_ind ] == "^"
                added_inds[ [beam_ind-1, beam_ind+1] ] .+= beam_num
                append!( split_beams, beam_ind )
                timelines += beam_num
            end
        end

        # Beam splir --> no more beams at that column index
        for beam in split_beams
            delete!( beam_dict, beam )
        end

        # Update beam column dictionary
        for ii in eachindex( added_inds )
            key = ii
            val = added_inds[ii]
            if haskey( beam_dict, key )
                beam_dict[ key ] += val
            elseif val != 0
                beam_dict[ key ] = val
            end
        end
    end


    println( timelines )
end

gold()
