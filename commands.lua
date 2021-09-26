require("util")
commands = {}

--commands.help = require("commands/help")

--commands.upgrade = require("commands/upgrade")
--commands.downgrade = require("commands/downgrade")
--commands.concertMode = require("commands/concertMode")

commands.prefix = require("commands/prefix")
-- commands.donate = require("commands/donate")
-- commands.reason = require("commands/reason")

commands.lua = require("/commands/luaExec")
-- commands.lockChannel = require("/commands/lockChannel")
-- commands.team = require("/commands/team")
-- commands.nick = require("/commands/nick")

-- commands.play = require("/commands/music/play")
-- commands.stop = require("/commands/music/stop")

-- commands.startRadio = require("/commands/music/startRadio")
-- commands.pauseRadio = require("/commands/music/pauseRadio")
-- commands.resumeRadio = require("/commands/music/resumeRadio")
-- commands.stopRadio = require("/commands/music/stopRadio")
-- commands.disconnect = require("/commands/music/disconnect")

-- commands.voiceClip = require("/commands/voiceClip")

commands.createTeam = require("/commands/createTeam")
commands.invite = require("/commands/invite")

return commands