--[[ local gate
for _, Gates in pairs(game.Workspace.Triggers:GetDescendants()) do
	if Gates:IsA("Part") and Gates:GetAttribute("GateNumber") then
		gate = Gates
		print(gate:GetAttribute("GateNumber"))
	end
end ]]

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
			
			if ToucehdTriggerDoorModel == hit.Parent.Parent.Gate:GetAttribute("GateNumber") then
				---------A TWEEN FOR THE DOORS WILL BE FIRED HERE
				task.wait(5)
				hit.Parent.Parent.Gate:Destroy() 
				print("TWEENING DOORS") 
				else
				print('NIL')
			end
			
			
       end

   end)

end