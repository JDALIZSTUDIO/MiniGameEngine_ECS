return {
    new = function()
        local Parameters       = {
            colors             = { {1, 1, 1, 1}, {1, 1, 1, 1}, {1, 1, 1, 1} },
            lifeTime           = { 1, 1 },
            linearAcceleration = { 0, 0, 0, 0 },
            linearDampening    = { 0, 0, 0, 0 },
            offset             = { 0, 0, 0, 0 },
            rotation           = { 0, 0 },
            sizes              = { 1, 1, 1 },
            sprite             = nil,
            sizeVariation      = { 1, 1 },
            spinVariation      = { 1, 1 }
        }
        return Parameters
    end
}