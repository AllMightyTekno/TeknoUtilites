	--[[
    ________      __          _____________       _____________      ________
   |  ______|\   |  |\       |____     ____|\    |____     ____|\   |  ______|\
   | |\______\|  |  | |           |   |\____\|    \___|   |\ ___\|  | |\______\|
   | |_|__       |  | |           |   | |             |   | |       | |_|__
   |  ____|\     |  | |           |   | |             |   | |       |  ____|\ 
   | |\____\|    |  | |           |   | |             |   | |       | |\____\|      
   | |_|____     |  |_|___     ___|   |_|___          |   | |       | |_|____      _      
   |________|\   |________|\  |____________|\         |___| |       |________|\   |_|\
    \________\|   \________\|  \____________\|         \___\|        \________\|   \_\|
    							Copyright ⓒ 2023 by Elite  >:)
   
   [2023 August]
   
   @ Elite#7704 / redlamppp 		(Creator)
   @ SPOOK / (robloxusername)  (Editor)
    
   Server receipt and gamepass handler
   
   
]]

-- // Types ( lazy as shit )
type receipt = {PlayerId: number; ProductId: number}

-- // Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")
local Players = game:GetService("Players")
local BS = game:GetService("BadgeService")

-- // Replicated
local remotes = ReplicatedStorage.Shared.Remotes

local clientRequestTeleport = remotes.RequestClientTeleport
local clientInifiniteJump = remotes.ClientInifiniteJump
local clientFourJump = remotes.ClientIFourJump
local requestUserOwnsProduct = remotes.RequestUserOwnsProduct
local productPurchased = remotes.ProductPurchased

-- // Modules
local ids = require(ReplicatedStorage.Shared.Identification)
-- // Events

-- // Variables
local server = {}
server.functions = {}
server.cache = {}

local Debounce = false
local jumppower = 50*4

----------------------------------
----|	Private Functions	|----
----------------------------------

local function findPlayer(name: string, useDisplay: boolean): Player | nil

	name = string.lower(name)
	local found: Player

	for _, v: Player in Players:GetPlayers() do
		if string.lower(v.Name) ~= name or string.lower(v.DisplayName) ~= name then continue end

		found = v

		break
	end

	return found
end

local function findNameById(find: number): string

	local found: string

	for name: string, id: number in ids do
		if id == find then found = name; break end
		continue
	end

	return found
end


function server.functions.FourTimeJumpPower(player: Player)

	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid: Humanoid = character.Humanoid
	
	productPurchased:FireClient(player, "FourTimeJumpPower")
	
	--humanoid.JumpPower = jumppower
	print("Fired")
	task.wait(.5)
	clientFourJump:FireClient(player)

end

function server.functions.TeleportToFriend(player: Player)

	productPurchased:FireClient(player, "TeleportToFriend")

end

function server.functions.SkipStage(player: Player)

	local leaderstats: Folder = player:FindFirstChild("leaderstats")
	local stage: IntValue = leaderstats.Stage
	if Debounce == false then
		Debounce = true
		stage.Value += 3
		player:LoadCharacter()
		task.wait(3.5)
		Debounce = false
	end

end

function server.functions.InfiniteJump(player: Player)
	local character = player.Character or player.CharacterAdded:Wait()
	local humanoid: Humanoid = character.Humanoid

	productPurchased:FireClient(player, "InfiniteJump")
	
	print('fired')
	task.wait(.5)
	clientInifiniteJump:FireClient(player)
	
end

----------------------------------
----|		Main Code		|----
----------------------------------

Players.PlayerAdded:Connect(function(player: Player)
	
	---->BadgeHandle
BS:AwardBadge(player.UserId,ids.OGplayer)
	if game.Players:FindFirstChild("ttignyemb") then
		BS:AwardBadge(player.UserId, ids.MetOwner)
	end	
	
	
	--> Add cache
	server.cache[player] = {}

	--> Add cached products back when respawn
	player.CharacterAdded:Connect(function(character: Model) 
		
		for id, _ in server.cache[player] do
			server.functions[findNameById(id)](player)
		end
		
	end)

	--> Check for gamepasses
	--for name: string, id: number in ids do
	--	if MarketplaceService:UserOwnsGamePassAsync(player.UserId, id) then
	--		server.functions[name]()
	--	end
	--end

end)

clientRequestTeleport.OnServerEvent:Connect(function(player: Player, other: string)
	if not other then return end

	--> check if he owns product
	if not server.cache[player][ids.TeleportToFriend] then
		warn(`Server request -> Teleport to player denied. Reason: User doesn't own product.`)
		MarketplaceService:PromptPurchase(player, ids.TeleportToFriend)
	end

	--> Find player simply
	local found: Player = Players:FindFirstChild(other)

	--> If not found then check for caps mistakes
	if not found then
		found = findPlayer(other, true)
		if not found then warn(`Server request -> Teleport player[{player.Name}] to player[{other}] failed. `) return end
	end

	--> Teleport player to other player
	player.Character:PivotTo(found.Character:GetPivot())

end)

--> Request if user owns product
requestUserOwnsProduct.OnServerInvoke = function(player: Player, id: number)
	if not id then return nil end

	local owns = server.cache[player][id]

	if not owns then
		return false
	end

	return owns
end


--> Process Receipt
MarketplaceService.ProcessReceipt = function(receiptInfo: receipt)
	local userId = receiptInfo.PlayerId
	local product = receiptInfo.ProductId

	local player = Players:GetPlayerByUserId(userId)

	--> Return unsuccesful pruchase
	if not player then
		return Enum.ProductPurchaseDecision.NotProcessedYet
	end

	--> Give player what they bought
	local handler = server.functions[findNameById(product)]

	local success, result = pcall(handler, player)

	--> Check for status
	if success then
		--> Add purchase to cache
		server.cache[player][product] = true

		--> Granted purchase reward
		return Enum.ProductPurchaseDecision.PurchaseGranted
	else
		warn(`Server purcahse request -> Failed to purchase product[{product}]. Error code: {result}.`)
	end

	--> Return failed
	return Enum.ProductPurchaseDecision.NotProcessedYet

end