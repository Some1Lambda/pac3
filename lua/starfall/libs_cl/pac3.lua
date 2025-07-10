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

local decode = pace.luadata.Decode

return function(instance)
local checkpermission = instance.player ~= SF.Superuser and SF.Permissions.check or function() end
local pac3_library = instance.Libraries.pac3

--- Loads a PAC3 outfit from its filename
-- @param string name The outfit's filename
-- @param boolean? clear Whether to clear the current outfit
function pac3_library.loadOutift(name,clear)
	checkpermission(instance,nil,"pac3.load")
	if clear == true then
        checkpermission(instance,nil,"pac3.clear")
    end

    checkluatype(name,TYPE_STRING)

	PAC.LoadParts(name,clear)
end

--- Loads a PAC3 outfit from a table or a string
-- @param string|table data Data to load
-- @param boolean? clear Whether to clear the current outfit
function pac3_library.loadFromData(data,clear)
    checkpermission(instance,nil,"pac3.load")
	if clear == true then
        checkpermission(instance,nil,"pac3.clear")
    end

    if istable(data) then
		PAC.LoadPartsFromTable(data,clear)
	elseif isstring(data) then
		local pac_data,_ = decode(str)
		if pac_data then
			PAC.LoadPartsFromTable(pac_data,clear)
		end
	else
		SF.ThrowTypeError("table or string", SF.GetType(data), 2)
	end


end

--- Clears the PAC3 outfit
function pac3_library.clearParts()
    checkpermission(instance,nil,"pac3.clear")

    PAC.ClearParts()
end

end