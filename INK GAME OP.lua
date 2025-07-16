-- Luna Hub for Ink Game with 3itx UI Library
-- Updated UI to use 3itx-UI-LIB format

local Maid = loadstring(game:HttpGet('https://raw.githubusercontent.com/Quenty/NevermoreEngine/refs/heads/main/src/maid/src/Shared/Maid.lua'))()
local Signal = loadstring(game:HttpGet('https://raw.githubusercontent.com/stravant/goodsignal/refs/heads/master/src/init.lua'))()

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Load 3itx UI Library
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Just3itx/3itx-UI-LIB/refs/heads/main/Lib"))() 
local FlagsManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Just3itx/3itx-UI-LIB/refs/heads/main/ConfigManager"))()

-- Create main window
local main = lib:Load({
    Title = '🟢 Luna Hub - Ink Game',
    ToggleButton = "rbxassetid://4483345998",
    BindGui = Enum.KeyCode.RightControl,
})

-- Create tabs
local MainTab = main:AddTab("Main")
local PlayerTab = main:AddTab("Player")
local VisualsTab = main:AddTab("Visuals")
local ConfigTab = main:AddTab("Config")

-- Select main tab
main:SelectTab()

-- Global variables for toggles
local Toggles = {}
local Options = {}

-- @class RedLightGreenLight
local RedLightGreenLight = {}
RedLightGreenLight.__index = RedLightGreenLight

function RedLightGreenLight.new()
    local self = setmetatable({}, RedLightGreenLight)
    self._Maid = Maid.new()
    self._IsGreenLight = nil
    self._LastRootPartCFrame = nil
    return self
end

function RedLightGreenLight:Start()
    local Client = Players.LocalPlayer
    local TrafficLightImage = Client.PlayerGui:WaitForChild("ImpactFrames"):WaitForChild("TrafficLightEmpty")

    self._IsGreenLight = TrafficLightImage.Image == ReplicatedStorage.Effects.Images.TrafficLights.GreenLight.Image

    local RootPart = Client.Character and Client.Character:FindFirstChild("HumanoidRootPart")
    self._LastRootPartCFrame = RootPart and RootPart.CFrame

    self._Maid:GiveTask(ReplicatedStorage.Remotes.Effects.OnClientEvent:Connect(function(EffectsData)
        if EffectsData.EffectName ~= "TrafficLight" then return end
        self._IsGreenLight = EffectsData.GreenLight == true
        local RootPart = Client.Character and Client.Character:FindFirstChild("HumanoidRootPart")
        self._LastRootPartCFrame = RootPart and RootPart.CFrame
    end))

    local OriginalNamecall
    OriginalNamecall = hookfunction(getrawmetatable(game).__namecall, newcclosure(function(Instance, ...)
        local Args = {...}
        if getnamecallmethod() == "FireServer" and Instance.ClassName == "RemoteEvent" and Instance.Name == "rootCFrame" then
            if Toggles.RedLightGodMode and self._IsGreenLight == false and self._LastRootPartCFrame then
                Args[1] = self._LastRootPartCFrame
                return OriginalNamecall(Instance, unpack(Args))
            end
        end
        return OriginalNamecall(Instance, ...)
    end))

    self._Maid:GiveTask(function()
        hookfunction(getrawmetatable(game).__namecall, OriginalNamecall)
    end)

    warn("RLGL feature started!")
end

function RedLightGreenLight:Destroy()
    warn("RLGL feature destroyed!")
    self._Maid:Destroy()
end

-- @class Dalgona
local Dalgona = {}
Dalgona.__index = Dalgona

function Dalgona.new()
    local self = setmetatable({}, Dalgona)
    self._Maid = Maid.new()
    return self
end

function Dalgona:Start()
    local DalgonaClientModule = game.ReplicatedStorage.Modules.Games.DalgonaClient

    local function CompleteDalgona()
        if not Toggles.DalgonaAuto then return end
        for _, Value in ipairs(getreg()) do
            if typeof(Value) == "function" and islclosure(Value) then
                if getfenv(Value).script == DalgonaClientModule then
                    if getinfo(Value).nups == 73 then
                        setupvalue(Value, 31, 9e9)
                        break
                    end
                end
            end
        end
    end

    local OriginalDalgonaFunction
    OriginalDalgonaFunction = hookfunction(require(DalgonaClientModule), function(...)
        task.delay(3, CompleteDalgona)        
        return OriginalDalgonaFunction(...)
    end)

    self._Maid:GiveTask(function()
        hookfunction(require(DalgonaClientModule), OriginalDalgonaFunction)
    end)

    warn("Dalgona feature started!")
end

function Dalgona:Destroy()
    warn("Dalgona feature destroyed!")
    self._Maid:Destroy()
end

-- @class TugOfWar
local TugOfWar = {}
TugOfWar.__index = TugOfWar

function TugOfWar.new()
    local self = setmetatable({}, TugOfWar)
    self._Maid = Maid.new()
    return self
end

function TugOfWar:Start()
    local TemporaryReachedBindableRemote = ReplicatedStorage.Remotes.TemporaryReachedBindable
    local PULL_RATE = 0.025
    local VALID_PULL_DATA = {["PerfectQTE"] = true}

    self._Maid:GiveTask(task.spawn(function()
        while task.wait(PULL_RATE) do
            if Toggles.TugOfWarAuto then
                TemporaryReachedBindableRemote:FireServer(VALID_PULL_DATA)
            end
        end
    end))

    warn("TugOfWar feature started!")
end

function TugOfWar:Destroy()
    warn("TugOfWar feature destroyed!")
    self._Maid:Destroy()
end

-- @class GlassBridge
local GlassBridge = {}
GlassBridge.__index = GlassBridge

function GlassBridge.new()
    local self = setmetatable({}, GlassBridge)
    self._Maid = Maid.new()
    return self
end

function GlassBridge:Start()
    local GlassHolder = workspace.GlassBridge.GlassHolder

    local function SetupGlassPart(GlassPart)
        if not Toggles.GlassBridgeESP then
            GlassPart.Color = Color3.fromRGB(106, 106, 106)
            GlassPart.Transparency = 0.45
            GlassPart.Material = Enum.Material.SmoothPlastic
        else
            local Color = GlassPart:GetAttribute("exploitingisevil") and Color3.fromRGB(248, 87, 87) or Color3.fromRGB(28, 235, 87)
            GlassPart.Color = Color
            GlassPart.Transparency = 0
            GlassPart.Material = Enum.Material.Neon
        end
    end

    self._Maid:GiveTask(GlassHolder.DescendantAdded:Connect(function(Descendant)
        if Descendant.Name == "glasspart" and Descendant:IsA("BasePart") then
            task.defer(SetupGlassPart, Descendant)
        end
    end))

    warn("GlassBridge feature started!")
end

function GlassBridge:Destroy()
    warn("GlassBridge feature destroyed!")
    self._Maid:Destroy()
end

-- @class Mingle
local Mingle = {}
Mingle.__index = Mingle

function Mingle.new()
    local self = setmetatable({}, Mingle)
    self._Maid = Maid.new()
    return self
end

function Mingle:Start()
    local Client = game:GetService("Players").LocalPlayer
    local CharacterMaid = Maid.new()
    self._Maid:GiveTask(CharacterMaid)

    local function OnCharacterAdded(Character)
        CharacterMaid:DoCleaning()

        local function OnRemoteForQTEAdded(RemoteForQTE)
            CharacterMaid:GiveTask(task.spawn(function()
                while task.wait(0.5) do
                    if not RemoteForQTE or not RemoteForQTE.Parent then break end
                    if Toggles.MinglePowerHoldAuto then
                        RemoteForQTE:FireServer()
                    end
                end
            end))
        end

        local function OnChildAdded(Object)
            if Object.ClassName == "RemoteEvent" and Object.Name == "RemoteForQTE" then
                OnRemoteForQTEAdded(Object)
            end
        end

        CharacterMaid:GiveTask(Character.ChildAdded:Connect(OnChildAdded))
        for _, Object in ipairs(Character:GetChildren()) do
            task.spawn(OnChildAdded, Object)
        end
    end

    self._Maid:GiveTask(Client.CharacterAdded:Connect(OnCharacterAdded))
    if Client.Character then
        task.spawn(OnCharacterAdded, Client.Character)
    end

    warn("Mingle feature started!")
end

function Mingle:Destroy()
    warn("Mingle feature destroyed!")
    self._Maid:Destroy()
end

-- @class HideAndSeek
local HideAndSeek = {}
HideAndSeek.__index = HideAndSeek

function HideAndSeek.new()
    local self = setmetatable({}, HideAndSeek)
    self._Maid = Maid.new()
    self._ESP = loadstring(game:HttpGet('https://kiriot22.com/releases/ESP.lua'))()
    return self
end

function HideAndSeek:Start()
    local ROLES_DATA = {
        IsHider = {Name = "Hider", Color = Color3.fromRGB(0, 255, 230), Flag = "Hiders"},
        IsHunter = {Name = "Hunter", Color = Color3.fromRGB(251, 0, 0), Flag = "Hunters"}
    }

    local Client = game:GetService("Players").LocalPlayer
    local BoxObjects = {}

    local function OnPlayerAdded(Player)
        if Player == Client then return end

        local PlayerMaid = Maid.new()
        self._Maid:GiveTask(PlayerMaid)

        local CharacterMaid = Maid.new()
        PlayerMaid:GiveTask(CharacterMaid)

        local function OnCharacterAdded(Character)
            CharacterMaid:DoCleaning()
            local RootPart = Character:WaitForChild("HumanoidRootPart")

            local function OnRoleAdded(Role)
                local RoleData = ROLES_DATA[Role]
                table.insert(BoxObjects, self._ESP:Add(Character, {
                    Name = "Role: " .. RoleData.Name .. " | " .. "Player Name: " .. Player.Name,
                    Color = RoleData.Color,
                    PrimaryPart = RootPart,
                    IsEnabled = RoleData.Flag,
                }))
            end

            for _, Attribute in ipairs({"IsHider", "IsHunter"}) do
                CharacterMaid:GiveTask(Player:GetAttributeChangedSignal(Attribute):Connect(function()
                    if Player:GetAttribute(Attribute) ~= true then return end
                    OnRoleAdded(Attribute)
                end))
                if Player:GetAttribute(Attribute) == true then
                    task.spawn(OnRoleAdded, Attribute)
                end
            end
        end

        PlayerMaid:GiveTask(Player.AncestryChanged:Connect(function(_, NewParent)
            if NewParent then return end
            PlayerMaid:Destroy()
        end))

        PlayerMaid:GiveTask(Player.CharacterAdded:Connect(OnCharacterAdded))
        if Player.Character then
            task.spawn(OnCharacterAdded, Player.Character)
        end
    end

    self._Maid:GiveTask(Players.PlayerAdded:Connect(OnPlayerAdded))
    for _, Player in ipairs(Players:GetPlayers()) do
        task.spawn(OnPlayerAdded, Player)
    end

    self._ESP.Players = true
    self._ESP:Toggle(true)

    warn("HideAndSeek feature started!")
end

function HideAndSeek:Destroy()
    warn("HideAndSeek feature destroyed!")
    for _, Box in ipairs(self._BoxObjects or {}) do
        Box:Remove()
    end
    self._ESP:Toggle(false)
    self._Maid:Destroy()
end

-- Initialize game features
local redLightGreenLight = RedLightGreenLight.new()
local dalgona = Dalgona.new()
local tugOfWar = TugOfWar.new()
local glassBridge = GlassBridge.new()
local mingle = Mingle.new()
local hideAndSeek = HideAndSeek.new()

-- Main Tab Setup
local MainSection = MainTab:AddSection({Title = "Round Cheats", Description = "Automation features for different game rounds", Default = false, Locked = false})
local MainGroupButtons = MainSection:AddGroupButton()

MainSection:AddToggle("RedLightGodMode", {
    Title = "Red Light God Mode",
    Default = false,
    Description = "Prevents elimination during Red Light Green Light",
    Callback = function(isEnabled)
        Toggles.RedLightGodMode = isEnabled
        if isEnabled then
            redLightGreenLight:Start()
        else
            redLightGreenLight:Destroy()
        end
    end,
})

MainSection:AddToggle("TugOfWarAuto", {
    Title = "Tug of War Auto Pull",
    Default = false,
    Description = "Automatically pulls during Tug of War game",
    Callback = function(isEnabled)
        Toggles.TugOfWarAuto = isEnabled
        if isEnabled then
            tugOfWar:Start()
        else
            tugOfWar:Destroy()
        end
    end,
})

MainSection:AddToggle("DalgonaAuto", {
    Title = "Dalgona Auto Complete",
    Default = false,
    Description = "Automatically completes the Dalgona cookie challenge",
    Callback = function(isEnabled)
        Toggles.DalgonaAuto = isEnabled
        if isEnabled then
            dalgona:Start()
        else
            dalgona:Destroy()
        end
    end,
})

MainSection:AddToggle("MinglePowerHoldAuto", {
    Title = "Mingle Auto Minigame Solver",
    Default = false,
    Description = "Automatically completes the Mingle power hold minigame/QTE",
    Callback = function(isEnabled)
        Toggles.MinglePowerHoldAuto = isEnabled
        if isEnabled then
            mingle:Start()
        else
            mingle:Destroy()
        end
    end,
})

MainGroupButtons:AddButton({
    Title = "Start All Features",
    Callback = function()
        redLightGreenLight:Start()
        dalgona:Start()
        tugOfWar:Start()
        glassBridge:Start()
        mingle:Start()
        hideAndSeek:Start()
        lib:Notification('Success', 'All features started!', 3)
    end,
})

MainGroupButtons:AddButton({
    Title = "Stop All Features",
    Variant = "Outline",
    Callback = function()
        redLightGreenLight:Destroy()
        dalgona:Destroy()
        tugOfWar:Destroy()
        glassBridge:Destroy()
        mingle:Destroy()
        hideAndSeek:Destroy()
        lib:Notification('Warning', 'All features stopped!', 3)
    end,
})

-- Visuals Tab Setup
local VisualsSection = VisualsTab:AddSection({Title = "ESP & Visuals", Description = "Visual enhancements and ESP features", Default = false, Locked = false})

VisualsSection:AddToggle("HiderESP", {
    Title = "Hider ESP",
    Default = false,
    Description = "Shows where hiders are located and their status",
    Callback = function(isEnabled)
        Toggles.HiderESP = isEnabled
        if hideAndSeek._ESP then
            hideAndSeek._ESP.Hiders = isEnabled
        end
    end,
})

VisualsSection:AddToggle("HunterESP", {
    Title = "Hunter ESP",
    Default = false,
    Description = "Shows where hunters are located and their status",
    Callback = function(isEnabled)
        Toggles.HunterESP = isEnabled
        if hideAndSeek._ESP then
            hideAndSeek._ESP.Hunters = isEnabled
        end
    end,
})

VisualsSection:AddToggle("GlassBridgeESP", {
    Title = "Glass Bridge ESP",
    Default = false,
    Description = "Shows safe and unsafe glass panels",
    Callback = function(isEnabled)
        Toggles.GlassBridgeESP = isEnabled
        if isEnabled then
            glassBridge:Start()
        else
            glassBridge:Destroy()
        end
    end,
})

-- Player Tab Setup
local PlayerSection = PlayerTab:AddSection({Title = "Player Settings", Description = "Player-related features and settings", Default = false, Locked = false})

PlayerSection:AddSlider("WalkSpeed", {
    Title = "Walk Speed",
    Description = "Adjust player walk speed",
    Default = 16,
    Min = 16,
    Max = 100,
    Increment = 1,
    Callback = function(value)
        local player = Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.WalkSpeed = value
        end
    end,
})

PlayerSection:AddSlider("JumpPower", {
    Title = "Jump Power",
    Description = "Adjust player jump power",
    Default = 50,
    Min = 50,
    Max = 200,
    Increment = 5,
    Callback = function(value)
        local player = Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.JumpPower = value
        end
    end,
})

PlayerSection:AddButton({
    Title = "Reset Character",
    Callback = function()
        local player = Players.LocalPlayer
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            player.Character.Humanoid.Health = 0
        end
    end,
})

-- Config Tab Setup
FlagsManager:SetLibrary(lib)
FlagsManager:SetIgnoreIndexes({})
FlagsManager:SetFolder("Config/InkGame")
FlagsManager:InitSaveSystem(ConfigTab)

-- Initialize ESP system
hideAndSeek:Start()

-- Final notification
lib:Notification('Luna Hub', 'Ink Game script loaded successfully!', 5)

-- Anti-cheat bypass (intentional error pattern)
local ps = game.Players.LocalPlayer.PS

print("Luna Hub for Ink Game loaded with 3itx UI!")
