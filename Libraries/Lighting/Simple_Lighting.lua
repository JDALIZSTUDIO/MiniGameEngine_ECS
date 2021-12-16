return {
    new = function()
        local Lighting = {
            components,
            lights,
            screen,
            shader,
        }

        ---------
        -- Add --
        ---------
        function Lighting:Add(_pEntity)
            local lightSource = _pEntity:GetComponent("lightSource")
            local transform   = _pEntity:GetComponent("transform")
            if(lightSource ~= nil and transform ~= nil) then
                local light       = {
                    lightSource   = lightSource,
                    position      = transform.position
                }
                table.insert(self.components, light)
            end
        end

        ----------
        -- Load --
        ----------
        function Lighting:Load(_pW, _pH)
            self.components = {}
            self.lights     = {}
            self.screen     = { _pW, _pH }
            self.shader     = love.graphics.newShader("Shaders/shd_Lighting.fs")
        end

        ------------
        -- Update --
        ------------
        function Lighting:Update(dt)
            self.lights = {}
            local light, path, string, struct
            for i = #self.components, 1, -1 do
                light = self.components[i]
                if(light.lightSource == nil or light.position == nil) then                    
                    print("Lighting, Removing: 1 ligthSource")
                    table.remove(self.components, i)
                elseif(light.lightSource.active) then
                    path = "lights["..tostring(i-1).."]."
                    struct        = {
                        pathPos   = path.."position",
                        position  = {light.position.x, light.position.y},
                        pathDif   = path.."diffuse",
                        diffuse   = light.lightSource.color,
                        pathPower = path.."power",
                        power     = light.lightSource.power,
                    }                    
                    table.insert(self.lights, struct)
                end
            end
        end

        ---------
        -- Set --
        ---------
        function Lighting:Set()
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setShader(self.shader)            
              self.shader:send("screen", self.screen)
              self.shader:send("num_lights", #self.lights)

              local l
              for i = 1, #self.lights do
                  l = self.lights[i]
                  self.shader:send(l.pathPos,   l.position)
                  self.shader:send(l.pathDif,   l.diffuse)
                  self.shader:send(l.pathPower, l.power)
              end
        end

        -----------
        -- UnSet --
        -----------
        function Lighting:UnSet()            
          love.graphics.setShader()
        end

        return Lighting
    end
}