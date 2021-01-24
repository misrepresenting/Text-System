-- vars
local LineCount = require(script.LineCount);
local Tabbing = require(script.Tabbing);
local SyntaxHighlighting = require(script.SyntaxHighlighting);

-- functions
local function Init(TextBox, LineCounter)
	LineCount(TextBox, LineCounter);
	Tabbing(TextBox);
	SyntaxHighlighting(TextBox);
end

-- main
return Init;
