-- Code copied from Discordia Wiki, but with slight modifications
local lua = {}
local sandbox = {
    discordia = discordia,
    client = client,

    commands = commands,
}
setmetatable(sandbox, { __index = _G })
local prefix = "="

local function printLine(...)
    local ret = {}
    for i = 1, select('#', ...) do
        local arg = tostring(select(i, ...))
        table.insert(ret, arg)
    end
    return table.concat(ret, '\t')
end

lua.name = "lua"
lua.description = "Executes lua script"
lua.tag = "Power"
lua.parse = function(message)

    local script = nil
    script = string.sub(message, #commands.prefix.currentPrefix + 8, #message - 3)
    return script

end

local codeBlock = function(message) return string.format("```\n%s```", message) end

lua.exec = function(self, message, content)
    local code = lua.parse(message.content)

    if not code then
        message:reply("No code block given")
        return
    end
    if message.author ~= message.client.owner then
        message:reply("You are not the bot owner. so fuck off")
        return
    end

    local lines = {} -- Line collection
    
    sandbox.message = message

    sandbox.print = function(...) -- intercept printed lines with this
        table.insert(lines, printLine(...))
    end

    -- Syntax errors
    local fn, syntaxError = load(code, 'FG Lua', 't', sandbox) -- load the code
    if not fn then return message:reply(codeBlock(syntaxError)) end -- handle syntax errors

    -- Runtime errors
    local success, runtimeError = pcall(fn) -- run the code
    if not success then return message:reply(codeBlock(runtimeError)) end -- handle runtime errors

    lines = table.concat(lines, '\n')

    if #lines > 1990 then -- truncate long messages
        lines = lines:sub(1, 1990)
    end
    
    return replyToMessage(message, codeBlock(lines))

end

return lua