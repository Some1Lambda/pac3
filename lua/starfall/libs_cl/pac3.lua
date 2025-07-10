if not istable(SF) then return end

local PAC = pace

local checkluatype = SF.CheckLuaType
local registerprivilege = SF.Permissions.registerPrivilege

registerprivilege("pac3.load", "Load a PAC3 outfit", "Allows the user load a PAC3", { client = { default = 1 } })
registerprivilege("pac3.clear", "Clear your PAC3 outfit", "Allows the user to clear the PAC3", { client = { default = 1 } })

--- PAC3 library
-- @name pac3
-- @class library
-- @libtbl pac3_library
SF.RegisterLibrary("pac3")

return function(instance)
local checkpermission = instance.player ~= SF.Superuser and SF.Permissions.check or function() end

local pac3_library = instance.Libraries.pac3

--- Loads a PAC3 outfit from a string
-- @param string str Data to load
-- @param boolean? clear Whether to clear the current parts
function pac3_library.loadFromString(str,clear)
    checkpermission(instance,nil,"pac3.load")
    checkluatype(str,TYPE_STRING)

    if clear == true then
        checkpermission(instance,nil,"pac3.clear")
    end

    local data,_ = PAC.luadata.Decode(str)
    if data then
        PAC.LoadPartsFromTable(data,clear)
    end
end

--- Clears the PAC3 outfit
function pac3_library.clearParts()
    checkpermission(instance,nil,"pac3.clear")

    PAC.ClearParts()
end

end