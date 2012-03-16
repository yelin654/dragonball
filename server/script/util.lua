function is_name_file(name)
   return name ~= "." and name ~= ".."
end

function rpc(name, params)
   if not type(params) == "table" then
      E("rpc params need table!")
      return
   end
   c_rpc(name, params)
end