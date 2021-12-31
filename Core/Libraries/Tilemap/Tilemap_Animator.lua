return {
    new = function()
        local Class = {}

        -------------
        -- On_Animation --
        -------------
        function Class:On_Animation(dt, _pTable)
            local animation, current
            for key, value in pairs(_pTable) do
                animation = value
                current   = animation.currentFrame
                animation.frameCounter = animation.frameCounter + (dt * current.duration * 0.1)
                if(animation.frameCounter >= 1) then
                    animation.frameCounter = 0
                    animation.indexFrame   = animation.indexFrame + 1
                    if(animation.indexFrame > #animation.frames) then
                        animation.indexFrame = 1
                    end
                    animation.currentFrame = animation.frames[animation.indexFrame]
                end
            end
        end

        return Class
    end
}