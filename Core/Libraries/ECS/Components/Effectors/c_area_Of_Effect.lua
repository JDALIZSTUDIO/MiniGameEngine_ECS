return {
    new = function(_pRadius)
      local factory          = Locator:Get_Service("f_component")
      local component        = factory.new("areaOfEffect")
            component.radius = _pRadius or 64      
            
      local tr     = "transform"

      ------------------
      -- Apply_Effect --
      ------------------
      function component:Apply_Effect(_pPosition, _pFunc)
        local others = self.gameObject.ECS:Get_Entities()
        local distance, other, transform
        for i = 1, #others do
          other = others[i]
          if(other ~= nil and 
             other.expired == false) then
            if(other ~= self.gameObject) then
              otherTrans = other:Get_Component(tr)
              if(otherTrans ~= nil) then
                distance   = _pPosition:Distance_To(otherTrans.position)
                if(distance <= self.radius) then
                  _pFunc(other)
                end
              end
            end
          end
        end
      end  
  
      return component  
    end
  }