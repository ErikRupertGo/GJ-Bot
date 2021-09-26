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