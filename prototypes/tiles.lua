require("prototypes.config")

color_tiles = {}

if ENABLE_CONCRETE then
    -- create new concrete tiles
    function add_concrete(color, mineresult, rgb, next_direction)
        concrete = util.table.deepcopy(data.raw["tile"]["concrete"])
        concrete.name                           = "concrete-"..color
        if next_direction then
            concrete.next_direction             = "concrete-"..next_direction
        end
        concrete.variants.main[1].picture       = MOD_NAME.."/graphics/concrete/"..color.."/concrete1.png"
        concrete.variants.main[2].picture       = MOD_NAME.."/graphics/concrete/"..color.."/concrete2.png"
        concrete.variants.main[3].picture       = MOD_NAME.."/graphics/concrete/"..color.."/concrete4.png"
        concrete.variants.inner_corner.picture  = MOD_NAME.."/graphics/concrete/"..color.."/concrete-inner-corner.png"
        concrete.variants.outer_corner.picture  = MOD_NAME.."/graphics/concrete/"..color.."/concrete-outer-corner.png"
        concrete.variants.side.picture          = MOD_NAME.."/graphics/concrete/"..color.."/concrete-side.png"
        concrete.variants.u_transition.picture  = MOD_NAME.."/graphics/concrete/"..color.."/concrete-u.png"
        concrete.variants.o_transition.picture  = MOD_NAME.."/graphics/concrete/"..color.."/concrete-o.png"
        concrete.map_color = {
            r = (rgb["r"] * 0.5),
            g = (rgb["g"] * 0.5),
            b = (rgb["b"] * 0.5)
        }
        concrete.minable["result"] = "concrete-"..mineresult

        table.insert(color_tiles,concrete)
    end

    for color,rgb in pairs(COLOR_TABLE) do
        if not NEXT_TABLE[color] then
            add_concrete(color, TILE_MINE_RESULT[color], rgb)
        else
            i = 0
            for i=1,#NEXT_TABLE[color] do
                j=i+i
                if j > #NEXT_TABLE[color] then j = 1 end
                add_concrete(NEXT_TABLE[color][i], color, rgb, NEXT_TABLE[color][j])
            end
        end
    end
end

data:extend(color_tiles)
