return {
  new = function(_pMaxTrail)
    local component = p_Component.new("trailEmitter")
          component.active = false
          component.trail  = {}
          component.maxT   = _pMaxTrail or 50
    
    function component:Update(dt, _pEntity)
      if(component.active) then
        local transform = _pEntity:GetComponent("transform")
        local length = #component.trail
        if(length > component.maxT) then table.remove(component.trail, 1) end
        table.insert(component.trail, {x = transform.position.x, y = transform.position.y, rotation = transform.rotation})
      end      
    end
    
    function component:Start()
      component.active = true
    end
    
    function component:Stop()
      component.active = false
    end
    
    return component
    
  end
}
