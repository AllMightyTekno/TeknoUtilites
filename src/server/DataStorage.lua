----[ SERVICES ]
local DataStore = game:GetService("DataStoreService")

---[ VARIABLES ]
 -- local checkPoints = workspace["Check Points"] List of all the checkipints in the obby game
local SteppedSound = game.SoundService.Master.SoundEffects.Success_Sound
local ClientData =  DataStore:GetDataStore("datastor00a2") --> Change the last Value for DataStorage Versioning [1 - 2 or 1- 1.2] 


local Data = {}

--->Function that handles when the player joins
function Data.PlayerJoins(plr: Player)
	warn("GAME HAS BEGUN")

	SteppedSound.Parent = plr
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = plr

	local stage = Instance.new("IntValue") --Default player stage
	stage.Name = "Stage"
	stage.Value = 1
	stage.Parent = leaderstats

	local Coins = Instance.new("IntValue")
	Coins.Name = "Coins"
	Coins.Value = 0
	Coins.Parent = leaderstats


	local Rebirths = Instance.new("IntValue")
	Rebirths.Name = "Rebirths"
	Rebirths.Value = 0 
	Rebirths.Parent = leaderstats

	--->Data Store GetAsync
	local ClientId = "Player"..plr.UserId
	local data = ClientData:GetAsync(ClientId)

	if data then
		Coins.Value = data
		Rebirths.Value = data
	else
		Coins.Value = 0
		Rebirths.Value = 0
	end
end

--->Function that handles twhen the player leaves
function Data.PlayerLeaves(plr: Player)
	local playerId = "Player"..plr.UserId

	local succes,errormessage = pcall(function()
		local SaveData = ClientData:SetAsync(playerId, plr.leaderstats.Coins.Value)	
	end)

	if succes then
		print("CLIENT DATA HAS SAVED SUCCES")
	else
		warn(errormessage)
	end
end


return Data
