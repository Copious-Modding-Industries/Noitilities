luaunit = require('luaunit')
require("env/env")

---
--- VEC2 TESTS
---
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
    local vec8 = vec1 + 3
    luaunit.assertEquals(vec8.x, 148)
    luaunit.assertEquals(vec8.y, 397)
end

function TestVec2:TestSub()
    local vec1 = Vec2(145, 394)
    local vec2 = Vec2(244, 330)
    local vec3 = vec1 - vec2
    luaunit.assertEquals(vec3.x, -99)
    luaunit.assertEquals(vec3.y, 64)
    local vec5 = Vec2(-292, -3049)
    local vec6 = Vec2(34, -292)
    local vec7 = vec5 - vec6
    luaunit.assertEquals(vec7.x, -326)
    luaunit.assertEquals(vec7.y, -2757)
    local vec8 = vec1 - 3
    luaunit.assertEquals(vec8.x, 142)
    luaunit.assertEquals(vec8.y, 391)
end

function TestVec2:TestDotProduct()
    local x = Vec2(30, 55):DotProduct(Vec2(340, -1))
    luaunit.assertEquals(x, -99236)
    local y = Vec2(-393, -491):DotProduct(Vec2(20, 6))
    luaunit.assertEquals(y, -417578)
end

function TestVec2:TestAbs()
    local x = Vec2(34, 30):Abs()
    local y = Vec2(-53, -10):Abs()
    local z = Vec2(-30, 10):Abs()
    luaunit.assertEquals(x.x, 34)
    luaunit.assertEquals(x.y, 30)
    luaunit.assertEquals(y.x, 53)
    luaunit.assertEquals(y.y, 10)
    luaunit.assertEquals(z.x, 30)
    luaunit.assertEquals(z.y, 10)
end

function TestVec2:TestMagnitude()
    local x = Vec2(100, 911):Magnitude()
    luaunit.assertAlmostEquals(x, 916.4, 0.5)
    local y = Vec2(-230, -10):Magnitude()
    luaunit.assertAlmostEquals(y, 230.2, 0.5)
end

function TestVec2:TestMagnitudeSquared()
    local x = Vec2(100, 911):MagnitudeSquared()
    luaunit.assertEquals(x, 839921)
    local y = Vec2(-230, -10):MagnitudeSquared()
    luaunit.assertEquals(y, 53000)
end

function TestVec2:TestNormalise()
    local x = Vec2(200, 103):Normalise()
    luaunit.assertAlmostEquals(x.x, 0.88902938858572, 0.01)
    luaunit.assertAlmostEquals(x.y, 0.45785013512164, 0.01)
end

function TestVec2:TestEQ()
    luaunit.assertIsTrue(Vec2(10, 39) == Vec2(10, 39))
    luaunit.assertIsFalse(Vec2(100, 100) == Vec2.One)
    luaunit.assertIsTrue(Vec2(1, 1) == Vec2.One)
end

function TestVec2:TestUNM()
    local x = -Vec2(234, 100)
    luaunit.assertEquals(x.x, -234)
    luaunit.assertEquals(x.y, -100)
    local y = -Vec2(-234, -100)
    luaunit.assertEquals(y.x, 234)
    luaunit.assertEquals(y.y, 100)
end

function TestVec2:TestToString()
    local x = tostring(Vec2(10, 10))
    luaunit.assertEquals(x, "(10, 10)")
    local y = tostring(Vec2(-239, 29))
    luaunit.assertEquals(y, "(-239, 29)")
end

function TestVec2:TestUnpack()
    local x, y = Vec2(100, 49):Unpack()
    luaunit.assertEquals(x, 100)
    luaunit.assertEquals(y, 49)
end

---
--- ECS TESTS
---

os.exit(luaunit.LuaUnit.run())