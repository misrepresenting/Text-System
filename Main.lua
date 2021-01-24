local function require(Asset)
	if (type(Asset) == "number") then
		return game:GetObjects("rbxassetid://" .. Asset)[1]
	else
		local Link = string.format("https://raw.githubusercontent.com/misrepresenting/Text-System/main/%s/Init.lua", Asset)
		local Response = game:HttpGetAsync(Link)

		local Function = loadstring(Response)
		local Success, Return = pcall(Function)

		if (Success) then
			return Return
		else
			error("[Main] (" .. Asset .. ")\n" .. Return)
		end
	end
end

-- vars
local Module = {};

local UserInputService = game:GetService("UserInputService");

local InputChanged = require("InputChanged");
local InputBegan = require("InputBegan");
local TextChanged = require("TextChanged");

-- functions
function Module:Init(TextBox, LineCounter)
	--TextBox.TextColor3 = TextBox.Parent.BackgroundColor3; -- Syntax Highlighting
	
	TextBox.InputChanged:Connect(function(Input)
		InputChanged(Input, TextBox)
	end)
	UserInputService.InputBegan:Connect(function(Input)
		InputBegan(Input, TextBox)
	end)
	TextBox:GetPropertyChangedSignal("Text"):Connect(function()
		TextChanged(TextBox, LineCounter)
	end)
end

-- main
return Module;
