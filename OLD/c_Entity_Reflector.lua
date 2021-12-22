return {
  new = function()
    local component = p_Component.new("entityReflector")
    local angleAdd = 35
    
    function component:Reflect(_pOther)
      local transformA = self.gameObject:Get_Component("transform")
      local bBoxA      = self.gameObject:Get_Component("boundingBox")
      local bBoxB      = _pOther:Get_Component("boundingBox")
      
      if(bBoxA.position.y < bBoxB.top) then 
        transformA.velocity.y = -transformA.velocity.y 
        
      elseif(bBoxA.position.y > bBoxB.bottom) then 
        transformA.velocity.y = -transformA.velocity.y 
        
      else         
        transformA.velocity.x = -transformA.velocity.x
        
      end
    end
    
    return component  
  end
}