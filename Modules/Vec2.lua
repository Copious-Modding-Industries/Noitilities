--- Vec2 class, used for Arithmetic and manipulation of 2 dimensional vectors.
--- @class Vec2
--- @field Zero Vec2
--- @field One Vec2
--- @field UnitX Vec2
--- @field UnitY Vec2
--- @operator call: Vec2
--- @operator unm: Vec2
--- @operator add: Vec2
--- @operator sub: Vec2
--- @operator mul: Vec2
--- @operator div: Vec2
local Vec2 = {}

--- @return Vec2
function Vec2:New(x, y)
    x = x or 0
    y = y or 0
    local o = {
        x = x,
        y = y,
    }
    setmetatable(o, Vec2)
    o.__index = Vec2
    return o;
end

--- @return Vec2
function Vec2:NewFromRad(rad)
    return Vec2:New(math.cos(rad), math.sin(rad))
end

--- @return Vec2
function Vec2:NewFromDeg(deg)
    return Vec2:NewFromRad(math.rad(deg))
end

--- @return Vec2
function Vec2.Add(v1, v2)
    if type(v1) == "number" then
        v1 = {x = v1, y = v1}
    end
    if type(v2) == "number" then
        v2 = {x = v2, y = v2}
    end
    return Vec2:New(v1.x + v2.x, v1.y + v2.y)
end

--- @return Vec2
function Vec2.Sub(v1, v2)
    if type(v1) == "number" then
        v1 = {x = v1, y = v1}
    end
    if type(v2) == "number" then
        v2 = {x = v2, y = v2}
    end
    return Vec2:New(v1.x - v2.x, v1.y - v2.y)
end

--- @return Vec2
function Vec2.Mul(v1, v2)
    if type(v1) == "number" then
        v1 = {x = v1, y = v1}
    end
    if type(v2) == "number" then
        v2 = {x = v2, y = v2}
    end
    return Vec2:New(v1.x*v2.x, v1.y*v2.y)
end

--- @return Vec2
function Vec2.Div(v1, v2)
    if type(v1) == "number" then
        v1 = {x = v1, y = v1}
    end
    if type(v2) == "number" then
        v2 = {x = v2, y = v2}
    end
    return Vec2:New(v1.x/v2.x, v1.y/v2.y)
end

--- @return number
function Vec2.DotProduct(a, b)
    local ax, ay = a.x-b.x, a.y-b.y
    local bx, by = b.x-a.x, b.y-a.y
    local dot = ax * bx + ay * by
    return dot
end

--- @return Vec2
function Vec2.Abs(v)
    return Vec2:New(math.abs(v.x), math.abs(v.y))
end

--- @return number
function Vec2.Magnitude(v)
    return math.sqrt(v.x^2 + v.y^2)
end

--- @return number
function Vec2.MagnitudeSquared(v)
    return v.x^2 + v.y^2
end

--- @return Vec2
function Vec2.Normalise(v)
    return v:Div(v:Magnitude())
end

--- @return boolean
function Vec2.__eq(a, b)
    if a.x ~= b.x or a.y ~= b.y then return false end
    return true
end

--- @return Vec2
function Vec2:__unm()
    self.x = -self.x
    self.y = -self.y
    return self
end

--- @return string
function Vec2:__tostring()
    return ("(%s, %s)"):format(tostring(self.x), tostring(self.y))
end

--- @return number, number
function Vec2.Unpack(v)
    return v.x, v.y
end

setmetatable(Vec2, {
    __index = function (_, k)
        if k == "Zero" then return Vec2:New(0, 0)
        elseif k == "One" then return Vec2:New(1, 1)
        elseif k == "UnitX" then return Vec2:New(1, 0)
        elseif k == "UnitY" then return Vec2:New(0, 1)
        end
    end,
    __call = function(_, x, y)
        return Vec2:New(x, y)
    end,
    __add = Vec2.Add,
    __sub = Vec2.Sub,
    __mul = Vec2.Mul,
    __div = Vec2.Div
})

return Vec2