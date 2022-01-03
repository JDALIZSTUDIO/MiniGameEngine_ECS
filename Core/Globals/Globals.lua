local Globals = {}

    -------------
    -- Classes --
    -------------
    Input         = nil
    LEVEL         = nil
    Table         = nil
    Vector2       = nil

function Globals:Load()
    LEVEL         = 1
    Vector2       = require('Core/Libraries/Vector2')
    Input         = require('Core/Libraries/Input/Input').new()
    Table         = require('Core/Libraries/Table').new()

end

return Globals