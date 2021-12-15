return {
    new = function()
        local easing = {}
        
        ------------
        -- linear --
        ------------
        function easing:linear(t, b, c, d)
            return c*t/d + b
        end

        ----------------
        -- easeInQuad --
        ----------------
        function easing:easeInQuad(t, b, c, d)
            t = t / d
            return c*t*t + b
        end

        -----------------
        -- easeOutQuad --
        -----------------
        function easing:easeOutQuad(t, b, c, d)
            t = t / d
            return -c * t*(t-2) + b
        end

        -------------------
        -- easeInOutQuad --
        -------------------
        function easing:easeInOutQuad(t, b, c, d)
            t = t / d/2
            if (t < 1) then return c/2*t*t + b end
            t = t - 1
            return -c/2 * (t*(t-2) - 1) + b
        end

        -----------------
        -- easeInCubic --
        -----------------
        function easing:easeInCubic(t, b, c, d)
            t = t / d
            return c*t*t*t + b
        end
    
        ------------------
        -- easeOutCubic --
        ------------------
        function easing:easeOutCubic(t, b, c, d)
            t = t / d
            t = t - 1
            return c*(t*t*t + 1) + b
        end

        --------------------
        -- easeInOutCubic --
        --------------------
        function easing:easeInOutCubic(t, b, c, d)
            t = t / d/2
            if (t < 1) then return c/2*t*t*t + b end
            t = t - 2
            return c/2*(t*t*t + 2) + b
        end

        -----------------
        -- easeInQuart --
        -----------------
        function easing:easeInQuart(t, b, c, d)
            t = t / d
            return c*t*t*t*t + b
        end

        ------------------
        -- easeOutQuart --
        ------------------
        function easing:easeOutQuart(t, b, c, d)
            t = t / d
            t = t - 1
            return -c * (t*t*t*t - 1) + b
        end

        --------------------
        -- easeInOutQuart --
        --------------------
        function easing:easeInOutQuart(t, b, c, d)
            t = t / d/2
            if (t < 1) then return c/2*t*t*t*t + b end
            t = t - 2
            return -c/2 * (t*t*t*t - 2) + b
        end

        -----------------
        -- easeInQuint --
        -----------------
        function easing:easeInQuint(t, b, c, d)
            t = t / d
            return c*t*t*t*t*t + b
        end

        ------------------
        -- easeOutQuint --
        ------------------
        function easing:easeOutQuint(t, b, c, d)
            t = t / d
            t = t - 1
            return c*(t*t*t*t*t + 1) + b
        end

        --------------------
        -- easeInOutQuint --
        --------------------
        function easing:easeInOutQuint(t, b, c, d)
            t = t / d/2
            if (t < 1) then return c/2*t*t*t*t*t + b end
            t = t - 2
            return c/2*(t*t*t*t*t + 2) + b
        end

        ----------------
        -- easeInSine --
        ----------------
        function easing:easeInSine(t, b, c, d)
            return -c * math.cos(t/d * (math.pi/2)) + c + b
        end

        -----------------
        -- easeOutSine --
        -----------------
        function easing:easeOutSine(t, b, c, d)
            return c * math.sin(t/d * (math.pi/2)) + b
        end

        -------------------
        -- easeInOutSine --
        -------------------
        function easing:easeInOutSine(t, b, c, d)
            return -c/2 * (math.cos(math.pi*t/d) - 1) + b
        end

        ----------------
        -- easeInExpo --
        ----------------
        function easing:easeInExpo(t, b, c, d)
            return c * math.pow( 2, 10 * (t/d - 1) ) + b
        end

        -----------------
        -- easeOutExpo --
        -----------------
        function easeOutExpo(t, b, c, d)
            return c * ( -math.pow( 2, -10 * t/d ) + 1 ) + b
        end

        -------------------
        -- easeInOutExpo --
        -------------------
        function easeInOutExpo(t, b, c, d)
            t = t / d/2
            if (t < 1) then return c/2 * math.pow( 2, 10 * (t - 1) ) + b end
            t = t - 1
            return c/2 * ( -math.pow( 2, -10 * t) + 2 ) + b
        end

        ----------------
        -- easeInCirc --
        ----------------
        function easeInCirc(t, b, c, d)
            t = t / d
            return -c * (math.sqrt(1 - t*t) - 1) + b
        end

        -----------------
        -- easeOutCirc --
        -----------------
        function easeOutCirc(t, b, c, d)
            t = t / d
            t = t - 1
            return c * math.sqrt(1 - t*t) + b
        end

        -------------------
        -- easeInOutCirc --
        -------------------
        function easeInOutCirc(t, b, c, d)
            t = t / d/2
            if (t < 1) then return -c/2 * (Math.sqrt(1 - t*t) - 1) + b end
            t = t - 2
            return c/2 * (math.sqrt(1 - t*t) + 1) + b
        end

        return easing
    end 
}