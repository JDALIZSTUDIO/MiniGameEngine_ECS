return {
    new = function()
        local Class = {}

        local deg = math.deg

        ----------------------
        -- Init_Tank_Bullet --
        ----------------------
        function Class:Init_Tank_Bullet(_pEntity, _pOwner, _pX, _pY, _pRotation)
            local spriteLoader = Locator:Get_Service("spriteLoader")
            local spr_bullet   = spriteLoader:Get_Sprite("tank_bullet")

            _pEntity:Add_Component(require('Game/ECS/Controllers/c_Bullet_Controller').new({owner = _pOwner}))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/FX/c_Animated_FX_Emitter').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(_pX, _pY, deg(_pRotation)))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 8, 8))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Box_Collider').new())

            local body = _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Simple_Body').new())
                body.isSolid = false
                 
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/FX/c_Trail_Emitter_SpriteRenderer').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new(spr_bullet))
            _pEntity.name = "bullet"
        end

        return Class
    end

}