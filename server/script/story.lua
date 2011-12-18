package.path = "script/?.lua;;"

require "log"
require "lfs"

ACTION_GEN = 0
ACTION_TALK = 1
ACTION_CHOICE = 2
ACTION_SOUND = 3

storys = {}

function add_story(idx)
   storys[idx] = {}
   D("add Story", idx)
end

function add_timeline(story_idx, timeline_idx)
   local story = storys[story_idx]
   story[timeline_idx] = {}
   D("add TimeLine", story_idx.."/"..timeline_idx)
end

function add_timeslice(story_idx, timeline_idx, timeslice_idx, func)
   local story = storys[story_idx]
   local timeline =  story[timeline_idx]
   timeline[timeslice_idx] = func
   D("add TimeSlice", story_idx.."/"..timeline_idx.."/", func)
end

function excute_timeslice(story_idx, timeline_idx, slice_idx)
   local story = storys[story_idx]
   local timeline =  story[timeline_idx]
   local slice = timeline[slice_idx]
end

function Story(idx)
   local s = {}
   s.idx = idx
   s.spaces = {}
   return s
end

function Space(idx)
   local s = {}
   s.idx = idx
   s.chapters = {}
   return s
end

function Chapter(idx)
   local c = {}
   c.idx = idx
   c.actions = {}
   return c
end

function Talk(c, idx)
   local a = Action(c, idx)
   a.type = ACTION_TALK
   return a
end

function Choice(c, idx)
   local a =  Action(c, idx)
   a.type = ACTION_CHOICE
   return a
end

function Sound(c, idx)
   local a =  Action(c, idx)
   a.type = ACTION_SOUND
   return a
end

function Action(c, idx)
   local a = {}
   a.idx = idx
   a.type = ACTION_GEN
   c.actions[idx] = a
   return a
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
   local story = Story(idx)
   storys[idx] = story
   for i, spaceid in ipairs(meta.spaces) do
      space = Space(spaceid)
      story.spaces[spaceid] = space
      spr = root.."p"..spaceid.."/"
      for file in lfs.dir(spr) do
         if string.match(file, "%.lua$") then
            fullname = spr..file
            D("to load chapter file("..fullname..")")
            chapter = dofile(fullname)
            D("load chapter("..chapter.idx..")")
            space.chapters[chapter.idx] = chapter
         end
      end
   end
end

-- for file in lfs.dir("script/yelin/s1/p1") do
--    if string.match(file, "%.lua$") then
--       D(file)
--    end
-- end

load_story("yelin", 1)

function action_on_start(story_idx, space_idx, chapter_idx, action_idx)
   local action = find_action(story_idx, space_idx, chapter_idx, action_idx)
   action.on_start()
end

function find_action(story_idx, space_idx, chapter_idx, action_idx)

end

function find_story(idx)
   return storys[idx]
end

function start_story(idx)
   local story = find_story(idx)
   local cpt = story.spaces[1].chapters[1]
   local action = cpt.start
end

function do_gen(action)

end

function do_talk(action)
   if type(action.text == "string") then
      play_talk_text(action.text)
   else
      play_talk_id(action.id)
   end
end

function do_choice(action)

end

function do_sound_action(action)
end

do_vt[ACTION_GEN] = do_gen
do_vt[ACTION_TALK] = do_talk
do_vt[ACTION_CHOICE] = do_choice
do_vt[ACTION_SOUND] = do_sound_action

function do_action(action)
   do_vt[action.type](action)
   if action.on_start ~= nil then
      action.on_start()
   end
end

