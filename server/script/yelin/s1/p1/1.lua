local chapter = Chapter(0)
local talk1 = Talk()
talk1.text = "离去之前叫醒我"
function talk1.on_start()
   play_sound(1)
end
function talk1.on_end()
   stop_sound(1)
end

local talk2 = Talk()
talk1.text = "石头在歌唱"
function talk2.on_start()
   play_sound(1)
end
function talk2.on_end()
   stop_sound(1)
end

local talk3 = Talk()
function talk3.on_start()
   play_sound(1)
end
function talk3.on_end()
   stop_sound(1)
end

local choice1 = Choice()
choice1.text = {"A", "B", "C"}
choice1.callback = {}

talk1.next = choice1

local choice1 = Choice()
talk2.next = choice2

chapter.start = talk1

return chapter
