function SplitPath(path)
    if string.len(path) == 0 then
        error("Given path was empty")
    end
    local pathrev = string.reverse(path)
    local fslashidx = string.find(pathrev, "/")
    local bslashidx = string.find(pathrev, "\\")
    local diridx = nil
    if fslashidx == nil and bslashidx == nil then
        return nil, path
    end
    -- either fslashidx of bslashidx is not nil

    if fslashidx == nil then     -- bslashidx is not nil
        diridx = bslashidx
    elseif bslashidx == nil then -- fslashidx is not nil
        diridx = fslashidx
    else                         -- both are not nil, just take the earliest.
        diridx = math.min(fslashidx, bslashidx)
    end

    if diridx == 0 then
        error("File path cannot end with a path separator")
    end
    diridx = string.len(path) - diridx

    return path:sub(0, diridx), path:sub(diridx + 2)
end
