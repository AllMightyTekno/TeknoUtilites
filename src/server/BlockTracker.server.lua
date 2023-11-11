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


--------------------------[VARIABLES]-------------------------------------------------------
local TS = game:GetService("TweenService")
local BlockModel = game.Workspace.BLOCK 
local Triggers = game.Workspace.Triggers:GetChildren("Base")

--------------------------[END]-----------------------------------------------------------------


----->TweenInfo of every door on open 
local TweenInfo = TS.TweenInfo(

)


 for _, Triggers in pairs(game.Workspace.Triggers:GetChildren()) do --Ittereates through the Triggers folder and checks for all chuildren
	
	
BlockModel.Touched:Connect(function(hit)

	
		if hit and hit:IsDescendantOf(game.Workspace.Triggers) then --Checks wheter what touched the trigger is a chikld of the triggers folder
    --FIRES WHEN THE BLOCK TOUCHES THE TRIGGERS
local TouchedTrigger = hit
local TouchedDoorAttr = hit:GetAttribute("Trigger_Number")  --Get's the Attribute of the gate that's suppose to be opended by the player
			
			--[[ REFERENCE
			print(hit.Parent.Parent.Gate:GetAttribute("GateNumber"))
			print(ToucehdTriggerDoorModel)
			This will print 1,2,3 in order with the more doors that are added
			]]
			
			if TouchedDoorAttr == hit.Parent.Parent.Gate:GetAttribute("GateNumber") then --Checks if the Trigger value the ball touch is equal to it oarent Gate if so then this run
				---------A TWEEN FOR THE DOORS WILL BE FIRED HERE
				task.wait(5)	
				hit.Parent.Parent.Gate:Destroy()  --Destroys the Gate with the given attribute
				print("INIT DOOR TWEENS") 
				else
				warn("ERROR ON LINE 39")
			end
			
			
       end

   end)

end