local factory  = require('Core/Libraries/ECS/Components/Controllers/c_Parent_Controller')

return {
  new = function()
    local component = factory.new()
        
    local an = "animator"

    local expired = false

    ------------------
    -- Update_Logic --
    ------------------
    function component:Update_Logic(dt)
        if(expired) then return end
        local animator = self.gameObject:Get_Component(an)
        if(animator == nil or animator.currentAnimation == nil) then return end
        if(animator.currentAnimation.finished) then self.gameObject:Destroy() expired = true end        
    end
    
    return component
  end
}