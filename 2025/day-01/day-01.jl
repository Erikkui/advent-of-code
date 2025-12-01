
function read_txt(path)
    open(path, "r") do f
    rawdata = readlines(f)
    return rawdata
    end
end

function parse_input(rawdata)
    directions = []
    steps = []
    for line in rawdata
        dir = line[1]
        step = parse( Int, line[2:end] )
        step = dir == 'R' ? step : -step
        push!(directions, dir)
        push!(steps, step)
    end

    return directions, steps
end

function task1()
    rawdata = read_txt()
    directions, steps = parse_input(rawdata)

    position = 50
    password = 0
    directions, steps = parse_input(rawdata)

    for step in steps
        steps_remaining = rem( step, 100 )
        full_rotations = step - steps_remaining

        position = position + steps_remaining
        if position >= 100
            position = position - 100
        elseif position < 0
            position = position + 100
        end
        # println(step,  "   ", position)

        if position == 0
            password += 1
        end
    end

    println(password)
    return password
end

# task1()

function task2()
    path = "2025/day-01/input.txt"
    rawdata = read_txt(path)
    directions, steps = parse_input(rawdata)

    position = 50
    password = 0
    directions, steps = parse_input(rawdata)

    for step in steps
        steps_remaining = rem( step, 100 )
        full_rotations = Int( abs( step - steps_remaining ) / 100 )
        password = password + full_rotations
        if position == 0    # When starting at 0, full rotations already counted
            position = position + steps_remaining
            if position < 0
                position = position + 100
            end
        else
            position = position + steps_remaining
            if position == 0
                password += 1
            elseif position >= 100
                position = position - 100
                password += 1
            elseif position < 0
                position = position + 100
                password += 1
            end
        end
    end
    return password
end

task2()
