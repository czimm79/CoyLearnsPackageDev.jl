my_f(x, y) = 2x+3y

"""
    add_three(x)

Compute `x + 3`.
"""
function add_three(x)
    x + 3
end

"""
    super_function(x, y)

Compute `2x + 3y + 3`.

# Example
```jldoctest
julia> super_function(3,2)
15
```
"""
function super_function(x, y)
    p1 = my_f(x, y)

    add_three(p1)
end
