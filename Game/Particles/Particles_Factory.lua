local factory = {}
    
    local aspect   = Locator:Get_Service("aspect")
    local s_loader = Locator:Get_Service("spriteLoader")
    local range    = 64 
    local rad      = math.rad
    local rnd      = math.random

    local function Translate(_pPosition)
        return {
            _pPosition.x  / aspect.scale,
            _pPosition.y  / aspect.scale
        }
    end

    function factory:Smoke_Properties(_pPosition, _pNumber)
        local properties       = {
            colors             = { {1, 1, 1, 0}, {0.5, 0.5, 0.5, 0.5}, {0, 0, 0, 0} },
            image              = love.graphics.newImage("Game/Images/FX/smoke_particle.png"),
            linearAcceleration = {rnd(-range, range), rnd(-range, range), rnd(-range, range), rnd(-range, range)},
            lifeTime           = { 0.5, 1 },
            maxParticles       = _pNumber,
            position           = Translate(_pPosition),
            rotation           = { rad(0), rad(359) },
            spinVariation      = rnd(1),
            sizes              = {0, 0.04, 0}
        }

        return properties
    end

    function factory:Test_parameters()
        local sprite = s_loader:Get_Sprite("smoke_particle1")
        local Parameters       = {
            colors             = { {1, 1, 1, 0.25}, {0.5, 0.5, 0.5, 0.75}, {0, 0, 0, 0} },
            lifeTime           = { 2, 3 },
            linearAcceleration = { -20, 20, -20, 20 },
            linearDampening    = { 0, 0, 0, 0 },
            offset             = { -4, 4, -4, 4 },
            rotation           = { 0, 359 },
            sizes              = { 0.05, 0.25, 0 },
            sprite             = sprite,
            sizeVariation      = { 0.1, 0.2 },
            spinVariation      = { -20, 20 }
        }
        return Parameters
    end


return factory