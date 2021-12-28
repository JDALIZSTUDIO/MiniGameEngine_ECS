local factory = {}
    
    local aspect = Locator:Get_Service("aspect")
    local range  = 64 
    local rad    = math.rad
    local rnd    = math.random

    local function Translate(_pPosition)
        return {
            _pPosition.x  / aspect.scale,
            _pPosition.y  / aspect.scale
        }
    end

    function factory:Smoke_Properties(_pPosition, _pNumber)
        local properties       = {
            colors             = {{1, 1, 1, 0}, {0.5, 0.5, 0.5, 0.5}, {0, 0, 0, 0}},
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


return factory