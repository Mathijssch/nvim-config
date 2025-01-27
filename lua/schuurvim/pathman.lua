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

function FileExists(path)
    local file = io.open(path, "r")
    if file then
        io.close(file)
        return true
    else
        return false
    end
end

function CreateFile(path)
    vim.cmd(string.format("silent !touch %s", path))
end

function NewFile(input)
    if FileExists(input) then
        vim.cmd.edit(input)
        return
    end

    local dir, file = SplitPath(input)
    print(dir, file)
    if dir ~= nil then
        vim.cmd(string.format("silent !mkdir -p %s", dir))
    end
    vim.cmd.edit(input)
    --vim.Open(input)
end

vim.api.nvim_create_user_command('Open', function()
    local file = vim.fn.expand('<cfile>')
    local dir = vim.fn.expand('%:h')
    local command
    if file:sub(1, 1) == '/' then
        command = file               -- absolute path
    else
        command = dir .. '/' .. file -- relative path
    end

    local uname = vim.loop.os_uname()
    if uname.sysname == 'Darwin' then
        vim.notify('Opening ' .. command)
        os.execute('open ' .. command)
    else
        vim.notify('Using xdg-open on ' .. command)
        os.execute('xdg-open ' .. command)
    end
end, {})

vim.api.nvim_create_user_command('ODir', function()
    local file = vim.fn.expand('<cfile>')
    local dir = vim.fn.expand('%:h')
    local command
    if file:sub(1, 1) == '/' then
        command = file               -- absolute path
    else
        command = dir .. '/' .. file -- relative path
    end
    command = command:match([[(.*/)]])
    local uname = vim.loop.os_uname()
    if uname.sysname == 'Darwin' then
        vim.notify('Opening ' .. command)
        os.execute('open ' .. command)
    else
        vim.notify('Using xdg-open on ' .. command)
        os.execute('xdg-open ' .. command)
    end
end, {})
