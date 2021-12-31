return {
  new = function()
    local f_controller = Locator:Get_Service("f_controller")
    local component    = f_controller.new()
        
    local an = "animator"

    local expired = false

    ------------------
    -- On_Update --
    ------------------
    function component:On_Update(dt)
        if(expired) then return end
        local animator = self.gameObject:Get_Component(an)
        if(animator == nil or animator.currentAnimation == nil) then return end
        if(animator.currentAnimation.finished) then self.gameObject:Destroy() expired = true end        
    end
    
    return component
  end
}