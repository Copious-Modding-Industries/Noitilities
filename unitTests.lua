luaunit = require('luaunit')

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
--- TRANSLATION TESTS
---
local commonCSVBase = [[
    mat_meat_warm,Lightly-cooked meat,Слегка поджаренное мясо,Carne mal passada,Carne poco hecha,Leicht gekochtes Fleisch,Viande bleue,Carne al sangue,Lekko ugotowane mięso,微熟的肉,少し調理された肉,설익힌 고기,,,
    mat_meat_hot,Cooked meat,Поджаренное мясо,Carne ao ponto,Carne al punto,Gekochtes Fleisch,Viande saignante,Carne cotta,Ugotowane mięso,熟肉,調理された肉,익힌 고기,,,
    mat_meat_done,Fully-cooked meat,Полностью прожаренное мясо,Carne bem passada,Carne muy hecha,Vollständig gekochtes Fleisch,Viande à point,Carne ben cotta,W pełni ugotowane mięso,全熟的肉,完全に調理された肉,완전히 익힌 고기,,,
    mat_meat_burned,Burned meat,Сгоревшее мясо,Carne queimada,Carne quemada,Verbranntes Fleisch,Viande brûlée,Carne bruciata,Przypalone mięso,烧焦的肉,焦げた肉,탄 고기,,,
    perkdesc_lower_spread,"Your spells have lower spread and extra damage, but have increased cast delay.","Заклинания наносят больше урона, разброс уменьшается, но задержка увеличивается.","Seus feitiços têm menor dispersão e causam mais dano, mas o tempo de conjuração é maior.","Tus hechizos tienen menor dispersión y daño adicional, pero tienen mayor demora de lanzamiento.","Deine Zauber haben eine geringere Streuung und erhöhten Schaden, aber eine erhöhte Zauberverzögerung.","Vos sorts ont une dispersion plus faible et infligent plus de dégâts, mais aussi un délai de lancement accru.","I tuoi incantesimi hanno una diffusione minore e infliggono danni extra, ma il ritardo di lancio è aumentato.","Twoje zaklęcia mają mniejszy rozrzut i większe obrażenia, ale i większe opóźnienie rzucania.",你的法术散射更小，伤害更高，但施放延迟增加。,自分の呪文範囲が狭まって追加ダメージを与えるが、呪文の詠唱遅延が増加する。,주문의 확산이 감소하고 추가 대미지를 가하며 시전 지연 시간은 증가합니다.,,,
    mat_peasoup_concentrate,Pea soup concentrate,Концентрированный гороховый суп,Sopa de ervilha concentrada,Concentrado de sopa de guisantes,Erbsensuppenkonzentrat,Concentré de soupe de pois,Zuppa di piselli concentrata,Koncentrat zupy grochowej,豌豆汤萃取物,マメのスープの濃縮物,농축 콩죽,,,
    mat_mammi,Mämmi,Мамми,Mämmi,Mämmi,Mämmi,Mämmi,Mämmi,Mämmi,莫米,マンミ,매미,,transliterate,
    mat_juhannussima,Juhannussima,Юханнуссима,Juhannussima,Juhannussima,Juhannussima,Juhannussima,Juhannussima,Juhannussima,尤汉努西玛,ユハンヌッシマ,유하누시마,,transliterate,
    item_hernekeittopurkki,Hernekeittopurkki,Гернекейттопуркки,Hernekeittopurkki,Hernekeittopurkki,Hernekeittopurkki,Hernekeittopurkki,Hernekeittopurkki,Hernekeittopurkki,赫鲁内盖托普尔奇,ヘルネッケイットッポルキ,헤르네케이토푸르키,,transliterate,
    item_kaljapullo,Kaljapullo,Кальяпулло,Kaljapullo,Kaljapullo,Kaljapullo,Kaljapullo,Kaljapullo,Kaljapullo,卡利亚普罗,カリヤプーロ,칼야풀로,,transliterate,
    perk_iron_stomach,Iron Stomach,Стальной желудок,Estômago de ferro,Estómago de hierro,Eisenbauch,Estomac en béton,Stomaco di ferro,Żelazny żołądek,铁胃,丈夫な胃,강철 위장,,,
    perkdesc_iron_stomach,You no longer suffer from negative effects of eating.,Вы больше не страдаете от негативных эффектов после еды.,Você não sofre mais os efeitos negativos ao comer.,Ya no sufrirás efectos negativos derivados de la comida.,Du leidest nicht mehr unter negativen Auswirkungen des Essens.,Vous ne souffrez plus d'effets négatifs en mangeant.,Non soffri più effetti negativi dopo aver mangiato.,Nie otrzymujesz już negatywnych efektów jedzenia.,你不再因食用物品而受到负面效果。,食事によるマイナス効果を受けなくなる。,이제 식사 시 부정적인 효과를 겪지 않습니다.,,,
]]
local Translations = require("Modules.Translations")
local files = {}
files["data/translations/common.csv"] = commonCSVBase
function ModTextFileSetContent(k, v)
    files[k] = v
end
function ModTextFileGetContent(k)
    return files[k]
end
TestTranslations = {}
function TestTranslations:TestRemoveKey()
    files["data/translations/common.csv"] = commonCSVBase
    Translations.RemoveKey("perkdesc_iron_stomach")
    luaunit.assertEquals(ModTextFileGetContent("data/translations/common.csv"):gsub(" ", ""),
([[
mat_meat_warm,Lightly-cooked meat,Слегка поджаренное мясо,Carne mal passada,Carne poco hecha,Leicht gekochtes Fleisch,Viande bleue,Carne al sangue,Lekko ugotowane mięso,微熟的肉,少し調理された肉,설익힌 고기,,,
mat_meat_hot,Cooked meat,Поджаренное мясо,Carne ao ponto,Carne al punto,Gekochtes Fleisch,Viande saignante,Carne cotta,Ugotowane mięso,熟肉,調理された肉,익힌 고기,,,
mat_meat_done,Fully-cooked meat,Полностью прожаренное мясо,Carne bem passada,Carne muy hecha,Vollständig gekochtes Fleisch,Viande à point,Carne ben cotta,W pełni ugotowane mięso,全熟的肉,完全に調理された肉,완전히 익힌 고기,,,
mat_meat_burned,Burned meat,Сгоревшее мясо,Carne queimada,Carne quemada,Verbranntes Fleisch,Viande brûlée,Carne bruciata,Przypalone mięso,烧焦的肉,焦げた肉,탄 고기,,,
perkdesc_lower_spread,"Your spells have lower spread and extra damage, but have increased cast delay.","Заклинания наносят больше урона, разброс уменьшается, но задержка увеличивается.","Seus feitiços têm menor dispersão e causam mais dano, mas o tempo de conjuração é maior.","Tus hechizos tienen menor dispersión y daño adicional, pero tienen mayor demora de lanzamiento.","Deine Zauber haben eine geringere Streuung und erhöhten Schaden, aber eine erhöhte Zauberverzögerung.","Vos sorts ont une dispersion plus faible et infligent plus de dégâts, mais aussi un délai de lancement accru.","I tuoi incantesimi hanno una diffusione minore e infliggono danni extra, ma il ritardo di lancio è aumentato.","Twoje zaklęcia mają mniejszy rozrzut i większe obrażenia, ale i większe opóźnienie rzucania.",你的法术散射更小，伤害更高，但施放延迟增加。,自分の呪文範囲が狭まって追加ダメージを与えるが、呪文の詠唱遅延が増加する。,주문의 확산이 감소하고 추가 대미지를 가하며 시전 지연 시간은 증가합니다.,,,
mat_peasoup_concentrate,Pea soup concentrate,Концентрированный гороховый суп,Sopa de ervilha concentrada,Concentrado de sopa de guisantes,Erbsensuppenkonzentrat,Concentré de soupe de pois,Zuppa di piselli concentrata,Koncentrat zupy grochowej,豌豆汤萃取物,マメのスープの濃縮物,농축 콩죽,,,
mat_mammi,Mämmi,Мамми,Mämmi,Mämmi,Mämmi,Mämmi,Mämmi,Mämmi,莫米,マンミ,매미,,transliterate,
mat_juhannussima,Juhannussima,Юханнуссима,Juhannussima,Juhannussima,Juhannussima,Juhannussima,Juhannussima,Juhannussima,尤汉努西玛,ユハンヌッシマ,유하누시마,,transliterate,
item_hernekeittopurkki,Hernekeittopurkki,Гернекейттопуркки,Hernekeittopurkki,Hernekeittopurkki,Hernekeittopurkki,Hernekeittopurkki,Hernekeittopurkki,Hernekeittopurkki,赫鲁内盖托普尔奇,ヘルネッケイットッポルキ,헤르네케이토푸르키,,transliterate,
item_kaljapullo,Kaljapullo,Кальяпулло,Kaljapullo,Kaljapullo,Kaljapullo,Kaljapullo,Kaljapullo,Kaljapullo,卡利亚普罗,カリヤプーロ,칼야풀로,,transliterate,
perk_iron_stomach,Iron Stomach,Стальной желудок,Estômago de ferro,Estómago de hierro,Eisenbauch,Estomac en béton,Stomaco di ferro,Żelazny żołądek,铁胃,丈夫な胃,강철 위장,,,
]]):gsub(" ", ""))
end

function TestTranslations:TestAddKey()
    files["data/translations/common.csv"] = commonCSVBase
    Translations.AddKey("test_trans_key", {
        en = "aa",
        ru = "bb",
        ["es-es"] = "cc"
    })
    luaunit.assertEquals(ModTextFileGetContent("data/translations/common.csv"):gsub(" ", ""),
    ([[
mat_meat_warm,Lightly-cooked meat,Слегка поджаренное мясо,Carne mal passada,Carne poco hecha,Leicht gekochtes Fleisch,Viande bleue,Carne al sangue,Lekko ugotowane mięso,微熟的肉,少し調理された肉,설익힌 고기,,,
mat_meat_hot,Cooked meat,Поджаренное мясо,Carne ao ponto,Carne al punto,Gekochtes Fleisch,Viande saignante,Carne cotta,Ugotowane mięso,熟肉,調理された肉,익힌 고기,,,
mat_meat_done,Fully-cooked meat,Полностью прожаренное мясо,Carne bem passada,Carne muy hecha,Vollständig gekochtes Fleisch,Viande à point,Carne ben cotta,W pełni ugotowane mięso,全熟的肉,完全に調理された肉,완전히 익힌 고기,,,
mat_meat_burned,Burned meat,Сгоревшее мясо,Carne queimada,Carne quemada,Verbranntes Fleisch,Viande brûlée,Carne bruciata,Przypalone mięso,烧焦的肉,焦げた肉,탄 고기,,,
perkdesc_lower_spread,"Your spells have lower spread and extra damage, but have increased cast delay.","Заклинания наносят больше урона, разброс уменьшается, но задержка увеличивается.","Seus feitiços têm menor dispersão e causam mais dano, mas o tempo de conjuração é maior.","Tus hechizos tienen menor dispersión y daño adicional, pero tienen mayor demora de lanzamiento.","Deine Zauber haben eine geringere Streuung und erhöhten Schaden, aber eine erhöhte Zauberverzögerung.","Vos sorts ont une dispersion plus faible et infligent plus de dégâts, mais aussi un délai de lancement accru.","I tuoi incantesimi hanno una diffusione minore e infliggono danni extra, ma il ritardo di lancio è aumentato.","Twoje zaklęcia mają mniejszy rozrzut i większe obrażenia, ale i większe opóźnienie rzucania.",你的法术散射更小，伤害更高，但施放延迟增加。,自分の呪文範囲が狭まって追加ダメージを与えるが、呪文の詠唱遅延が増加する。,주문의 확산이 감소하고 추가 대미지를 가하며 시전 지연 시간은 증가합니다.,,,
mat_peasoup_concentrate,Pea soup concentrate,Концентрированный гороховый суп,Sopa de ervilha concentrada,Concentrado de sopa de guisantes,Erbsensuppenkonzentrat,Concentré de soupe de pois,Zuppa di piselli concentrata,Koncentrat zupy grochowej,豌豆汤萃取物,マメのスープの濃縮物,농축 콩죽,,,
mat_mammi,Mämmi,Мамми,Mämmi,Mämmi,Mämmi,Mämmi,Mämmi,Mämmi,莫米,マンミ,매미,,transliterate,
mat_juhannussima,Juhannussima,Юханнуссима,Juhannussima,Juhannussima,Juhannussima,Juhannussima,Juhannussima,Juhannussima,尤汉努西玛,ユハンヌッシマ,유하누시마,,transliterate,
item_hernekeittopurkki,Hernekeittopurkki,Гернекейттопуркки,Hernekeittopurkki,Hernekeittopurkki,Hernekeittopurkki,Hernekeittopurkki,Hernekeittopurkki,Hernekeittopurkki,赫鲁内盖托普尔奇,ヘルネッケイットッポルキ,헤르네케이토푸르키,,transliterate,
item_kaljapullo,Kaljapullo,Кальяпулло,Kaljapullo,Kaljapullo,Kaljapullo,Kaljapullo,Kaljapullo,Kaljapullo,卡利亚普罗,カリヤプーロ,칼야풀로,,transliterate,
perk_iron_stomach,Iron Stomach,Стальной желудок,Estômago de ferro,Estómago de hierro,Eisenbauch,Estomac en béton,Stomaco di ferro,Żelazny żołądek,铁胃,丈夫な胃,강철 위장,,,
perkdesc_iron_stomach,You no longer suffer from negative effects of eating.,Вы больше не страдаете от негативных эффектов после еды.,Você não sofre mais os efeitos negativos ao comer.,Ya no sufrirás efectos negativos derivados de la comida.,Du leidest nicht mehr unter negativen Auswirkungen des Essens.,Vous ne souffrez plus d'effets négatifs en mangeant.,Non soffri più effetti negativi dopo aver mangiato.,Nie otrzymujesz już negatywnych efektów jedzenia.,你不再因食用物品而受到负面效果。,食事によるマイナス効果を受けなくなる。,이제 식사 시 부정적인 효과를 겪지 않습니다.,,,
test_trans_key,aa,bb,,cc,,,,,,,,
]]):gsub(" ", ""))
end

os.exit(luaunit.LuaUnit.run())