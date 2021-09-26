local spawn = require('coro-spawn')
local split = require('coro-split')
local parse = require('url').parse
local discordia = require('discordia')
local json = require('json')
local http = require('http')

local client = discordia.Client()
local connection
local msg = ''
local channel
local playingURL = ''
local playingTrack = 0

if not args[2] then
  print("Please specify a token.")
  os.exit()
end

local function getStream(url)

  local child = spawn('youtube-dl', {
    args = {'-g', url},
    stdio = {nil, true, true}
  })

  local stream
  local function readstdout()
    local stdout = child.stdout
    for chunk in stdout.read do
      local mime = parse(chunk, true).query.mime
      if mime then
        if type(mime) == 'table' then
          for _, m in pairs(mime) do
            if m:find('audio') then
              stream = chunk
              break
            end
          end
        else
          if mime:find('audio') then
            stream = chunk
          end
        end
      end
    end
    return pcall(stdout.handle.close, stdout.handle)
  end

  local function readstderr()
    local stderr = child.stderr
    for chunk in stderr.read do
      print(chunk)
    end
    return pcall(stderr.handle.close, stderr.handle)
  end

  split(readstdout, readstderr, child.waitExit)

  return stream and stream:gsub('%c', '')
end

local function getPlaylistStream(url, number)
  local child = spawn('youtube-dl', {
    args = {'-g', '--playlist-items', number, url},
    stdio = {nil, true, true}
  })

  local stream
  local function readstdout()
    local stdout = child.stdout
    for chunk in stdout.read do
      local mime = parse(chunk, true).query.mime
      if mime then
        if type(mime) == 'table' then
          for _, m in pairs(mime) do
            if m:find('audio') then
              stream = chunk
              break
            end
          end
        else
          if mime:find('audio') then
            stream = chunk
          end
        end
      end
    end
    return pcall(stdout.handle.close, stdout.handle)
  end

  local function readstderr()
    local stderr = child.stderr
    for chunk in stderr.read do
      print(chunk)
    end
    return pcall(stderr.handle.close, stderr.handle)
  end

  split(readstdout, readstderr, child.waitExit)

  return stream and stream:gsub('%c', '')
end

local function len(tbl)
  local count = 0
  for k,v in pairs(tbl) do
    count = count + 1
  end
  return count
end

local streamPlaylist = coroutine.wrap(function(url, beginWith)
  local child = spawn('youtube-dl', {
    args = {'-J', url},
  })
  stdio = {nil, true, true}
  local playlist = json.decode(child.stdout:read())
  connection = channel:join()
  if connection then
    p('Connected')
    for playingTrack = beginWith or 1, len(playlist.entries) do
      local stream = getPlaylistStream(url, playingTrack)
      print('Playing track '..playingTrack..' of '..len(playlist.entries))
      connection:playFFmpeg(stream)
    end
  end
end)

client:on('ready', function()
  p('Logged in as ' .. client.user.username)
  channel = client:getChannel('787994393973096478') -- voice channel ID goes here
  assert(channel and channel.type == discordia.enums.channelType.voice, 'couldn\'t find channel or channel was not a voice channel')
end)

client:on('messageCreate', function(message)
  print(os.date('!%Y-%m-%d %H:%M:%S', message.createdAt).. ' <'.. message.author.name.. '> '.. message.content) --Screen output
  if message.author.id ~= client.user.id then --If not himself
    msg = message
    if string.find(msg.content, 'audio%.play ') then
      connection = channel:join()
      if connection then
        print('connected')
        playingURL = string.gsub(msg.content, 'audio%.play ', '')
        local stream = getStream(playingURL) -- URL goes here
        print('playing')
        connection:playFFmpeg(stream)
      end
    elseif string.find(msg.content, 'audio%.playlist ') then
      playingURL = string.gsub(msg.content, 'audio%.playlist ', '')
      streamPlaylist(playingURL, 2)
    elseif msg.content == 'audio.pause' then
      connection:pauseStream()
    elseif msg.content == 'audio.resume' then
      connection:resumeStream()
    elseif msg.content == 'audio.skip' then
      print('stopping')
      connection:stopStream()
    elseif msg.content == 'audio.leave' then
      print('leaving')
      connection:close()
    end
  end
end)

client:run("Bot " .. args[2])
