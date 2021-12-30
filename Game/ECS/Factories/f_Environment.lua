return {
    new = function()
        local Class = {}

        local spriteLoader = Locator:Get_Service("spriteLoader")
        local deg          = math.deg

        -----------------------
        -- Init_Destructible --
        -----------------------
        function Class:Init_Destructible(_pEntity, _pX, _pY)
            _pEntity:Add_Component(require('Game/ECS/Controllers/c_Destructible_Controller').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Effectors/c_Health').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(_pX, _pY, 0))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 32, 32))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Box_Collider').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Rigid_Body').new({isStatic = true}))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_DropShadow').new(4, 4))
        end

        
        --------------------
        -- Init_Explosive --
        --------------------
        function Class:Init_Explosive(_pEntity, _pX, _pY)
            _pEntity:Add_Component(require('Game/ECS/Controllers/c_Explosive_Controller').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Effectors/c_Health').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/FX/c_Animated_FX_Emitter').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Effectors/c_area_Of_Effect').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(_pX, _pY, 0))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 32, 32))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Box_Collider').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Rigid_Body').new({isStatic = true}))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_DropShadow').new(4, 4))
        end


        ----------------
        -- Init_Block --
        ----------------
        function Class:Init_Block(_pEntity, _pX, _pY)
            local spr_idle  = spriteLoader:Get_Sprite("block")
            local spr_hurt  = spriteLoader:Get_Sprite("block_hurt")
            local spr_death = spriteLoader:Get_Sprite("block_death")
            self:Init_Destructible(_pEntity, _pX, _pY)
            local anim = _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
                  anim:Add("idle",  spr_idle,  32,   32, 0, 0, 1, 1,  1, 1,   0, false)
                  anim:Add("hurt",  spr_hurt,  128, 128, 0, 0, 1, 1, 20, 1, 120, false)
                  anim:Add("death", spr_death, 128, 128, 0, 0, 1, 1, 37, 1, 120, false)
        end
        
        --------------------
        -- Init_BrickWall --
        --------------------
        function Class:Init_BrickWall(_pEntity, _pX, _pY)
            local spr_idle  = spriteLoader:Get_Sprite("brickWall")
            local spr_hurt  = spriteLoader:Get_Sprite("brickWall_hurt")
            local spr_death = spriteLoader:Get_Sprite("brickWall_death")
            self:Init_Destructible(_pEntity, _pX, _pY)
            local anim = _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
                  anim:Add("idle",  spr_idle,  32,   32, 0, 0, 1, 1,  1, 1,   0, false)
                  anim:Add("hurt",  spr_hurt,  128, 128, 0, 0, 1, 1, 20, 1, 120, false)
                  anim:Add("death", spr_death, 128, 128, 0, 0, 1, 1, 41, 1, 120, false)
        end
        
        ----------------
        -- Init_Crate --
        ----------------
        function Class:Init_Crate(_pEntity, _pX, _pY)
            local spr_idle  = spriteLoader:Get_Sprite("crate")
            local spr_hurt  = spriteLoader:Get_Sprite("crate_hurt")
            local spr_death = spriteLoader:Get_Sprite("crate_death")
            self:Init_Destructible(_pEntity, _pX, _pY)
            local anim = _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
                  anim:Add("idle",  spr_idle,  32,   32, 0, 0, 1, 1,  1, 1,   0, false)
                  anim:Add("hurt",  spr_hurt,  128, 128, 0, 0, 1, 1, 20, 1, 120, false)
                  anim:Add("death", spr_death, 128, 128, 0, 0, 1, 1, 43, 1, 120, false)
        end

        -----------------
        -- Init_Barrel --
        -----------------
        function Class:Init_Barrel(_pEntity, _pX, _pY)
            local spr_idle  = spriteLoader:Get_Sprite("barrel")
            local spr_hurt  = spriteLoader:Get_Sprite("barrel_hurt")
            local spr_death = spriteLoader:Get_Sprite("barrel_death")
            self:Init_Explosive(_pEntity, _pX, _pY)
            local anim = _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
                  anim:Add("idle",  spr_idle,  32,   32, 0, 0, 1, 1, 1,  1,   0, false)
                  anim:Add("hurt",  spr_hurt,  128, 128, 0, 0, 1, 1, 20, 1, 120, false)
                  anim:Add("death", spr_death, 128, 128, 0, 0, 1, 1, 34, 1, 120, false)
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