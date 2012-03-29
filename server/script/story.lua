package.path = "script/?.lua;;"

--require "lfs"
require "log"
require "util"

ACTION_GEN = 0
ACTION_TALK = 1
ACTION_CHOICE = 2
ACTION_SOUND = 3
ACTION_GUIDE = 4
ACTION_MONOLOG = 5

tnil = {}

storys = {}
chapter = nil

function new_story(idx)
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
   chapter = c
   c.start = new_action(ACTION_GEN)
   chapter = nil
   return c
end


function on_action_start_default()end
function on_action_end_default()end

function link(pre, next)
   table.insert(pre.nexts, next)
end

function new_action(type)
   local a = {}
   local c = chapter
   a.idx = c.acc_idx
   a.type = type
   a.on_start = on_action_start_default
   a.on_end = on_action_end_default

   c.acc_idx = c.acc_idx + 1
   c.actions[a.idx] = a

   return a
end

DEFAULT_TALK_THOUGH = ""
function new_talk(from, text)
   local t = new_action(ACTION_TALK)
   t.from = from or ""
   t.text = text or ""
   t.though = DEFAULT_TALK_THOUGH or ""
   return t
end

function new_choice(alters, result)
   local c = new_action(ACTION_CHOICE)
   c.alters = alters or tnil
   c.result = result or 1
   return c
end

function new_sound(rid)
   local s = new_action(ACTION_SOUND)
   s.rid = rid or 0
   return s
end

function new_guide()
   local g = new_action(ACTION_GUIDE)
   g.speed = 20
   g.stay = 1000
   g.texts = {""}
   return g
end

function new_monolog()
   local mono = new_action(ACTION_MONOLOG)
   return mono
end

function new_pic(rid)
   local pic = {}
   pic.rid = rid or 0
   return pic
end

function load_story(name, idx)
   local root = "script/"..name.."/s"..idx.."/"
   local file = root.."meta.lua"
   D("to load "..file)
   local meta = dofile(file)
   local fullname
   local story = new_story(idx)
   storys[idx] = story
   local pre
   for key, id in ipairs(meta.chapters) do
      --if string.match(file, "%.lua$") then
      fullname = root..id..".lua"
      D("to load chapter file("..fullname..")")
      chapter = new_chapter(id)
      dofile(fullname)
      D("load chapter("..chapter.idx..")")
      story.chapters[chapter.idx] = chapter
      --end
   end
   for id, chapter in pairs(story.chapters) do
      if chapter.pre ~= nil then
         pre = story.chapters[chapter.pre]
         pre.next = chapter
         D("link chapter", pre.idx, chapter.idx)
      end
   end
   chapter = nil
end

function lua_update_progress(story_idx, chapter_idx, action_idx)
   progress.story_idx = story_idx
   progress.chapter_idx = chapter_idx
   progress.action_idx = action_idx
end

function write_progress()
   D("write progress", progress.story_idx, progress.chapter_idx, progress.action_idx)
   c_write_progress(progress.story_idx, progress.chapter_idx, progress.action_idx)
end

function read_progress()
   local story_idx, chapter_idx, action_idx = c_read_progress()
   D("read progress", story_idx, chapter_idx, action_idx)
   progress.story_idx = story_idx
   progress.chapter_idx = chapter_idx
   progress.action_idx = action_idx
end

function find_action(progress)
   local chapter = find_chapter(progress)
   return chapter.actions[progress.action_idx]
end

function find_chapter(progress)
   D("find chapter", progress.story_idx, progress.chapter_idx)
   return storys[progress.story_idx].chapters[progress.chapter_idx]
end

progress = {}
progress.story_idx = 0
progress.chapter_idx = 0
progress.action_idx = 0

function find_story(idx)
   return storys[idx]
end

function start_story(idx)
   progress.story_idx = idx
   start_chapter(storys[idx].chapters[1])
   D("start story", idx)
end

function start_chapter(chapter)
   rpc("load_chapter", {chapter.idx})
   progress.chapter_idx = chapter.idx
   progress.action_idx = 0
   write_progress()
   D("start load chapter", chapter.idx)
end

function on_chapter_load()
   read_progress()
   D("on_chapter_load", progress.chapter_idx)
   --c_rpc("clear_screen")
   local c = find_chapter(progress)
   do_action(c.start)
   progress.action_idx = c.start.idx
   write_progress()
   D("start chapter", progress.chapter_idx)
end

function do_gen(action)

end

meta_sound = {}
meta_guide = {}
meta_mono = {}
meta_talk = {}
meta_pic = {}
meta_choice = {}

function init_meta()
   meta_sound.rid = 0

   meta_guide.texts = 0
   meta_guide.speed = 0
   meta_guide.stay = 0

   meta_mono.texts = 0

   meta_talk.text = 0
   meta_talk.from = 0

   meta_pic.rid = 0
end

function read_meta(from, to)
   for k in pairs(to) do
      v = from[k]
      to[k] = v
      D("read key:"..k, "value:"..tostring(v))
   end
end

function play_talk(talk)
   meta_talk.text = talk.text or ""
   meta_talk.from = talk.from or ""
   meta_talk.though = talk.though or ""
   D("play talk")
   PT(talk)
   --read_meta(talk, meta_talk)
   c_rpc("play_talk", {meta_talk})
end

function play_choice(choice)
   meta_choice.alters = choice.alters or tnil
   meta_choice.result = choice.result or 1
   D("play choice")
   PT(choice)
   c_rpc("play_choice", {meta_choice})
end

function play_sound(sound)
   read_meta(sound, meta_sound)
   c_rpc("play_sound", {meta_sound})
end

function play_bgm(sound)
   read_meta(sound, meta_sound)
   c_rpc("play_bgm", {meta_sound})
end

function play_guide(guide)
   read_meta(guide, meta_guide)
   c_rpc("play_guide", {meta_guide})
end

function stop_all_sound()
   c_rpc("stop_all_sound", {})
end

function play_monolog(mono)
   read_meta(mono, meta_mono)
   c_rpc("play_monolog", {meta_mono})
end

do_vt = {}
do_vt[ACTION_GEN] = do_gen
do_vt[ACTION_TALK] = play_talk
do_vt[ACTION_CHOICE] = play_choice
do_vt[ACTION_SOUND] = play_sound
do_vt[ACTION_GUIDE] = play_guide
do_vt[ACTION_MONOLOG] = play_monolog

function do_action(action)
   D("do action, type("..action.type..")", "idx("..action.idx..")")
   do_vt[action.type](action)
   action.on_start()
end

function change_background(pic)
   read_meta(pic, meta_pic)
   c_rpc("change_background", {meta_pic})
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

function next_main_action()
   read_progress()
   local action = find_action(progress)
   do_next(action)
end

function do_next(action)
   local chapter
   action.on_end()
   action = action.next
   if action ~= nil then
      progress.action_idx = action.idx
      write_progress()
      do_action(action)
   else
      chapter = find_chapter(progress)
      if chapter.next ~= nil then
         chapter = chapter.next
         start_chapter(chapter)
      else
         D("story end")
      end
   end
end

function on_choose(id)
   D("choose "..id)
   read_progress()
   local choice = find_action(progress)
   if choice.result == id then
      D("match result")
      do_next(choice)
   end
end

init_meta()

--get_story_list("yelin")
load_story("yelin", 1)
