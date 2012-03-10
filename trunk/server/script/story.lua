package.path = "script/?.lua;;"

--require "lfs"
require "log"
require "util"

ACTION_GEN = 0
ACTION_TALK = 1
ACTION_CHOICE = 2
ACTION_SOUND = 3
ACTION_GUIDE = 4

storys = {}

function new_story(idx)
   local s = {}
   s.idx = idx
   s.spaces = {}
   return s
end

function new_space(idx)
   local s = {}
   s.idx = idx
   s.chapters = {}
   return s
end

function new_chapter(idx)
   local c = {}
   c.idx = idx
   c.actions = {}
   c.acc_idx = 1
   c.start = new_action(c, ACTION_GEN)
   return c
end


function on_action_start()end
function on_action_end()end

function link(pre, next)
   table.insert(pre.nexts, next)
end

function new_action(c, type)
   local a = {}

   a.idx = c.acc_idx
   a.type = type
   a.on_start = on_action_start
   a.on_end = on_action_end

   c.acc_idx = c.acc_idx + 1
   c.actions[a.idx] = a

   return a
end

function new_talk(c)
   return new_action(c, ACTION_TALK)
end

function new_choice(c)
   return new_action(c, ACTION_CHOICE)
end

function new_sound(c)
   return new_action(c, ACTION_SOUND)
end

function new_guide(c)
   return new_action(c, ACTION_GUIDE)
end

function load_story(name, idx)
   local root = "script/"..name.."/s"..idx.."/"
   local file = root.."meta.lua"
   D("to load "..file)
   local meta = dofile(file)
   local space
   local chapter
   local spr
   local fullname
   local story = new_story(idx)
   storys[idx] = story
   local pre
   for i, spaceid in ipairs(meta.spaces) do
      space = new_space(spaceid)
      story.spaces[spaceid] = space
      spr = root.."p"..spaceid.."/"
      for key, file in ipairs(meta.chapters) do
         --if string.match(file, "%.lua$") then
            fullname = spr..file..".lua"
            D("to load chapter file("..fullname..")")
            chapter = dofile(fullname)
            D("load chapter("..chapter.idx..")")
            space.chapters[chapter.idx] = chapter
         --end
      end
      for id, chapter in pairs(space.chapters) do
         if chapter.pre ~= nil then
            pre = space.chapters[id]
            pre.next = chapter
         end
      end
   end
end

-- for file in lfs.dir("script/yelin/s1/p1") do
--    if string.match(file, "%.lua$") then
--       D(file)
--    end
-- end

function lua_update_progress(story_idx, space_idx, chapter_idx, action_idx)
   progress.story_idx = story_idx
   progress.space_idx = space_idx
   progress.chapter_idx = chapter_idx
   progress.action_idx = action_idx
end

function update_progress(progress)
   c_update_progress(progress.story_idx, progress.space_idx, progress.chapter_idx, progress.action_idx)
end

function action_on_start()
   local action = find_action(progress)
   action.on_start()
end

function find_action(progress)
   local chapter = find_chapter(progress)
   return chapter[progress.action_idx]
end

function find_chapter(progress)
   return storys[progress.story_idx].spaces[progress.space_idx].chapters[progress.chapter_idx]
end

progress = {}
progress.story_idx = 0
progress.space_idx = 0
progress.chapter_idx = 0
progress.action_idx = 0

function next_action()
   local action = find_action(progress)
   local chapter
   action.on_end()
   action = action.next
   if action ~= nil then
      progress.action_idx = action.idx
      update_progress(progress)
      action.on_start()
   else
      chapter = find_chapter(progress)
      if chapter.next ~= nil then
         chapter = chapter.next
         progress.action_idx = 1
         progress.chapter_idx = chapter.idx
         update_progress(progress)
         do_action(chapter.actions[1])
      else

      end
   end
end

function find_story(idx)
   return storys[idx]
end

function start_story(idx)
   progress.story_idx = idx
   progress.space_idx = 1
   progress.chapter_idx = 0
   local c = find_chapter(progress)
   progress.action_idx = c.start.idx
   --update_progress(progress)
   do_action(c.start)
   D("start story", idx)
end

function do_gen(action)

end

function play_talk(action)
   if type(action.text) == "string" then
      play_talk_text(action.text)
   else
      play_talk_id(action.id)
   end
end

function play_choice(action)

end

function play_sound(sound)
   c_rpc("play_sound", {sound})
end

function play_guide(guide)
   c_rpc("play_guide", {guide})
end

do_vt = {}
do_vt[ACTION_GEN] = do_gen
do_vt[ACTION_TALK] = play_talk
do_vt[ACTION_CHOICE] = play_choice
do_vt[ACTION_SOUND] = play_sound
do_vt[ACTION_GUIDE] = play_guide

function do_action(action)
   D("do action, type("..action.type..")")
   do_vt[action.type](action)
   action.on_start()
end

function on_choose(id)
   local action = find_action(progress)
   action["on"..id]()
end

function get_story_list(name)
   local root = "script/"..name.."/"
   local meta
   local metaname
   local result = {}
   -- for file in lfs.dir(root) do
   --    if string.match(file, "^s") then
   --       metaname = root..file.."/meta.lua"
   --       D("start load meta file("..metaname..")")
   --       meta = dofile(metaname)
   --       D("finish load meta file("..metaname..")")
   --       result[meta.idx] = meta.name
   --    end
   -- end
   return result
end

--get_story_list("yelin")
load_story("yelin", 1)
