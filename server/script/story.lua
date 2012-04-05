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
ACTION_COMMAND = 6

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
   a.type = type
   --a.on_start = on_action_start_default
   --a.on_end = on_action_end_default
   local c = chapter
   if nil ~= c then
      a.idx = c.acc_idx
      c.acc_idx = c.acc_idx + 1
      c.actions[a.idx] = a
   end
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

function new_command()
   local command = new_action(ACTION_COMMAND)
   return command
end

function new_pic(rid)
   local pic = {}
   pic.rid = rid or 0
   return pic
end

function append_action(action)
   chapter.last.next = action
   chapter.last = action
end

function am(texts)
   local mono = new_monolog()
   mono.texts = texts
   append_action(mono)
   return mono
end

function ag(texts)
   local guide = new_guide()
   guide.texts = texts
   append_action(guide)
   return guide
end

function at(from, text)
   local talk = new_talk(from, text)
   append_action(talk)
   return talk
end

function ac(alters, result)
   local choice = new_choice(alters, result)
   append_action(choice)
   return choice
end

function acom(name, ...)
   local com = new_command()
   com.name = name
   com.args = {...}
   -- if type(args) ~= "table" then
   --    com.args = tnil
   -- else
   --    com.args = args
   -- end
   append_action(com)
   return com
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
      D("start load chapter file("..fullname..")")
      chapter = new_chapter(id)
      chapter.last = tnil
      chapter.start = chapter.last
      dofile(fullname)
      chapter.start = chapter.start.next
      tnil.next = nil
      D("finish chapter("..chapter.idx..")")
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

function start_story(chapter_idx)
   progress.story_idx = 1
   start_chapter(storys[1].chapters[chapter_idx])
   D("start story, chapter:"..chapter_idx)
   c_log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>\n");
end

function start_chapter(chapter)
   rpc("load_chapter", {chapter.idx})
   progress.chapter_idx = chapter.idx
   progress.action_idx = 0
   write_progress()
   c_save_progress()
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
meta_command = {}

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

function play_guide(guide)
   read_meta(guide, meta_guide)
   c_rpc("play_guide", {meta_guide})
end

function play_monolog(mono)
   read_meta(mono, meta_mono)
   c_rpc("play_monolog", {meta_mono})
end

function play_sound(sound)
   read_meta(mono, meta_sound)
   c_rpc("play_sound", {meta_sound})
end

function send_command(com)
   D("send command name:"..com.name)
   PT(com.args)
   c_rpc(com.name, com.args)
end

do_vt = {}
do_vt[ACTION_GEN] = do_gen
do_vt[ACTION_TALK] = play_talk
do_vt[ACTION_CHOICE] = play_choice
do_vt[ACTION_SOUND] = play_sound
do_vt[ACTION_GUIDE] = play_guide
do_vt[ACTION_MONOLOG] = play_monolog
do_vt[ACTION_COMMAND] = send_command

function do_action(action)
   D("do action, type("..action.type..")", "idx("..action.idx..")")
   do_vt[action.type](action)
   if action.on_start ~= nil then
      action.on_start()
   end
end

function play_bgm(id)
   c_rpc("play_bgm", {id})
end

function change_background(id)
   D("change_background", id)
   c_rpc("change_background", {id})
end

function clear_background()
   c_rpc("clear_background", tnil)
end

function tip_end(tip)
   c_rpc("tip_end", {tip})
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
   if action.on_end ~= nil then
      action.on_end()
   end
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
   local str = ""
   for k,v in ipairs(choice.alters) do
      str = str.."["..k.."]"..v.." "
   end
   str = str.."------>".."["..id.."]"..choice.alters[id]
   --if id ~= 0 then
   --end
   c_log(str.."\n")
   --if choice.result == id or choice.result == 0 then
   --D("match result")
   do_next(choice)
   --end
end

init_meta()

--get_story_list("yelin")
load_story("yelin", 1)
