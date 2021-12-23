local Entity = require 'Core/Libraries/ECS/Entity'

local test = {}

function test:NewGameObject()
  local entity = Entity.new()
  
  return entity
end



return test