local invite = {}

function invite:exec(message)

    local mentionedUsers = message.mentionedUsers

    -- Checks if there are mentioned users in message
    if not (#mentionedUsers > 0) then replyToMessage(message, "No users specified"); return end

    local roleId = nil
    -- Checks if the message author is in a team
    for k, v in pairs(commands.createTeam.teams) do
        if message.member:hasRole(k) then
            roleId = k
            break;
        end
    end

    if not roleId  then replyToMessage(message, "You don't have a team") return end

    -- Adds the team role to the mentioned users
    message.mentionedUsers:forEach(function(user)
        local member = message.guild:getMember(user.id)
        member:addRole(roleId)
    end)

    replyToMessage(message, "Users are now in your team")
end

return setmetatable(invite, {__index = self})