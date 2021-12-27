return {
    new = function()
        local Class = {}

        local deg = math.deg

        ----------------------
        -- Init_Tank_Bullet --
        ----------------------
        function Class:Init_Tank_Bullet(_pEntity, _pOwner, _pX, _pY, _pRotation)
            _pEntity:Add_Component(require('Game/ECS/Controllers/c_Bullet_Controller').new({owner = _pOwner}))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/FX/c_Animated_FX_Emitter').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Movement/c_Transform').new(_pX, _pY, deg(_pRotation)))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Bounding_Box').new(0, 0, 8, 8))
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Box_Collider').new())

            local body = _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Collisions/c_Simple_Body').new())
                body.isSolid = false
                 
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Trail_Emitter').new())
            _pEntity:Add_Component(require('Core/Libraries/ECS/Components/Rendering/c_Sprite_Renderer').new("Game/Images/Projectiles/tank_bullet.png"))
            _pEntity.name = "bullet"
        end

        return Class
    end

}