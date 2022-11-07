--- Vec2 class, used for Arithmetic and manipulation of 2 dimensional vectors.
--- @class Vec2
--- @field Zero Vector2Instance
--- @field One Vector2Instance
--- @field UnitX Vector2Instance
--- @field UnitY Vector2Instance
local Vector2 = {}

--- @class Vector2Instance: Vec2
--- @field x number
--- @field y number
local Vector2Instance = {}
function Vector2:New(x, y)
    x = x or 0
    y = y or 0
    local o = {
        x = x,
        y = y,
    }
    o.__index = Vector2Instance
    return o;
end

function Vector2.Add(v1, v2)
    if type(v1) == "number" then
        v1 = {x = v1, y = v1}
    end
    if type(v2) == "number" then
        v2 = {x = v2, y = v2}
    end
    return Vector2:New(v1.x + v2.x, v1.y + v2.y)
end

function Vector2.Sub(v1, v2)
    if type(v1) == "number" then
        v1 = {x = v1, y = v1}
    end
    if type(v2) == "number" then
        v2 = {x = v2, y = v2}
    end
    return Vector2:New(v1.x - v2.x, v1.y - v2.y)
end

function Vector2.Mul(v1, v2)
    if type(v1) == "number" then
        v1 = {x = v1, y = v1}
    end
    if type(v2) == "number" then
        v2 = {x = v2, y = v2}
    end
    return Vector2:New(v1.x*v2.x, v1.y*v2.y)
end

function Vector2.Div(v1, v2)
    if type(v1) == "number" then
        v1 = {x = v1, y = v1}
    end
    if type(v2) == "number" then
        v2 = {x = v2, y = v2}
    end
    return Vector2:New(v1.x/v2.x, v1.y/v2.y)
end

function Vector2.DotProduct(a, b)
    local ax, ay = a.x-b.x, a.y-b.y
    local bx, by = b.x-a.x, b.y-a.y
    local dot = ax * bx + ay * by
    return dot
end

--- Methods only applicable to vector instances
function Vector2Instance:Abs()
    self.x = math.abs(self.x)
    self.y = math.abs(self.y)
    return self
end

function Vector2Instance:Magnitude()
    return math.sqrt(self.x^2 + self.y^2)
end

function Vector2Instance:MagnitudeSquared()
    return self.x^2 + self.y^2
end

function Vector2Instance:Normalise()
    return self:Div(self:Magnitude())
end

setmetatable(Vector2Instance, Vector2)
setmetatable(Vector2, {
    __index = function (_, k)
        if k == "Zero" then return Vector2:New(0, 0)
        elseif k == "One" then return Vector2:New(1, 1)
        elseif k == "UnitX" then return Vector2:New(1, 0)
        elseif k == "UnitY" then return Vector2:New(0, 1)
        end
    end,
    __call = function(x, y)
        return Vector2:New(x, y)
    end,
    __tostring = function(t)
        return "("..t.x..", "..t.y..")"
    end,
    __unm = function (t)
        t.x = -t.x
        t.y = -t.y
        return t
    end,
    __eq = function (a, b)
        if a.x ~= b.x or a.y ~= b.y then return false end
        return true
    end,
    __add = Vector2.Add,
    __sub = Vector2.Sub,
    __mul = Vector2.Mul,
    __div = Vector2.Div
})


local vec1 = Vector2:New({5,2})
local vec2 = Vector2:New({1,2})
local vec3 = vec1 + vec2
print(vec3.x, vec3.y)