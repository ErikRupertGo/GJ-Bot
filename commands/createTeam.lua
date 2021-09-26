local createTeam = {}

createTeam.teams = {}

function createTeam:exec(message)
    local teamName = string.match(message.content, '\".+\"')
    teamName = string.sub(teamName, 2, #teamName - 1)

    if not teamName then 
        replyToMessage(message, "Please put double quotes in your team name")
        return
    end

    replyToMessage(message, "Please wait for a few moments while I create your channels")

    -- Creating a role then adding it to teams array
    local role = message.guild:createRole(teamName)
    table.insert(self.teams, role.id)

    -- Moves it up from verified role and solo jammer
    role:moveUp(1)

    -- Creating Category
    local category = message.guild:createCategory(teamName)
    
    -- Perms
    local permsOverwrite = nil
     -- @everyone
    permsOverwrite = category:getPermissionOverwriteFor(message.guild.defaultRole)
    permsOverwrite:denyPermissions(commands.enums.permission.readMessages)

    -- Moderator
    permsOverwrite = category:getPermissionOverwriteFor(message.guild:getRole('890830458785505296'))
    permsOverwrite:allowPermissions(commands.enums.permission.readMessages)

    -- Judge
    permsOverwrite = category:getPermissionOverwriteFor(message.guild:getRole('890830458785505295'))
    permsOverwrite:allowPermissions(commands.enums.permission.readMessages)

    -- Press Corps
    permsOverwrite = category:getPermissionOverwriteFor(message.guild:getRole('890830458785505294'))
    permsOverwrite:allowPermissions(commands.enums.permission.readMessages)

    -- Team
    permsOverwrite = category:getPermissionOverwriteFor(role)
    permsOverwrite:allowPermissions(commands.enums.permission.readMessages,
                                    commands.enums.permission.manageChannels
                                    )

    -- Channel Creation
    category:createTextChannel("team-chat")
    category:createVoiceChannel("Team Voice")

    -- Adds the team role to the author and the mentioned users
    message.member:addRole(role)
    message.mentionedUsers:forEach(function(user)
        local member = message.guild:getMember(user.id)
        member:addRole(role)
    end)

    replyToMessage(message, "Category Created")

end

return setmetatable(createTeam, {__index = self})