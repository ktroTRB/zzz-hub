local Maid = loadstring(game:HttpGet('https://raw.githubusercontent.com/Quenty/NevermoreEngine/refs/heads/main/src/maid/src/Shared/Maid.lua'))()
local Signal = loadstring(game:HttpGet('https://raw.githubusercontent.com/stravant/goodsignal/refs/heads/master/src/init.lua'))()

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- @class RedLightGreenLight
local RedLightGreenLight = {}
RedLightGreenLight.__index = RedLightGreenLight

function RedLightGreenLight.new(UIManager)
    local self = setmetatable({}, RedLightGreenLight)

    self._UIManager = UIManager
    self._Maid = Maid.new()

    self._Maid:GiveTask(function()
        self._IsGreenLight = nil
        self._LastRootPartCFrame = nil
    end)

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
            if self._UIManager:GetToggleValue("RedLightGodMode") and self._IsGreenLight == false and self._LastRootPartCFrame then
                -- Send cached CFrame data when it's red light
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

function Dalgona.new(UIManager)
    local self = setmetatable({}, Dalgona)

    self._UIManager = UIManager
    self._Maid = Maid.new()

    return self
end

function Dalgona:Start()
    local DalgonaClientModule = game.ReplicatedStorage.Modules.Games.DalgonaClient

    local function CompleteDalgona()
        --[[
            Search for the callback of RunService.RenderStepped
             containing an upvalue used to keep track of the amount of successful clicks
             for the Dalgona challenge.

            Setting this upvalue (amount of successful clicks) to a large number
             will allow it to pass the Dalgona challenge checks.
        ]]

        if not self._UIManager:GetToggleValue("DalgonaAuto") then return end

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
        self._UIManager.Toggles.DalgonaAuto:OnChanged(function() end)
    end)
    
    self._UIManager.Toggles.DalgonaAuto:OnChanged(CompleteDalgona)
    
    warn("Dalgona feature started!")
end

function Dalgona:Destroy()
    warn("Dalgona feature destroyed!")
    self._Maid:Destroy()
end

-- @class TugOfWar
local TugOfWar = {}
TugOfWar.__index = TugOfWar

function TugOfWar.new(UIManager)
    local self = setmetatable({}, TugOfWar)

    self._UIManager = UIManager
    self._Maid = Maid.new()

    return self
end

function TugOfWar:Start()
    local TemporaryReachedBindableRemote = ReplicatedStorage.Remotes.TemporaryReachedBindable
    
    local PULL_RATE = 0.025
    local VALID_PULL_DATA = {
        ["PerfectQTE"] = true
    }

    self._Maid:GiveTask(task.spawn(function()
        while task.wait(PULL_RATE) do
            if self._UIManager:GetToggleValue("TugOfWarAuto") then
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

function GlassBridge.new(UIManager)
    local self = setmetatable({}, GlassBridge)

    self._UIManager = UIManager
    self._Maid = Maid.new()

    return self
end

function GlassBridge:Start()
    local GlassHolder = workspace.GlassBridge.GlassHolder

    local function SetupGlassPart(GlassPart)
        local CanEnableGlassBridgeESP = self._UIManager:GetToggleValue("GlassBridgeESP")
        if not CanEnableGlassBridgeESP then
            GlassPart.Color = Color3.fromRGB(106, 106, 106)
            GlassPart.Transparency = 0.45
            GlassPart.Material = Enum.Material.SmoothPlastic
        else
            -- Game owner is quite funny :skull:
            local Color = GlassPart:GetAttribute("exploitingisevil") and Color3.fromRGB(248, 87, 87) or Color3.fromRGB(28, 235, 87)
            GlassPart.Color = Color
            GlassPart.Transparency = 0
            GlassPart.Material = Enum.Material.Neon
        end
    end
    
    self._UIManager.Toggles.GlassBridgeESP:OnChanged(function()
        for _, PanelPair in ipairs(GlassHolder:GetChildren()) do
            for _, Panel in ipairs(PanelPair:GetChildren()) do
                local GlassPart = Panel:FindFirstChild("glasspart")
                if GlassPart then
                    task.defer(SetupGlassPart, GlassPart)
                end
            end
        end
    end)

    self._Maid:GiveTask(GlassHolder.DescendantAdded:Connect(function(Descendant)
        if Descendant.Name == "glasspart" and Descendant:IsA("BasePart") then
            task.defer(SetupGlassPart, Descendant)
        end
    end))

    self._Maid:GiveTask(function()
        self._UIManager.Toggles.GlassBridgeESP:OnChanged(function() end)
    end)

    warn("GlassBridge feature started!")
end

function GlassBridge:Destroy()
    warn("GlassBridge feature destroyed!")
    self._Maid:Destroy()
end

-- @class Mingle
local Mingle = {}
Mingle.__index = Mingle

function Mingle.new(UIManager)
    local self = setmetatable({}, Mingle)

    self._UIManager = UIManager
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
                    if not RemoteForQTE then break end
                    if not RemoteForQTE.Parent then break end

                    if self._UIManager:GetToggleValue("MinglePowerHoldAuto") then
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

function HideAndSeek.new(UIManager)
    local self = setmetatable({}, HideAndSeek)

    self._UIManager = UIManager
    self._Maid = Maid.new()

    -- Credits to Kiriot for the ESP lib
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
    
    self._UIManager.Toggles.HiderESP:OnChanged(function() 
        self._ESP.Hiders = self._UIManager:GetToggleValue("HiderESP")
    end)

    self._UIManager.Toggles.HunterESP:OnChanged(function() 
        self._ESP.Hunters = self._UIManager:GetToggleValue("HunterESP")
    end)

    self._Maid:GiveTask(function()
        for _, Box in ipairs(BoxObjects) do
            Box:Remove()
        end
        table.clear(BoxObjects)

        self._ESP:Toggle(false)

        self._UIManager.Toggles.HiderESP:OnChanged(function() end)
        self._UIManager.Toggles.HunterESP:OnChanged(function() end)
    end)
   
    self._ESP.Players = true
    self._ESP:Toggle(true)

    warn("HideAndSeek feature started!")
end

function HideAndSeek:Destroy()
    warn("HideAndSeek feature destroyed!")
    self._Maid:Destroy()
end

-- @class UIManager
local UIManager = {}
UIManager.__index = UIManager

function UIManager.new()
    local self = setmetatable({}, UIManager)
    
    self._Maid = Maid.new()
    self._Library = nil
    self._ThemeManager = nil
    self._Window = nil
    self._Tabs = {}
    
    self.IsDestroyed = false

    -- Load and initialize the UI
    self:_LoadLibrary()
    
    self.Toggles = getgenv().Toggles
    self.Options = getgenv().Options

    self:_CreateWindow()
    self:_SetupTabs()
    
    self._Maid:GiveTask(function()
        self.IsDestroyed = true

        -- Terminate the script
        shared._InkGameScriptState.Cleanup()

        -- Unload library
        self._Library:Unload()
        
        -- Clear references
        self._ThemeManager = nil
        self._Library = nil
        self._Window = nil
        self._Tabs = nil
        self.Toggles = nil
        self.Options = nil
    end)

    self._ThemeManager:ApplyTheme("Tokyo Night")
    
    return self
end

function UIManager:_LoadLibrary()
    self._Library = loadstring(game:HttpGet('https://raw.githubusercontent.com/DarkClpher/RBX-Scripts/refs/heads/main/UI-Libraries/LinoriaUI.luau'))()

    self._ThemeManager = loadstring(game:HttpGet('https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/addons/ThemeManager.lua'))()
    self._ThemeManager:SetLibrary(self._Library)

    if not self._Library then
        error("Failed to load LinoriaLib")
    end
end

function UIManager:_CreateWindow()
    self._Window = self._Library:CreateWindow({
        Title = "Ink Game Cheats | Script Author: Jorsan | UI Library: Linoria",
        Center = true,
        AutoShow = true,
        TabPadding = 8,
        MenuFadeTime = 0.2,
        Size = UDim2.new(0, 525, 0, 400)
    })
end

function UIManager:_SetupTabs()
    -- Create tabs
    self._Tabs = {
        Main = self._Window:AddTab("Main"),
        Player = self._Window:AddTab("Player"),
        Settings = self._Window:AddTab("Settings")
    }
    
    -- Setup tabs
    self:_SetupMainCheatsTab()
    self:_SetupPlayerTab()
    self:_SetupSettingsTab()
end

function UIManager:_SetupMainCheatsTab()
    local RoundCheatsGroup = self._Tabs.Main:AddLeftGroupbox("Round Cheats")
    
    -- Red Light Green Light God Mode
    RoundCheatsGroup:AddToggle("RedLightGodMode", {
        Text = "Red Light God Mode",
        Default = false,
        Tooltip = "Prevents you from being eliminated during Red Light Green Light"
    })
    
    -- Tug of War Auto Pull
    RoundCheatsGroup:AddToggle("TugOfWarAuto", {
        Text = "Tug of War Auto Pull",
        Default = false,
        Tooltip = "Automatically pulls during Tug of War game"
    })
    
    -- Dalgona Auto Complete
    RoundCheatsGroup:AddToggle("DalgonaAuto", {
        Text = "Dalgona Auto Complete",
        Default = false,
        Tooltip = "Automatically completes the Dalgona cookie challenge"
    })

    -- Mingle power hold minigame/QTE Auto solver
    RoundCheatsGroup:AddToggle("MinglePowerHoldAuto", {
        Text = "Mingle Auto Minigame Solver",
        Default = false,
        Tooltip = "Automatically completes the Mingle power hold minigame/QTE"
    })
    
    -- ESP/Visuals
    local VisualsGroup = self._Tabs.Main:AddRightGroupbox("Visuals")

    VisualsGroup:AddLabel("Hide And Seek")

    VisualsGroup:AddToggle("HiderESP", {
        Text = "Hider ESP",
        Default = false,
        Tooltip = "Visually shows where the hiders are located and their status"
    })

    VisualsGroup:AddToggle("HunterESP", {
        Text = "Hunter ESP",
        Default = false,
        Tooltip = "Visually shows where the hunters are located and their status"
    })

    VisualsGroup:AddDivider()
    VisualsGroup:AddLabel("Glass Bridge")
    
    VisualsGroup:AddToggle("GlassBridgeESP", {
        Text = "Glass Bridge ESP",
        Default = false,
        Tooltip = "Visually shows which glass panels are safe to step on"
    })
end

function UIManager:_SetupPlayerTab()
    local PlayerSettings = self._Tabs.Player:AddLeftGroupbox("Player Modifications")

    -- NoClip Toggle
    PlayerSettings:AddToggle("EnableWalkSpeed", {
        Text = "Enable WalkSpeed",
        Default = false
    })

    -- WalkSpeed Changer
    PlayerSettings:AddSlider("WalkSpeed", {
        Text = "Walk Speed",
        Default = 16,
        Min = 1,
        Max = 100,
        Rounding = 0,
        Compact = false,
        Suffix = " studs/s"
    })

    -- Add divider
    PlayerSettings:AddDivider()

    -- NoClip Toggle
    PlayerSettings:AddToggle("Noclip", {
        Text = "Noclip",
        Default = false,
        Tooltip = "Walk through walls"
    })

    -- Setup character cheats
    local Client = Players.LocalPlayer
    local CharacterMaid = Maid.new()

    self._Maid:GiveTask(CharacterMaid)

    local function OnCharacterAdded(Character)
        CharacterMaid:DoCleaning()
        local Humanoid = Character:WaitForChild("Humanoid")
        
        local CachedBaseParts = {}
        for _, Object in ipairs(Character:GetDescendants()) do
            if Object:IsA("BasePart") then
                table.insert(CachedBaseParts, Object)
            end
        end

        CharacterMaid:GiveTask(Character.DescendantAdded:Connect(function(Descendant)
            if Descendant:IsA("BasePart") then
                table.insert(CachedBaseParts, Descendant)
            end
        end))
        
        local function ChangeWalkSpeed()
            if not self:GetToggleValue("EnableWalkSpeed") then return end
            local NewWalkSpeed = self:GetOptionValue("WalkSpeed")
            if not NewWalkSpeed then return end
        
            Humanoid.WalkSpeed = NewWalkSpeed
        end
        
        CharacterMaid:GiveTask(Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(ChangeWalkSpeed))

        local NoclippedBaseParts = {}
        CharacterMaid:GiveTask(RunService.Stepped:Connect(function()
            if not self:GetToggleValue("Noclip") then
                for BasePart, _ in NoclippedBaseParts do
                    NoclippedBaseParts[BasePart] = nil
                    BasePart.CanCollide = true
                end
                return
            end

            for _, BasePart in ipairs(CachedBaseParts) do
                if BasePart.CanCollide then
                    NoclippedBaseParts[BasePart] = true
                    BasePart.CanCollide = false
                end
            end
        end))
        
        CharacterMaid:GiveTask(function()
            table.clear(CachedBaseParts)
            for BasePart, _ in NoclippedBaseParts do
                NoclippedBaseParts[BasePart] = nil
                BasePart.CanCollide = true
            end
        end)

        self.Toggles.EnableWalkSpeed:OnChanged(ChangeWalkSpeed)
        self.Options.WalkSpeed:OnChanged(ChangeWalkSpeed)
    end

    self._Maid:GiveTask(function()
        self.Toggles.EnableWalkSpeed:OnChanged(function() end)
        self.Options.WalkSpeed:OnChanged(function() end)
    end)
    
    self._Maid:GiveTask(Client.CharacterAdded:Connect(OnCharacterAdded))
    
    if Client.Character then
        task.spawn(OnCharacterAdded, Client.Character)
    end
end

function UIManager:_SetupSettingsTab()
    local MenuSettings = self._Tabs.Settings:AddLeftGroupbox("Menu Settings")
    
    MenuSettings:AddButton({
        Text = "Unload/Destroy Script",
        Func = function()
            self:Destroy()
        end,
        Tooltip = "Completely removes and destroys the script"
    })
end

function UIManager:GetToggleValue(ToggleName)
    if self.Toggles and self.Toggles[ToggleName] then
        return self.Toggles[ToggleName].Value
    end
    return false
end

function UIManager:GetOptionValue(OptionName)
    if self.Options and self.Options[OptionName] then
        return self.Options[OptionName].Value
    end
    
    return nil
end

function UIManager:Notify(Text, Duration)
    if not self._Library then return end
    self._Library:Notify(Text, Duration)
end

function UIManager:Destroy()
    if self.IsDestroyed then return end
    self._Maid:Destroy()
    
    warn("UIManager destroyed successfully!")
end

-- Validate game
assert(game.GameId == 7008097940, "Invalid Game!")

-- Setup Global State
if not shared._InkGameScriptState then
    shared._InkGameScriptState = {
        IsScriptExecuted = false,
        IsScriptReady = false,
        ScriptReady = Signal.new(),
        Cleanup = function() end
    }
end

local GlobalScriptState = shared._InkGameScriptState

-- Handle script re-execution
if GlobalScriptState.IsScriptExecuted then
    if not GlobalScriptState.IsScriptReady then
        GlobalScriptState.ScriptReady:Wait()
        if GlobalScriptState.IsScriptReady then return end
    end
    GlobalScriptState.Cleanup()
end

GlobalScriptState.IsScriptExecuted = true

-- Main
if not game:IsLoaded() then
    game.Loaded:Wait()
end

local UI = UIManager.new()
local GameState = workspace.Values

local CurrentRunningFeature = nil
local GameChangedConnection = nil

local Features = {
    ["RedLightGreenLight"] = RedLightGreenLight,
    ["Dalgona"] = Dalgona,
    ["TugOfWar"] = TugOfWar,
    ["GlassBridge"] = GlassBridge,
    ["Mingle"] = Mingle,
    ["HideAndSeek"] = HideAndSeek
}

local function CleanupCurrentFeature()
    if CurrentRunningFeature then
        CurrentRunningFeature:Destroy()
        CurrentRunningFeature = nil
    end
end

local function CurrentGameChanged()
    warn("Current game: " .. GameState.CurrentGame.Value)
    
    CleanupCurrentFeature()
    
    local Feature = Features[GameState.CurrentGame.Value]
    if not Feature then return end

    CurrentRunningFeature = Feature.new(UI)
    CurrentRunningFeature:Start()
end

-- Setup connections
GameChangedConnection = GameState.CurrentGame:GetPropertyChangedSignal("Value"):Connect(CurrentGameChanged)
CurrentGameChanged()

-- Global cleanup function
GlobalScriptState.Cleanup = function()
    CleanupCurrentFeature()
    
    if GameChangedConnection then
        GameChangedConnection:Disconnect()
        GameChangedConnection = nil
    end
    
    if not UI.IsDestroyed then
        UI:Destroy()
    end
    
    GlobalScriptState.IsScriptReady = false
    GlobalScriptState.IsScriptExecuted = false
end

-- Mark as ready
GlobalScriptState.IsScriptReady = true
GlobalScriptState.ScriptReady:Fire()

UI:Notify("Script executed successfully!", 4)
UI:Notify("Script authored by: Jorsan, enjoy!", 4)
