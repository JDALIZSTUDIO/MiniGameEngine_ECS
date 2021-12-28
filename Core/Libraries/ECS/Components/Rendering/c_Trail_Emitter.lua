return {
  new = function(_pMaxTrail)
    local f_component      = Locator:Get_Service("f_component")
    local component        = f_component.new("trailEmitter")
          component.active = true
          component.trail  = {}
          component.maxT   = _pMaxTrail or 50
    
    local insert = table.insert
    local remove = table.remove

    function component:Update(dt, _pEntity)
      if(component.active) then
        local transform = _pEntity:Get_Component("transform")
        local length = #component.trail
        if(length > component.maxT) then remove(component.trail, 1) end
        insert(component.trail, {x = transform.position.x, y = transform.position.y, rotation = transform.rotation})
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
