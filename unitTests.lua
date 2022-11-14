luaunit = require('luaunit')
require("env")
local Vec2 = require("Modules.Vec2")
TestVec2 = {}
function TestVec2:TestStaticMembers()
    local zero = Vec2.Zero
    local one = Vec2.One
    local ux = Vec2.UnitX
    local uy = Vec2.UnitY
    luaunit.assertEquals(zero.x, 0)
    luaunit.assertEquals(zero.y, 0)
    luaunit.assertEquals(one.x, 1)
    luaunit.assertEquals(one.y, 1)
    luaunit.assertEquals(ux.x, 1)
    luaunit.assertEquals(ux.y, 0)
    luaunit.assertEquals(uy.x, 0)
    luaunit.assertEquals(uy.y, 1)
end

function TestVec2:TestNew()
    local v1 = Vec2(10, -40)
    luaunit.assertEquals(v1.x, 10)
    luaunit.assertEquals(v1.y, -40)
    local v2 = Vec2()
    luaunit.assertEquals(v2.x, 0)
    luaunit.assertEquals(v2.y, 0)
end

function TestVec2:TestNewFromRad()
    local vec = Vec2:NewFromRad(50, 2)
    luaunit.assertAlmostEquals(vec.x, 1.9299320569842, 0.01)
    luaunit.assertAlmostEquals(vec.y, -0.52474970740786, 0.01)
end

function TestVec2:TestNewFromDeg()
    local vec = Vec2:NewFromDeg(50, 2)
    luaunit.assertAlmostEquals(vec.x, 1.2855752193731, 0.01)
    luaunit.assertAlmostEquals(vec.y, 1.532088886238, 0.01)
end

function TestVec2:TestAdd()
    local vec1 = Vec2(145, 394)
    local vec2 = Vec2(244, 330)
    local vec3 = vec1 + vec2
    luaunit.assertEquals(vec3.x, 389)
    luaunit.assertEquals(vec3.y, 724)
    local vec5 = Vec2(-292, -3049)
    local vec6 = Vec2(34, -292)
    local vec7 = vec5 + vec6
    luaunit.assertEquals(vec7.x, -258)
    luaunit.assertEquals(vec7.y, -3341)
end
os.exit( luaunit.LuaUnit.run() )