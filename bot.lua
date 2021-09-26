discordia = require('discordia')
client = discordia.Client()
local clock = discordia.Clock()
discordia.extensions()
require("util")

commands = require ("commands")
commands.enums = discordia.enums

-- Getting the token
local tokenFile = io.open("token", "r")
io.input(tokenFile)
local token = io.read()
io.close(tokenFile)

math.randomseed(os.time())

client:on('ready', function()
	commands.lua.extra.client = client
	print("Bot is now online!")
end)

client:on('messageCreate', function(message)
	--if message.author ~= client.owner then return end
	if not message.guild then return end
	if message.author.bot then return end

	local args = Split(message.content, " ")

	if not string.find(args[1], commands.prefix.currentPrefix) then return end
    local cmd = string.sub(args[1], #commands.prefix.currentPrefix + 1)

	if commands[cmd] == nil then return end

	local status, error = pcall(commands[cmd].exec, commands[cmd], message, message.content)
	if status == false then message:reply("```"..error.."```") end

end)

client:run("Bot "..token)

