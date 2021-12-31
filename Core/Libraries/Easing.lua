return {
    new = function()
        local abs  = math.abs     
        local asin = math.asin
        local cos  = math.cos
        local pi   = math.pi
        local pow  = math.pow
        local sin  = math.sin
        local sqrt = math.sqrt

        ------------
        -- linear --
        ------------
        local function linear(t, b, c, d)
            return c*t/d + b
        end

        ----------------
        -- easeInQuad --
        ----------------
        local function easeInQuad(t, b, c, d)
            t = t / d
            return c*t*t + b
        end

        -----------------
        -- easeOutQuad --
        -----------------
        local function easeOutQuad(t, b, c, d)
            t = t / d
            return -c * t*(t-2) + b
        end

        -------------------
        -- easeInOutQuad --
        -------------------
        local function easeInOutQuad(t, b, c, d)
            t = t / d/2
            if (t < 1) then return c/2*t*t + b end
            t = t - 1
            return -c/2 * (t*(t-2) - 1) + b
        end

        -----------------
        -- easeInCubic --
        -----------------
        local function easeInCubic(t, b, c, d)
            t = t / d
            return c*t*t*t + b
        end
    
        ------------------
        -- easeOutCubic --
        ------------------
        local function easeOutCubic(t, b, c, d)
            t = t / d
            t = t - 1
            return c*(t*t*t + 1) + b
        end

        --------------------
        -- easeInOutCubic --
        --------------------
        local function easeInOutCubic(t, b, c, d)
            t = t / d/2
            if (t < 1) then return c/2*t*t*t + b end
            t = t - 2
            return c/2*(t*t*t + 2) + b
        end

        -----------------
        -- easeInQuart --
        -----------------
        local function easeInQuart(t, b, c, d)
            t = t / d
            return c*t*t*t*t + b
        end

        ------------------
        -- easeOutQuart --
        ------------------
        local function easeOutQuart(t, b, c, d)
            t = t / d
            t = t - 1
            return -c * (t*t*t*t - 1) + b
        end

        --------------------
        -- easeInOutQuart --
        --------------------
        local function easeInOutQuart(t, b, c, d)
            t = t / d/2
            if (t < 1) then return c/2*t*t*t*t + b end
            t = t - 2
            return -c/2 * (t*t*t*t - 2) + b
        end

        -----------------
        -- easeInQuint --
        -----------------
        local function easeInQuint(t, b, c, d)
            t = t / d
            return c*t*t*t*t*t + b
        end

        ------------------
        -- easeOutQuint --
        ------------------
        local function easeOutQuint(t, b, c, d)
            t = t / d
            t = t - 1
            return c*(t*t*t*t*t + 1) + b
        end

        --------------------
        -- easeInOutQuint --
        --------------------
        local function easeInOutQuint(t, b, c, d)
            t = t / d/2
            if (t < 1) then return c/2*t*t*t*t*t + b end
            t = t - 2
            return c/2*(t*t*t*t*t + 2) + b
        end

        ----------------
        -- easeInSine --
        ----------------
        local function easeInSine(t, b, c, d)
            return -c * cos(t/d * (pi/2)) + c + b
        end

        -----------------
        -- easeOutSine --
        -----------------
        local function easeOutSine(t, b, c, d)
            return c * sin(t/d * (pi/2)) + b
        end

        -------------------
        -- easeInOutSine --
        -------------------
        local function easeInOutSine(t, b, c, d)
            return -c/2 * (cos(pi*t/d) - 1) + b
        end

        ----------------
        -- easeInExpo --
        ----------------
        local function easeInExpo(t, b, c, d)
            return c * pow( 2, 10 * (t/d - 1) ) + b
        end

        -----------------
        -- easeOutExpo --
        -----------------
        local function easeOutExpo(t, b, c, d)
            return c * ( -pow( 2, -10 * t/d ) + 1 ) + b
        end

        -------------------
        -- easeInOutExpo --
        -------------------
        local function easeInOutExpo(t, b, c, d)
            t = t / d/2
            if (t < 1) then return c/2 * pow( 2, 10 * (t - 1) ) + b end
            t = t - 1
            return c/2 * ( -pow( 2, -10 * t) + 2 ) + b
        end

        ----------------
        -- easeInCirc --
        ----------------
        local function easeInCirc(t, b, c, d)
            t = t / d
            return -c * (sqrt(1 - t*t) - 1) + b
        end

        -----------------
        -- easeOutCirc --
        -----------------
        local function easeOutCirc(t, b, c, d)
            t = t / d
            t = t - 1
            return c * sqrt(1 - t*t) + b
        end

        -------------------
        -- easeInOutCirc --
        -------------------
        local function easeInOutCirc(t, b, c, d)
            t = t / d/2
            if (t < 1) then return -c/2 * (sqrt(1 - t*t) - 1) + b end
            t = t - 2
            return c/2 * (sqrt(1 - t*t) + 1) + b
        end

        -------------------
        -- easeInElastic --
        -------------------
        local function easeInElastic(t, b, c, d, a, p)
            if t == 0 then return b end

            t = t / d

            if t == 1  then return b + c end

            if not p then p = d * 0.3 end

            local s

            if not a or a < abs(c) then
                a = c
                s = p / 4
            else
                s = p / (2 * pi) * asin(c/a)
            end

            t = t - 1

            return -(a * pow(2, 10 * t) * sin((t * d - s) * (2 * pi) / p)) + b
        end

        local Class = {
            linear         = linear,
            easeInQuad     = easeInQuad,
            easeOutQuad    = easeOutQuad,
            easeInOutQuad  = easeInOutQuad,
            easeInCubic    = easeInCubic,
            easeOutCubic   = easeOutCubic,
            easeInOutCubic = easeInOutCubic,
            easeInQuart    = easeInQuart,
            easeOutQuart   = easeOutQuart,
            easeInOutQuart = easeInOutQuart,
            easeInQuint    = easeInQuint,
            easeOutQuint   = easeOutQuint,
            easeInOutQuint = easeInOutQuint,
            easeInSine     = easeInSine,
            easeOutSine    = easeOutSine,
            easeInOutSine  = easeInOutSine,
            easeInExpo     = easeInExpo,
            easeOutExpo    = easeOutExpo,
            easeInOutExpo  = easeInOutExpo,
            easeInCirc     = easeInCirc,
            easeOutCirc    = easeOutCirc,
            easeInOutCirc  = easeInOutCirc,
            easeInElastic  = easeInElastic
        }        
        
        function Class:New_Auto_Tween(_pFunc, _pStart, _pTarget, _pDuration)
            local tween = {
                duration = _pDuration or 1,
                finshed  = false,
                func     = _pFunc,
                start    = _pStart  or 0,
                target   = _pTarget or 0,
                time     = 0,
            }
    
            function tween:Get_Value(_pTime)
                if(self.time >= self.duration) then
                    self.time     = self.duration
                    self.finished = true
                end
                return self.func(_pTime, self.start, (self.target - self.start), self.duration)
            end
            return tween
        end

        function Class:New_Tween(_pFunc, _pStart, _pTarget, _pDuration)
            local tween = {
                duration = _pDuration or 1,
                finshed  = false,
                func     = _pFunc,
                start    = _pStart  or 0,
                target   = _pTarget or 0,
                time     = 0,
            }
    
            function tween:Get_Value()
                return self.func(self.time, self.start, (self.target - self.start), self.duration)
            end

            function tween:Update(dt)
                if(not self.finished) then
                    self.time = self.time + dt
                    if(self.time >= self.duration) then
                        self.time     = self.duration
                        self.finished = true
                    end
                end
            end

            return tween
        end

        return Class
    end 
}