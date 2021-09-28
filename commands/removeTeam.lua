local removeTeam = {}

function removeTeam:exec(message)
    -- Only people with manage guild permission can use this command
    if not message.member:hasPermission(commands.enums.permission.manageGuild) then return end

    -- Checks if there is a role mentioned in the message
    if #message.mentionedRoles == 0 then
        replyToMessage(message, "No roles mentioned")
        return
    end

    -- Iterates in each role mentioned
    message.mentionedRoles:forEach(function(role)

        -- Checks if the role mentioned is in the teams list
        if not commands.createTeam.teams[role.id] then 
            replyToMessage(message, role.name.." is not in the teams list")
            return
        end

        -- Substitution for ease of reading 
        local roleTable = commands.createTeam.teams[role.id]

        -- Sets category variable
        local category = message.client:getChannel(roleTable.category)

        -- Iterates each text channel in the category
        category.textChannels:forEach(function(tChannel)
            tChannel:delete()
        end)

        -- Iterates each voice channel in the category
        category.voiceChannels:forEach(function(vChannel)
            vChannel:delete()
        end)

        -- Deletes the category
        category:delete()

        -- Deletes the role and clears it in the teams list
        role:delete()
        commands.createTeam.teams[role.id] = nil
    end)

    replyToMessage(message, "Teams deleted")
end

return setmetatable(removeTeam, {__index = self})