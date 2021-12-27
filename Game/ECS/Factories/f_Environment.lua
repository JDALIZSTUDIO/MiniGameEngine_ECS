return {
    new = function()
        local Class = {}

        local deg = math.deg

        -----------------------
        -- Init_Destructible --
        -----------------------
        function Class:Init_Destructible(_pEntity, _pX, _pY)
            _pEntity:Add_Component(require('Game/ECS/Controllers/c_Destructible_Controller').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Health/c_Health').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(_pX, _pY, 0))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 32, 32))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Box_Collider').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Rigid_Body').new({isStatic = true}))
        end

        
        --------------------
        -- Init_Explosive --
        --------------------
        function Class:Init_Explosive(_pEntity, _pX, _pY)
            _pEntity:Add_Component(require('Game/ECS/Controllers/c_Explosive_Controller').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Health/c_Health').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/FX/c_Animated_FX_Emitter').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(_pX, _pY, 0))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 32, 32))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Box_Collider').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Rigid_Body').new({isStatic = true}))
        end


        ----------------
        -- Init_Block --
        ----------------
        function Class:Init_Block(_pEntity, _pX, _pY)
            self:Init_Destructible(_pEntity, _pX, _pY)
            local anim = _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
                  anim:Add("idle",  "Game/Images/Environment/block.png", 32, 32, 0, 0, 1, 1, 1, 1, 0,  false)
                  anim:Add("death", "Game/Images/FX/block_death_128x128_n37.png", 128, 128, 0, 0, 1, 1, 37, 1, 120,  false)
        end
        
        --------------------
        -- Init_BrickWall --
        --------------------
        function Class:Init_BrickWall(_pEntity, _pX, _pY)
            self:Init_Destructible(_pEntity, _pX, _pY)
            local anim = _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
                  anim:Add("idle",  "Game/Images/Environment/brickWall.png", 32, 32, 0, 0, 1, 1, 1, 1, 0,  false)
                  anim:Add("death", "Game/Images/FX/brickWall_death_128x128_n41.png", 128, 128, 0, 0, 1, 1, 41, 1, 120,  false)
        end
        
        ----------------
        -- Init_Crate --
        ----------------
        function Class:Init_Crate(_pEntity, _pX, _pY)
            self:Init_Destructible(_pEntity, _pX, _pY)
            local anim = _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
                  anim:Add("idle",  "Game/Images/Environment/crate.png", 32, 32, 0, 0, 1, 1, 1, 1, 0,  false)
                  anim:Add("death", "Game/Images/FX/crate_death_128x128_n43.png", 128, 128, 0, 0, 1, 1, 43, 1, 120,  false)
        end

        -----------------
        -- Init_Barrel --
        -----------------
        function Class:Init_Barrel(_pEntity, _pX, _pY)
            self:Init_Explosive(_pEntity, _pX, _pY)
            local anim = _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
                  anim:Add("idle",  "Game/Images/Environment/barrel.png", 32, 32, 0, 0, 1, 1, 1, 1, 0,  false)
                  anim:Add("death", "Game/Images/FX/barrel_death_128x128_n34.png", 128, 128, 0, 0, 1, 1, 34, 1, 120,  false)
        end

        ---------------
        -- Init_Bush --
        ---------------
        function Class:Init_Bush(_pEntity, _pX, _pY)
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 16, 16))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Rigid_Body').new({isStatic = true}))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Images/Tank_Game/bush.png"))
        end

        return Class
    end

}