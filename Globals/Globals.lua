local Globals = {
    ---------
    -- ECS --
    ---------
    p_Entity             = nil,
    p_Component          = nil,
    p_System             = nil,

    -------------
    -- Classes --
    -------------
    Aspect        = nil,
    Camera        = nil,
    Easing        = nil,
    Input         = nil,
    Helpers       = nil,
    Scene_Manager = nil,
    Table         = nil,
    Transition    = nil,
    Vector2       = nil,

    ---------------
    -- Booleans --
    ---------------
    debug = true
}

function Globals:Load()
    Vector2       = require('Libraries/Vector2')
    p_Entity      = require('Libraries/ECS/Parents/p_Entity')
    p_Component   = require('Libraries/ECS/Parents/p_Component')
    p_System      = require('Libraries/ECS/Parents/p_System')
    Aspect        = require('Libraries/Aspect').new()
    Easing        = require('Libraries/Easing').new()
    Input         = require('Libraries/Input/Input').new()
    Camera        = require('Libraries/Camera/Camera').new()
    Table         = require('Libraries/Table').new()
    Transition    = require('Libraries/Transition').new()
    Scene_Manager = require('Libraries/Scenes/Scene_Manager').new()
end

return Globals