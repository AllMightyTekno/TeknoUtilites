--Example component for Server Side

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Knit
local Knit = require(ReplicatedStorage.Packages.Knit)

-- Table
local module = {
	constructors = {},
	methods = {},
}
module.metatable = {__index=module.methods}


----------------------------------
----|   Public Constructors	|----
----------------------------------

function module.constructors.new()
	return setmetatable({
		
	}, module.metatable)
end

----------------------------------
----|     Public Methods		|----
----------------------------------

function module.methods.Action()
	
end


--> set module type
type module = typeof(module.constructors.new(table.unpack(...)))
--> Return
return module.constructors