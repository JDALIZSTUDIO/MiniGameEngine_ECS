return {
    new = function()
        local Lighting = {
            lights,
            screen,
            shader,
            surface
        }
        
        local lights

        function Lighting:Add(_pEntity)
            local lightSource = _pEntity:GetComponent("lightSource")
            local transform   = _pEntity:GetComponent("transform")
            local light       = {
                lightSource   = lightSource,
                position      = transform.position
            }
            table.insert(self.lights, light)
        end

        function Lighting:Load(_pW, _pH)
            self.lights  = {}
            self.screen  = { _pW, _pH }
            self.shader  = love.graphics.newShader("Shaders/shd_Lighting.fs")
            self.surface = love.graphics.newCanvas(_pW, _pH)
            self.surface:setFilter("nearest", "nearest")
        end

        function Lighting:Update(dt)
            lights = {}
            local light, path, string, struct
            for i = #self.lights, 1, -1 do
                light = self.lights[i]
                if(light.lightSource == nil or light.position == nil) then                    
                    print("Lighting, Removing: 1 ligthSource")
                    table.remove(self.lights, i)
                elseif(light.lightSource.active) then
                    path = "lights["..tostring(i-1).."]."
                    struct        = {
                        pathPos   = path.."position",
                        position  = {light.position.x, light.position.y},
                        pathDif   = path.."diffuse",
                        diffuse   = light.lightSource.color,
                        pathPower = path.."power",
                        power     = light.lightSource.power
                    }
                    
                    table.insert(lights, struct)
                end
            end
        end

        function Lighting:Set()
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.setShader(self.shader)            
              self.shader:send("screen", self.screen)
              self.shader:send("num_lights", #lights)

              local l
              for i = 1, #lights do
                  l = lights[i]
                  self.shader:send(l.pathPos,   l.position)
                  self.shader:send(l.pathDif,   l.diffuse)
                  self.shader:send(l.pathPower, l.power)
              end
        end

        function Lighting:UnSet()            
          love.graphics.setShader()
        end

        return Lighting
    end
}