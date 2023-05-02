using XML

function parse_constraint(constraint::Node, variables::Dict{String, Any}, model::SeaPearl.CPModel, trailer::SeaPearl.Trailer)
    tag = constraint.tag

    if tag == "allDifferent"
        str_constraint_variables = children(constraint)[1].value
        allDiff_vars = get_all_variables(str_constraint_variables, variables)
    end
end

function get_all_variables(str_constraint_variables, variables)
    constraint_variables = split(str_constraint_variables, " ")
    all_variables = Dict()
    for v in constraint_variables

        rfind(v, "[")
        id, idx = split(v, "[")
        idx = split(idx, "]")[1]

        #all elements from the array are included
        if idx == ""
            var = variables[name]
            for i in 1:length(var)
                push!(all_variables, name * "[" * string(i) * "]")
            end

        #only a subset form the array from index l to index u are included
        else
            bounds = split(idx, "..")
            if length(bounds) == 1
                push!(all_variables, name * "[" * bounds[1] * "]")
            else
                for i in parse(Int, bounds[1]):parse(Int, bounds[2])+1
                    push!(all_variables, name * "[" * string(i) * "]")
                end
            end
        end
    end
    return all_variables
end


