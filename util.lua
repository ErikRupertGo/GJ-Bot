local json = require('/deps/json')
--local fs = require('/deps/fs')

--Ripped off from https://www.codegrepper.com/code-examples/lua/lua+split+string+into+table
function Split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function existsInArray(_table, object)
    for i, v in pairs(_table) do
        if object == v then
            return true, i
        end
    end
    return false, nil
end

function replyToMessage(message, content)

    message:reply { 
        content = content,
        reference = {
            message = message
        }
    }
    
end

local gorgonzola

function updateJSON(object)
   
    fs.writeFileSync("data.json", json.encode(guildCollection))
end

function getJSONObject()

    return json.decode(fs.readFileSync("mrpoopybutthole.json"))
end