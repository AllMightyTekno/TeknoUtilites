script.Parent.Activated:Connect(function() --When the client equips the Tool
	local mouse = game.Players.LocalPlayer:GetMouse()
	script.Parent.RemoteEvent:FireServer(mouse.Target,mouse.Hit)
   
    mouse.Move:Connect(function()
       local Target = mouse.Target
    end)

        if mouse.Target and mouse.Target.Parent:FindFirstChild("Humanoid") then
            local CharacterModel = mouse.Target.Parent --Every character with a Humanoid is set to the CharacterModel Variable
            mouse.Target.Parent = CharacterModel
            warn('ROPE ATTACHED TO '..mouse.Target.Parent.Name)
end

end)
