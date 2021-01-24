-- Resize

-- vars
local TextService = game:GetService("TextService");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");


-- functions
local function Main(TextBox)
	local Text = TextBox.Text;
	local PrevChar = string.sub(Text, TextBox.CursorPosition - 1, TextBox.CursorPosition - 1);

	if (PrevChar == "\t") then
		TextBox.Text = string.sub(Text, 1, TextBox.CursorPosition - 2) .. "    " .. string.sub(Text, TextBox.CursorPosition, #Text);
		TextBox.CursorPosition = TextBox.CursorPosition + 3;
	end
end

-- main
return Main;
