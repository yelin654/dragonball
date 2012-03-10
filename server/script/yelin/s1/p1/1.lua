local chapter = new_chapter(1)
local talk1 = new_talk(chapter)
talk1.text = "离去之前叫醒我"
function talk1.on_start()
   play_sound(1)
end
function talk1.on_end()
   stop_sound(1)
end

local talk2 = new_talk(chapter)
talk1.text = 5
function talk2.on_start()
   play_sound(1)
end
function talk2.on_end()
   stop_sound(1)
end

local talk3 = new_talk(chapter)
function talk3.on_start()
   play_sound(1)
end
function talk3.on_end()
   stop_sound(1)
end

local choice1 = new_choice(chapter)
choice1.text = {"A", "B", "C"}
function choice1.on1()
end

function choice1.on2()
end

function choice1.on3()
end

talk1.next = choice1

local choice1 = new_choice(chapter)
talk2.next = choice2

chapter.pre = 1

return chapter
