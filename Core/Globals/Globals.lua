local Globals = {}

    -------------
    -- Classes --
    -------------
    Input         = nil
    Helpers       = nil
    Table         = nil
    Vector2       = nil

function Globals:Load()
    Vector2       = require('Core/Libraries/Vector2')
    Input         = require('Core/Libraries/Input/Input').new()
    Table         = require('Core/Libraries/Table').new()

end

return Globals