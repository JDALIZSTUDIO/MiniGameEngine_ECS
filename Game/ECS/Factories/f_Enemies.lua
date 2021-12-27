return {
    new = function()
        local Class = {}

        ---------------------
        -- Initialize_Tank --
        ---------------------
        function Class:Init_Tank(_pEntity, _pX, _pY)
            -- Body --
            _pEntity.name = "enemyTank"
            _pEntity:Add_Component(require('Game/ECS/Controllers/c_Enemy_Tank_Controller').new())

            local transformBody = _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(_pX, _pY, 0))

            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 24, 24))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Rigid_Body').new())

            local anim = _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
                  anim:Add("idle", "Game/Images/Enemies/tank_body_blue.png", 96, 96, 0, 0, 1, 1, 2, 1)
                  anim:Add("move", "Game/Images/Enemies/tank_body_blue.png", 96, 96, 0, 0, 1, 2, 2, 2)

            -- Cannon --
            local cannon = _pEntity.ECS:Create()
                  cannon.name = "cannon"

            local transformCannon = cannon:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(_pX, _pY, 0))
                                    cannon:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 32, 32))
                                    cannon:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Game/Images/Player/Tank_canon.png"))
                    
            transformBody:Add_Child(transformCannon)
            anim:Set_Alpha(0)
        end
        
        ------------------
        -- Init_Spawner --
        ------------------
        function Class:Init_Spawner(_pEntity, _pX, _pY)
            _pEntity:Add_Component(require('Game/ECS/Controllers/c_Spawner_Controller').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Health/c_Health').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(_pX, _pY, 0))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 32, 32))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Box_Collider').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Simple_Body').new())            

            local anim = _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
                  anim:Add("closed",  "Game/Images/Enemies/spawner_atlas.png", 32, 32, 0, 0, 1, 1, 1, 1, 0,  false)
                  anim:Add("open",    "Game/Images/Enemies/spawner_atlas.png", 32, 32, 0, 0, 2, 1, 2, 1, 0,  false)
                  anim:Add("opening", "Game/Images/Enemies/spawner_atlas.png", 32, 32, 0, 0, 1, 2, 3, 2, 15, false)
                  anim:Add("closing", "Game/Images/Enemies/spawner_atlas.png", 32, 32, 0, 0, 1, 3, 3, 3, 15, false)
                  anim:Add("death",   "Game/Images/FX/spawner_death_128x128_40.png", 32, 32, 0, 0, 1, 3, 3, 3, 120, false)
        end

        return Class
    end
}