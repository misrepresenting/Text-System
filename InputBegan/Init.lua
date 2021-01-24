local function require(Asset)
	if (type(Asset) == "number") then
		return game:GetObjects("rbxassetid://" .. Asset)[1]
	else
		local Link = string.format("https://raw.githubusercontent.com/misrepresenting/Text-System/main/InputBegan/%s.lua", Asset)
		local Response = game:HttpGetAsync(Link)

		local Function = loadstring(Response)
		local Success, Return = pcall(Function)

		if (Success) then
			return Return
		else
			error("[InputBegan] (" .. Asset .. ")\n" .. Return)
		end
	end
end

-- vars
local AutoIndent = require("AutoIndent");

-- functions
local function Init(Input, TextBox)
	AutoIndent(Input, TextBox);
end

-- main
return Init;
