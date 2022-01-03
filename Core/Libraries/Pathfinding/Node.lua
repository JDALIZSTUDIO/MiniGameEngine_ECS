return {
    new = function(_pX, _pY, _pCost)
        local node   = {
            cost     = _pCost or 9999,
            position = {
                x = _pX,
                y = _pY
            }
        }
    end
}