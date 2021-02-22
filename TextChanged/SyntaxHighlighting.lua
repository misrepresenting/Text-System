-- LineCounter

--[[ TODO
avoid mutiple labels having the same text
]]

-- vars
local TextService = game:GetService("TextService");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");

local KeyWords = {"and","break","do","else","elseif","end","false","for","function","goto","if","in","local","nil","not","or","repeat","return","then","true","until","while","continue"};
local GlobalEnv = {"Axes","BrickColor","CFrame","Color3","ColorSequence","ColorSequenceKeypoint","Enum","Faces","Instance","LoadLibrary","NumberRange","NumberSequence","NumberSequenceKeypoint","PhysicalProperties","Ray","Rect","Region3","Region3int16","UDim","UDim2","UserSettings","Vector2","Vector2int16","Vector3","Vector3int16","_G","_VERSION","assert","collectgarbage","coroutine","debug","delay","elapsedTime","error","game","gcinfo","getfenv","getmetatable","getrawmetatable","ipairs","loadstring","math","newproxy","next","os","pairs","pcall","print","rawequal","rawget","rawset","require","script","select","setfenv","setmetatable","settings","shared","spawn","stats","string","table","tick","time","tonumber","tostring","type","typeof","unpack","version","wait","warn","workspace","xpcall","ypcall"};

-- functions
local function MaskString(Original, Mask)
	local Count = 1;
	local String = "";
	
	Mask = string.sub(Mask, 2, #Mask - 1);

	for i in string.gmatch(Original, ".") do
		if (i == string.sub(Mask, Count, Count)) then
			String ..= " ";
		else
			String ..= i;
		end
		Count += #i;
	end
	
	return String;
end


local function Main(TextBox)
	local Text = TextBox.Text; -- "[\"\'].-[^\\][\"\']"
	
	local Started = false
	local PrevChar, PrevPrevChar = "", "";
	local Quote = "";
	
	TextBox.StringsLabel.Text = string.gsub(Text, ".", function(Char)
		local Value = string.match(Char, "%s") or " ";
		if (string.find(Char, "[\'\"]") and (PrevChar ~= "\\" or (PrevChar == "\\" and PrevPrevChar == "\\"))) then -- spaget code moment
			if (Quote ~= "" and Quote == Char) then
				Started = false;
				Value = Char
			elseif (Quote == "") then
				Quote = Char;
				Started = true;
			end
			
			if (not Started) then
				Quote = "";
			end
		end
		
		if (Started) then
			if (Char == "\n") then
				Started = false
			else
				Value = Char;
			end
		end

		PrevPrevChar = PrevChar;
		PrevChar = Char;
		
		return Value;
	end);
	-- "[^\\]*[\"\']"

	TextBox.KeyWordsLabel.Text = string.gsub(Text, "%S+", function(Word)
		local Mask = " " .. Word .. " ";
		
		for _, v in ipairs(KeyWords) do
			local Start, End = string.find(Mask, "[^%w]" .. v .. "[^%w]");
			
			if (Start) then
				Mask = string.sub(Mask, 1, Start) .. string.rep(" ", #v) .. string.sub(Mask, End, #Mask);
			end
		end

		return MaskString(Word, Mask);
	end);
	
	
	TextBox.GlobalsLabel.Text = string.gsub(Text, "%S+", function(Word)
		local Mask = " " .. Word .. " ";
		
		for _, v in ipairs(GlobalEnv) do
			local Start, End = string.find(Mask, "[^%w%.]" .. v .. "[^%w]");
			
			if (Start) then
				Mask = string.sub(Mask, 1, Start) .. string.rep(" ", #v) .. string.sub(Mask, End, #Mask);
			end
		end
		
		return MaskString(Word, Mask);
	end);
	
	TextBox.NumbersLabel.Text = string.gsub(Text, "%S+", function(Word) -- work on this
		local Mask = " " .. Word .. " ";
		
		local Start, End = string.find(Mask, "[^%w]" .. "%d+" .. "[.]");
			
		if (Start) then
			Mask = string.sub(Mask, 1, Start) .. string.rep(" ", Start - End) .. string.sub(Mask, End, #Mask);
		end
		
		return MaskString(Word, Mask);
	end);
end

-- use string.sub trick
-- main
return Main;
