--Example component for client side

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Knit
local Knit = require(ReplicatedStorage.Packages.Knit)

-- Table
local component = {
	constructors = {},
	methods = {},
}
component.metatable = {__index=component.methods}


----------------------------------
----|   Public Constructors	|----
----------------------------------

function component.constructors.new()
	return setmetatable({
		
	}, component.metatable)
end

----------------------------------
----|     Public Methods		|----
----------------------------------

function component.methods.Action()
	
end


--> set component type
type component = typeof(component.constructors.new(table.unpack(...)))
--> Return
return component.constructors