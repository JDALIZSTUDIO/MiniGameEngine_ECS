return {
    new = function()
        local Class = {}

        local spriteLoader = Locator:Get_Service("spriteLoader")
        local deg          = math.deg

        function Class:Init_Cursor(_pEntity)
            local spr_cursor = spriteLoader:Get_Sprite("crosshair")

            _pEntity:Add_Component(require('Game/ECS/Controllers/c_Cursor_Controller').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(0, 0, 0))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Sprite_GUI_Renderer').new(spr_cursor))
        end

        -----------------
        -- Init_Player --
        -----------------
        function Class:Init_Player(_pEntity, _pX, _pY)
            local spr_body   = spriteLoader:Get_Sprite("tank_beige")
            local spr_cannon = spriteLoader:Get_Sprite("tank_cannon")

            _pEntity:Add_Component(require('Game/ECS/Controllers/c_Tank_Body_Controller').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Health/c_Health').new())

            local transformBody = _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(_pX, _pY, 0))

            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 24, 24))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Rigid_Body').new({maxForce = 100}))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Lighting/c_Fog_Remover').new())

            local anim = _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Animator').new())
                    anim:Add("idle", spr_body, 96, 96, 0, 0, 1, 1, 2, 1)
                    anim:Add("move", spr_body, 96, 96, 0, 0, 1, 2, 2, 2)
            
            --_pEntity:Add_Component(require('Core/Libraries/ECS/Components/FX/c_Love_Particle_System').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/FX/c_Particle_System').new())

            Camera:Attach(transformBody)

            local cannon = _pEntity.ECS:Create()

            cannon.name = "cannon"
            cannon:Add_Component(require('Game/ECS/Controllers/c_Tank_Canon_Controller').new())

            local transformCannon = cannon:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(x, y, 0))

            cannon:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 32, 32))
            cannon:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new(spr_cannon))

            transformBody:Add_Child(transformCannon)
        end

        return Class
    end

}