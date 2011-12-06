local chapter = {}
local talk1 = Talk()
function talk.on_start()
   play_sound(1)
end
function talk1.on_end()
   stop_sound(1)
end

local action2 = Choice()
talk1.next = action2
chapter.actions = {talk1, action2}

