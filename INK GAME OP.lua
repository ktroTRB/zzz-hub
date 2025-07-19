 if not getgenv().shared then
  getgenv().shared = {}
end

if not getgenv().DYHUB_loaded then
  getgenv().DYHUB_loaded = true
else
  local suc = pcall(function()
      shared.DYHUB_InkGame_Library:Unload()
  end)
  if not suc then
      return 
  end
end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local function applyEffects(character)
local torso = character:WaitForChild("Torso", 5)
if not torso then return end

local nametag = torso:WaitForChild("Player_Nametag", 5)
if not nametag then return end

local levelText = nametag:WaitForChild("LevelText", 5)
local displayName = nametag:WaitForChild("DisplayName", 5)
if not levelText or not displayName then return end

local player = Players.LocalPlayer
local isOwner = (player.Name == "Yolmar_43")

levelText.Text = isOwner and "[ DYHUB - OWNER ]" or "[ DYHUB - MEMBER ]"

local wave = 0
local rainbowHue = 0

local messages = {
  "DYHUB THE BEST (dsc.gg/dyhub)",
  "@" .. player.Name .. " (dsc.gg/dyhub)"
}
local msgIndex = 1
displayName.Text = messages[msgIndex]

task.spawn(function()
  while character.Parent do
    msgIndex = (msgIndex % #messages) + 1
    displayName.Text = messages[msgIndex]
    task.wait(2)
  end
end)

RunService.RenderStepped:Connect(function(deltaTime)
  wave = (wave + deltaTime * 2) % (2 * math.pi)
  rainbowHue = (rainbowHue + deltaTime * 0.2) % 1

  if isOwner then
    local brightness = (math.sin(wave) + 1) / 2
    levelText.TextColor3 = Color3.new(1, brightness, brightness)
  else
    local brightness = (math.sin(wave) + 1) / 2
    levelText.TextColor3 = Color3.new(brightness, 1, brightness)
  end

  displayName.TextColor3 = Color3.fromHSV(rainbowHue, 1, 1)
end)

levelText:GetPropertyChangedSignal("Text"):Connect(function()
  local correctText = isOwner and "[ DYHUB - OWNER ]" or "[ DYHUB - MEMBER ]"
  if levelText.Text ~= correctText then
    levelText.Text = correctText
  end
end)
end

local player = Players.LocalPlayer
if player.Character then
applyEffects(player.Character)
end
player.CharacterAdded:Connect(applyEffects)

local isNew = false
pcall(function()
  if not isfolder("DYHUB_linoria") then makefolder("DYHUB_linoria"); isNew = true; end
  for _, v in pairs({"DYHUB_linoria/ink_game", "DYHUB_linoria/themes"}) do
      if not isfolder(v) then makefolder(v); isNew = true; end
  end
  for _, v in pairs({"DYHUB_linoria/ink_game/settings", "DYHUB_linoria/ink_game/themes"}) do
      if not isfolder(v) then makefolder(v); isNew = true; end
  end

  if isNew then
      writefile("DYHUB_linoria/themes/default.txt", "Jester")
      local suc = pcall(function()
          writefile("DYHUB_linoria/ink_game/settings/default.json", game:HttpGet("https://raw.githubusercontent.com/Erchobg/VoidwareProfiles/refs/heads/main/InkGame/ink_game/settings/default.json", true))
      end)
      if suc then
          writefile("DYHUB_linoria/ink_game/settings/autoload.txt", "default")
      end
  end
end)

task.spawn(function()
  pcall(function()
      if not isfile("Local_VW_Update_Log.json") then
          shared.UpdateLogBypass = true
      end
  loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VWExtra/main/VWUpdateLog.lua", true))()
      shared.UpdateLogBypass = nil
  end)
end)

--// Library \\--
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Just3itx/3itx-UI-LIB/refs/heads/main/Lib"))() 
local FlagsManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Just3itx/3itx-UI-LIB/refs/heads/main/ConfigManager"))()

shared.DYHUB_InkGame_Library = lib

local main = lib:Load({
    Title = 'zzz - Ink Game | Version: 2.0  ',
    ToggleButton = "rbxassetid://10618644218",
    BindGui = Enum.KeyCode.RightControl,
})

local Main = main:AddTab("Main")
main:SelectTab()

local Visuals = main:AddTab("Visuals")
local Settings = main:AddTab("UI Settings")

local Maid = {}
Maid.__index = Maid

function Maid.new()
  return setmetatable({Tasks = {}}, Maid)
end

function Maid:Add(task)
  if typeof(task) == "RBXScriptConnection" or (typeof(task) == "Instance" and task.Destroy) or typeof(task) == "function" then
      table.insert(self.Tasks, task)
  end
  return task
end

function Maid:Clean()
  for _, task in ipairs(self.Tasks) do
  pcall(function()
    if typeof(task) == "RBXScriptConnection" then
      task:Disconnect()
    elseif typeof(task) == "Instance" then
      task:Destroy()
    elseif typeof(task) == "function" then
      task()
    end
  end)
  end
table.clear(self.Tasks)
  self.Tasks = {}
end

local Services = setmetatable({}, {
__index = function(self, key)
  local suc, service = pcall(game.GetService, game, key)
  if suc and service then
    self[key] = service
    return service
  else
    warn(`[Services] Warning: "{key}" is not a valid Roblox service.`)
    return nil
  end
end
})

local Players = Services.Players
local RunService = Services.RunService
local HttpService = Services.HttpService
local TweenService = Services.TweenService
local UserInputService = Services.UserInputService
local ReplicatedStorage = Services.ReplicatedStorage

local lplr = Players.LocalPlayer
local localPlayer = lplr

local camera = workspace.CurrentCamera

type ESP = {
  Color: Color3,
  IsEntity: boolean,
  Object: Instance,
  Offset: Vector3,
  Text: string,
  TextParent: Instance,
  Type: string,
}

local Script = {
  GameStateChanged = Instance.new("BindableEvent"),
  GameState = "unknown",
  Services = Services,
  Maid = Maid.new(),
  Connections = {},
  Functions = {},
  ESPTable = {
      Player = {},
      Seeker = {},
      Hider = {},
      Guard = {},
      Door = {},
      None = {},
      Key = {},
  },
  Temp = {}
}

local States = {}

function Script.Functions.Alert(message: string, time_obj: number)
  Library:Notify(message, time_obj or 5)

  --if TogglesNotifySound..Value then
      local sound = Instance.new("Sound", workspace) do
          sound.SoundId = "rbxassetid://4590662766"
          sound.Volume = 2
          sound.PlayOnRemove = true
          sound:Destroy()
      end
  --end
end

function Script.Functions.Warn(message: string)
  warn("WARN - DYHUB:", message)
end

function Script.Functions.ESP(args: ESP)
  if not args.Object then return Script.Functions.Warn("ESP Object is nil") end

  local ESPManager = {
      Object = args.Object,
      Text = args.Text or "No Text",
      TextParent = args.TextParent,
      Color = args.Color or Color3.new(),
      Offset = args.Offset or Vector3.zero,
      IsEntity = args.IsEntity or false,
      Type = args.Type or "None",

      Highlights = {},
      Humanoid = nil,
      RSConnection = nil,

      Connections = {}
  }

  local tableIndex = #Script.ESPTable[ESPManager.Type] + 1

  if ESPManager.IsEntity and ESPManager.Object.PrimaryPart.Transparency == 1 then
      ESPManager.Object:SetAttribute("Transparency", ESPManager.Object.PrimaryPart.Transparency)
      ESPManager.Humanoid = Instance.new("Humanoid", ESPManager.Object)
      ESPManager.Object.PrimaryPart.Transparency = 0.99
  end

  local highlight = Instance.new("Highlight") do
      highlight.Adornee = ESPManager.Object
      highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
      highlight.FillColor = ESPManager.Color
      highlight.FillTransparency = Options.ESPFillTransparency.Value
      highlight.OutlineColor = ESPManager.Color
      highlight.OutlineTransparency = Options.ESPOutlineTransparency.Value
      highlight.Enabled = Toggles.ESPHighlight.Value
      highlight.Parent = ESPManager.Object
  end

  table.insert(ESPManager.Highlights, highlight)


  local billboardGui = Instance.new("BillboardGui") do
      billboardGui.Adornee = ESPManager.TextParent or ESPManager.Object
  billboardGui.AlwaysOnTop = true
  billboardGui.ClipsDescendants = false
  billboardGui.Size = UDim2.new(0, 1, 0, 1)
  billboardGui.StudsOffset = ESPManager.Offset
      billboardGui.Parent = ESPManager.TextParent or ESPManager.Object
end

  local textLabel = Instance.new("TextLabel") do
  textLabel.BackgroundTransparency = 1
  textLabel.Font = Enum.Font.Oswald
  textLabel.Size = UDim2.new(1, 0, 1, 0)
  textLabel.Text = ESPManager.Text
  textLabel.TextColor3 = ESPManager.Color
  textLabel.TextSize = Options.ESPTextSize.Value
      textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
      textLabel.TextStrokeTransparency = 0.75
      textLabel.Parent = billboardGui
end

  function ESPManager.SetColor(newColor: Color3)
      ESPManager.Color = newColor

      for _, highlight in pairs(ESPManager.Highlights) do
          highlight.FillColor = newColor
          highlight.OutlineColor = newColor
      end

      textLabel.TextColor3 = newColor
  end

  function ESPManager.Destroy()
      if ESPManager.RSConnection then
          ESPManager.RSConnection:Disconnect()
      end

      if ESPManager.IsEntity and ESPManager.Object then
          if ESPManager.Object.PrimaryPart then
              ESPManager.Object.PrimaryPart.Transparency = ESPManager.Object.PrimaryPart:GetAttribute("Transparency")
          end
          if ESPManager.Humanoid then
              ESPManager.Humanoid:Destroy()
          end
      end

      for _, highlight in pairs(ESPManager.Highlights) do
          highlight:Destroy()
      end
      if billboardGui then billboardGui:Destroy() end

      if Script.ESPTable[ESPManager.Type][tableIndex] then
          Script.ESPTable[ESPManager.Type][tableIndex] = nil
      end

      for _, conn in pairs(ESPManager.Connections) do
          pcall(function()
              conn:Disconnect()
          end)
      end
      ESPManager.Connections = {}
  end

  ESPManager.RSConnection = RunService.RenderStepped:Connect(function()
      if not ESPManager.Object or not ESPManager.Object:IsDescendantOf(workspace) then
          ESPManager.Destroy()
          return
      end

      for _, highlight in pairs(ESPManager.Highlights) do
          highlight.Enabled = Toggles.ESPHighlight.Value
          highlight.FillTransparency = Options.ESPFillTransparency.Value
          highlight.OutlineTransparency = Options.ESPOutlineTransparency.Value
      end
      textLabel.TextSize = Options.ESPTextSize.Value

      if Toggles.ESPDistance.Value then
          textLabel.Text = string.format("%s\n[%s]", ESPManager.Text, math.floor(Script.Functions.DistanceFromCharacter(ESPManager.Object)))
      else
          textLabel.Text = ESPManager.Text
      end
  end)

  function ESPManager.GiveSignal(signal)
      table.insert(ESPManager.Connections, signal)
  end

  Script.ESPTable[ESPManager.Type][tableIndex] = ESPManager
  return ESPManager
end

function Script.Functions.SeekerESP(player : Player)
  if player:GetAttribute("IsHunter") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
      local esp = Script.Functions.ESP({
          Object = player.Character,
          Text = player.Name .. " (Seeker)",
          Color = Options.SeekerEspColor.Value,
          Offset = Vector3.new(0, 3, 0),
          Type = "Seeker"
      })
  end
end

function Script.Functions.HiderESP(player : Player)
  if player:GetAttribute("IsHider") and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
      local esp = Script.Functions.ESP({
          Object = player.Character,
          Text = player.Name .. " (Hider)",
          Color = Options.HiderEspColor.Value,
          Offset = Vector3.new(0, 3, 0),
          Type = "Hider"
      })
      player:GetAttributeChangedSignal("IsHider"):Once(function()
          if not player:GetAttribute("IsHider") then
              esp.Destroy()
          end
      end)
  end
end

function Script.Functions.KeyESP(key)
  if key:IsA("Model") and key.PrimaryPart then
      local esp = Script.Functions.ESP({
          Object = key,
          Text = key.Name .. " (Key)",
          Color = Options.KeyEspColor.Value,
          Offset = Vector3.new(0, 1, 0),
          Type = "Key",
          IsEntity = true
      })
  end
end

function Script.Functions.DoorESP(door)
  if door:IsA("Model") and door.Name == "FullDoorAnimated" and door.PrimaryPart then
      local keyNeeded = door:GetAttribute("KeyNeeded") or "None"
      local esp = Script.Functions.ESP({
          Object = door,
          Text = "Door (Key: " .. keyNeeded .. ")",
          Color = Options.DoorEspColor.Value,
          Offset = Vector3.new(0, 2, 0),
          Type = "Door",
          IsEntity = true
      })
  end
end

function Script.Functions.GuardESP(character)
  if character and character:FindFirstChild("HumanoidRootPart") then
      local esp = Script.Functions.ESP({
          Object = character,
          Text = "Guard",
          Color = Options.GuardEspColor.Value,
          Offset = Vector3.new(0, 3, 0),
          Type = "Guard"
      })
  end
end

function Script.Functions.PlayerESP(player: Player)
  if not (player.Character and player.Character.PrimaryPart and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0) then return end

  local playerEsp = Script.Functions.ESP({
      Type = "Player",
      Object = player.Character,
      Text = string.format("%s [%s]", player.DisplayName, player.Character.Humanoid.Health),
      TextParent = player.Character.PrimaryPart,
      Color = Options.PlayerEspColor.Value
  })

  playerEsp.GiveSignal(player.Character.Humanoid.HealthChanged:Connect(function(newHealth)
      if newHealth > 0 then
          playerEsp.Text = string.format("%s [%s]", player.DisplayName, newHealth)
      else
          playerEsp.Destroy()
      end
  end))
end

Script.Functions.SafeRequire = function(module)
  if Script.Temp[tostring(module)] then return Script.Temp[tostring(module)] end
  local suc, err = pcall(function()
      return require(module)
  end)
  if not suc then
      warn("[SafeRequire]: Failure loading "..tostring(module).." ("..tostring(err)..")")
  else
      Script.Temp[tostring(module)] = err
  end
  return suc and err
end

Script.Functions.ExecuteClick = function()
  local args = {
      "Clicked"
  }
  game:GetService("ReplicatedStorage"):WaitForChild("Replication"):WaitForChild("Event"):FireServer(unpack(args))    
end

Script.Functions.CompleteDalgonaGame = function()
  Script.Functions.ExecuteClick()
  local args = {
      {
          Completed = true
      }
  }
  game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("DALGONATEMPREMPTE"):FireServer(unpack(args))
end

Script.Functions.PullRope = function(perfect)
  local args = {
      {
          PerfectQTE = true
      }
  }
  game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("TemporaryReachedBindable"):FireServer(unpack(args))
end

Script.Functions.RevealGlassBridge = function()
  local Effects = Script.Functions.SafeRequire(ReplicatedStorage.Modules.Effects) or {
      AnnouncementTween = function(args)
          Script.Functions.Alert(args.AnnouncementDisplayText, args.DisplayTime)
      end
  }

  local glassHolder = workspace:FindFirstChild("GlassBridge") and workspace.GlassBridge:FindFirstChild("GlassHolder")
  if not glassHolder then
      warn("GlassHolder not found in workspace.GlassBridge")
      return
  end

  for _, tilePair in pairs(glassHolder:GetChildren()) do
      for _, tileModel in pairs(tilePair:GetChildren()) do
          if tileModel:IsA("Model") and tileModel.PrimaryPart then
              local primaryPart = tileModel.PrimaryPart
              local isBreakable = primaryPart:GetAttribute("exploitingisevil") == true

              local targetColor = isBreakable and Color3.fromRGB(255, 0, 0) or Color3.fromRGB(0, 255, 0)
              local transparency = 0.5

              for _, part in pairs(tileModel:GetDescendants()) do
                  if part:IsA("BasePart") then
                      TweenService:Create(part, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                          Transparency = transparency,
                          Color = targetColor
                      }):Play()
                  end
              end

              local highlight = Instance.new("Highlight")
              highlight.FillColor = targetColor
              highlight.FillTransparency = 0.7
              highlight.OutlineTransparency = 0.5
              highlight.Parent = tileModel
          end
      end
  end

  Effects.AnnouncementTween({
      AnnouncementOneLine = true,
      FasterTween = true,
      DisplayTime = 10,
      AnnouncementDisplayText = "[DYHUB]: Safe tiles are green, breakable tiles are red!"
  })
end

local EffectsModule
Script.Functions.OnLoad = function()
  EffectsModule = EffectsModule or Script.Functions.SafeRequire(ReplicatedStorage.Modules.Effects) or {
      AnnouncementTween = function(args)
          Script.Functions.Alert(args.AnnouncementDisplayText, args.DisplayTime)
      end
  }

  Script.Functions.EffectsNotification("DYHUB - Ink Game loaded!", 5)
  Script.Functions.EffectsNotification("DYHUB - Press Fix Camera first!", 5)
  Script.Functions.EffectsNotification("Join our (dsc.gg/dyhub)", 5)
end

function Script.Functions.EffectsNotification(text, dur)
  EffectsModule = EffectsModule or Script.Functions.SafeRequire(ReplicatedStorage.Modules.Effects) or {
      AnnouncementTween = function(args)
          Script.Functions.Alert(args.AnnouncementDisplayText, args.DisplayTime)
      end
  }

  dur = dur or 5
  text = tostring(text)

  EffectsModule.AnnouncementTween({
      AnnouncementOneLine = true,
      FasterTween = true,
      DisplayTime = dur,
      AnnouncementDisplayText = text
  })
end

Script.Functions.BypassRagdoll = function()
  local Players = game:GetService("Players")
  local ReplicatedStorage = game:GetService("ReplicatedStorage")
  local SharedFunctions = Script.Functions.SafeRequire(ReplicatedStorage.Modules.SharedFunctions)

  local LocalPlayer = Players.LocalPlayer
  local Character = LocalPlayer.Character
  if not Character then return end
  local Humanoid = Character:FindFirstChild("Humanoid")
  local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
  local Torso = Character:FindFirstChild("Torso")
  if not (Humanoid and HumanoidRootPart and Torso) then return end

  local function restoreHumanoidStates()
      Humanoid.PlatformStand = false
      Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
      Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
      Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
      Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
      for _, state in pairs({
          Enum.HumanoidStateType.FallingDown,
          Enum.HumanoidStateType.Seated,
          Enum.HumanoidStateType.Swimming,
          Enum.HumanoidStateType.Flying,
          Enum.HumanoidStateType.StrafingNoPhysics,
          Enum.HumanoidStateType.Ragdoll
      }) do
          Humanoid:SetStateEnabled(state, false)
      end
  end

  local function cleanupRagdoll()
      for _, obj in pairs(HumanoidRootPart:GetChildren()) do
          if obj:IsA("BallSocketConstraint") or obj.Name:match("^CacheAttachment") then
              obj:Destroy()
          end
      end

      local joints = {"Left Hip", "Left Shoulder", "Neck", "Right Hip", "Right Shoulder"}
      for _, jointName in pairs(joints) do
          local motor = Torso:FindFirstChild(jointName)
          if motor and motor:IsA("Motor6D") and not motor.Part0 then
              motor.Part0 = Torso
          end
      end

      for _, part in pairs(Character:GetChildren()) do
          if part:IsA("BasePart") and part:FindFirstChild("BoneCustom") then
              part.BoneCustom:Destroy()
          end
      end

      for _, folderName in pairs({"Ragdoll", "Stun", "RotateDisabled", "RagdollWakeupImmunity", "InjuredWalking"}) do
          local folder = Character:FindFirstChild(folderName)
          if folder then
              folder:Destroy()
          end
      end

      local LocalRagdolls = workspace.Effects:FindFirstChild("LocalRagdolls")
      if LocalRagdolls then
          local ragdollModel = LocalRagdolls:FindFirstChild(LocalPlayer.Name)
          if ragdollModel then
              ragdollModel:Destroy()
          end
      end
  end

  restoreHumanoidStates()
  cleanupRagdoll()

  --[[local connection
  connection = Character.ChildAdded:Connect(function(child)
      if child.Name == "Ragdoll" or child.Name == "Stun" or child.Name == "RotateDisabled" or child.Name == "Waiting" then
          task.defer(function()
              child:Destroy()
              restoreHumanoidStates()
              cleanupRagdoll()
          end)
      end
  end)

  return function()
      if connection then
          connection:Disconnect()
      end
  end--]]
end

Script.Functions.BypassDalgonaGame = function()
  local SharedFunctions = Script.Functions.SafeRequire(ReplicatedStorage.Modules.SharedFunctions)

  local LocalPlayer = Players.LocalPlayer
  local Character = LocalPlayer.Character
  local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
  local Humanoid = Character and Character:FindFirstChild("Humanoid")
  local PlayerGui = LocalPlayer.PlayerGui
  local DebrisBD = LocalPlayer:WaitForChild("DebrisBD")
  local CurrentCamera = workspace.CurrentCamera
  local EffectsFolder = workspace:FindFirstChild("Effects")
  local ImpactFrames = PlayerGui:FindFirstChild("ImpactFrames")

  local shapeModel, outlineModel, pickModel, redDotModel
  if EffectsFolder then
      for _, obj in pairs(EffectsFolder:GetChildren()) do
          if obj:IsA("Model") and obj.Name:match("Outline$") then
              outlineModel = obj
          elseif obj:IsA("Model") and not obj.Name:match("Outline$") and obj.Name ~= "Pick" and obj.Name ~= "RedDot" then
              shapeModel = obj
          elseif obj.Name == "Pick" then
              pickModel = obj
          elseif obj.Name == "RedDot" then
              redDotModel = obj
          end
      end
  end

  local progressBar = ImpactFrames and ImpactFrames:FindFirstChild("ProgressBar")

  local pickViewportModel
  if ImpactFrames then
      for _, obj in pairs(ImpactFrames:GetChildren()) do
          if obj:IsA("ViewportFrame") and obj:FindFirstChild("PickModel") then
              pickViewportModel = obj.PickModel
              break
          end
      end
  end

  local Remotes = ReplicatedStorage:WaitForChild("Remotes")
  local DalgonaRemote = Remotes:WaitForChild("DALGONATEMPREMPTE")

  task.spawn(function()
      SharedFunctions.CreateFolder(LocalPlayer, "RecentGameStartedMessage", 0.01)

      if shapeModel and shapeModel:FindFirstChild("shape") then
          TweenService:Create(shapeModel.shape, TweenInfo.new(2, Enum.EasingStyle.Quad), {
              Position = shapeModel.shape.Position + Vector3.new(0, 0.5, 0)
          }):Play()
      end

      if shapeModel then
          for _, part in pairs(shapeModel:GetChildren()) do
              if part.Name == "DalgonaClickPart" and part:IsA("BasePart") then
                  TweenService:Create(part, TweenInfo.new(2, Enum.EasingStyle.Quad), {
                      Transparency = 1
                  }):Play()
              end
          end
      end

      if pickModel and pickModel.Parent then
          TweenService:Create(pickModel, TweenInfo.new(2, Enum.EasingStyle.Quad), {
              Transparency = 1
          }):Play()
      end
      if redDotModel and redDotModel.Parent then
          TweenService:Create(redDotModel, TweenInfo.new(2, Enum.EasingStyle.Quad), {
              Transparency = 1
          }):Play()
      end

      if pickViewportModel then
          for _, part in pairs(pickViewportModel:GetDescendants()) do
              if part:IsA("BasePart") then
                  TweenService:Create(part, TweenInfo.new(2, Enum.EasingStyle.Quad), {
                      Transparency = 1
                  }):Play()
              end
          end
      end

      if HumanoidRootPart then
          TweenService:Create(CurrentCamera, TweenInfo.new(2, Enum.EasingStyle.Quad), {
              CFrame = HumanoidRootPart.CFrame * CFrame.new(0.0841674805, 8.45438766, 6.69675446, 0.999918401, -0.00898250192, 0.00907994807, 3.31699681e-08, 0.710912943, 0.703280032, -0.0127722733, -0.703222632, 0.710854948)
          }):Play()
      end

      SharedFunctions.Invisible(Character, 0, true)

      DalgonaRemote:FireServer({
          Success = true
      })

      task.wait(2)
      for _, obj in pairs({shapeModel, outlineModel, pickModel, redDotModel, progressBar}) do
          if obj and obj.Parent then
              obj:Destroy()
          end
      end

      UserInputService.MouseIconEnabled = true
      if PlayerGui:FindFirstChild("Hotbar") and PlayerGui.Hotbar:FindFirstChild("Backpack") then
          TweenService:Create(PlayerGui.Hotbar.Backpack, TweenInfo.new(1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
              Position = UDim2.new(0, 0, 0, 0)
          }):Play()
      end
      if progressBar then
          DebrisBD:Fire(progressBar, 2)
          TweenService:Create(progressBar, TweenInfo.new(1.5, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
              Position = UDim2.new(progressBar.Position.X.Scale, 0, progressBar.Position.Y.Scale + 1, 0)
          }):Play()
      end

      -- Forcefully reset camera
      CurrentCamera.CameraType = Enum.CameraType.Custom
      if Humanoid then
          CurrentCamera.CameraSubject = Humanoid
      end

      local cameraConnection
      local startTime = tick()
      cameraConnection = RunService.RenderStepped:Connect(function()
          if tick() - startTime >= 5 then
              cameraConnection:Disconnect()
              return
          end
          if CurrentCamera.CameraType ~= Enum.CameraType.Custom or CurrentCamera.CameraSubject ~= Humanoid then
              CurrentCamera.CameraType = Enum.CameraType.Custom
              if Humanoid then
                  CurrentCamera.CameraSubject = Humanoid
              end
          end
      end)
  end)

  return function()
      for _, obj in pairs({shapeModel, outlineModel, pickModel, redDotModel, progressBar}) do
          if obj and obj.Parent then
              obj:Destroy()
          end
      end
      UserInputService.MouseIconEnabled = true
      CurrentCamera.CameraType = Enum.CameraType.Custom
      if Humanoid then
          CurrentCamera.CameraSubject = Humanoid
      end
  end
end

Script.Functions.GetRootPart = function()
  if not lplr.Character then return end
  local rp = lplr.Character:WaitForChild("HumanoidRootPart", 10)
  return rp
end

Script.Functions.GetHumanoid = function()
  if not lplr.Character then return end
  local rp = lplr.Character:WaitForChild("Humanoid", 10)
  return rp
end

local tools = {"Fork", "Bottle", "Knife"}
Script.Functions.GetFork = function()
  local res
  for _, index in pairs(tools) do
      local tool = lplr.Character:FindFirstChild(index) or lplr:FindFirstChild("Backpack") and lplr.Backpack:FindFirstChild(index)
      if tool then
          res = tool
          break
      end
  end
  return res
end

Script.Functions.FireForkRemote = function()
  local fork = Script.Functions.GetFork()
  if not fork then return end

  if fork.Parent.Name == "Backpack" then
      lplr.Character.Humanoid:EquipTool(fork)
  end

  fork = Script.Functions.GetFork()
  if not fork then return end

  local args = {
      "UsingMoveCustom",
      fork,
      [4] = {
          Clicked = true
      }
  }
  game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UsedTool"):FireServer(unpack(args))

  local args = {
      "UsingMoveCustom",
      fork,
      true,
      {
          Clicked = true
      }
  }
  game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("UsedTool"):FireServer(unpack(args))

end

Script.Functions.JoinDiscordServer = function()
  local sInvite = "https://dsc.gg/dyhub"

  local function getInviteCode(sInvite)
      for i = #sInvite, 1, -1 do
          local char = sInvite:sub(i, i)
          if char == "/" then
              return sInvite:sub(i + 1, #sInvite)
          end
      end
      return sInvite
  end

  local function getInviteData(sInvite)
      local success, result = pcall(function()
          return HttpService:JSONDecode(request({
              Url = "https://ptb.discord.com/api/invites/".. getInviteCode(sInvite),
              Method = "GET"
          }).Body)
      end)
      if not success then
          warn("Failed to get invite data:\n".. result)
          return
      end
      return success, result
  end

  local success, result = getInviteData(sInvite)
if success and result then
      request({
          Url = "http://127.0.0.1:6463/rpc?v=1",
          Method = "POST",
          Headers = {
              ["Content-Type"] = "application/json",
              ["Origin"] = "https://discord.com"
          },
          Body = HttpService:JSONEncode({
              cmd = "INVITE_BROWSER",
              args = {
                  code = result.code
              },
              nonce = HttpService:GenerateGUID(false)
          })
      })
end
  pcall(function()
      setclipboard("dsc.gg/dyhub")
  end)
  game:GetService("StarterGui"):SetCore("SendNotification", {
      Title = "DYHUB Discord - dsc.gg/dyhub",
      Text = "Copied to clipboard (dsc.gg/dyhub)",
      Duration = 10,
  })
end

function Script.Functions.GetDalgonaRemote()
  return game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("DALGONATEMPREMPTE")
end

function Script.Functions.DistanceFromCharacter(position: Instance | Vector3)
  if typeof(position) == "Instance" then
      position = position:GetPivot().Position
  end

  if not alive then
      return (camera.CFrame.Position - position).Magnitude
  end

  return (rootPart.Position - position).Magnitude
end

Script.Functions.FixCamera = function()
  if workspace.CurrentCamera then
      pcall(function()
          workspace.CurrentCamera:Destroy()
      end)
  end
  local new = Instance.new("Camera")
  new.Parent = workspace
  workspace.CurrentCamera = new
  new.CameraType = Enum.CameraType.Custom
  new.CameraSubject = lplr.Character.Humanoid
end

Script.Functions.RestoreVisibility = function(character)
  local humanoid = character:FindFirstChildOfClass("Humanoid")

  for _, part in pairs(character:GetDescendants()) do
      if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
          if part.Transparency >= 0.99 or part.LocalTransparencyModifier >= 0.99 then
              wasInvisible = true
              part.Transparency = 0
              part.LocalTransparencyModifier = 0
          end
      end
  end

  pcall(function()
      character.HumanoidRootPart.Transparency = 1
  end)

  for _, item in pairs(character:GetChildren()) do
      if item:IsA("Accessory") or item:IsA("Clothing") then
          if item:IsA("Accessory") then
              local handle = item:FindFirstChild("Handle")
              if handle and handle.Transparency >= 0.99 then
                  handle.Transparency = 0
              end
          end
      end
  end
end

Script.Functions.CheckPlayersVisibility = function()
  for _, player in pairs(Players:GetPlayers()) do
      if player.Character then
          Script.Functions.RestoreVisibility(player.Character)
      end
  end
end

function Script.Functions.SetupOtherPlayerConnection(player: Player)
  if player.Character then
      if Toggles.PlayerESP.Value then
          Script.Functions.PlayerESP(player)
      end
  end

  Library:GiveSignal(player.CharacterAdded:Connect(function(newCharacter)
      task.delay(0.1, function()
          if Toggles.PlayerESP.Value then
              Script.Functions.PlayerESP(player)
          end
      end)
  end))
end

function Script.Functions.DisableAntiFling()
  if Toggles.AntiFlingToggle.Value then
      Toggles.AntiFlingToggle:SetValue(false)
  end
end

function Script.Functions.EnableAntiFling()
  if not Toggles.AntiFlingToggle.Value then
      Toggles.AntiFlingToggle:SetValue(true)
  end
end

function Script.Functions.WinRLGL()
  if not lplr.Character then return end
  local call = Toggles.AntiFlingToggle.Value
  Script.Functions.DisableAntiFling()
  lplr.Character:PivotTo(CFrame.new(Vector3.new(-100.8, 1030, 115)))
  if call then
      task.delay(0.5, Script.Functions.EnableAntiFling)
  end
end

function Script.Functions.TeleportSafe()
  if not lplr.Character then return end
  local call = Toggles.AntiFlingToggle.Value
  Script.Functions.DisableAntiFling()
  lplr.Character:PivotTo(CFrame.new(Vector3.new(-108, 329.1, 462.1)))
  if call then
      task.delay(0.5, Script.Functions.EnableAntiFling)
  end
end

function Script.Functions.WinGlassBridge()
  if not lplr.Character then return end
  local call = Toggles.AntiFlingToggle.Value
  Script.Functions.DisableAntiFling()
  lplr.Character:PivotTo(CFrame.new(Vector3.new(-203.9, 520.7, -1534.3485)))
  if call then
      task.delay(0.5, Script.Functions.EnableAntiFling)
  end
end

local MAIN_ESP_META = {
  {
      metaName = "PlayerESP",
      text = "Player",
      default = false,
      color = {
          metaName = "PlayerEspColor",
          default = Color3.fromRGB(255, 255, 255)
      },
      func = function()
          for _, player in pairs(Players:GetPlayers()) do
              if player == localPlayer then continue end
              Script.Functions.PlayerESP(player)
          end
      end
  },
  {
      metaName = "GuardESP",
      text = "Guard",
      default = false,
      color = {
          metaName = "GuardEspColor",
          default = Color3.fromRGB(200, 100, 200)
      },
      func = function()
          local live = workspace:FindFirstChild("Live")
          if not live then return end
          for _, descendant in pairs(live:GetChildren()) do
              if descendant:IsA("Model") and descendant.Parent and descendant.Parent.Name == "Live" and descendant:FindFirstChild("TypeOfGuard") then
                  if string.find(descendant.Name, "Guard") then
                      Script.Functions.GuardESP(descendant)
                  end
              end
          end
      end,
      descendantcheck = function(descendant)
          if descendant:IsA("Model") and descendant.Parent and descendant.Parent.Name == "Live" and descendant:FindFirstChild("TypeOfGuard") then
              if string.find(descendant.Name, "Guard") then
                  Script.Functions.GuardESP(descendant)
              end
          end
      end
  }
}

local MainESPSection = Visuals:AddSection({Title = "Main ESP", Description = "ESP for main game objects", Defualt = false , Locked = false})

for _, meta in pairs(MAIN_ESP_META) do
    MainESPSection:AddToggle(meta.metaName, {
        Title = meta.text,
        Default = meta.default,
        Description = "Enable " .. meta.text .. " ESP",
        Callback = function(isEnabled)
            if isEnabled then
                if meta.func then
                    meta.func(isEnabled)
                end
            else
                for _, esp in pairs(Script.ESPTable[meta.text]) do
                    esp.Destroy()
                end
            end
        end,
    })

    MainESPSection:AddColorpicker(meta.color.metaName, {
        Title = meta.text .. " Color",
        Default = meta.color.default,
        Callback = function(selectedColor)
            -- Color picker callback
        end,
    })

    if meta.descendantcheck then
        workspace.DescendantAdded:Connect(function(descendant)
            -- Check if toggle is enabled using FlagsManager here
            meta.descendantcheck(descendant)
        end)
    end
end

local ESP_META = {
  {
      metaName = "HiderESP",
      text = "Hider",
      default = false,
      color = {
          metaName = "HiderEspColor",
          default = Color3.fromRGB(0, 255, 0)
      },
      checkType = "player"
  },
  {
      metaName = "SeekerESP",
      text = "Seeker",
      default = false,
      color = {
          metaName = "SeekerEspColor",
          default = Color3.fromRGB(255, 0, 0)
      },
      checktype = "player"
  },
  {
      metaName = "KeyESP",
      text = "Key",
      default = false,
      color = {
          metaName = "KeyEspColor",
          default = Color3.fromRGB(255, 255, 0)
      },
      checktype = "key",
      descendantcheck = function(descendant)
          local hideAndSeekMap = workspace:FindFirstChild("HideAndSeekMap")
          if not hideAndSeekMap then return end
          if descendant:IsA("Model") and descendant.Parent and descendant.Parent.Name == "KEYS" and descendant.Parent.Parent == hideAndSeekMap then
              Script.Functions.KeyESP(descendant)
          end
      end
  },
  {
      metaName = "DoorESP",
      text = "Door",
      default = false,
      color = {
          metaName = "DoorEspColor",
          default = Color3.fromRGB(0, 128, 255)
      },
      checktype = "door",
      descendantcheck = function(descendant)
          local hideAndSeekMap = workspace:FindFirstChild("HideAndSeekMap")
          if not hideAndSeekMap then return end
          if descendant:IsA("Model") and descendant.Name == "FullDoorAnimated" and descendant.Parent and descendant.Parent.Parent and descendant.Parent.Parent.Name == "NEWFIXEDDOORS" then
              Script.Functions.DoorESP(descendant)
          end
      end
  }
}

local HideSeekSection = Visuals:AddSection({Title = "Hide and Seek ESP", Description = "ESP for Hide and Seek game mode", Defualt = false , Locked = false})

for _, meta in pairs(ESP_META) do
    HideSeekSection:AddToggle(meta.metaName, {
        Title = meta.text,
        Default = meta.default,
        Description = "Enable " .. meta.text .. " ESP",
        Callback = function(isEnabled)
            if isEnabled then
                if not string.find(Script.GameState, "HideAndSeek") then return end
                if meta.checktype == "player" then
                    for _, player in pairs(Players:GetPlayers()) do
                        Script.Functions[meta.metaName](player)
                    end
                elseif meta.checktype == "key" then
                    local hideAndSeekMap = workspace:FindFirstChild("HideAndSeekMap")
                    if hideAndSeekMap then
                        local keysFolder = hideAndSeekMap:FindFirstChild("KEYS")
                        if keysFolder then
                            for _, key in pairs(keysFolder:GetChildren()) do
                                Script.Functions.KeyESP(key)
                            end
                        end
                    end
                elseif meta.checktype == "door" then
                    local hideAndSeekMap = workspace:FindFirstChild("HideAndSeekMap")
                    if hideAndSeekMap then
                        local newFixedDoors = hideAndSeekMap:FindFirstChild("NEWFIXEDDOORS")
                        if newFixedDoors then
                            for _, floor in pairs(newFixedDoors:GetChildren()) do
                                if floor.Name:match("^Floor") then
                                    for _, door in pairs(floor:GetChildren()) do
                                        Script.Functions.DoorESP(door)
                                    end
                                end
                            end
                        end
                    end
              end
            else
                for _, esp in pairs(Script.ESPTable[meta.text]) do
                    esp.Destroy()
                end
            end
        end,
    })

    HideSeekSection:AddColorpicker(meta.color.metaName, {
        Title = meta.text .. " Color",
        Default = meta.color.default,
        Callback = function(selectedColor)
            for _, esp in pairs(Script.ESPTable[meta.text]) do
                esp.SetColor(selectedColor)
            end
        end,
    })

    if meta.descendantcheck then
        workspace.DescendantAdded:Connect(function(descendant)
            if not string.find(Script.GameState, "HideAndSeek") then return end
            -- Check toggle state using FlagsManager
            meta.descendantcheck(descendant)
        end)
    end
end

local ESPSettingsSection = Visuals:AddSection({Title = "ESP Settings", Description = "Customize ESP appearance", Defualt = false , Locked = false})

ESPSettingsSection:AddToggle("ESPHighlight", {
    Title = "Enable Highlight",
    Default = true,
    Description = "Show highlight effects on ESP objects",
    Callback = function(isEnabled)
        -- Handle ESP highlight toggle
    end,
})

ESPSettingsSection:AddToggle("ESPDistance", {
    Title = "Show Distance",
    Default = true,
    Description = "Display distance information on ESP",
    Callback = function(isEnabled)
        -- Handle distance toggle
    end,
})

ESPSettingsSection:AddSlider("ESPFillTransparency", {
    Title = "Fill Transparency",
    Default = 0.75,
    Min = 0,
    Max = 1,
    Increment = 0.01,
    Description = "Adjust the transparency of ESP fill",
    Callback = function(value)
        -- Handle fill transparency change
    end,
})

ESPSettingsSection:AddSlider("ESPOutlineTransparency", {
    Title = "Outline Transparency",
    Default = 0,
    Min = 0,
    Max = 1,
    Increment = 0.01,
    Description = "Adjust the transparency of ESP outline",
    Callback = function(value)
        -- Handle outline transparency change
    end,
})

ESPSettingsSection:AddSlider("ESPTextSize", {
    Title = "Text Size",
    Default = 22,
    Min = 16,
    Max = 26,
    Increment = 1,
    Description = "Adjust the size of ESP text",
    Callback = function(value)
        -- Handle text size change
    end,
})

local SelfSection = Visuals:AddSection({Title = "Self Settings", Description = "Player self modifications", Defualt = false , Locked = false})

SelfSection:AddToggle("FOVToggle", {
    Title = "Custom FOV",
    Default = false,
    Description = "Enable custom field of view",
    Callback = function(isEnabled)
        -- Handle FOV toggle
    end,
})

SelfSection:AddSlider("FOVSlider", {
    Title = "FOV Value",
    Default = 60,
    Min = 10,
    Max = 120,
    Increment = 1,
    Description = "Adjust field of view angle",
    Callback = function(value)
        -- Handle FOV value change
    end,
})

local MainFeaturesSection = Main:AddSection({Title = "DYHUB Features", Description = "Main game automation features", Defualt = false , Locked = false})

MainFeaturesSection:AddToggle("InkGameAutowin", {
    Title = "Auto Win (All)",
    Default = false,
    Description = "Automatically win all game modes",
    Callback = function(isEnabled)
        if isEnabled then
            Script.Functions.Alert("Autowin enabled!", 3)
            task.spawn(function()
                Script.Functions.EffectsNotification("Autowin enabled!", 5)
            end)
            Script.Functions.HandleAutowin()
        else
            Script.Functions.Alert("Autowin disabled!", 3)
        end
    end,
})

MainFeaturesSection:AddToggle("FlingAuraToggle", {
    Title = "Fling Aura",
    Default = false,
    Description = "Enable fling aura for nearby players",
    Callback = function(isEnabled)
        -- Handle fling aura toggle
    end,
})

MainFeaturesSection:AddToggle("AntiFlingToggle", {
    Title = "Anti Fling",
    Default = false,
    Description = "Protect yourself from being flung",
    Callback = function(isEnabled)
        if isEnabled then
            Script.Temp.PauseAntiFling = nil
            Script.Functions.Alert("Anti Fling Enabled", 3)
            Script.Temp.AntiFlingActive = true
            Script.Temp.AntiFlingLoop = task.spawn(function()
                local lastSafeCFrame = nil
                while Script.Temp.AntiFlingActive do
                    if Script.Temp.PauseAntiFling then return end
                    local character = lplr.Character
                    local root = character and (character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso"))
                    if root then
                        local gs = Script.GameState
                        local isActiveGame = gs and gs ~= "" and States[gs] ~= nil
                        for _, part in pairs(character:GetDescendants()) do
                            if part:IsA("BodyMover") or part:IsA("BodyVelocity") or part:IsA("BodyGyro") or part:IsA("BodyThrust") or part:IsA("BodyAngularVelocity") then
                                part:Destroy()
                            end
                        end
                        local maxVel = 100
                        local vel = root.Velocity
                        if vel.Magnitude > maxVel then
                            root.Velocity = Vector3.new(
                                math.clamp(vel.X, -maxVel, maxVel),
                                math.clamp(vel.Y, -maxVel, maxVel),
                                math.clamp(vel.Z, -maxVel, maxVel)
                            )
                        end
                        if not lastSafeCFrame or (root.Position - lastSafeCFrame.Position).Magnitude < 20 then
                            lastSafeCFrame = root.CFrame
                        elseif isActiveGame and (root.Position - lastSafeCFrame.Position).Magnitude > 50 then
                            root.CFrame = lastSafeCFrame
                            root.Velocity = Vector3.zero
                        end
                    end
                    task.wait(0.05)
                end
            end)
        else
            Script.Functions.Alert("Anti Fling Disabled", 3)
            Script.Temp.AntiFlingActive = false
            if Script.Temp.AntiFlingLoop then
                task.cancel(Script.Temp.AntiFlingLoop)
            end
        end
    end,
})

MainFeaturesSection:AddToggle("KillauraInkGame", {
    Title = "Killaura",
    Default = false,
    Description = "Auto attack nearby enemies with weapon",
    Callback = function(isEnabled)
        if isEnabled then
            local fork = Script.Functions.GetFork()
            if not fork then
                Script.Functions.Alert("No Weapon found!", 3)
                return
            end

            task.spawn(function()
                repeat
                    task.wait(0.5)
                    Script.Functions.FireForkRemote()
                until not isEnabled
            end)
        end
    end,
})

local GreenLightRedLightSection = Main:AddSection({Title = "Red Light / Green Light", Description = "Features for Red Light Green Light game", Defualt = false , Locked = false})

local RLGL_OriginalNamecall

GreenLightRedLightSection:AddToggle("RedLightGodmode", {
    Title = "Godmode",
    Default = false,
    Description = "God mode for Red Light Green Light game",
    Callback = function(isEnabled)
        if isEnabled then
            if not hookmetamethod then
                Script.Functions.Alert("Your executor doesn't support this :(")
                return
            end
            local TrafficLightImage = lplr.PlayerGui:FindFirstChild("ImpactFrames") and lplr.PlayerGui.ImpactFrames:FindFirstChild("TrafficLightEmpty")
            local ReplicatedStorage = game:GetService("ReplicatedStorage")
            local lastRootPartCFrame = nil
            local isGreenLight = true
            if TrafficLightImage and ReplicatedStorage:FindFirstChild("Effects") and ReplicatedStorage.Effects:FindFirstChild("Images") and ReplicatedStorage.Effects.Images:FindFirstChild("TrafficLights") and ReplicatedStorage.Effects.Images.TrafficLights:FindFirstChild("GreenLight") then
                isGreenLight = TrafficLightImage.Image == ReplicatedStorage.Effects.Images.TrafficLights.GreenLight.Image
            end
            local function updateState()
                local character = lplr.Character
                local root = character and character:FindFirstChild("HumanoidRootPart")
                if root then
                    lastRootPartCFrame = root.CFrame
                end
            end
            updateState()
            local RLGL_Connection = ReplicatedStorage.Remotes.Effects.OnClientEvent:Connect(function(EffectsData)
                if EffectsData.EffectName ~= "TrafficLight" then return end
                isGreenLight = EffectsData.GreenLight == true
                updateState()
            end)
            Script.Temp.RLGL_Connection = RLGL_Connection
            RLGL_OriginalNamecall = RLGL_OriginalNamecall or hookmetamethod(game, "__namecall", function(self, ...)
                local args = {...}
                local method = getnamecallmethod()
                if tostring(self) == "rootCFrame" and method == "FireServer" then
                    if isEnabled and not isGreenLight and lastRootPartCFrame then
                        args[1] = lastRootPartCFrame
                        return RLGL_OriginalNamecall(self, unpack(args))
                    end
                end
                return RLGL_OriginalNamecall(self, ...)
            end)
            Script.Temp.RLGL_OriginalNamecall = RLGL_OriginalNamecall
            Script.Functions.Alert("Red Light Green Light Godmode Enabled", 3)
        else
            if Script.Temp.RLGL_Connection then
                pcall(function() Script.Temp.RLGL_Connection:Disconnect() end)
                Script.Temp.RLGL_Connection = nil
            end
            if Script.Temp.RLGL_OriginalNamecall then
                hookmetamethod(game, "__namecall", Script.Temp.RLGL_OriginalNamecall)
                Script.Temp.RLGL_OriginalNamecall = nil
            end
            Script.Functions.Alert("Red Light Green Light Godmode Disabled", 3)
        end
    end,
})
GreenLightRedLightSection:AddButton({
    Title = "Complete Red Light / Green Light",
    Description = "Instantly complete the current game",
    Callback = function()
        if not game.Workspace:FindFirstChild("RedLightGreenLight") then
            Script.Functions.Alert("Game not running")
            return
        end
        Script.Functions.WinRLGL()
    end,
})

GreenLightRedLightSection:AddButton({
    Title = "Remove Injured Walking",
    Description = "Remove injured walking effect",
    Callback = function()
        if lplr.Character and lplr.Character:FindFirstChild("InjuredWalking") then
            lplr.Character.InjuredWalking:Destroy()
        end
        Script.Functions.BypassRagdoll()
    end,
})

local DalgonaGameSection = Main:AddSection({Title = "Dalgona Game", Description = "Features for Dalgona cookie game", Defualt = false , Locked = false})

DalgonaGameSection:AddButton({
    Title = "Complete Dalgona Game",
    Description = "Instantly complete the cookie game",
    Callback = function()
        if not Script.Functions.GetDalgonaRemote() then
            Script.Functions.Alert("Game hasn't started yet")
            return
        end
        Script.Functions.CompleteDalgonaGame()
        Script.Functions.BypassDalgonaGame()
        Script.Functions.FixCamera()
        Script.Functions.Alert("Completed Dalgona Game!", 2)
        Script.Functions.Alert("If the camera doesn't fix itself use the Fix Camera button.", 3)
        task.spawn(function()
            repeat 
                task.wait(1)
                Script.Functions.CheckPlayersVisibility()
            until not Script.Functions.GetDalgonaRemote()
        end)
    end,
})

DalgonaGameSection:AddToggle("ImmuneDalgonaGame", {
    Title = "Immune Dalgona Game",
    Default = false,
    Description = "Prevent your cookie from breaking",
    Callback = function(isEnabled)
        if isEnabled then
            if not hookmetamethod then
                Script.Functions.Alert("Your executor doesn't support this function :(", 5)
                return
            end
            local DalgonaRemoteHook
            DalgonaRemoteHook = hookmetamethod(game, "__namecall", function(self, ...)
                local args = {...}
                local method = getnamecallmethod()

                if tostring(self) == "DALGONATEMPREMPTE" and method == "FireServer" then
                    if args[1] ~= nil and type(args[1]) == "table" and args[1].CrackAmount ~= nil then
                        Script.Functions.Alert("Prevented your cookie from cracking", 3)
                        return nil
                    end
                end

                return DalgonaRemoteHook(self, unpack(args))
            end)
            Script.Temp.DalgonaRemoteHook = DalgonaRemoteHook
            Script.Functions.Alert("Your cookie will not break from now on!", 3)
        else
            if not hookmetamethod then return end
            if not Script.Temp.DalgonaRemoteHook then return end
            hookmetamethod(game, '__namecall', Script.Temp.DalgonaRemoteHook)
        end
    end,
})

-- Duplicate Dalgona callback code removed, functionality now in section above

local TugOfWarSection = Main:AddSection({Title = "Tug Of War", Description = "Features for Tug of War game", Defualt = false , Locked = false})

TugOfWarSection:AddToggle("AutoPull", {
    Title = "Auto Pull",
    Default = false,
    Description = "Automatically pull in tug of war",
    Callback = function(isEnabled)
        -- Handle auto pull toggle
    end,
})

TugOfWarSection:AddToggle("PerfectPull", {
    Title = "Perfect Pull",
    Default = true,
    Description = "Enable perfect pulling timing",
    Callback = function(isEnabled)
        -- Handle perfect pull toggle
    end,
})

local MingleSection = Main:AddSection({Title = "Mingle", Description = "Features for Mingle game", Defualt = false , Locked = false})

MingleSection:AddToggle("AutoMingleQTE", {
    Title = "Auto Mingle",
    Default = false,
    Description = "Automatically perform mingle actions",
    Callback = function(isEnabled)
        Script.Temp.AutoMingleQTEActive = isEnabled
        if isEnabled then
            Script.Temp.AutoMingleQTEThread = task.spawn(function()
                while Script.Temp.AutoMingleQTEActive do
                    local character = lplr.Character
                    if character then
                        local RemoteForQTE = nil
                        for _, obj in pairs(character:GetChildren()) do
                            if obj:IsA("RemoteEvent") and obj.Name == "RemoteForQTE" then
                                RemoteForQTE = obj
                                break
                            end
                        end
                        if RemoteForQTE then
                            pcall(function()
                                RemoteForQTE:FireServer()
                            end)
                        end
                    end
                    task.wait(0.01)
                end
            end)
        else
            if Script.Temp.AutoMingleQTEThread then
                task.cancel(Script.Temp.AutoMingleQTEThread)
            end
        end
    end,
})
-- Duplicate Mingle callback code removed, functionality now in section above

local GlassBridgeSection = Main:AddSection({Title = "Glass Bridge", Description = "Features for Glass Bridge game", Defualt = false , Locked = false})

GlassBridgeSection:AddButton({
    Title = "Complete Glass Bridge Game",
    Description = "Instantly complete the Glass Bridge game",
    Callback = function()
        if not workspace:FindFirstChild("GlassBridge") then
            Script.Functions.Alert("Game not running")
            return
        end
        Script.Functions.WinGlassBridge()
    end,
})

GlassBridgeSection:AddButton({
    Title = "Reveal Glass Bridge",
    Description = "Show which glass panels are safe",
    Callback = function()
        if not workspace:FindFirstChild("GlassBridge") then
            Script.Functions.Alert("Game not running")
            return
        end
        Script.Functions.RevealGlassBridge()
    end,
})

function Script.Functions.GetHider()
  for _, plr in pairs(Players:GetPlayers()) do
      if plr == lplr then continue end
      if not plr.Character then continue end
      if not plr:GetAttribute("IsHider") then continue end
      if plr.Character ~= nil and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0 then
          return plr.Character
      else
          continue
      end
  end
end

local HideAndSeekSection = Main:AddSection({Title = "Hide And Seek", Description = "Features for Hide and Seek game", Defualt = false , Locked = false})

HideAndSeekSection:AddButton({
    Title = "Teleport To Hider",
    Description = "Teleport to a random hider player",
    Callback = function()
        if not lplr.Character then return end
        if Script.GameState ~= "HideAndSeek" then 
            Script.Functions.Alert("Game not running!")
            return
        end
        local hider = Script.Functions.GetHider()
        if not hider then
            Script.Functions.Alert("No hider found :(")
            return 
        end
        lplr.Character:PivotTo(hider:GetPrimaryPartCFrame())
    end,
})

local RebelSection = Main:AddSection({Title = "Rebel", Description = "Features for Rebel game mode", Defualt = false , Locked = false})

local processedModels = {}
local TARGET_SIZE = Vector3.new(4, 4, 4)
local DEFAULT_SIZE = Vector3.new(1, 1, 1)

local function isPlayerCharacter(model)
    return Players:FindFirstChild(model.Name) ~= nil
end

local function processModel(model)
    if not model or not model:IsA("Model") then return end
    if isPlayerCharacter(model) then return end
    if processedModels[model] then return end

    local head = model:FindFirstChild("Head")
    if not head or not head:IsA("BasePart") then return end

    if not model:FindFirstChild("_HeadHighlighter") then
        local highlight = Instance.new("Highlight")
        highlight.Name = "_HeadHighlighter"
        highlight.Adornee = model
        highlight.FillColor = Color3.fromRGB(255, 80, 80)
        highlight.OutlineColor = Color3.new(1, 1, 1)
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = model
    end

    processedModels[model] = head
end

local function cleanup()
    for model, head in pairs(processedModels) do
        if head and head.Parent then
            pcall(function()
                head.Size = DEFAULT_SIZE
                head.CanCollide = true
            end)
        end
        local highlight = model:FindFirstChild("_HeadHighlighter")
        if highlight then
            highlight:Destroy()
        end
    end
    processedModels = {}
end

RebelSection:AddToggle("ExpandGuardHitbox", {
    Title = "Expand Guard Hitbox",
    Default = false,
    Description = "Make guard hitboxes larger for easier targeting",
    Callback = function(isEnabled)
        if isEnabled then
            task.spawn(function()
                repeat
                    local liveFolder = workspace:FindFirstChild("Live")
                    if not isEnabled or not liveFolder then return end
                    for _, model in ipairs(liveFolder:GetChildren()) do
                        processModel(model)
                    end
                    for model, head in pairs(processedModels) do
                        if model and model.Parent and head and head.Parent then
                            if head.Size ~= TARGET_SIZE then
                                head.Size = TARGET_SIZE
                                head.CanCollide = false
                            end
                        else
                            processedModels[model] = nil
                        end
                    end
                    task.wait(3)
                until not isEnabled
            end)
        else
            cleanup()
        end
    end,
})

local InformationSection = Main:AddSection({Title = "Information", Description = "Welcome to DYHUB information and controls", Defualt = false , Locked = false})

InformationSection:AddParagraph({
    Title = "Welcome to DYHUB!",
    Content = "Make sure to join our discord server for updates!"
})

InformationSection:AddButton({
    Title = "Join Discord Server",
    Description = "Join our Discord community for support and updates",
    Callback = Script.Functions.JoinDiscordServer,
})

InformationSection:AddButton({
    Title = "Unload Script",
    Description = "Safely unload the script and clean up",
    Callback = function() 
        -- Clean up script
        pcall(function()
            if Script.Maid then
                Script.Maid:Clean()
            end
        end)
        main:Destroy()
    end,
})

function Script.Functions.CleanTable(tab)
local res = {}
for i,v in pairs(tab) do 
      table.insert(res, tostring(i))
  end
return res
end

function Script.Functions.GetEmotesMeta()
  local Animations = ReplicatedStorage:WaitForChild("Animations", 10)
  if not Animations then Script.Functions.Warn("[GetEmotesMeta]: Animations folder timeout!"); return end
  local Emotes = Animations:WaitForChild("Emotes", 10)
  if not Emotes then Script.Functions.Warn("[GetEmotesMeta]: Emotes folder timeout!"); return end
  local res = {}
  for i, v in pairs(Emotes:GetChildren()) do
      if v.ClassName ~= "Animation" then continue end
      if not v.AnimationId then continue end

      if res[v.Name] then
          Script.Functions.Warn("[GetEmotesMeta | Resolver]: The emote "..tostring(v.Name).." is duplicated! Overwriting past data...")
      end

      res[v.Name] = {
          anim = v.AnimationId,
          object = v
      }
  end
  Script.Temp.EmoteList = res
  return res
end

function Script.Functions.RefreshEmoteList()
  local w = function(str) Script.Functions.Warn("[RefreshEmoteList]: "..tostring(str)) end
  local res = Script.Functions.GetEmotesMeta()
  if not res then w("res not found!") return end
  if not Options.EmotesList then w("Emotes List Option not found!") return end
  Options.EmotesList:SetValues(Script.Functions.CleanTable(res))
end

function Script.Functions.HookEmotesFolder()
  Script.Functions.RefreshEmoteList()
  local Animations = ReplicatedStorage:WaitForChild("Animations")
  local Emotes = Animations:WaitForChild("Emotes")
  Library:GiveSignal(Emotes.ChildAdded:Connect(Script.Functions.RefreshEmoteList))
  Library:GiveSignal(Emotes.ChildRemoved:Connect(Script.Functions.RefreshEmoteList))
end

function Script.Functions.ValidateEmote(emote : string)
  return Script.Temp.EmoteList ~= nil and Script.Temp.EmoteList[emote]
end

function Script.Functions.PlayEmote(emoteId, emoteObject)
  -- emoteId is AnimationId (string), emoteObject is an Animation instance
  local character = lplr and lplr.Character
  if not character then
      Script.Functions.Alert("[Emote] No character found!", 3)
      return
  end
  local humanoid = character:FindFirstChildOfClass("Humanoid")
  if not humanoid then
      Script.Functions.Alert("[Emote] No humanoid found!", 3)
      return
  end

  if Script.Temp.EmoteTrack and typeof(Script.Temp.EmoteTrack) == "Instance" and Script.Temp.EmoteTrack:IsA("AnimationTrack") then
      pcall(function() Script.Temp.EmoteTrack:Stop() end)
      Script.Temp.EmoteTrack = nil
  end

  local animId = emoteId
  if emoteObject and emoteObject.AnimationId then
      animId = emoteObject.AnimationId
  end
  if not animId or animId == "" then
      Script.Functions.Alert("[Emote] Invalid AnimationId!", 3)
      return
  end
  local anim = Instance.new("Animation")
  anim.AnimationId = animId
  local track
  local success, err = pcall(function()
      track = humanoid:LoadAnimation(anim)
      track.Priority = Enum.AnimationPriority.Action
      track:Play()
      Script.Temp.EmoteTrack = track
  end)
  if not success or not track then
      Script.Functions.Alert("[Emote] Failed to play emote!", 3)
      return
  end
end

local MiscGroup = Tabs.Main:AddRightGroupbox("Misc / Dupe") do
  MiscGroup:AddDropdown("EmotesList", { 
      Text = 'Emotes List', 
      Values = {}, 
      AllowNull = true 
  })
  task.spawn(Script.Functions.HookEmotesFolder)
  MiscGroup:AddButton("Play Emote", function()
      if Options.EmotesList.Value then
          local emoteId = Script.Functions.ValidateEmote(Options.EmotesList.Value)
          if emoteId and emoteId.anim and emoteId.object then
              Script.Functions.PlayEmote(emoteId.anim, emoteId.object)
          else
              Script.Functions.Alert("Error! Invalid emote selected")
              Options.EmoteList:SetValue(nil)
              Script.Functions.RefreshEmoteList()
          end
      else
          Script.Functions.Alert("No Emote Selected!", 3)
      end
  end)
  MiscGroup:AddButton("Stop Emoting", function()
      if Script.Temp.EmoteTrack and typeof(Script.Temp.EmoteTrack) == "Instance" and Script.Temp.EmoteTrack:IsA("AnimationTrack") then
          pcall(function() Script.Temp.EmoteTrack:Stop() end)
          Script.Temp.EmoteTrack = nil
      end
  end)

  MiscGroup:AddDivider()

  MiscGroup:AddToggle("AntiRagdoll", {
      Text = "Anti Ragdoll + No Stun",
      Default = false
  })

  MiscGroup:AddButton("Remove Ragdoll Effect", Script.Functions.BypassRagdoll)

  MiscGroup:AddDivider()
  MiscGroup:AddToggle("SpectateModeToggler", {
      Text = "Enable Spectator Mode",
      Default = false
  })
  Toggles.SpectateModeToggler:OnChanged(function(call)
      workspace.Values.CanSpectateIfWonGame.Value = call
  end)
  MiscGroup:AddDivider()
  MiscGroup:AddButton("Fix Camera", Script.Functions.FixCamera)
  MiscGroup:AddButton("Skip Cutscene", Script.Functions.FixCamera)
  --MiscGroup:AddDivider()
  MiscGroup:AddButton("Teleport To Safe Place", function()
      if not lplr.Character then
          Script.Functions.Alert("No character found")
          return
      end
      Script.Functions.TeleportSafe()
  end)

  MiscGroup:AddButton("Fix Players Visibility", Script.Functions.CheckPlayersVisibility)
end

Toggles.AntiRagdoll:OnChanged(function()
  if call then
      Script.Functions.Alert("Anti Ragdoll + No Stun Enabled", 3)
      Script.Functions.BypassRagdoll()
      task.spawn(function()
          repeat
              task.wait()
              Script.Functions.BypassRagdoll()
          until not Toggles.AntiRagdoll.Value or Library.Unloaded
      end)
  else
      Script.Functions.Alert("Anti Ragdoll + No Stun Disabled", 3)
  end
end)

Library:GiveSignal(workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
  if workspace.CurrentCamera then
      camera = workspace.CurrentCamera
  end
end))

Toggles.FOVToggle:OnChanged(function(call)
  if call then
      Script.Temp.OldFOV = camera and camera.FieldOfView or 60
      task.spawn(function()
          repeat 
              if camera then
                  camera.FieldOfView = Options.FOVSlider.Value
              end
              task.wait()
          until not Toggles.FOVToggle.Value or Library.Unloaded
      end)
  end
end)

local PlayerGroupBox = Tabs.Main:AddLeftGroupbox("Player") do
  PlayerGroupBox:AddSlider("SpeedSlider", {
      Text = "Walk Speed",
      Default = 16,
      Min = 0,
      Max = 300,
      Rounding = 1
  })

  PlayerGroupBox:AddToggle("SpeedToggle", {
      Text = "Speed",
      Default = false
  }):AddKeyPicker("SpeedKey", {
      Mode = "Toggle",
      Default = "C",
      Text = "Speed",
      SyncToggleState = true
  })

  PlayerGroupBox:AddToggle("Noclip", {
      Text = "Noclip",
      Default = false
  }):AddKeyPicker("NoclipKey", {
      Mode = "Toggle",
      Default = "N",
      Text = "Noclip",
      SyncToggleState = true
  })

  PlayerGroupBox:AddToggle("InfiniteJump", {
      Text = "Infinite Jump",
      Default = false
  })

  PlayerGroupBox:AddToggle("Fly", {
      Text = "Fly",
      Default = false
  })--[[:AddKeyPicker("FlyKey", {
      Mode = "Toggle",
      Default = "F",
      Text = "Fly",
      SyncToggleState = true
  })--]]

  PlayerGroupBox:AddSlider("FlySpeed", {
      Text = "Fly Speed",
      Default = 20,
      Min = 10,
      Max = 300,
      Rounding = 1,
      Compact = true,
  })
end

function Script.Functions.HookShittyAntiFlingDetection()
  if not lplr.Character then return end
  if not Toggles.FlingAuraToggle.Value then return end
  if Script.Temp.MainScriptHook then
      pcall(function()
          Script.Temp.MainScriptHook:Disconnect()
      end)
  end
  local Main = lplr.Character:WaitForChild("Main")
  if Main.Enabled then
      Script.Functions.Alert("Patched the Ink Game shitty Anti Fling :omegalul:", 1)
  end
  pcall(function()
      Main.Enabled = false
      Main.Disabled = true
  end)
  Script.Temp.MainScriptHook = Main:GetPropertyChangedSignal("Enabled"):Connect(function()
      Main.Enabled = false
      Main.Disabled = true
  end)
end

Library:GiveSignal(lplr.CharacterAdded:Connect(Script.Functions.HookShittyAntiFlingDetection))
pcall(Script.Functions.HookShittyAntiFlingDetection)

function Script.Functions.RevertAntiFlingDetection()
  if Script.Temp.MainScriptHook then
      pcall(function()
          Script.Temp.MainScriptHook:Disconnect()
      end)
  end
  if not lplr.Character then return end
  local Main = lplr.Character:WaitForChild("Main")
  Main.Enabled = true
  Main.Disabled = false
end

Toggles.FlingAuraToggle:OnChanged(function(enabled)
  local function setNoclip(state)
      if Toggles.Noclip.Value ~= state then
          Toggles.Noclip:SetValue(state)
      end
  end

  local function stopFlingAura()
      Script.Temp.FlingAuraActive = false
      setNoclip(false)
      if Script.Temp.FlingAuraDeathConn then
          Script.Temp.FlingAuraDeathConn:Disconnect()
          Script.Temp.FlingAuraDeathConn = nil
      end
  end

  if enabled then
      Script.Functions.Alert("Fling Aura Enabled", 3)
      Script.Temp.FlingAuraActive = true
      Script.Functions.HookShittyAntiFlingDetection()
      setNoclip(true)
      local player = lplr
      local function getRoot(character)
          return character and (character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso"))
      end
      local humanoid = player.Character and player.Character:FindFirstChildWhichIsA("Humanoid")
      if humanoid then
          Script.Temp.FlingAuraDeathConn = humanoid.Died:Connect(stopFlingAura)
      end
      task.spawn(function()
          local movel = 0.1
          while Script.Temp.FlingAuraActive and not Library.Unloaded do
              local character = player.Character
              local root = getRoot(character)
              if character and character.Parent and root and root.Parent then
                  local originalVel = root.Velocity
                  root.Velocity = originalVel * 10000 + Vector3.new(0, 10000, 0)
                  RunService.RenderStepped:Wait()
                  if character and character.Parent and root and root.Parent then
                      root.Velocity = originalVel
                  end
                  RunService.Stepped:Wait()
                  if character and character.Parent and root and root.Parent then
                      root.Velocity = originalVel + Vector3.new(0, movel, 0)
                      movel = -movel
                  end
              end
              RunService.Heartbeat:Wait()
          end
      end)
  else
      Script.Functions.Alert("Fling Aura Disabled", 3)
      Script.Functions.RevertAntiFlingDetection()
      stopFlingAura()
  end
end)

Toggles.Fly:SetVisible(false)
Options.FlySpeed:SetVisible(false)

Toggles.Noclip:OnChanged(function(call)
  if call then
      Script.Functions.Alert("Noclip Enabled", 3)
      local function NoclipLoop()
          if lplr.Character ~= nil then
              for _, child in pairs(lplr.Character:GetDescendants()) do
                  if child:IsA("BasePart") and child.CanCollide == true then
                      child.CanCollide = false
                  end
              end
          end
      end
      task.spawn(function()
          repeat 
              RunService.Heartbeat:Wait()
              NoclipLoop()
          until not Toggles.Noclip.Value or Library.Unloaded
      end)
  else
      Script.Functions.Alert("Noclip Disabled", 3)
      if lplr.Character ~= nil then
          for _, child in pairs(lplr.Character:GetDescendants()) do
              if child:IsA("BasePart") and child.CanCollide == false then
                  child.CanCollide = true
              end
          end
      end
  end
end)

Options.SpeedSlider:OnChanged(function(val)
  if not Toggles.SpeedToggle.Value then return end
  if not lplr.Character then return end
  if not lplr.Character:FindFirstChild("Humanoid") then return end
  lplr.Character.Humanoid.WalkSpeed = Options.SpeedSlider.Value
end)

Toggles.SpeedToggle:OnChanged(function(call)
  if call then
      Script.Functions.Alert("Speed Enabled", 3)
      Script.Temp.OldSpeed = lplr.Character.Humanoid.WalkSpeed
      task.spawn(function()
          repeat
              task.wait(0.5)
              if not lplr.Character then return end
              if not lplr.Character:FindFirstChild("Humanoid") then return end
              if call then
                  lplr.Character.Humanoid.WalkSpeed = Options.SpeedSlider.Value
              else
                  lplr.Character.Humanoid.WalkSpeed = Script.Temp.OldSpeed or 23
              end
          until not Toggles.SpeedToggle.Value or Library.Unloaded
      end)
  else
      Script.Functions.Alert("Speed Disabled", 3)
      lplr.Character.Humanoid.WalkSpeed = Script.Temp.OldSpeed or 23
  end
end)  

local controlModule

Toggles.Fly:OnChanged(function(value)
  local rootPart = Script.Functions.GetRootPart()
  if not rootPart then return end

  local humanoid = Script.Functions.GetHumanoid()
  if humanoid then
      humanoid.PlatformStand = value
  end

  local flyBody = Script.Temp.FlyBody or Instance.new("BodyVelocity")
  flyBody.Velocity = Vector3.zero
  flyBody.MaxForce = Vector3.one * 9e9
  Script.Temp.FlyBody = flyBody

  Script.Temp.FlyBody.Parent = value and rootPart or nil

  if value then
      controlModule = controlModule or Script.Functions.SafeRequire(lplr:WaitForChild("PlayerScripts"):WaitForChild("PlayerModule"):WaitForChild("ControlModule"))
      Script.Connections["Fly"] = RunService.RenderStepped:Connect(function()
          local moveVector = controlModule:GetMoveVector()
          local velocity = -((camera.CFrame.LookVector * moveVector.Z) - (camera.CFrame.RightVector * moveVector.X)) * Options.FlySpeed.Value

          Script.Temp.FlyBody.Velocity = velocity
      end)
  else
      if Script.Connections["Fly"] then
          Script.Connections["Fly"]:Disconnect()
      end
  end
end)

local SecurityGroupBox = Tabs.Main:AddRightGroupbox("Security") do
  SecurityGroupBox:AddToggle("AntiAfk", {
      Text = "Anti AFK",
      Default = true
  })
  Toggles.AntiAfk:OnChanged(function(call)
      if call then
          local VirtualUser = Services.VirtualUser
          Script.Temp.AntiAfkConnection = lplr.Idled:Connect(function()
              VirtualUser:Button2Down(Vector2.new(0, 0), camera.CFrame)
              wait(1)
              VirtualUser:Button2Up(Vector2.new(0, 0), camera.CFrame)
          end)
      else
          if not Script.Temp.AntiAfkConnection then return end
          pcall(function()
              Script.Temp.AntiAfkConnection:Disconnect()
          end)
      end
  end)
  SecurityGroupBox:AddToggle("StaffDetector", {
      Text = "Anti-Admin",
      Default = true
  })
  Toggles.StaffDetector:OnChanged(function(call)
      if call then
          local STAFF_GROUP_ID = 12398672
          local STAFF_MIN_RANK = 120
          local staffRoles = {
              [120] = "moderator",
              [254] = "dev",
              [255] = "owner"
          }
          Script.Temp.DetectedStaff = Script.Temp.DetectedStaff or {}
          local function checkPlayerStaff(player)
              local success, rank = pcall(function()
                  return player:GetRankInGroup(STAFF_GROUP_ID)
              end)
              if success and rank and rank >= STAFF_MIN_RANK then
                  local roleName = staffRoles[rank] or ("rank " .. tostring(rank))
                  Script.Functions.Alert("[Anti-Admin] Staff detected: " .. player.Name .. " (" .. roleName .. ")", 10)
                  Script.Temp.DetectedStaff[player.UserId] = {Name = player.Name, Role = roleName}
                  return true
              end
              return false
          end
          Script.Temp.StaffDetectorConnections = Script.Temp.StaffDetectorConnections or {}
          for _, player in pairs(Players:GetPlayers()) do
              if player ~= localPlayer then
                  checkPlayerStaff(player)
              end
          end
          Script.Temp.StaffDetectorConnections.PlayerAdded = Players.PlayerAdded:Connect(function(player)
              if player ~= localPlayer then
                  task.wait(1)
                  checkPlayerStaff(player)
              end
          end)
          Script.Temp.StaffDetectorConnections.PlayerRemoving = Players.PlayerRemoving:Connect(function(player)
              local staffInfo = Script.Temp.DetectedStaff and Script.Temp.DetectedStaff[player.UserId]
              if staffInfo then
                  Script.Functions.Alert("[Anti-Admin] Staff left: " .. staffInfo.Name .. " (" .. staffInfo.Role .. ")", 10)
                  Script.Temp.DetectedStaff[player.UserId] = nil
              end
          end)
      else
          if Script.Temp.StaffDetectorConnections then
              for _, conn in pairs(Script.Temp.StaffDetectorConnections) do
                  pcall(function() conn:Disconnect() end)
              end
              Script.Temp.StaffDetectorConnections = nil
          end
          Script.Temp.DetectedStaff = nil
          Script.Functions.Alert("[Anti-Admin] Staff detection disabled.", 3)
      end
  end)
end

local PerformanceGroupBox = Tabs.Main:AddRightGroupbox("Performance") do
  PerformanceGroupBox:AddToggle("LowGFX", {
      Text = "Low GFX",
      Default = false
  })
  PerformanceGroupBox:AddToggle("DisableEffects", {
      Text = "Disable Effects",
      Default = false
  })
  Toggles.DisableEffects:OnChanged(function(call)
      if call then
          local Effects = workspace:WaitForChild("Effects", 15)
          if not Effects then return end
          Effects:ClearAllChildren()
          Script.Temp.DisableEffectsConnection = Effects.ChildAdded:Connect(function(child)
              child:Destroy()
          end)
      else
          if Script.Temp.DisableEffectsConnection then
              pcall(function()
                  Script.Temp.DisableEffectsConnection:Disconnect()
              end)
              Script.Temp.DisableEffectsConnection = nil
          end
      end
  end)
  PerformanceGroupBox:AddButton("Clear Effects Cache", function()
      if workspace:FindFirstChild("Effects") then
          workspace.Effects:ClearAllChildren()
      end
  end)
end

Library:GiveSignal(lplr.CharacterAdded:Connect(function(char)
  if not Toggles.SpeedToggle.Value then return end
  local hum = char:WaitForChild("Humanoid", 10)
  if not hum then return end
  hum.WalkSpeed = Options.SpeedSlider.Value
end))

local lastCleanupFunction = function() end

function Script.Functions.HandleAutowin()
  if lastCleanupFunction then
      pcall(lastCleanupFunction)
  end

  pcall(function()
      Script.GameState = workspace.Values.CurrentGame.Value
  end)

  if States[Script.GameState] then
      Script.Functions.Alert("[Auto Win]: Running on "..tostring(Script.GameState))
      task.spawn(function()
          Script.Functions.EffectsNotification("[Auto Win]: Running on "..tostring(Script.GameState), 10)
      end)
      lastCleanupFunction = States[Script.GameState]()
  else
      task.spawn(function()
          Script.Functions.EffectsNotification("[Auto Win]: Waiting for the next game...", 10)
      end)
      Script.Functions.Alert("[Auto Win]: Waiting for the next game...")
  end
end

States = {
  RedLightGreenLight = function()
      local call = true
      task.spawn(function()
          repeat
              Script.Functions.WinRLGL()
              --Script.Functions.Alert("Teleporting to safe place in 5 seconds to prevent getting pushed out")
              task.wait(5)
              --Script.Functions.TeleportSafe()
          until not call or not Toggles.InkGameAutowin.Value or Script.GameState ~= "RedLightGreenLight"
      end)
      if not Toggles.AntiFlingToggle.Value then
          Toggles.AntiFlingToggle:SetValue(true)
      end
      return function()
          call = false
          if Toggles.AntiFlingToggle.Value then
              Toggles.AntiFlingToggle:SetValue(false)
          end
      end
      --[[if not Toggles.RedLightGodmode.Value then
          Toggles.RedLightGodmode:SetValue(true)
      end
      return function()
          if Toggles.RedLightGodmode.Value then
              Toggles.RedLightGodmode:SetValue(false)
          end
      end--]]
  end,
  Mingle = function()
      if not Toggles.AutoMingleQTE.Value then
          Toggles.AutoMingleQTE:SetValue(true)
      end
      return function()
          if Toggles.AutoMingleQTE.Value then
              Toggles.AutoMingleQTE:SetValue(false)
          end
      end
  end,
  TugOfWar = function()
      if not Toggles.AutoPull.Value then
          Toggles.AutoPull:SetValue(true)
      end
      if not Toggles.PerfectPull.Value then
          Toggles.PerfectPull:SetValue(true)
      end

      return function()
          if Toggles.AutoPull.Value then
              Toggles.AutoPull:SetValue(false)
          end
      end
  end,
  GlassBridge = function()
      Script.Functions.RevealGlassBridge()
      Script.Functions.WinGlassBridge()
  end,
  HideAndSeek = function()
      if lplr:GetAttribute("IsHider") then
          Script.Functions.TeleportSafe()
      else
          Script.Functions.Alert("[Auto Win]: Hide and Seek support for Seekers soon...")
      end
  end,
  LightsOut = Script.Functions.TeleportSafe,
  Dalgona = function()
      task.spawn(function()
          repeat task.wait() until Script.Functions.GetDalgonaRemote() or not Toggles.InkGameAutowin.Value or Library.Unloaded
          if not Toggles.InkGameAutowin.Value then return end
          task.wait(3)
          Script.Functions.CompleteDalgonaGame()
          Script.Functions.BypassDalgonaGame()
          Script.Functions.FixCamera()
      end)

      return function()
          Script.Functions.FixCamera()
          Script.Functions.CheckPlayersVisibility()
      end
  end
}

Library:GiveSignal(workspace:WaitForChild("Values"):WaitForChild("CurrentGame"):GetPropertyChangedSignal("Value"):Connect(function()
  Script.GameState = workspace.Values.CurrentGame.Value
  Script.GameStateChanged:Fire(Script.GameState)

  if not Script.GameState then return end
  Script.GameState = tostring(Script.GameState)

  if Toggles.InkGameAutowin.Value then
      Script.Functions.HandleAutowin()
  end

  if string.find(Script.GameState, "HideAndSeek") then
      for _, meta in pairs(ESP_META) do
          if not Toggles[meta.metaName] then continue end
          if Toggles[meta.metaName].Value then
              Toggles[meta.metaName]:SetValue(false)
              Toggles[meta.metaName]:SetValue(true)
          end
      end
  end
end))

Toggles.AutoPull:OnChanged(function(call)
  if call then
      task.spawn(function()
          repeat
              Script.Functions.PullRope(Toggles.PerfectPull.Value)
              task.wait()
          until not Toggles.AutoPull.Value or Library.Unloaded
      end)
  end
end)

Library:GiveSignal(UserInputService.JumpRequest:Connect(function()
  if Toggles.InfiniteJump.Value then
      if not lplr.Character then return end
      if not lplr.Character:FindFirstChild("Humanoid") then return end
      lplr.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
  end
end))

for _, player in pairs(Players:GetPlayers()) do
  if player == localPlayer then continue end
  Script.Functions.SetupOtherPlayerConnection(player)
end

Library:GiveSignal(Players.PlayerAdded:Connect(function(player)
  if player == localPlayer then return end
  Script.Functions.SetupOtherPlayerConnection(player)
end))

task.spawn(function() pcall(Script.Functions.OnLoad) end)

Library:OnUnload(function()
  pcall(function()
      Script.Maid:Clean()
  end)
  for _, conn in pairs(Script.Connections) do
      pcall(function()
          conn:Disconnect()
      end)
  end
  pcall(Script.Functions.RevertAntiFlingDetection)
  SaveManager:Save()
  Library.Unloaded = true
  getgenv().voidware_loaded = false
  shared.Voidware_InkGame_Library = nil
end)

local MenuSection = Settings:AddSection({Title = "Menu Settings", Description = "Menu configuration options", Defualt = false , Locked = false})

MenuSection:AddKeybind("MenuKeybind", {
    Title = "Menu Toggle Key",
    Default = "RightShift",
    Description = "Key to toggle the menu on/off",
    Callback = function(keybind)
        -- Menu keybind callback
    end,
})

MenuSection:AddButton({
    Title = "Join Discord Server", 
    Description = "Join our Discord community",
    Callback = Script.Functions.JoinDiscordServer,
})

local CreditsSection = Settings:AddSection({Title = "Credits", Description = "Development team credits", Defualt = false , Locked = false})

CreditsSection:AddParagraph({
    Title = "DYHUB Development Team",
    Content = "TEAM - Python / Dex\nSCRIPTER - Feature All\nUI - 3itx Library\nBYPASS - Disable Anti-Cheat All\nLOOPHOLES - Infinite Yield / Dex / Remote Spy\n\nFor Premium access: @dyumraisgoodguy#6969 on Discord"
})

-- Add Config tab with FlagsManager
local Config = main:AddTab("Config")

local ConfigSection = Config:AddSection({Title = "Configuration", Description = "Save and load your settings", Defualt = false , Locked = false})

ConfigSection:AddButton({
    Title = "Save Config",
    Description = "Save current settings to file",
    Callback = function()
        FlagsManager:Save("InkGameConfig")
        main:Notify("Config Saved!", "Configuration saved successfully", 3)
    end,
})

ConfigSection:AddButton({
    Title = "Load Config", 
    Description = "Load settings from file",
    Callback = function()
        FlagsManager:Load("InkGameConfig")
        main:Notify("Config Loaded!", "Configuration loaded successfully", 3)
    end,
})

ConfigSection:AddButton({
    Title = "Reset Config",
    Description = "Reset all settings to default", 
    Callback = function()
        FlagsManager:Reset()
        main:Notify("Config Reset!", "All settings reset to default", 3)
    end,
})

-- Initialize FlagsManager
FlagsManager:Init("InkGame_DYHUB", main)

-- Success notification
main:Notify("DYHUB Loaded!", "Ink Game script loaded successfully with 3itx UI", 5)
