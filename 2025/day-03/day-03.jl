function read_txt(path)
    open(path, "r") do f
    rawdata = readlines(f)
    return rawdata
    end
end

function parse_input(rawdata)
    banks = []
    for line in rawdata
        bank = split( line, "" )
        bank = [ parse( Int, ii ) for ii in bank ]
        push!( banks, bank )
    end

    return banks
end

function find_max_joltage( bank )
    bank_joltage = nothing

    first_max_ind = argmax( bank[1:end-1] )
    bank_joltage_1 = bank[ first_max_ind ]

    bank = @view bank[ first_max_ind+1:end ]
    second_max_ind = argmax( bank )
    bank_joltage_2 = bank[ second_max_ind ]

    bank_joltage = bank_joltage_1*10 + bank_joltage_2
    return bank_joltage
end

function silver()
    path = "2025/day-03/input.txt"
    rawdata = read_txt( path )
    banks = parse_input( rawdata )

    total_joltage = 0
    for bank in banks
        bank_joltage = find_max_joltage( bank )
        total_joltage += bank_joltage
    end

    println( total_joltage )
end
silver()


function find_max_joltage_gold(bank)
    bank_joltage = []
    numbers_list = collect( 9:-1:1 )
    batteries_remaining = 12
    while batteries_remaining > 0
        bank_length = length( bank )
        for ii = numbers_list
            ind = findfirst( isequal(ii), bank )
            if isnothing( ind )
                numbers_list = numbers_list[ numbers_list .!= ii ]
            else
                if bank_length - ind == batteries_remaining - 1
                    append!( bank_joltage, bank[ ind:end ] )
                    batteries_remaining = 0
                    break
                elseif bank_length - ind > batteries_remaining - 1
                    append!( bank_joltage, bank[ind] )
                    bank = bank[ ind+1:end ]
                    batteries_remaining -= 1
                    break
                end
            end
        end
    end

    bank_joltage = parse( Int, join( bank_joltage) )
    return bank_joltage
end

function gold()
    path = "2025/day-03/input.txt"
    rawdata = read_txt( path )
    banks = parse_input( rawdata )

    total_joltage = 0

    for bank in banks
        bank_joltage = find_max_joltage_gold( bank )
        total_joltage += bank_joltage
    end

    println( total_joltage )
end
gold()
