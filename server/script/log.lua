function D(...)
   print("[DEBUG][LUA] ", ...)
end

function E(...)
   print("[ERROR][LUA] ", ...)
end

function PT(t)
   for k,v in pairs(t) do
      D("key:"..k..", value:"..tostring(v))
   end
end