local function require(Asset)
	if (type(Asset) == "number") then
		return game:GetObjects("rbxassetid://" .. Asset)[1]
	else
		local Link = string.format("https://raw.githubusercontent.com/misrepresenting/Text-System/main/TextChanged/%s.lua", Asset)
		local Response = game:HttpGetAsync(Link)

		local Function = loadstring(Response)
		local Success, Return = pcall(Function)

		if (Success) then
			return Return
		else
			error("[TextChanged] (" .. Asset .. ")\n" .. Return)
		end
	end
end

-- vars
local LineCount = require("LineCount");
local Tabbing = require("Tabbing");
local SyntaxHighlighting = require("SyntaxHighlighting");

-- functions
local function Init(TextBox, LineCounter)
	LineCount(TextBox, LineCounter);
	Tabbing(TextBox);
	SyntaxHighlighting(TextBox);
end

-- main
return Init;
