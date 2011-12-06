package.path = "script/?.lua;;"

require "log"
require "lfs"

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
   return c
end

function Talk()
   local s = {}
--   s.idx = idx
   return s
end

function Choice(idx)
   local s = {}
   s.idx = idx
   return s
end

function Sound(idx)
   local s = {}
   s.idx = idx
   return s
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
   for i, spaceid in ipairs(meta.spaces) do
      space = Space(spaceid)
      storys[spaceid] = space
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

