-- LineCounter

--[[ known bugs:

it doesnt know what the end of a scope is
]]

-- vars
local TextService = game:GetService("TextService");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");

local KeyWords = {
	{"else", "end"};
	{"do", "end"};
	{"then", "end"};
	{"{", "}"};
	{"%([ ]*function", "end)"};
	{"function", "end"};
	{"repeat", "until"};
};

local Patterns = {
	"\"(.-)\"";
	"\'(.-)\'";
	"%-%-.+";
	"{(.-)}";
};

-- functions
local function Main(Input, TextBox)
	if (Input.KeyCode == Enum.KeyCode.Return and TextBox:IsFocused()) then
		local Text = TextBox.Text;
		
		local TotalLines = string.split(string.sub(Text, 1, TextBox.CursorPosition - 1), "\n");
		local PrevLine = TotalLines[#TotalLines - 1] or "";
		
		local Start, Layer = string.find(PrevLine, "[ ]+");
		
		Layer = (Start == 1) and Layer or 0; -- check if spaces start at da zeroth character
		
		for _, v in pairs(Patterns) do
			PrevLine = string.gsub(PrevLine, v, ""); -- we dont rlly need this anymore anyway
		end
		
		for _, v in ipairs(KeyWords) do
			if (string.match(PrevLine, v[1])) then
				TextBox.Text = string.sub(Text, 1, TextBox.CursorPosition - 1) .. "    " .. string.rep(" ", Layer) .. "\n" .. string.rep(" ", Layer) .. v[2] .. string.sub(Text, TextBox.CursorPosition, #Text);
				TextBox.CursorPosition = TextBox.CursorPosition + 4 + Layer;
				
				return;
			end
		end
		
		TextBox.Text = string.sub(Text, 1, TextBox.CursorPosition - 1) .. string.rep(" ", Layer) .. string.sub(Text, TextBox.CursorPosition, #Text);
		TextBox.CursorPosition = TextBox.CursorPosition + Layer;
	end
end

-- main
return Main;
