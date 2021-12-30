return {
    new = function()
        local Class = {}

        local rnd          = math.random
        local spriteLoader = Locator:Get_Service("spriteLoader")

        ---------------------
        -- Initialize_Tank --
        ---------------------
        function Class:Init_Tank(_pEntity, _pX, _pY)

            local color = "tank_pink"
            if(rnd(1) > 0.5) then color = "tank_blue" end

            local spr_body   = spriteLoader:Get_Sprite(color)
            local spr_cannon = spriteLoader:Get_Sprite("tank_cannon")
            
            -- Body --
            _pEntity.name = "enemyTank"
            _pEntity:Add_Component(require('Game/ECS/Controllers/c_Enemy_Tank_Controller').new())

            local transformBody = _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(_pX, _pY, 0))

            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 24, 24))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Rigid_Body').new())

            local anim = _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
                  anim:Add("idle", spr_body, 96, 96, 0, 0, 1, 1, 2, 1)
                  anim:Add("move", spr_body, 96, 96, 0, 0, 1, 2, 2, 2)

            -- Cannon --
            local cannon = _pEntity.ECS:Create()
                  cannon.name = "cannon"

            local transformCannon = cannon:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(_pX, _pY, 0))
                                    cannon:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 32, 32))
                                    cannon:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new(spr_cannon))
                    
            transformBody:Add_Child(transformCannon)
            anim:Set_Alpha(0)
        end
        
        ------------------
        -- Init_Spawner --
        ------------------
        function Class:Init_Spawner(_pEntity, _pX, _pY)
            local spr_atlas = spriteLoader:Get_Sprite("tank_spawner")
            local spr_death = spriteLoader:Get_Sprite("tank_cannon")

            _pEntity:Add_Component(require('Game/ECS/Controllers/c_Spawner_Controller').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Effectors/c_Health').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(_pX, _pY, 0))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 32, 32))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Box_Collider').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Simple_Body').new())            
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_DropShadow').new(4, 4))
            
            local anim = _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
                  anim:Add("closed",  spr_atlas, 32, 32, 0, 0, 1, 1, 1, 1, 0,  false)
                  anim:Add("open",    spr_atlas, 32, 32, 0, 0, 2, 1, 2, 1, 0,  false)
                  anim:Add("opening", spr_atlas, 32, 32, 0, 0, 1, 2, 3, 2, 15, false)
                  anim:Add("closing", spr_atlas, 32, 32, 0, 0, 1, 3, 3, 3, 15, false)
                  anim:Add("death",   spr_death, 32, 32, 0, 0, 1, 3, 3, 3, 120, false)
        end

        return Class
    end
}