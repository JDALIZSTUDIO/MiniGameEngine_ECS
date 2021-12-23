local Globals = {}

    ---------
    -- ECS --
    ---------
    p_Entity      = nil
    p_Component   = nil
    p_System      = nil

    -------------
    -- Classes --
    -------------
    Aspect        = nil
    Camera        = nil
    Easing        = nil
    Input         = nil
    Helpers       = nil
    Scene_Manager = nil
    Table         = nil
    Transition    = nil
    Vector2       = nil

function Globals:Load()
    Vector2       = require('Core/Libraries/Vector2')
    p_Entity      = require('Core/Libraries/ECS/Parents/p_Entity')
    p_Component   = require('Core/Libraries/ECS/Parents/p_Component')
    p_System      = require('Core/Libraries/ECS/Parents/p_System')
    Aspect        = require('Core/Libraries/Aspect').new()
    Easing        = require('Core/Libraries/Easing').new()
    Input         = require('Core/Libraries/Input/Input').new()
    Camera        = require('Core/Libraries/Camera/Camera').new()
    Table         = require('Core/Libraries/Table').new()
    Transition    = require('Core/Libraries/Transition').new()
    Scene_Manager = require('Core/Libraries/Scenes/Scene_Manager').new()

    Camera:Load()
end

return Globals