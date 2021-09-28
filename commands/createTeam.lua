local createTeam = {}

createTeam.teams = {}

function createTeam:exec(message)
    local teamName = string.match(message.content, '\".+\"')

    if not teamName then 
        replyToMessage(message, "Please put double quotes in your team name")
        return
    end

    teamName = string.sub(teamName, 2, #teamName - 1)

    -- Checks if member has a team already
    for k, v in pairs(self.teams) do
        if message.member:hasRole(k) then
            replyToMessage(message, "You already have a team");
            return;
        end
    end

    replyToMessage(message, "Please wait for a few moments while I create your channels")

    -- Creating a role and adding an array for the role (array inside of array)
    local role = message.guild:createRole(teamName)
    self.teams[role.id] = {}

    -- Hoist
    role:hoist()
    role:enableMentioning()

    -- Moves it up from verified role and solo jammer
    role:moveUp(1)

    -- Creating Category
    local category = message.guild:createCategory(teamName)
    
    -- Stores it in respective array
    self.teams[role.id].category = category.id
    
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
    local textChannel = category:createTextChannel("team-chat")
    local voiceChannel = category:createVoiceChannel("Team Voice")


    -- Adds the team role to the author and the mentioned users
    message.member:addRole(role)
    message.mentionedUsers:forEach(function(user)
        local member = message.guild:getMember(user.id)
        member:addRole(role)
    end)

    replyToMessage(message, "Category Created")

end

return setmetatable(createTeam, {__index = self})