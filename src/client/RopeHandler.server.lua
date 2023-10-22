--------------------------[VARIABLES]-------------------------------------------------------
local rope
local att0
local att1
local newRope
--------------------------[END]-----------------------------------------------------------------

--------------------------[OnServerEvent]-------------------------------------------------------
script.Parent.Parent.RemoteEvent.OnServerEvent:Connect(function(plr,target,hit)
	if rope == nil then
		if target == nil then return end --If theres no target than return the statement
		if target:IsA('Sky') or target:IsA('Atmosphere') or target == nil then return end --Checks wheter the mouse is pointing to the skybox or atmosphere
		if target.Name ~= 'Baseplate' then
			if (script.Parent.Parent.Parent.HumanoidRootPart.Position - target.Position).Magnitude > 30 then return end
			rope = Instance.new('RopeConstraint')
			rope.Color = BrickColor.new(0, 1, 0) --Green rope 
			att0 = Instance.new('Attachment')
			att1 = Instance.new('Attachment')
			att0.Parent = target --Where it's attached oon target
			att1.Parent = script.Parent.Parent.Parent.LeftHand---Where it's attached on me
			rope.Visible = true
			rope.Parent = script.Parent.Parent.Parent.HumanoidRootPart
			rope.Attachment0 = att0
			rope.Attachment1 = att1
			rope.Length = (script.Parent.Parent.Parent.HumanoidRootPart.Position - target.Position).Magnitude ---How is it between me and the target
            warn(math.ceil(rope.Length).." STUDS AWAY")
		else
			newRope = game.ServerStorage.ForRope:Clone()
			newRope.Parent = workspace
			newRope.CFrame = hit
			task.wait(0.05)
			if (script.Parent.Parent.Parent.HumanoidRootPart.Position - newRope.Position).Magnitude > 30 then newRope:Destroy() newRope = nil return end ---If the distance between the Roper and the targ is more than 30 studs than it destroys the rope
			rope = Instance.new('RopeConstraint')
			att0 = Instance.new('Attachment')
			att1 = Instance.new('Attachment')
			att0.Parent = newRope
			att1.Parent = script.Parent.Parent.Parent.HumanoidRootPart
			rope.Visible = true
			rope.Parent = script.Parent.Parent.Parent.HumanoidRootPart
			rope.Attachment0 = att0
			rope.Attachment1 = att1
			rope.Length = (script.Parent.Parent.Parent.HumanoidRootPart.Position - newRope.Position).Magnitude

		end
	else
		rope:Destroy()
		att0:Destroy()
		att1:Destroy()
		rope = nil
		att0 = nil
		att1 = nil
		if newRope ~= nil then
			newRope:Destroy()
			newRope = nil
		end
	end
end)
--------------------------[END]-------------------------------------------------------

--------------------------[OnToolUnEquipped]-------------------------------------------------------
script.Parent.Parent.Unequipped:Connect(function()
	if rope ~= nil then
		rope:Destroy()
		att0:Destroy()
		att1:Destroy()
		rope = nil
		att0 = nil
		att1 = nil
		if newRope ~= nil then
			newRope:Destroy()
			newRope = nil
		end
	end
end)
--------------------------[END]-------------------------------------------------------
