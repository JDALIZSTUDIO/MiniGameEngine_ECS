return {
    new = function(_pName)
        local Scene = require('Core/Libraries/Scenes/Scene_Parent').new(_pName)
        
        local Tilemap

        ----------
        -- Load --
        ----------
        function Scene:Load()
            Tilemap = require('Core/Libraries/Tilemap/Tilemap').new()
            Tilemap:Load('Core/Libraries/Tilemap/Maps/TESTMAP3')
        end

        ------------
        -- Update --
        ------------
        function Scene:Update(dt)
            Tilemap:Update(dt)
        end

        ----------
        -- Draw --
        ----------
        function Scene:Draw()
            Tilemap:DrawBack()
            Tilemap:DrawFront()
        end

        return Scene
    end
}