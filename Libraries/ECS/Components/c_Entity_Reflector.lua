return {
  new = function()
    local component = p_Component.new("entityReflector")
    
    function component:Reflect(_pEntity, _pOther)
      local transformA = _pEntity:GetComponent("transform")
      local bBoxA      = _pEntity:GetComponent("boxCollider")
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