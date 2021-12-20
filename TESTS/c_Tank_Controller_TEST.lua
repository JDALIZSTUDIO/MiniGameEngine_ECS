local factory  = require('Libraries/ECS/Components/Controllers/c_Player_Controller')

return {
  new = function(_pECS)
    local component = factory.new(_pECS)
          
    local gameObject   = nil
    local acceleration = 10

    -----------------
    -- Custom_Load --
    -----------------
    function component:Custom_Load()  
      gameObject = component.gameObject
    end
    
    -------------------
    -- Process_Input --
    -------------------
    function component:Process_Input()  
      local rigidbody = gameObject:GetComponent("rigidBody")

      if(Input.keyboard:GetAxis("up")) then rigidbody:Add_Force({x = 0, y = -acceleration}) end
      if(Input.keyboard:GetAxis("down")) then rigidbody:Add_Force({x = 0, y = acceleration}) end
      if(Input.keyboard:GetAxis("left")) then rigidbody:Add_Force({x = -acceleration, y = 0}) end
      if(Input.keyboard:GetAxis("right")) then rigidbody:Add_Force({x = acceleration, y = 0}) end

    end

    ------------------
    -- Update_Logic --
    ------------------
    function component:Update_Logic(dt)  
      
    end
    
    -----------------------
    -- OnEntityCollision --
    -----------------------
    function component:OnEntityCollision(_pTable)
      
    end
    
    ---------------------
    -- OnTileCollision --
    ---------------------
    function component:OnTileCollision(_pTileID)
      
    end
    
    
    return component
  end
}