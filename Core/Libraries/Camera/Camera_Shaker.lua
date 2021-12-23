return {
    new = function()
        local Class   = {
            duration  = 0,
            magnitude = 0,
            remaining = 0,
            offset    = Vector2.new()
        }

        -----------
        -- Shake --
        -----------
        function Class:Shake(_pMagnitude, _pDuration)
            if(_pMagnitude > self.remaining) then
                self.magnitude = _pMagnitude
                self.remaining = _pMagnitude
                self.duration  = _pDuration
            end
        end

        ------------
        -- Update --
        ------------
        function Class:Update(dt)
            if(self.remaining > 0) then
                self.offset:Set(
                    math.random(-self.remaining, self.remaining),
                    math.random(-self.remaining, self.remaining)
                )
                self.remaining = math.max(0, self.remaining - ((1/self.duration) * self.magnitude))
                if(self.remaining <= 0) then self.offset:Set(0, 0) end
            end
        end       

        return Class
    end
}