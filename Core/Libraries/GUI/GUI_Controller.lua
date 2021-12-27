return {
    new = function()
        local Class = {
            element = {
                button,
                label,
                panel,
                spriteFont
            },

            lstElements = {}
        }
        
        local insert = table.insert
        local remove = table.remove

        ---------
        -- Add --
        ---------
        function Class:Add(_pElement)
            _pElement:Load()

            insert(self.lstElements, _pElement)
            return _pElement
        end
        
        ----------
        -- Load --
        ----------
        function Class:Load()
            self.element.button     = require('Core/Libraries/GUI/Elements/GUI_Button')
            self.element.label      = require('Core/Libraries/GUI/Elements/GUI_Label')
            self.element.panel      = require('Core/Libraries/GUI/Elements/GUI_Panel')            
            self.element.spriteFont = require('Core/Libraries/GUI/Elements/GUI_SpriteFont')
        end

        ------------
        -- Update --
        ------------
        function Class:Update(dt)
            local element
            for i = #self.lstElements, 1, -1 do
                element = self.lstElements[i]
                if(element.expired) then
                    remove(self.lstelements, element)
                else
                    element.Update(dt)
                end
            end
        end
        
        ------------
        -- UnLoad --
        ------------
        function Class:UnLoad()
            self.lstElements = {}
        end
        
        ----------
        -- Draw --
        ----------
        function Class:Draw()
            for i = 1, #self.lstElements do
                self.lstElements[i].Draw()
            end
        end
        return Class
    end
}