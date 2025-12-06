function read_txt(path)
    open(path, "r") do f
    rawdata = readlines(f)
    return rawdata
    end
end

function parse_input(rawdata)
    nrows = length( rawdata )
    ncols = length( rawdata[1] )
    operations = zeros( ncols )

    datamat = []
    for ii in 1:nrows
        row = split( rawdata[ii], " " )
        row = row[ row .!= ""  ]
        n_operations = length( row )
        if ii == 1
            datamat = Matrix{Any}(undef, 0, n_operations )
        end
        datamat = vcat( datamat, reshape( row, 1, n_operations ) )
    end

    numbers = parse.( Int, datamat[ 1:end-1, : ] )
    operations = datamat[ end, : ]

    return numbers, operations
end


function silver()
    path = "2025/day-06/input.txt"
    rawdata = read_txt( path )

    numbers, operations = parse_input( rawdata )
    _, n_tasks = size( numbers )

    checksum = 0
    for ii = 1:n_tasks
        operation = operations[ii]
        operands = numbers[ :, ii ]
        if operation == "+"
            checksum += sum( operands )
        elseif operation == "*"
            checksum += prod( operands )
        end
    end

    println( checksum )
end

silver()


function transform_numbers( operands )
    n_numbers = size( operands, 2 )
    numbers = []
    for ii in 1:n_numbers
        col = operands[ :, ii ]
        number = col[ col .!= " " ] |> join
        number = parse( Int, number )
        append!( numbers, number )
    end
    return numbers
end

function parse_input_gold( rawdata )
    nrows = length( rawdata )

    datamat = []
    for ii in 1:nrows
        row = split( rawdata[ii], "" )
        rowlen = length( row )
        if ii == 1
            datamat = Matrix{Any}(undef, 0, rowlen )
        end
        datamat = vcat( datamat, reshape( row, 1, rowlen ) )
    end

    numbers = datamat[ 1:end-1, : ]
    operations = datamat[ end, : ]
    operations = operations[ operations .!= " "]

    rowlen = size( numbers, 2 )
    operands = Vector{ Vector{Int} }( undef, 0 )
    prev_empty_ind = 0
    mat_ii = []
    for ii in 1:rowlen
        col = numbers[ :, ii ]
        if all( col .== " " )
            mat_ii = numbers[ :, prev_empty_ind+1:ii-1 ]
            mat_ii = transform_numbers( mat_ii )
            push!( operands, mat_ii )
            prev_empty_ind = ii
        end
        if ii == rowlen
            mat_ii = numbers[ :, prev_empty_ind+1:end ]
            mat_ii = transform_numbers( mat_ii )
            push!( operands, mat_ii )
        end
    end

    return operands, operations
end


function gold()
    path = "2025/day-06/input.txt"
    rawdata = read_txt( path )

    operands, operations = parse_input_gold( rawdata )
    n_tasks = length( operands )
    checksum = 0
    for ii = 1:n_tasks
        operation = operations[ii]
        numbers = operands[ii]
        if operation == "+"
            checksum += sum( numbers )
        elseif operation == "*"
            checksum += prod( numbers )
        end
    end

    println( checksum )
end

gold()
