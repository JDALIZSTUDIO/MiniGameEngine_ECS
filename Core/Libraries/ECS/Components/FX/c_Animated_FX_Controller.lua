return {
    new = function()
        local f_controller = Locator:Get_Service("f_controller")
        local component    = f_controller.new()
                
        local an   = "animator"
        local lerp = Lerp

        ------------------
        -- On_Update --
        ------------------
        function component:On_Update(dt)  
            local animator = self.gameObject:Get_Component(an)
            local current  = animator.currentAnimation
            if(animator.currentFrame >= (#current.quadData * 0.5)) then
                animator.alpha = lerp(animator.alpha, 0, 0.1)
            end
        end

        return component
    end
  }