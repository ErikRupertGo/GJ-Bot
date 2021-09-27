local prefix = {}

prefix.name = "prefix"
prefix.description = [[Changes the prefix of the bot]]
prefix.tag = "General"
prefix.currentPrefix = "."
function prefix:exec(message)
    if not message.member:hasPermission(commands.enums.permission.manageGuild) then return end
    local args = Split(message.content, " ")
    if args[2] == nil then
        replyToMessage(message, "No prefix specified")
        return
    end
    self.currentPrefix = args[2]
    replyToMessage(message, "Prefix changed to "..self.currentPrefix)
end

return setmetatable(prefix, {__index = self})