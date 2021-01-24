-- LineCounter

-- vars
local TextService = game:GetService("TextService");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");

-- functions
local function Main(Input, TextBox)
	if (Input.UserInputType == Enum.UserInputType.MouseWheel) then
		TextBox:ReleaseFocus();
	end
end

-- main
return Main;
