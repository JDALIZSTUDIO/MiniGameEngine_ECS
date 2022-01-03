return {
    new = function()
        local f_node   = nil
        local Class    = {
            isDebug    = true,
            ClosedList = {},
            grid       = {},
            openList   = {},
            width      = 0,
            height     = 0
        }

        local closedList = {}
        local openList   = {}

        local insert = table.insert
        local remove = table.remove

        ----------
        -- Load --
        ----------
        function Class:Load()
            f_node = require('Core/Libraries/Pathfinding/Node')
        end

        -----------------
        -- Create_Grid --
        -----------------
        function Class:Create_Grid(_pW, _pH)
            self.grid     = {}
            self.solution = {}
            for xx = 1, _pW do 
                self.grid[xx]     = {}
                self.solution[xx] = {}
                for yy = 1, _pH do
                    self.grid[xx][yy]     = 0
                    self.solution[xx][yy] = 0
                end
            end
        end

        --------------------------
        -- Return_Smallest_Cost --
        --------------------------
        function Class:Return_Smallest_Cost()
            local index, node
            local cost = 9999
            for i = 1, #openList do
                node = openList[i]
                if(node.cost < cost) then
                    index = i
                    cost  = node.cost
                end
            end
            return i
        end

        --------------
        -- Get_Path --
        --------------
        function Class:Get_Path(_pStartX, _pStartY, _pEndX, _pEndY)
            -- Initialize tables
            self.closedList = {}
            self.openList   = {}

            -- Add first node --
            insert(self.openList, f_node.new(_pStartX, _pStartY, 0))

            -- find the nodes around --
            local index, currentNode
            while(#self.openList > 0) do

                -- Get the current node
                index       = self:Return_Smallest_Cost()
                currentNode = self.openList[index]
                insert(self.closedList, currentNode)
                remove(self.openList, index)

                -- Found the goal
                if(currentNode.position.x == _pEndX and
                   currentNode.position.y == _pEndY) then
                    return self:Return_BackTracked_Path()
                end


            end

            return nil
        end

        function Class:Return_BackTracked_Path()
            local path = {}
            for i = #self.closedList, 1, -1 do
                insert(path, self.closedList[i])
            end
            return path
        end

        ----------
        -- Draw --
        ----------
        function Class:Draw(_pNodes, _pTileWidth, _pTileHeight)
            if(not self.isDebug) then return end
            love.graphics.setColor(0, 0, 1, 0.5)
            local node
            for i = 1, #_pNodes do
                node = _pNodes[i]
                love.graphics.rectangle(
                    "fill",
                    (node.position.x - 1) * _pTileWidth,
                    (node.position.y - 1) * _pTileHeight,
                    _pTileWidth,
                    _pTileHeight
                )
            end
            love.graphics.setColor(1, 1, 1, 1)
        end
        
        Class:Load()

        return Class
    end
}