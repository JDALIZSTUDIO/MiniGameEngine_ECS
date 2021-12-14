return {
  new = function()
    local component = p_Component.new("entityReflector")
    local angleAdd = 35
    
    function component:Reflect(_pOther)
      local transformA = self.gameObject:GetComponent("transform")
      local bBoxA      = self.gameObject:GetComponent("boxCollider")
      local bBoxB      = _pOther:GetComponent("boxCollider")
      
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