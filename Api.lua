
-- This file manages the API functions.





function ExecuteString(a_String)
	assert(type(a_String) == 'string')
	
	local Function, ErrorMsg = loadstring(a_String)
	if (not Function) then
		return false, ErrorMsg
	end
	
	return Function()
end