local chapter = Chapter(1)
local talk1 = Talk(chapter, 1)
talk1.text = "离去之前叫醒我"
function talk1.on_start()
   play_sound(1)
end
function talk1.on_end()
   stop_sound(1)
end

local talk2 = Talk(chapter, 2)
talk1.text = 5
function talk2.on_start()
   play_sound(1)
end
function talk2.on_end()
   stop_sound(1)
end

local talk3 = Talk(chapter, 3)
function talk3.on_start()
   play_sound(1)
end
function talk3.on_end()
   stop_sound(1)
end

local choice1 = Choice(chapter, 4)
choice1.text = {"A", "B", "C"}
function choice1.on1()
end

function choice1.on2()
end

function choice1.on3()
end

talk1.next = choice1

local choice1 = Choice(chapter, 5)
talk2.next = choice2

chapter.pre = 1

return chapter
