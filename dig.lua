if game.PlaceId ~= 126244816328678 then
    return
end

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "zzz Hub | Dig Games  ",
   Icon = 133520378097790,
   LoadingTitle = "DiG Game Script zzz hub",
   LoadingSubtitle = "Join zzz hub",
   Theme = "DarkBlue",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false,
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "zzz",
      FileName = "zzz"
   },
   Discord = {
      Enabled = true,
      Invite = "PaRYpmJ4cG",
      RememberJoins = true
   },
   KeySystem = False,
   KeySettings = {
      Title = "Han Key",
      Subtitle = "Key system",
      Note = "Mau Key? Buy Key Premium",
      FileName = "Key",
      SaveKey = true,
      GrabKeyFromSite = false,
      Key = {"Premium_jfgue786eh767et75egyf5"}
   }
})

-- Buat part transparan untuk Billboard
local part = Instance.new("Part", workspace)
part.Anchored = true
part.CanCollide = false
part.Size = Vector3.new(4,1,4)
part.Transparency = 1
part.Name = "DiscordBillboard"

-- Ambil posisi player
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

part.Position = hrp.Position + Vector3.new(0,5,0)

-- Buat BillboardGui
local bb = Instance.new("BillboardGui", part)
bb.Size = UDim2.new(0, 200, 0, 50)
bb.StudsOffset = Vector3.new(0, 6, 0)
bb.AlwaysOnTop = true

-- Teks utama
local text = Instance.new("TextLabel", bb)
text.Size = UDim2.new(1, 0, 1, 0)
text.BackgroundTransparency = 1
text.Text = "https://discord.gg/PaRYpmJ4cG"
text.TextColor3 = Color3.fromRGB(180, 220, 255)
text.TextStrokeTransparency = 0
text.TextStrokeColor3 = Color3.new(0, 0, 0)
text.Font = Enum.Font.GothamBold
text.TextScaled = true

-- Tambahkan gambar (tanduk/icon)
local img = Instance.new("ImageLabel", bb)
img.Size = UDim2.new(0.3, 0, 0.3, 0)
img.Position = UDim2.new(0.35, 0, 1, 0)
img.BackgroundTransparency = 100
img.Image = "133520378097790" -- 🔷 ID gambar bisa diganti sesuai selera

-- Auto hilang setelah 1 detik
task.delay(10, function()
    part:Destroy()
end)

-- Notifikasi di sini yaaaaaaaaaa

local Players = game:GetService("Players")
local player = Players.LocalPlayer

Rayfield:Notify({
    Title = "Script Loaded",
    Content = "Have Fun With My Script, "..player.Name..", Enjoyy To My Script",
    Duration = 7
})

Rayfield:Notify({
    Title = "Support Game",
    Content = "DIG, Steal A Brainrot",
    Duration = 6.5, -- durasi tampil (detik)
    Image = 4483362458, -- optional: ID icon Roblox, bisa ganti
    Actions = { -- optional: tombol aksi
        Ignore = {
            Name = "Okay",
            Callback = function()
                print("✅ User clicked okay on notification.")
            end
        },
    },
})

local Tab = Window:CreateTab("Update", nil)
local Section = Tab:CreateSection("Changelog")

-- ✅ Buat GUI basic
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BasicGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- frame kiri atas
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 120)
Frame.Position = UDim2.new(0, 10, 0, 50) -- 👈 di bawah logo Roblox
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui

-- label judul
local Label = Instance.new("TextLabel")
Label.Size = UDim2.new(1, 0, 0.5, 0)
Label.BackgroundTransparency = 1
Label.TextColor3 = Color3.fromRGB(255, 255, 255)
Label.Text = "📄 zzz hub n"
Label.TextSize = 14
Label.Parent = Frame

-- label status boss
local BossStatus = Instance.new("TextLabel")
BossStatus.Size = UDim2.new(1, 0, 0.5, 0)
BossStatus.Position = UDim2.new(0, 0, 0.5, 0)
BossStatus.BackgroundTransparency = 1
BossStatus.TextColor3 = Color3.fromRGB(255, 200, 0)
BossStatus.Text = "Boss Status: Checking..."
BossStatus.TextSize = 12
BossStatus.Parent = Frame

-- ✅ Status toggle
local guiVisible = true
ScreenGui.Enabled = guiVisible

Tab:CreateToggle({
        Name = "Show Basic GUI",
        CurrentValue = true,
        Flag = "ShowBasicGUI",
        Callback = function(Value)
                guiVisible = Value
                ScreenGui.Enabled = guiVisible
                warn("Basic GUI visible:", guiVisible)
        end,
})

-- ✅ Boss checker
task.spawn(function()
        while true do
                if guiVisible then
                        local bossSpawns = workspace:FindFirstChild("Spawns") and workspace.Spawns:FindFirstChild("BossSpawns")
                        local foundBoss = false

                        if bossSpawns then
                                for _, boss in ipairs(bossSpawns:GetChildren()) do
                                        if boss:FindFirstChildWhichIsA("Model") or #boss:GetChildren() > 0 then
                                                foundBoss = true
                                                break
                                        end
                                end
                        end

                        if foundBoss then
                                BossStatus.Text = "Boss Status: 🟥 Spawned!"
                                BossStatus.TextColor3 = Color3.fromRGB(255, 0, 0)
                        else
                                BossStatus.Text = "Boss Status: ✅ None"
                                BossStatus.TextColor3 = Color3.fromRGB(0, 255, 0)
                        end
                end
                task.wait(1)
        end
end)

warn("✅ Basic GUI loaded & boss status enabled.")

Tab:CreateParagraph({
    Title = "What's New?",
    Content = [[
[+] Added Boss Teleport
 - Tp To Fuzzball
 - Tp To King Crab
 - Tp To Candlelight Phantom
 - Tp To Giant Spider
 - Tp To Basilisk
 - Tp To Molten Monstrosity
 - Tp To Dire Wolf

- Join discord HLemon Hub
    ]]
})

local Button = Tab:CreateButton({
   Name = "zzz hub🍋",
   Callback = function()
      -- Ganti link di sini dengan link Discord kamu
      setclipboard("https://discord.gg/PaRYpmJ4cG")
      
      -- Tampilkan notifikasi bahwa link sudah dicopy
      Rayfield:Notify({
         Title = "Copied!",
         Content = "https://discord.gg/PaRYpmJ4cG",
         Duration = 2,
         Image = 4483362458,
         Actions = {
            Ignore = {
               Name = "OK",
               Callback = function() end
            }
         }
      })
   end,
})

local Tab = Window:CreateTab("Farm", nil)
local Section = Tab:CreateSection("DIG Main")

-- ✅ Enhanced Auto Dig (Fast) Script logic
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local Backpack = LocalPlayer:WaitForChild("Backpack")
local Holes = workspace:WaitForChild("World"):WaitForChild("Zones"):WaitForChild("_NoDig")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local ENABLED = false
local digCount = 0
local connections = {}
local lastShovelCheck = 0
local shovelCheckInterval = 1 -- Check every 1 second

-- ✅ Enhanced shovel list
local shovelNames = {
    "Wooden Shovel", "Bejeweled Shovel", "Training Shovel", "Toy Shovel",
    "Copper Shovel", "Rock Shovel", "Lucky Shovel", "Ruby Shovel",
    "Abyssal Shovel", "Bell Shovel", "Magnet Shovel", "Jam Shovel",
    "Candlelight Shovel", "Spore Spade", "Slayers Shovel", "Arachnid Shovel",
    "Shortcake Shovel", "Pizza Roller", "Rock Splitter", "Archaic Shovel",
    "Frigid Shovel", "Venomous Shovel", "Gold Digger", "Obsidian Shovel",
    "Prismatic Shovel", "Beast Slayer", "Solstice Shovel", "Glinted Shovel",
    "Draconic Shovel", "Monstrous Shovel", "Starfire Shovel"
}

function hasShovelEquipped()
    local character = LocalPlayer.Character
    if not character then return false end
    
    local tool = character:FindFirstChildOfClass("Tool")
    if not tool then return false end
    
    -- Check if the equipped tool is a shovel
    for _, shovelName in ipairs(shovelNames) do
        if tool.Name == shovelName then
            return true, tool
        end
    end
    return false, nil
end

function getShovelFromBackpack()
    for _, tool in ipairs(Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            for _, shovelName in ipairs(shovelNames) do
                if tool.Name == shovelName then
                    return tool
                end
            end
        end
    end
    return nil
end

function ensureShovelEquipped()
    local hasEquipped, equippedShovel = hasShovelEquipped()
    if hasEquipped then return true end
    
    -- Try to equip a shovel from backpack
    local availableShovel = getShovelFromBackpack()
    if availableShovel then
        pcall(function()
            Remotes:WaitForChild("Backpack_Equip"):FireServer(availableShovel)
        end)
        task.wait(0.2) -- Wait for equip to complete
        return hasShovelEquipped()
    end
    
    return false
end

function getTool()
    local hasEquipped, tool = hasShovelEquipped()
    return hasEquipped and tool or nil
end

function destroyHitbox()
    local hitbox = Holes:FindFirstChild(LocalPlayer.Name.."_Crater_Hitbox")
    if hitbox then hitbox:Destroy() end
end

function activateTool()
    if not ENABLED then return end
    
    -- Check if we have a shovel equipped (with periodic check)
    local currentTime = tick()
    if currentTime - lastShovelCheck > shovelCheckInterval then
        ensureShovelEquipped()
        lastShovelCheck = currentTime
    end
    
    local tool = getTool()
    if tool then
        destroyHitbox()
        tool:Activate()
    end
end

function setupEvents()
    table.insert(connections, LocalPlayer.PlayerGui.ChildAdded:Connect(function(v)
        if v.Name == "Dig" then
            local strong_bar = v.Safezone.Holder:FindFirstChild("Area_Strong")
            local player_bar = v.Safezone.Holder:FindFirstChild("PlayerBar")
            table.insert(connections, player_bar:GetPropertyChangedSignal("Position"):Connect(function()
                if ENABLED then
                    player_bar.Position = strong_bar.Position
                    digCount += 1
                    activateTool()
                end
            end))
        end
    end))

    table.insert(connections, LocalPlayer:GetAttributeChangedSignal("IsDigging"):Connect(function()
        if ENABLED and not LocalPlayer:GetAttribute("IsDigging") then
            activateTool()
        end
    end))

    table.insert(connections, LocalPlayer.CharacterAdded:Connect(function(char)
        char.ChildAdded:Connect(function(v)
            if ENABLED and v:IsA("Tool") then
                -- Check if it's a shovel
                for _, shovelName in ipairs(shovelNames) do
                    if v.Name == shovelName then
                        task.wait(0.1)
                        activateTool()
                        break
                    end
                end
            end
        end)
    end))

    if LocalPlayer.Character then
        table.insert(connections, LocalPlayer.Character.ChildAdded:Connect(function(v)
            if ENABLED and v:IsA("Tool") then
                -- Check if it's a shovel
                for _, shovelName in ipairs(shovelNames) do
                    if v.Name == shovelName then
                        task.wait(0.1)
                        activateTool()
                        break
                    end
                end
            end
        end))
    end

    table.insert(connections, RunService.Heartbeat:Connect(function()
        if ENABLED and digCount >= 3 then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame *= CFrame.Angles(0, math.rad(2), 0)
                activateTool()
            end
        end
    end))
end

function cleanupEvents()
    for _, conn in ipairs(connections) do
        conn:Disconnect()
    end
    connections = {}
end

-- ✅ Enhanced Toggle
Tab:CreateToggle({
    Name = "Auto Dig (Fast)",
    CurrentValue = false,
    Flag = "AutoDigRotate",
    Callback = function(Value)
        ENABLED = Value
        if Value then
            digCount = 0
            -- Ensure we have a shovel equipped when starting
            if not ensureShovelEquipped() then
                Rayfield:Notify({
                    Title = "No Shovel Found",
                    Content = "Please get a shovel from the shop first!",
                    Duration = 4
                })
                return
            end
            setupEvents()
            Rayfield:Notify({
                Title = "Auto Dig Enabled",
                Content = "Fast auto dig is now active with shovel detection",
                Duration = 3
            })
        else
            cleanupEvents()
        end
    end,
})

-- ✅ Enhanced Auto Dig (Slow) Script logic
local local_player = game:GetService("Players").LocalPlayer
local workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Backpack = local_player:WaitForChild("Backpack")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local holes = workspace:FindFirstChild("World"):FindFirstChild("Zones"):FindFirstChild("_NoDig")

getgenv().enabled = false -- default off
local slowDigLastCheck = 0
local slowDigCheckInterval = 2 -- Check every 2 seconds

-- ✅ Enhanced shovel detection for slow dig
function hasShovelEquippedSlow()
    local character = local_player.Character
    if not character then return false end
    
    local tool = character:FindFirstChildOfClass("Tool")
    if not tool then return false end
    
    -- Check if the equipped tool is a shovel
    for _, shovelName in ipairs(shovelNames) do
        if tool.Name == shovelName then
            return true, tool
        end
    end
    return false, nil
end

function getShovelFromBackpackSlow()
    for _, tool in ipairs(Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            for _, shovelName in ipairs(shovelNames) do
                if tool.Name == shovelName then
                    return tool
                end
            end
        end
    end
    return nil
end

function ensureShovelEquippedSlow()
    local hasEquipped, equippedShovel = hasShovelEquippedSlow()
    if hasEquipped then return true end
    
    -- Try to equip a shovel from backpack
    local availableShovel = getShovelFromBackpackSlow()
    if availableShovel then
        pcall(function()
            Remotes:WaitForChild("Backpack_Equip"):FireServer(availableShovel)
        end)
        task.wait(0.2) -- Wait for equip to complete
        return hasShovelEquippedSlow()
    end
    
    return false
end

function get_tool()
    local hasEquipped, tool = hasShovelEquippedSlow()
    return hasEquipped and tool or nil
end

function checkAndEquipShovel()
    local currentTime = tick()
    if currentTime - slowDigLastCheck > slowDigCheckInterval then
        ensureShovelEquippedSlow()
        slowDigLastCheck = currentTime
    end
end

local_player.Character.ChildAdded:Connect(function(v)
    if enabled and v:IsA("Tool") then
        -- Check if it's a shovel
        for _, shovelName in ipairs(shovelNames) do
            if v.Name == shovelName then
                task.wait(1)
                if holes:FindFirstChild(local_player.Name.."_Crater_Hitbox") then
                    holes[local_player.Name.."_Crater_Hitbox"]:Destroy()
                end
                v:Activate()
                break
            end
        end
    end
end)

local_player.PlayerGui.ChildAdded:Connect(function(v)
    if enabled and v.Name == "Dig" then
        local strong_bar = v:FindFirstChild("Safezone"):FindFirstChild("Holder"):FindFirstChild("Area_Strong")
        local player_bar = v:FindFirstChild("Safezone"):FindFirstChild("Holder"):FindFirstChild("PlayerBar")
        player_bar:GetPropertyChangedSignal("Position"):Connect(function()
            if not enabled then return end
            if math.abs(player_bar.Position.X.Scale - strong_bar.Position.X.Scale) <= 0.04 then
                checkAndEquipShovel()
                local tool = get_tool()
                if tool then
                    tool:Activate()
                    task.wait()
                end
            end
        end)
    end
end)

local_player:GetAttributeChangedSignal("IsDigging"):Connect(function()
    if not enabled then return end
    if not local_player:GetAttribute("IsDigging") then
        if holes:FindFirstChild(local_player.Name.."_Crater_Hitbox") then
            holes[local_player.Name.."_Crater_Hitbox"]:Destroy()
        end
        checkAndEquipShovel()
        local tool = get_tool()
        if tool then
            tool:Activate()
        end
    end
end)

-- 🧰 Enhanced Rayfield Toggle
local Toggle = Tab:CreateToggle({
   Name = "Auto Dig (slow)",
   CurrentValue = false,
   Flag = "AutoDigToggle",
   Callback = function(Value)
       -- Set enabled on/off saat toggle ditekan
       getgenv().enabled = Value
       if Value then
           -- Check if we have a shovel equipped when starting
           if not ensureShovelEquippedSlow() then
               Rayfield:Notify({
                   Title = "No Shovel Found",
                   Content = "Please get a shovel from the shop first!",
                   Duration = 4
               })
               return
           end
           Rayfield:Notify({
               Title = "Auto Dig Enabled",
               Content = "Slow auto dig is now active with shovel detection",
               Duration = 3
           })
       end
   end,
})

local Section = Tab:CreateSection("Equip Shovel")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Backpack = LocalPlayer:WaitForChild("Backpack")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")

local ENABLED = false
local backpackConn

-- ✅ Daftar shovel
local shovelNames = {
    "Wooden Shovel", "Bejeweled Shovel", "Training Shovel", "Toy Shovel",
    "Copper Shovel", "Rock Shovel", "Lucky Shovel", "Ruby Shovel",
    "Abyssal Shovel", "Bell Shovel", "Magnet Shovel", "Jam Shovel",
    "Candlelight Shovel", "Spore Spade", "Slayers Shovel", "Arachnid Shovel",
    "Shortcake Shovel", "Pizza Roller", "Rock Splitter", "Archaic Shovel",
    "Frigid Shovel", "Venomous Shovel", "Gold Digger", "Obsidian Shovel",
    "Prismatic Shovel", "Beast Slayer", "Solstice Shovel", "Glinted Shovel",
    "Draconic Shovel", "Monstrous Shovel", "Starfire Shovel"
}

-- ✅ Equip shovel dari list
function equipAnyShovel()
    for _, tool in ipairs(Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            for _, name in ipairs(shovelNames) do
                if tool.Name == name then
                    Remotes:WaitForChild("Backpack_Equip"):FireServer(tool)
                    return
                end
            end
        end
    end
end

-- ✅ Unequip
function unequip()
    Remotes:WaitForChild("Backpack_Equip"):FireServer(nil)
end

-- ✅ Toggle Rayfield
Tab:CreateToggle({
    Name = "Auto Equip Shovel",
    CurrentValue = false,
    Flag = "AutoShovelSimple",
    Callback = function(state)
        ENABLED = state

        if ENABLED then
            equipAnyShovel()

            -- sambungkan listener
            backpackConn = Backpack.ChildAdded:Connect(function(child)
                if ENABLED then
                    task.wait(0.1)
                    equipAnyShovel()
                end
            end)

        else
            unequip()

            -- putuskan listener
            if backpackConn then
                backpackConn:Disconnect()
                backpackConn = nil
            end
        end
    end
})

local Tab = Window:CreateTab("Mecahnic", nil)
local Section = Tab:CreateSection("Cars")

-- 🟦 List mobil
local vehicleList = {
    "ATV", "Golf Cart", "Koi Truck", "Commander", "Silver",
    "Pulse", "Rumbler", "Tracer", "DMW M3", "Elite 6x6",
    "Forklift", "The Ox", "Roadster RS", "Tornado", "McBruce 700", "Monster Silver"
}

-- 🟦 Remote references
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VehicleSpawn = ReplicatedStorage.Remotes:FindFirstChild("Vehicle_Spawn")
local AvaRoot = workspace:WaitForChild("World"):WaitForChild("NPCs"):WaitForChild("Ava Carter"):WaitForChild("HumanoidRootPart")

if not VehicleSpawn then
    warn("Vehicle_Spawn remote tidak ditemukan!")
end

-- 🟦 Buat tombol untuk setiap mobil
for _, vehicleName in ipairs(vehicleList) do
    Tab:CreateButton({
        Name = "Spawn: "..vehicleName,
        Callback = function()
            if VehicleSpawn then
                VehicleSpawn:FireServer(vehicleName, AvaRoot, {})
                Rayfield:Notify({
                    Title = "Spawn Mobil",
                    Content = "Spawned: " .. vehicleName,
                    Duration = 3
                })
            else
                Rayfield:Notify({
                    Title = "Error",
                    Content = "Remote Vehicle_Spawn tidak ditemukan!",
                    Duration = 3
                })
            end
        end
    })
end

local Tab = Window:CreateTab("Shop", nil)
local Section = Tab:CreateSection("Shovel Shop Teleport")

-- 📦 Service
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

-- 📦 Noclip function
local noclipConn
local function setNoclip(state)
    if state then
        if noclipConn then noclipConn:Disconnect() end
        noclipConn = RunService.Stepped:Connect(function()
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid:ChangeState(11) -- noclip
            end
        end)
    else
        if noclipConn then
            noclipConn:Disconnect()
            noclipConn = nil
        end
    end
end

-- 📦 Teleport dengan noclip
local function tpWithNoclip(x, y, z, name)
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        setNoclip(true)
        hrp.CFrame = CFrame.new(x, y, z)
        Rayfield:Notify({
            Title = "Teleport",
            Content = "✅ Teleported to "..name,
            Duration = 3
        })
        task.delay(0.5, function()
            setNoclip(false)
        end)
    end
end

-- 📦 Data teleport
local teleports = {
    {"Bejeweled Shovel", 31.2093, 3.0318, 39.8111},
    {"Training Shovel", 2121.1235, 112.5746, -298.7560},
    {"Toy Shovel", 2119.4553, 113.6495, -298.0141},
    {"Copper Shovel", 15.2426, 61.0899, 4.8759},
    {"Rock Shovel", 2112.3464, 112.6290, -294.7606},
    {"Lucky Shovel", 2111.1553, 113.5927, -294.1081},
    {"Ruby Shovel", 1327.8562, 81.1430, 542.9059},
    {"Bell Shovel", 1329.5909, 83.6888, 541.6209},
    {"Magnet Shovel", 2853.4087, -360.5666, -883.8994},
    {"Jam Shovel", 3522.3616, 84.9355, 1528.2647},
    {"Candlelight Shovel", 17.4070, 3.7727, 146.4270},
    {"Spore Shovel", 3987.8251, 227.6757, -141.8380},
    {"Slayers Shovel", 2516.5246, 89.4888, 1301.1907},
    {"Arachnid Shovel", -822.2592, 17.3944, 1260.7221},
    {"Shortcake Shovel", 484.3059, 5.5491, -284.0187},
    {"Rock Splitter", 134.4634, 5.6453, -45.0966},
    {"Archaic Shovel", -6108.1030, 119.4773, -1907.2861},
    {"Frigid Shovel", 6523.1782, 2612.3432, -2949.0361},
    {"Venomous Shovel", 16.9659, 5.5344, 32.9641},
    {"Gold Digger", 62.6586, 5.3908, 51.6359},
    {"Obsidian Shovel", -8022.6240, 342.8148, -1791.4763},
    {"Prismatic Shovel", 5131.5590, 1113.0532, -2105.3071},
    {"Beast Slayer", 128.5010, 7.1945, 19.1139},
    {"Solstice Shovel", 5567.9575, -394.3601, -1912.5024},
    {"Glinted Shovel", -6177.6743, 1630.6092, -1842.7865},
    {"Draconic Shovel", -8571.2793, 391.2796, -2133.6345},
    {"Starline Shovel", -2.5368, -68.4143, 1.2173}
}

-- 📦 Tombol-tombol teleport
for _, data in ipairs(teleports) do
    Tab:CreateButton({
        Name = "Teleport To "..data[1],
        Callback = function()
            tpWithNoclip(data[2], data[3], data[4], data[1])
        end
    })
end

local Section = Tab:CreateSection("Traveling Merchant")

local Button = Tab:CreateButton({
   Name = "Teleport to Traveling Merchant",
   Callback = function()
      -- 🧭 Teleport to Traveling Merchant
      local player = game:GetService("Players").LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

      local merchant = workspace:FindFirstChild("World")
      if merchant then
          merchant = merchant:FindFirstChild("NPCs")
      end
      if merchant then
          merchant = merchant:FindFirstChild("Merchant Cart")
      end
      if merchant then
          merchant = merchant:FindFirstChild("Traveling Merchant")
      end

      if merchant and merchant:FindFirstChild("HumanoidRootPart") then
          humanoidRootPart.CFrame = merchant.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
          warn("✅ Teleported to Traveling Merchant!")
      else
          warn("❌ Traveling Merchant not found.")
      end
   end,
})

local Tab = Window:CreateTab("Misc/Player", nil)
local Section = Tab:CreateSection("Anti Staff")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- 🔷 Daftar UserId staff yang ingin diawasi
local staffList = {
    129332660, -- contoh staff
    146089324, -- tambah id lain
    556677889  -- dst
}

local notifyStaffEnabled = true
local staffAction = "Notify" -- default

-- 🔷 Fungsi untuk cek apakah player yang join adalah staff
local function handleStaff(player)
    if not notifyStaffEnabled then return end

    for _, id in ipairs(staffList) do
        if player.UserId == id then
            if staffAction == "Notify" then
                Rayfield:Notify({
                    Title = "⚠️ Staff Masuk Server",
                    Content = player.Name .. " (ID: " .. id .. ") terdeteksi sebagai staff.",
                    Duration = 6,
                    Actions = {
                        Accept = {
                            Name = "OK",
                            Callback = function() end
                        }
                    }
                })
            elseif staffAction == "Kick" then
                LocalPlayer:Kick("Staff terdeteksi di server: " .. player.Name)
            end
            break
        end
    end
end

-- 🔷 Toggle Rayfield
Tab:CreateToggle({
    Name = "Anti Staff",
    CurrentValue = true, -- ✅ auto ON
    Flag = "DeteksiStaff",
    Callback = function(Value)
        notifyStaffEnabled = Value

        if Value then
            -- cek semua player yang sudah ada di server
            for _, p in ipairs(Players:GetPlayers()) do
                handleStaff(p)
            end
        end
    end,
})

-- 🔷 Select Rayfield
Tab:CreateDropdown({
    Name = "Choose Staff Method",
    Options = {"Notify", "Kick"},
    CurrentOption = "Notify",
    Flag = "ChooseStaff",
    Callback = function(Option)
        staffAction = Option
    end,
})

-- 🔷 Listen untuk player baru
Players.PlayerAdded:Connect(handleStaff)

-- ✅ Panggil sekali supaya toggle langsung jalan tanpa tunggu klik
for _, p in ipairs(Players:GetPlayers()) do
    handleStaff(p)
end

local Section = Tab:CreateSection("Setting")

local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local godModeEnabled = false

local function setGodMode(enable)
    if enable then
        Humanoid.MaxHealth = math.huge
        Humanoid.Health = math.huge
    else
        Humanoid.MaxHealth = 100
        Humanoid.Health = 100
    end
end

-- selalu monitor Health & Died
Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
    if godModeEnabled and Humanoid.Health < math.huge then
        Humanoid.Health = math.huge
    end
end)

Humanoid.Died:Connect(function()
    if godModeEnabled then
        task.wait(1)
        LocalPlayer:LoadCharacter()
    end
end)

-- saat respawn ganti Humanoid saja
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")

    if godModeEnabled then
        setGodMode(true)

        Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            if godModeEnabled and Humanoid.Health < math.huge then
                Humanoid.Health = math.huge
            end
        end)

        Humanoid.Died:Connect(function()
            if godModeEnabled then
                task.wait(1)
                LocalPlayer:LoadCharacter()
            end
        end)
    end
end)

Tab:CreateToggle({
    Name = "God Mode",
    CurrentValue = false,
    Callback = function(state)
        godModeEnabled = state

        if state then
            setGodMode(true)
            Rayfield:Notify({
                Title = "God Mode",
                Content = "God Mode Aktif",
                Duration = 3
            })
        else
            setGodMode(false)
            Rayfield:Notify({
                Title = "God Mode",
                Content = "God Mode Nonaktif",
                Duration = 3
            })
        end
    end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- update character kalau respawn
LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
end)

local noclipEnabled = false

Tab:CreateToggle({
    Name = "Noclip",
    CurrentValue = false,
    Callback = function(state)
        noclipEnabled = state

        if state then
            Rayfield:Notify({
                Title = "Noclip",
                Content = "Noclip Diaktifkan.",
                Duration = 3
            })
        else
            Rayfield:Notify({
                Title = "Noclip",
                Content = "Noclip Dimatikan.",
                Duration = 3
            })
            -- pastikan balik normal
            if Character then
                for _, part in ipairs(Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
})

-- jalankan setiap frame
RunService.Stepped:Connect(function()
    if noclipEnabled and Character then
        for _, part in ipairs(Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
    end
end)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

LocalPlayer.CharacterAdded:Connect(function(char)
    Character = char
    Humanoid = char:WaitForChild("Humanoid")
end)

getgenv().WalkSpeedEnabled = false
getgenv().JumpPowerEnabled = false

local walkSpeedValue = 16
local jumpPowerValue = 50

-- WalkSpeed Toggle
Tab:CreateToggle({
    Name = "WalkSpeed",
    CurrentValue = false,
    Flag = "WalkSpeedToggle",
    Callback = function(Value)
        getgenv().WalkSpeedEnabled = Value
    end,
})

-- WalkSpeed Slider
Tab:CreateSlider({
    Name = "WalkSpeed Value",
    Range = {16, 200},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "WalkSpeedSlider",
    Callback = function(Value)
        walkSpeedValue = Value
    end,
})

-- JumpPower Toggle
Tab:CreateToggle({
    Name = "JumpPower",
    CurrentValue = false,
    Flag = "JumpPowerToggle",
    Callback = function(Value)
        getgenv().JumpPowerEnabled = Value
    end,
})

-- JumpPower Slider
Tab:CreateSlider({
    Name = "JumpPower Value",
    Range = {50, 200},
    Increment = 1,
    Suffix = "Power",
    CurrentValue = 50,
    Flag = "JumpPowerSlider",
    Callback = function(Value)
        jumpPowerValue = Value
    end,
})

-- Loop yang lebih kuat
RunService.RenderStepped:Connect(function()
    if not Character or not Humanoid or Humanoid.Parent ~= Character then
        Character = LocalPlayer.Character
        if Character then
            Humanoid = Character:FindFirstChildOfClass("Humanoid")
        end
    end

    if Humanoid then
        if getgenv().WalkSpeedEnabled then
            Humanoid.WalkSpeed = walkSpeedValue
        else
            Humanoid.WalkSpeed = 16
        end

        if getgenv().JumpPowerEnabled then
            Humanoid.JumpPower = jumpPowerValue
        else
            Humanoid.JumpPower = 50
        end
    end
end)

local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")

Tab:CreateButton({
    Name = "Boost FPS",
    Callback = function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 1e10
        Lighting.Brightness = 1

        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("PostEffect") then
                v.Enabled = false
            end
        end

        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Decal") or obj:IsA("Texture") then
                obj.Transparency = 0.5
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                obj.Enabled = false
            end
        end

        Rayfield:Notify({
            Title = "Boost FPS",
            Content = "Boost FPS diaktifkan.",
            Duration = 3
        })
    end
})

local Tab = Window:CreateTab("Inventory", nil)
local Section = Tab:CreateSection("Sell")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Rocky = workspace:WaitForChild("World"):WaitForChild("NPCs"):WaitForChild("Rocky")
local SellAllItems = ReplicatedStorage:WaitForChild("DialogueRemotes"):WaitForChild("SellAllItems")

getgenv().autoSell = false
getgenv().sellDelay = 3 -- default 3 detik

-- Toggle Auto Sell
Tab:CreateToggle({
   Name = "Auto Sell",
   CurrentValue = false,
   Flag = "Toggle_AutoSell",
   Callback = function(Value)
      getgenv().autoSell = Value
   end,
})

-- Slider untuk atur delay
Tab:CreateSlider({
   Name = "Auto Sell Delay (detik)",
   Range = {1, 60},
   Increment = 1,
   Suffix = "s",
   CurrentValue = 3,
   Flag = "Slider_AutoSellDelay",
   Callback = function(Value)
      getgenv().sellDelay = Value
   end,
})

-- Loop Auto Sell
task.spawn(function()
        while task.wait(1) do
                if getgenv().autoSell then
                        SellAllItems:FireServer(Rocky)
                        task.wait(getgenv().sellDelay)
                end
        end
end)

local Tab = Window:CreateTab("Magnets", nil)
local Section = Tab:CreateSection("Equip Magnets")

local player = game.Players.LocalPlayer
local playerName = player.Name

local rs = game:GetService("ReplicatedStorage")
local remotes = rs:WaitForChild("Remotes")

-- Fungsi equip magnet
local function equipMagnet(magnetName)
    local magnet = rs:WaitForChild("PlayerStats")
        :WaitForChild(playerName)
        :WaitForChild("Inventory")
        :WaitForChild("Magnets")
        :FindFirstChild(magnetName)

    if magnet then
        remotes:WaitForChild("Magnet_Equip"):FireServer(magnet)
    end
end

-- Tambahkan tombol-tombol ke Tab yang sudah ada
Tab:CreateButton({ Name = "Prismatic Magnet", Callback = function() equipMagnet("Prismatic Magnet") end })
Tab:CreateButton({ Name = "Crimsonsteel Magnet", Callback = function() equipMagnet("Crimsonsteel Magnet") end })
Tab:CreateButton({ Name = "Magic Magnet", Callback = function() equipMagnet("Magic Magnet") end })
Tab:CreateButton({ Name = "Golden Horseshoe", Callback = function() equipMagnet("Golden Horseshoe") end })
Tab:CreateButton({ Name = "Legendary Magnet", Callback = function() equipMagnet("Legendary Magnet") end })
Tab:CreateButton({ Name = "Fossil Brush", Callback = function() equipMagnet("Fossil Brush") end })
Tab:CreateButton({ Name = "Fortuned Magnet", Callback = function() equipMagnet("Fortuned Magnet") end })
Tab:CreateButton({ Name = "Brass Magnet", Callback = function() equipMagnet("Brass Magnet") end })
Tab:CreateButton({ Name = "Ghost Magnet", Callback = function() equipMagnet("Ghost Magnet") end })
Tab:CreateButton({ Name = "Odd Mushroom", Callback = function() equipMagnet("Odd Mushroom") end })
Tab:CreateButton({ Name = "Green Magnet", Callback = function() equipMagnet("Green Magnet") end })
Tab:CreateButton({ Name = "Light Bulb", Callback = function() equipMagnet("Light Bulb") end })
Tab:CreateButton({ Name = "Red Magnet", Callback = function() equipMagnet("Red Magnet") end })
Tab:CreateButton({ Name = "Basic Magnet", Callback = function() equipMagnet("Basic Magnet") end })

local Tab = Window:CreateTab("Teleport Bosses", nil)
local Section = Tab:CreateSection("Boss")

local Button = Tab:CreateButton({
    Name = "Teleport to King Crab",
    Callback = function()
        -- 🦀 Teleport ke King Crab
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- path fix: Workspace.Spawns.BossSpawns.King Crab
        local bossSpawns = workspace:FindFirstChild("Spawns")
        if bossSpawns then
            bossSpawns = bossSpawns:FindFirstChild("BossSpawns")
        end

        local boss
        if bossSpawns then
            boss = bossSpawns:FindFirstChild("King Crab")
        end

        if boss and boss:FindFirstChild("HumanoidRootPart") then
            humanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            warn("✅ Teleported to King Crab!")
        else
            warn("❌ King Crab not found.")
        end
    end,
})

local Button = Tab:CreateButton({
   Name = "Teleport to Candlelight Phantom",
   Callback = function()
      -- 🧭 Teleport to Candlelight Phantom
      local player = game:GetService("Players").LocalPlayer
      local character = player.Character or player.CharacterAdded:Wait()
      local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

      local boss

      -- Cari boss di seluruh Workspace
      for _, obj in ipairs(workspace:GetDescendants()) do
         if obj:IsA("Model") and obj.Name == "Candlelight Phantom" and obj:FindFirstChild("HumanoidRootPart") then
            boss = obj
            break
         end
      end

      if boss then
         humanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
         warn("✅ Teleported to Candlelight Phantom!")
      else
         warn("❌ Candlelight Phantom not found.")
      end
   end,
})

Tab:CreateButton({
    Name = "Teleport to Molten Monstrosity",
    Callback = function()
        local player = game.Players.LocalPlayer
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        if hrp then
            hrp.CFrame = CFrame.new(
                -8797.094, 434.878, -1919.448,
                1, 0, 0,
                0, 1, 0,
                0, 0, 1
            )
        end
    end
})

local Button = Tab:CreateButton({
    Name = "Teleport to Basilisk",
    Callback = function()
        -- 🐍 Teleport ke Basilisk
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- path fix: Workspace.Spawns.BossSpawns.Basilisk
        local bossSpawns = workspace:FindFirstChild("Spawns")
        if bossSpawns then
            bossSpawns = bossSpawns:FindFirstChild("BossSpawns")
        end

        local boss
        if bossSpawns then
            boss = bossSpawns:FindFirstChild("Basilisk")
        end

        if boss and boss:FindFirstChild("HumanoidRootPart") then
            humanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            warn("✅ Teleported to Basilisk!")
        else
            warn("❌ Basilisk not found.")
        end
    end,
})

local Button = Tab:CreateButton({
    Name = "Teleport to Dire Wolf",
    Callback = function()
        -- 🐺 Teleport ke Dire Wolf
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        -- path fix: Workspace.Spawns.BossSpawns.Dire Wolf
        local bossSpawns = workspace:FindFirstChild("Spawns")
        if bossSpawns then
            bossSpawns = bossSpawns:FindFirstChild("BossSpawns")
        end

        local boss
        if bossSpawns then
            boss = bossSpawns:FindFirstChild("Dire Wolf")
        end

        if boss and boss:FindFirstChild("HumanoidRootPart") then
            humanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            warn("✅ Teleported to Dire Wolf!")
        else
            warn("❌ Dire Wolf not found.")
        end
    end,
})

local Button = Tab:CreateButton({
    Name = "Teleport to Fuzzball",
    Callback = function()
        -- 🟢 Teleport ke Fuzzball
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        local bossSpawns = workspace:FindFirstChild("Spawns")
        if bossSpawns then
            bossSpawns = bossSpawns:FindFirstChild("BossSpawns")
        end

        local boss
        if bossSpawns then
            boss = bossSpawns:FindFirstChild("Fuzzball")
        end

        if boss and boss:FindFirstChild("HumanoidRootPart") then
            humanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            warn("✅ Teleported to Fuzzball!")
        else
            warn("❌ Fuzzball not found.")
        end
    end,
})

local Button = Tab:CreateButton({
    Name = "Teleport to Giant Spider",
    Callback = function()
        -- 🕷️ Teleport ke Giant Spider
        local player = game:GetService("Players").LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

        local bossSpawns = workspace:FindFirstChild("Spawns")
        if bossSpawns then
            bossSpawns = bossSpawns:FindFirstChild("BossSpawns")
        end

        local boss
        if bossSpawns then
            boss = bossSpawns:FindFirstChild("Giant Spider")
        end

        if boss and boss:FindFirstChild("HumanoidRootPart") then
            humanoidRootPart.CFrame = boss.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            warn("✅ Teleported to Giant Spider!")
        else
            warn("❌ Giant Spider not found.")
        end
    end,
})

local Tab = Window:CreateTab("Teleport Npc", nil)
local Section = Tab:CreateSection("Npc")

local player = game.Players.LocalPlayer
local npcsFolder = workspace:WaitForChild("World"):WaitForChild("NPCs")

-- Fungsi teleport
local function teleportToNPC(npcName)
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart")

    for _, npc in ipairs(npcsFolder:GetDescendants()) do
        if npc:IsA("Model") and npc.Name:lower():match(npcName:lower()) then
            local targetPart = npc:FindFirstChild("HumanoidRootPart") or npc.PrimaryPart
            if targetPart then
                hrp.CFrame = targetPart.CFrame + Vector3.new(0, 3, 0)
            end
            break
        end
    end
end

-- Daftar semua NPC
local npcNames = {
    "Sydney", "Roger Star", "Ava Carter", "Berry Dust", "Cole Blood", "Cave Worker", "Carly Enzo", "Malcom Wheels",
    "Annie Rae", "Magnus", "Mushroom Azali", "Penguin Mechanic", "Banker", "Gary Bull", "Tribes Mate", "Discoshroom",
    "John", "Mark Lever", "Max", "Ethan Bands", "Jane", "Blueshroom", "Brooke Kali", "Smith", "Dani Snow", "Grant Thorn",
    "Will", "Stranded Steve", "Drawstick Liz", "Ferry Conductor", "Steve Levi", "Sam Colby", "Mushroom Researcher",
    "Tom Baker", "Penguin Customer", "Pete R.", "Arthur Dig", "Granny Glenda", "Collin", "Cindy", "Jenn Diamond",
    "Tribe Leader", "Mourning Family Member", "Young Guitarist", "Bu Ran", "Billy Joe", "Andy", "Soten Ran", "Mrs.Salty",
    "Merchant Cart.Traveling Merchant", "Rocky", "Nate", "Blueshroom Merchant", "Barry", "Kira Pale", "Kei Ran", "Hale",
    "Darren", "Jim Diamond", "Ben Bones.Ben Bones", "Andrew", "Old Blueshroom", "Jie Ran", "Silver", "O'Myers", "Erin Field",
    "Pizza Penguin", "Lexi Star", "Ninja Deciple", "Mrs.Tiki", "Purple Imp", "Albert"
}

-- Buat tombol per NPC (masing-masing sendiri)
for _, npcName in ipairs(npcNames) do
    Tab:CreateButton({
        Name = "Teleport To NPC "..npcName,
        Callback = function()
            teleportToNPC(npcName)
        end
    })
end

local Tab = Window:CreateTab("Teleport Island", nil)
local Section = Tab:CreateSection("Island")

Tab:CreateButton({
    Name = "Teleport to Fox Town",
    Callback = function()
        local player = game.Players.LocalPlayer
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        if hrp then
            -- Posisi Fox Town
            hrp.CFrame = CFrame.new(2073.82324, 121.487457, -378.836548)
        end
    end
})

Tab:CreateButton({
    Name = "Teleport to Verdant Vale",
    Callback = function()
        local player = game.Players.LocalPlayer
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        if hrp then
            -- CFrame Verdant Vale (posisi + rotasi)
            hrp.CFrame = CFrame.new(
                3548.83154, 82.0540695, 1330.61133,
                0.0363482684, 3.42970523e-08, 0.999339163,
                4.76747836e-16, 1, -3.43197293e-08,
                -0.999339163, 1.24746324e-09, 0.0363482684
            )
        end
    end
})

Tab:CreateButton({
    Name = "Teleport to Mount Cinder",
    Callback = function()
        local player = game.Players.LocalPlayer
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        if hrp then
            -- CFrame Mount Cinder (posisi + rotasi)
            hrp.CFrame = CFrame.new(
                4576.03955, 1101.71594, -1708.38879,
                -0.978816926, -5.98474876e-08, 0.20473747,
                -5.36289306e-08, 1, 3.59220316e-08,
                -0.20473747, 2.41812401e-08, -0.978816926
            )
        end
    end
})

Tab:CreateButton({
    Name = "Teleport to Rooftop Woodlands",
    Callback = function()
        local player = game.Players.LocalPlayer
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        if hrp then
            -- CFrame Rooftop Woodlands (posisi + rotasi)
            hrp.CFrame = CFrame.new(
                3895.53564, 225.724136, 375.536469,
                -0.352712542, -8.26963955e-08, -0.935731709,
                -6.85288555e-08, 1, -6.25450696e-08,
                0.935731709, 4.20641939e-08, -0.352712542
            )
        end
    end
})

-- pastikan Rayfield & Window sudah siap sebelum ini

local bossesFolder = workspace.World:WaitForChild("NPCs")

local bossesToWatch = {
    ["Molten Monstrosity"] = true,
    ["A King Crab"] = true,
    ["Fuzzball"] = true,
    ["Candlelight Phantom"] = true,
    ["Giant Spider"] = true,
    ["Basilisk"] = true,
}

local function notifyBoss(name)
    Rayfield:Notify({
        Title = "Boss Spawned!",
        Content = name .. " has spawned!",
        Duration = 5,
        Actions = {
            OK = {
                Name = "OK",
                Callback = function() end
            }
        }
    })
end

-- cek boss yang sudah ada saat join
for _,v in ipairs(bossesFolder:GetChildren()) do
    if bossesToWatch[v.Name] then
        notifyBoss(v.Name)
    end
end

-- pantau boss baru yang spawn
bossesFolder.ChildAdded:Connect(function(child)
    if bossesToWatch[child.Name] then
        notifyBoss(child.Name)
    end
end)

-- ✅ Anti Auto-Purchase System for Meteor Shower
local Tab = Window:CreateTab("Anti Auto-Purchase", nil)
local Section = Tab:CreateSection("Protection")

-- Global flag to prevent auto-purchases
getgenv().preventAutoPurchase = true

-- Block automatic dialogue responses that could trigger purchases
local function blockAutoPurchase()
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local DialogueRemotes = ReplicatedStorage:FindFirstChild("DialogueRemotes")
    
    if DialogueRemotes then
        local RemoteFunc = DialogueRemotes:FindFirstChild("RemoteFunc")
        if RemoteFunc then
            -- Hook the RemoteFunc to prevent unwanted purchases
            local oldFireServer = RemoteFunc.FireServer
            RemoteFunc.FireServer = function(self, ...)
                local args = {...}
                
                -- Block meteor shower purchases if auto-purchase is disabled
                if getgenv().preventAutoPurchase then
                    local argString = tostring(args[1] or "")
                    if argString:lower():find("meteor") or argString:lower():find("shower") then
                        warn("⚠️ Blocked automatic meteor shower purchase!")
                        return
                    end
                end
                
                return oldFireServer(self, ...)
            end
        end
    end
end

-- Toggle for auto-purchase protection
Tab:CreateToggle({
    Name = "Block Auto Meteor Shower Purchase",
    CurrentValue = true,
    Flag = "BlockAutoPurchase",
    Callback = function(Value)
        getgenv().preventAutoPurchase = Value
        if Value then
            blockAutoPurchase()
            Rayfield:Notify({
                Title = "Protection Enabled",
                Content = "Automatic meteor shower purchases are now blocked",
                Duration = 3
            })
        else
            Rayfield:Notify({
                Title = "Protection Disabled",
                Content = "Automatic meteor shower purchases are now allowed",
                Duration = 3
            })
        end
    end,
})

-- Manual meteor shower purchase button (for when users actually want it)
Tab:CreateButton({
    Name = "Manual Meteor Shower Purchase",
    Callback = function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local DialogueRemotes = ReplicatedStorage:FindFirstChild("DialogueRemotes")
        
        if DialogueRemotes then
            local RemoteFunc = DialogueRemotes:FindFirstChild("RemoteFunc")
            if RemoteFunc then
                -- Temporarily disable protection for manual purchase
                local oldProtection = getgenv().preventAutoPurchase
                getgenv().preventAutoPurchase = false
                
                -- Attempt manual purchase (you'll need to adjust this based on the actual purchase method)
                pcall(function()
                    RemoteFunc:FireServer("meteor_shower") -- Adjust this parameter as needed
                end)
                
                -- Restore protection
                getgenv().preventAutoPurchase = oldProtection
                
                Rayfield:Notify({
                    Title = "Manual Purchase",
                    Content = "Attempted manual meteor shower purchase",
                    Duration = 3
                })
            end
        end
    end,
})

-- Initialize the protection on script load
blockAutoPurchase()
