function read_txt(path)
    open(path, "r") do f
    rawdata = read(f, String)
    return rawdata
    end
end

function parse_input(rawdata)
    ranges = []
    range_string = split( rawdata, "," )
    for range in range_string
        start, end_ = parse.( Int, split( range, "-" ) )
        range = start:end_
        push!( ranges, range )
    end

    return ranges
end


function check_id_range( range )
    invalid_ids = Vector{Int}()
    range_start = range.start
    range_end = range.stop

    number = range_start
    for number in range
        digits_array = digits( number ) |> reverse
        digits_half_ind = Int( length( digits_array ) / 2 )
        second_half = digits_array[ digits_half_ind+1:end ]
        if second_half[1] == "0"
            continue
        else
            test_number = vcat( second_half, second_half ) |> join
            test_number = parse( Int, test_number )
            if test_number in range && !( test_number in invalid_ids )
                push!( invalid_ids, test_number )
            end
        end
    end

    return sum( invalid_ids )
end


function task1()
    path = "2025/day-02/input.txt"
    rawdata = read_txt(path)
    ranges = parse_input(rawdata)

    count = 0
    for range in ranges
        range1, range2 = range.start, range.stop
        r1len = ndigits( range1 )
        r2len = ndigits( range2 )

        if mod( r1len, 2 ) != 0
            range1 = Int( ceil( range1, digits = -r1len ) )
        end
        if range1 > range2
            continue
        end

        if mod( r2len, 2 ) != 0
            range2 = Int( floor( range2, digits = -r2len+1 ) ) - 1
        end
        if range2 < range1
            continue
        end

        range = range1:range2
        count_ii = check_id_range( range )
        count += count_ii
    end

    println( "Count: ", count )
end

task1()


function check_id_patterns( range )
    invalid_ids = Vector{Int}()

    for number in range
        digits_array = digits( number ) |> reverse
        array_len = length( digits_array )
        arr_half_len = round( Int, array_len / 2 )
        for ii in 1:arr_half_len
            if mod( array_len, ii ) != 0
                continue
            else
                reps = Int( array_len / ii )
                pattern = digits_array[1:ii] |> join
                test_number = repeat( pattern, reps )
                test_number = parse( Int, test_number )
                if test_number in range && !( test_number in invalid_ids )
                    push!( invalid_ids, test_number )
                end
            end
        end
    end
    return sum( invalid_ids )
end


function task2()
    path = "2025/day-02/input.txt"
    rawdata = read_txt(path)
    ranges = parse_input(rawdata)

    count = 0
    for range in ranges
        range1, range2 = range.start, range.stop

        range = range1:range2
        count_ii = check_id_patterns( range )
        count += count_ii
    end

    println( "Count: ", count )
end

task2()
