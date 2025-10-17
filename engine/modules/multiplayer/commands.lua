local commands = {}
-- Серверные команды

commands.list = {"say"}

function commands.say(text)
    return text
end

return commands