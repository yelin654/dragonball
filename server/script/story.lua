function D(...)
   print("[LUA_DEBUG]", ...)
end

function E(...)
   print("[LUA_ERROR]", ...)
end

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
   return s
end

function Talk(idx)
   local s = {}
   s.idx = idx
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

function load(name, idx)

end

