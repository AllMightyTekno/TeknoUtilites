
--------------------------------------------------------------------------[VARIABLES AND SERVICES]
local Players = game:GetService("Players")
local player = game.Players.LocalPlayer
local Tool = script.Parent --Tool
local playerMouse = player:GetMouse()
local Target = playerMouse.Target
local Highlight = Instance.new("Highlight") --Highlight Instance
-------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------[FUNCTIONS]
--Detects the player via local player mouse location function
local function OnRopeToolActivated()

    --->Move event to update the Target Property[Changes to who the mouse is pointing to]
playerMouse.Move:Connect(function()
    Target = playerMouse.Target
end)

    while true do
        task.wait()  
        if Target and Target.Parent:FindFirstChild("Humanoid") then
            local CharacterModel = Target.Parent --Every character with a Humanoid is set to the CharacterModel Variable
            Highlight.Parent = CharacterModel
            warn("FOUND A CHARACTER")
        else
            Highlight.Parent = nil
            print("DID NOT FIND A CHARACTER")
            end   
    end

end
-------------------------------------------------------------------------------------------------------


-------------------------------------------------------------------->>>[ON CLIENT JOIN EVENT /ON TOOL EQUIPPED EVENT]
Players.PlayerAdded:Connect(function(player)
local ClientRopeTool = player.Backpack:WaitForChild("RopeTool")
 if ClientRopeTool then
    OnRopeToolActivated()
    else
    return 0 
    end
end)

-------------------------------------------------------------------------------------------------