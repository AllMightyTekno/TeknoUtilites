--[[ local gate
for _, Gates in pairs(game.Workspace.Triggers:GetDescendants()) do
	if Gates:IsA("Part") and Gates:GetAttribute("GateNumber") then
		gate = Gates
		print(gate:GetAttribute("GateNumber"))
	end
end ]]

--[[
-Find a way so that you can add Blocks or balls as a detector
]]


local TS = game:GetService("TweenService")
local BlockModel = game.Workspace.BLOCK 
local Triggers = game.Workspace.Triggers:GetChildren("Base")

 for _, Triggers in pairs(game.Workspace.Triggers:GetChildren()) do
	
	
BlockModel.Touched:Connect(function(hit)

		if hit and hit:IsDescendantOf(game.Workspace.Triggers) then --Checks wheter what touched the trigger is a chikld of the triggers folder
    --FIRES WHEN THE BLOCK TOUCHES THE TRIGGERS
local TouchedTrigger = hit
local ToucehdTriggerDoorModel = hit:GetAttribute("Trigger_Number")  --Get's the Attribute of the gate that's suppose to be opended by the player
			
			--[[ REFERENCE
			print(hit.Parent.Parent.Gate:GetAttribute("GateNumber"))
			print(ToucehdTriggerDoorModel)
			]]
			
			if ToucehdTriggerDoorModel == hit.Parent.Parent.Gate:GetAttribute("GateNumber") then --Checks if the Trigger value the ball touch is equal to it oarent Gate if so then this run
				---------A TWEEN FOR THE DOORS WILL BE FIRED HERE
				hit.Parent.Parent.Gate:Destroy()  --Destroys the Gate with the given attribute
				task.wait(5)
				print("TWEENING DOORS") 
				else
				warn("ERROR ON LINE 33")
			end
			
			
       end

   end)

end