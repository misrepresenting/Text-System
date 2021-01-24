-- LineCounter

-- vars
local TextService = game:GetService("TextService");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");

-- functions
local function Main(TextBox, LineCounter)
	local Text = TextBox.Text;
	local LineCount = #string.split(Text, "\n");
	local LineCountString = "";
	
	for i = 1, LineCount do
		LineCountString ..= i .. "\n";
	end
	
	LineCounter.Text = LineCountString;
end

-- main
return Main;
