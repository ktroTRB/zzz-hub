-- Load Fluent library
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

-- Create main window optimized for mobile with larger horizontal size
local Window = Fluent:CreateWindow({
    Title = "💧 Water HUB",
    SubTitle = "Ultimate Edition v5.3",
    TabWidth = 180,
    Size = UDim2.fromOffset(480, 360),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Variables
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera
local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled

-- Create persistent image (always visible)
local persistentGui = Instance.new("ScreenGui")
persistentGui.Name = "FluentPersistentButton"
persistentGui.Parent = playerGui
persistentGui.ResetOnSpawn = false
persistentGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
persistentGui.Enabled = true

-- Main button
local imageButton = Instance.new("ImageButton")
imageButton.Name = "PersistentControl"
imageButton.Size = UDim2.fromOffset(70, 70)
imageButton.Position = UDim2.new(0, 20, 0.5, -35)
imageButton.AnchorPoint = Vector2.new(0, 0.5)
imageButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
imageButton.BorderSizePixel = 0
imageButton.Image = "rbxassetid://6034684930"
imageButton.ScaleType = Enum.ScaleType.Fit
imageButton.Parent = persistentGui

-- Transparency effect
imageButton.BackgroundTransparency = 0.5
imageButton.ImageTransparency = 0.2

-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0.3, 0)
corner.Parent = imageButton

-- Hover effect
local hoverTween = TweenService:Create(imageButton, TweenInfo.new(0.3), {
    BackgroundTransparency = 0.2,
    ImageTransparency = 0,
    Size = UDim2.fromOffset(75, 75)
})
local normalTween = TweenService:Create(imageButton, TweenInfo.new(0.3), {
    BackgroundTransparency = 0.5,
    ImageTransparency = 0.2,
    Size = UDim2.fromOffset(70, 70)
})

imageButton.MouseEnter:Connect(function()
    hoverTween:Play()
end)
imageButton.MouseLeave:Connect(function()
    normalTween:Play()
end)

-- Dragging variables
local dragging = false
local dragStart = nil
local startPos = nil

-- Drag functions
local function onDragStart(input)
    dragging = true
    dragStart = input.Position
    startPos = imageButton.Position
end

local function onDragEnd(input)
    dragging = false
end

local function onDragMove(input)
    if dragging then
        local delta = input.Position - dragStart
        imageButton.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end

-- Connect drag events
imageButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        onDragStart(input)
    end
end)

imageButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        onDragEnd(input)
    end
end)

imageButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        onDragMove(input)
    end
end)

-- Toggle menu function
local function toggleMenu()
    if Window and Window.Root then
        Window.Root.Visible = not Window.Root.Visible
    end
end

-- Click handler
imageButton.MouseButton1Click:Connect(function()
    if not dragging then
        toggleMenu()
    end
end)

-- Rotation animation for water drop
spawn(function()
    local rotation = 0
    while imageButton and imageButton.Parent do
        rotation = rotation + 2
        imageButton.Rotation = rotation
        RunService.Heartbeat:Wait()
    end
end)

-- Intercept LeftControl
local function onKeyDown(key, gameProcessed)
    if key.KeyCode == Enum.KeyCode.LeftControl then
        if persistentGui.Enabled then
            toggleMenu()
            return
        end
    end
end

UserInputService.InputBegan:Connect(onKeyDown)

-- State management
local connections = {}
local states = {
    speedBoost = false,
    antiTrap = false,
    antiStun = false,
    infiniteJump = false,
    espPlayers = false,
    espBox = false,
    autoCollectMoney = false,
    fastSteal = false,
    godMode = false,
    noclip = false,
    fly = false
}

-- Helper variables
local stealHelperGui = nil
local originalWalkSpeed = 16
local originalJumpPower = 50
local espBoxes = {}
local basePosition = nil
local lastAttacker = nil

-- Utility Functions
local function getCharacter()
    return player.Character
end

local function getHumanoid()
    local char = getCharacter()
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function getRootPart()
    local char = getCharacter()
    return char and char:FindFirstChild("HumanoidRootPart")
end

-- Enhanced Anti-Stun with attacker detection
local function toggleAntiStun(enabled)
    states.antiStun = enabled
    
    if connections.antiStun then
        connections.antiStun:Disconnect()
        connections.antiStun = nil
    end
    
    if connections.damageDetection then
        connections.damageDetection:Disconnect()
        connections.damageDetection = nil
    end
    
    if enabled then
        connections.damageDetection = RunService.Heartbeat:Connect(function()
            local humanoid = getHumanoid()
            if humanoid then
                local currentHealth = humanoid.Health
                if currentHealth < humanoid.MaxHealth * 0.9 then
                    local rootPart = getRootPart()
                    if rootPart then
                        local closestPlayer = nil
                        local closestDistance = math.huge
                        
                        for _, targetPlayer in pairs(Players:GetPlayers()) do
                            if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                local distance = (targetPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude
                                if distance < 20 and distance < closestDistance then
                                    closestDistance = distance
                                    closestPlayer = targetPlayer
                                end
                            end
                        end
                        
                        if closestPlayer then
                            lastAttacker = closestPlayer
                        end
                    end
                end
            end
        end)
        
        connections.antiStun = RunService.Heartbeat:Connect(function()
            local humanoid = getHumanoid()
            local rootPart = getRootPart()
            
            if humanoid and rootPart then
                if humanoid:GetState() == Enum.HumanoidStateType.PlatformStanding or
                   humanoid:GetState() == Enum.HumanoidStateType.FallingDown or
                   humanoid:GetState() == Enum.HumanoidStateType.Ragdoll or
                   humanoid:GetState() == Enum.HumanoidStateType.Flying then
                    humanoid:ChangeState(Enum.HumanoidStateType.Running)
                end
                
                if math.abs(rootPart.Velocity.Y) > 50 then
                    rootPart.Velocity = Vector3.new(rootPart.Velocity.X, 0, rootPart.Velocity.Z)
                end
                
                for _, child in pairs(rootPart:GetChildren()) do
                    if child:IsA("BodyPosition") or child:IsA("BodyVelocity") or 
                       child:IsA("BodyAngularVelocity") or child:IsA("BodyThrust") then
                        child:Destroy()
                    end
                end
                
                humanoid.PlatformStand = false
                humanoid.Sit = false
                rootPart.Anchored = false
                
                if lastAttacker and humanoid.Health < humanoid.MaxHealth * 0.8 then
                    humanoid.Health = humanoid.MaxHealth
                end
            end
        end)
    else
        lastAttacker = nil
    end
end

-- Infinite Jump implementation
local function toggleInfiniteJump(enabled)
    states.infiniteJump = enabled
    
    if connections.infiniteJump then
        connections.infiniteJump:Disconnect()
        connections.infiniteJump = nil
    end
    
    if connections.jumpHeight then
        connections.jumpHeight:Disconnect()
        connections.jumpHeight = nil
    end
    
    if enabled then
        connections.infiniteJump = UserInputService.JumpRequest:Connect(function()
            local humanoid = getHumanoid()
            local rootPart = getRootPart()
            
            if humanoid and rootPart and humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
                bodyVelocity.Velocity = Vector3.new(0, 60, 0)
                bodyVelocity.Parent = rootPart
                
                game:GetService("Debris"):AddItem(bodyVelocity, 0.1)
            end
        end)
        
        connections.jumpHeight = RunService.Heartbeat:Connect(function()
            local humanoid = getHumanoid()
            if humanoid then
                humanoid.JumpPower = 50
                humanoid.JumpHeight = 7.2
            end
        end)
    end
end

-- Single Method Teleportation System
local function singleMethodTeleport(targetPosition, methodNumber)
    local rootPart = getRootPart()
    if not rootPart or not targetPosition then return false end
    
    local startTime = tick()
    local attemptConnection
    local success = false
    local wasNoclip = states.noclip
    local timeout = 10 -- 10 seconds timeout for single method
    
    -- Enable noclip temporarily
    if not wasNoclip then
        states.noclip = true
        if connections.noclip then
            connections.noclip:Disconnect()
        end
        connections.noclip = RunService.Stepped:Connect(function()
            local character = getCharacter()
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
    
    -- Cleanup function
    local function cleanup()
        for _, child in pairs(rootPart:GetChildren()) do
            if child.Name:find("Teleport") then
                child:Destroy()
            end
        end
        
        if not wasNoclip then
            states.noclip = false
            if connections.noclip then
                connections.noclip:Disconnect()
                connections.noclip = nil
            end
        end
    end
    
    -- Success function
    local function onSuccess()
        success = true
        if attemptConnection then
            attemptConnection:Disconnect()
        end
        cleanup()
        Fluent:Notify({
            Title = "Base TP",
            Content = "Successfully teleported using method " .. methodNumber .. "!",
            Duration = 3
        })
    end
    
    -- Method execution functions
    local methods = {
        -- Method 1: Direct CFrame teleportation
        function(target)
            rootPart.CFrame = CFrame.new(target)
            rootPart.Velocity = Vector3.new(0, 0, 0)
        end,
        
        -- Method 2: High altitude bypass
        function(target)
            local highTarget = Vector3.new(target.X, target.Y + 150, target.Z)
            rootPart.CFrame = CFrame.new(highTarget)
            rootPart.Velocity = Vector3.new(0, 0, 0)
            wait(0.3)
            rootPart.CFrame = CFrame.new(target)
        end,
        
        -- Method 3: Smooth flying movement
        function(target)
            local currentPos = rootPart.Position
            local direction = (target - currentPos).Unit
            local distance = (target - currentPos).Magnitude
            
            if distance > 3 then
                local speed = math.min(80, distance * 1.5)
                local newPos = currentPos + direction * speed * (1/60)
                rootPart.CFrame = CFrame.new(newPos)
                rootPart.Velocity = Vector3.new(0, 0, 0)
            end
        end,
        
        -- Method 4: BodyPosition method
        function(target)
            local bodyPos = rootPart:FindFirstChild("TeleportBodyPosition")
            if not bodyPos then
                bodyPos = Instance.new("BodyPosition")
                bodyPos.Name = "TeleportBodyPosition"
                bodyPos.MaxForce = Vector3.new(8000, 8000, 8000)
                bodyPos.P = 10000
                bodyPos.D = 1000
                bodyPos.Parent = rootPart
            end
            bodyPos.Position = target
        end,
        
        -- Method 5: Step-by-step teleportation
        function(target)
            local currentPos = rootPart.Position
            local distance = (target - currentPos).Magnitude
            local steps = math.ceil(distance / 15)
            
            for i = 1, steps do
                local alpha = i / steps
                local stepPos = currentPos:Lerp(target, alpha)
                rootPart.CFrame = CFrame.new(stepPos)
                rootPart.Velocity = Vector3.new(0, 0, 0)
                wait(0.05)
            end
        end,
        
        -- Method 6: Velocity-based teleportation
        function(target)
            local bodyVel = rootPart:FindFirstChild("TeleportBodyVelocity")
            if not bodyVel then
                bodyVel = Instance.new("BodyVelocity")
                bodyVel.Name = "TeleportBodyVelocity"
                bodyVel.MaxForce = Vector3.new(8000, 8000, 8000)
                bodyVel.Parent = rootPart
            end
            
            local direction = (target - rootPart.Position).Unit
            local distance = (target - rootPart.Position).Magnitude
            
            if distance > 3 then
                bodyVel.Velocity = direction * math.min(150, distance * 8)
            else
                bodyVel.Velocity = Vector3.new(0, 0, 0)
            end
        end
    }
    
    if not methods[methodNumber] then
        Fluent:Notify({
            Title = "Base TP",
            Content = "Invalid method number!",
            Duration = 3
        })
        cleanup()
        return false
    end
    
    attemptConnection = RunService.Heartbeat:Connect(function()
        local currentTime = tick()
        local elapsed = currentTime - startTime
        
        -- Check if we're close enough to target (success condition)
        local distance = (rootPart.Position - targetPosition).Magnitude
        if distance < 4 then
            onSuccess()
            return
        end
        
        -- Execute the selected method
        pcall(function()
            methods[methodNumber](targetPosition)
        end)
        
        -- Timeout check
        if elapsed > timeout then
            if attemptConnection then
                attemptConnection:Disconnect()
            end
            
            cleanup()
            
            Fluent:Notify({
                Title = "Base TP",
                Content = "Method " .. methodNumber .. " failed - timeout reached!",
                Duration = 4
            })
        end
    end)
    
    return true
end

-- Enhanced Multi-Method Base Teleportation System
local function advancedBaseTeleport(targetPosition)
    local rootPart = getRootPart()
    if not rootPart or not targetPosition then return false end
    
    local startTime = tick()
    local attemptConnection
    local success = false
    local currentMethod = 1
    local methodStartTime = startTime
    local wasNoclip = states.noclip
    local methodTimeouts = {2, 3, 4, 3, 3, 3} -- Timeout for each method
    
    -- Enable noclip temporarily
    if not wasNoclip then
        states.noclip = true
        if connections.noclip then
            connections.noclip:Disconnect()
        end
        connections.noclip = RunService.Stepped:Connect(function()
            local character = getCharacter()
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
    
    -- Cleanup function
    local function cleanup()
        for _, child in pairs(rootPart:GetChildren()) do
            if child.Name:find("Teleport") then
                child:Destroy()
            end
        end
        
        if not wasNoclip then
            states.noclip = false
            if connections.noclip then
                connections.noclip:Disconnect()
                connections.noclip = nil
            end
        end
    end
    
    -- Success function
    local function onSuccess(methodUsed)
        success = true
        if attemptConnection then
            attemptConnection:Disconnect()
        end
        cleanup()
        Fluent:Notify({
            Title = "Base TP",
            Content = "Successfully teleported using method " .. methodUsed .. "!",
            Duration = 3
        })
    end
    
    -- Teleportation methods array
    local methods = {
        -- Method 1: Direct CFrame teleportation
        function(target)
            rootPart.CFrame = CFrame.new(target)
            rootPart.Velocity = Vector3.new(0, 0, 0)
        end,
        
        -- Method 2: High altitude bypass
        function(target)
            local highTarget = Vector3.new(target.X, target.Y + 150, target.Z)
            rootPart.CFrame = CFrame.new(highTarget)
            rootPart.Velocity = Vector3.new(0, 0, 0)
            wait(0.3)
            rootPart.CFrame = CFrame.new(target)
        end,
        
        -- Method 3: Smooth flying movement
        function(target)
            local currentPos = rootPart.Position
            local direction = (target - currentPos).Unit
            local distance = (target - currentPos).Magnitude
            
            if distance > 3 then
                local speed = math.min(80, distance * 1.5)
                local newPos = currentPos + direction * speed * (1/60)
                rootPart.CFrame = CFrame.new(newPos)
                rootPart.Velocity = Vector3.new(0, 0, 0)
            end
        end,
        
        -- Method 4: BodyPosition method
        function(target)
            local bodyPos = rootPart:FindFirstChild("TeleportBodyPosition")
            if not bodyPos then
                bodyPos = Instance.new("BodyPosition")
                bodyPos.Name = "TeleportBodyPosition"
                bodyPos.MaxForce = Vector3.new(8000, 8000, 8000)
                bodyPos.P = 10000
                bodyPos.D = 1000
                bodyPos.Parent = rootPart
            end
            bodyPos.Position = target
        end,
        
        -- Method 5: Step-by-step teleportation
        function(target)
            local currentPos = rootPart.Position
            local distance = (target - currentPos).Magnitude
            local steps = math.ceil(distance / 20) -- 20 studs per step
            
            for i = 1, steps do
                local alpha = i / steps
                local stepPos = currentPos:Lerp(target, alpha)
                rootPart.CFrame = CFrame.new(stepPos)
                rootPart.Velocity = Vector3.new(0, 0, 0)
                wait(0.05)
            end
        end,
        
        -- Method 6: Velocity-based teleportation
        function(target)
            local bodyVel = rootPart:FindFirstChild("TeleportBodyVelocity")
            if not bodyVel then
                bodyVel = Instance.new("BodyVelocity")
                bodyVel.Name = "TeleportBodyVelocity"
                bodyVel.MaxForce = Vector3.new(8000, 8000, 8000)
                bodyVel.Parent = rootPart
            end
            
            local direction = (target - rootPart.Position).Unit
            local distance = (target - rootPart.Position).Magnitude
            
            if distance > 3 then
                bodyVel.Velocity = direction * math.min(150, distance * 8)
            else
                bodyVel.Velocity = Vector3.new(0, 0, 0)
            end
        end
    }
    
    -- Initial notification
    Fluent:Notify({
        Title = "Base TP",
        Content = "Starting method 1...",
        Duration = 1
    })
    
    attemptConnection = RunService.Heartbeat:Connect(function()
        local currentTime = tick()
        local totalElapsed = currentTime - startTime
        local methodElapsed = currentTime - methodStartTime
        
        -- Check if we're close enough to target (success condition)
        local distance = (rootPart.Position - targetPosition).Magnitude
        if distance < 4 then
            onSuccess(currentMethod)
            return
        end
        
        -- Check if current method has timed out
        local currentTimeout = methodTimeouts[currentMethod] or 3
        if methodElapsed > currentTimeout then
            -- Clean up current method
            for _, child in pairs(rootPart:GetChildren()) do
                if child.Name:find("Teleport") then
                    child:Destroy()
                end
            end
            
            -- Move to next method
            currentMethod = currentMethod + 1
            methodStartTime = currentTime
            
            if currentMethod <= #methods then
                Fluent:Notify({
                    Title = "Base TP",
                    Content = "Method " .. (currentMethod - 1) .. " failed. Trying method " .. currentMethod .. "...",
                    Duration = 1
                })
            else
                -- All methods failed
                if attemptConnection then
                    attemptConnection:Disconnect()
                end
                
                -- Emergency escape
                rootPart.CFrame = CFrame.new(rootPart.Position.X, 500, rootPart.Position.Z)
                cleanup()
                
                Fluent:Notify({
                    Title = "Base TP",
                    Content = "All methods failed - Emergency exit!",
                    Duration = 4
                })
                return
            end
        end
        
        -- Execute current method if still valid
        if currentMethod <= #methods then
            pcall(function()
                methods[currentMethod](targetPosition)
            end)
        end
        
        -- Ultimate safety timeout after 25 seconds
        if totalElapsed > 25 then
            if attemptConnection then
                attemptConnection:Disconnect()
            end
            
            rootPart.CFrame = CFrame.new(rootPart.Position.X, 1000, rootPart.Position.Z)
            cleanup()
            
            Fluent:Notify({
                Title = "Base TP",
                Content = "Ultimate timeout - Emergency exit!",
                Duration = 4
            })
        end
    end)
    
    return true
end

-- Create tabs
local Tabs = {
    Main = Window:AddTab({ Title = "🛡️ Main", Icon = "shield" }),
    Visual = Window:AddTab({ Title = "👁️ Visual", Icon = "eye" }),
    Misc = Window:AddTab({ Title = "🔧 Misc", Icon = "settings" }),
    Money = Window:AddTab({ Title = "💰 Money", Icon = "dollar-sign" }),
    Server = Window:AddTab({ Title = "🌐 Server", Icon = "globe" })
}

-- MAIN TAB
Tabs.Main:AddToggle("SpeedBoost", {
    Title = "⚡ Speed Boost 8x (Enhanced)",
    Description = "Increases movement speed significantly",
    Default = false,
    Callback = function(value)
        states.speedBoost = value
        if player.Character and player.Character:FindFirstChild("Humanoid") then
            if value then
                player.Character.Humanoid.WalkSpeed = originalWalkSpeed * 8
                player.Character.Humanoid.JumpPower = originalJumpPower * 4
            else
                player.Character.Humanoid.WalkSpeed = originalWalkSpeed
                player.Character.Humanoid.JumpPower = originalJumpPower
            end
        end
    end
})

Tabs.Main:AddToggle("AntiTrap", {
    Title = "🚫 Anti Trap (Movement Freedom)",
    Description = "Prevents being trapped by other players",
    Default = false,
    Callback = function(value)
        states.antiTrap = value
        
        if connections.antiTrap then
            connections.antiTrap:Disconnect()
            connections.antiTrap = nil
        end
        
        if value then
            connections.antiTrap = RunService.Heartbeat:Connect(function()
                local humanoid = getHumanoid()
                local rootPart = getRootPart()
                
                if humanoid and rootPart then
                    humanoid.PlatformStand = false
                    humanoid.Sit = false
                    rootPart.Anchored = false
                    
                    for _, v in pairs(rootPart:GetChildren()) do
                        if v:IsA("BodyPosition") or v:IsA("BodyVelocity") or v:IsA("BodyAngularVelocity") then
                            v:Destroy()
                        end
                    end
                end
            end)
        end
    end
})

Tabs.Main:AddToggle("AntiStun", {
    Title = "🛡️ Anti Stun (Enhanced with Attacker Detection)",
    Description = "Prevents stunning and detects who attacks you",
    Default = false,
    Callback = function(value)
        toggleAntiStun(value)
    end
})

Tabs.Main:AddToggle("InfiniteJump", {
    Title = "🦘 Infinite Jump (Enhanced)",
    Description = "Jump infinitely without touching ground",
    Default = false,
    Callback = function(value)
        toggleInfiniteJump(value)
    end
})

Tabs.Main:AddToggle("GodMode", {
    Title = "🛡️ God Mode",
    Description = "Complete invincibility",
    Default = false,
    Callback = function(value)
        states.godMode = value
        
        if connections.godMode then
            connections.godMode:Disconnect()
            connections.godMode = nil
        end
        
        if value then
            connections.godMode = RunService.Heartbeat:Connect(function()
                local humanoid = getHumanoid()
                if humanoid then
                    humanoid.Health = humanoid.MaxHealth
                    
                    pcall(function()
                        humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
                        humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                        humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
                    end)
                    
                    local char = getCharacter()
                    if char and not char:FindFirstChild("ForceField") then
                        local ff = Instance.new("ForceField")
                        ff.Visible = false
                        ff.Parent = char
                    end
                end
            end)
        end
    end
})

Tabs.Main:AddToggle("Noclip", {
    Title = "👻 Noclip",
    Description = "Walk through walls",
    Default = false,
    Callback = function(value)
        states.noclip = value
        
        if connections.noclip then
            connections.noclip:Disconnect()
            connections.noclip = nil
        end
        
        if value then
            connections.noclip = RunService.Stepped:Connect(function()
                local character = getCharacter()
                if character then
                    for _, part in pairs(character:GetDescendants()) do
                        if part:IsA("BasePart") then
                            part.CanCollide = false
                        end
                    end
                end
            end)
        else
            local character = getCharacter()
            if character then
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        part.CanCollide = true
                    end
                end
            end
        end
    end
})

-- VISUAL TAB
Tabs.Visual:AddToggle("ESPPlayers", {
    Title = "👥 ESP Player Highlights",
    Description = "Highlight all players",
    Default = false,
    Callback = function(value)
        states.espPlayers = value
        for _, targetPlayer in pairs(Players:GetPlayers()) do
            if targetPlayer ~= Players.LocalPlayer and targetPlayer.Character then
                local highlight = targetPlayer.Character:FindFirstChild("Highlight")
                if value then
                    if not highlight then
                        highlight = Instance.new("Highlight")
                        highlight.Parent = targetPlayer.Character
                        highlight.FillColor = Color3.fromRGB(255, 0, 0)
                        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    end
                else
                    if highlight then
                        highlight:Destroy()
                    end
                end
            end
        end
    end
})

local function createESPBox(character)
    local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "ESPBox"
    billboardGui.Adornee = humanoidRootPart
    billboardGui.Size = UDim2.new(4, 0, 6, 0)
    billboardGui.StudsOffset = Vector3.new(0, 0, 0)
    billboardGui.Parent = character
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.Parent = billboardGui
    
    local function createLine(name, size, position)
        local line = Instance.new("Frame")
        line.Name = name
        line.Size = size
        line.Position = position
        line.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        line.BorderSizePixel = 0
        line.Parent = frame
        return line
    end
    
    createLine("Top", UDim2.new(1, 0, 0, 2), UDim2.new(0, 0, 0, 0))
    createLine("Bottom", UDim2.new(1, 0, 0, 2), UDim2.new(0, 0, 1, -2))
    createLine("Left", UDim2.new(0, 2, 1, 0), UDim2.new(0, 0, 0, 0))
    createLine("Right", UDim2.new(0, 2, 1, 0), UDim2.new(1, -2, 0, 0))
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 0, 20)
    nameLabel.Position = UDim2.new(0, 0, 0, -25)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = character.Name
    nameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    nameLabel.TextSize = 14
    nameLabel.Font = Enum.Font.SourceSansBold
    nameLabel.TextStrokeTransparency = 0
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Parent = frame
    
    return billboardGui
end

local function removeESPBox(character)
    local espBox = character:FindFirstChild("ESPBox")
    if espBox then
        espBox:Destroy()
    end
end

Tabs.Visual:AddToggle("ESPBox", {
    Title = "📦 ESP Box",
    Description = "Show boxes around players",
    Default = false,
    Callback = function(value)
        states.espBox = value
        for _, targetPlayer in pairs(Players:GetPlayers()) do
            if targetPlayer ~= Players.LocalPlayer and targetPlayer.Character then
                if value then
                    createESPBox(targetPlayer.Character)
                else
                    removeESPBox(targetPlayer.Character)
                end
            end
        end
    end
})

-- MISC TAB
Tabs.Misc:AddSection("🚀 Stealing Tools")

Tabs.Misc:AddToggle("FastSteal", {
    Title = "⚡ Fast Steal",
    Description = "Instantly steal without hold duration",
    Default = false,
    Callback = function(value)
        states.fastSteal = value
    end
})

Tabs.Misc:AddButton({
    Title = "💰 Steal Helper",
    Description = "Compact stealing assistance tool",
    Callback = function()
        if stealHelperGui then
            stealHelperGui:Destroy()
        end
        
        stealHelperGui = Instance.new("ScreenGui")
        stealHelperGui.Name = "StealHelper"
        stealHelperGui.Parent = playerGui
        stealHelperGui.ResetOnSpawn = false
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.fromOffset(180, 120)
        frame.Position = UDim2.new(0, 20, 0.3, 0)
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        frame.BackgroundTransparency = 0.1
        frame.BorderSizePixel = 0
        frame.Active = true
        frame.Draggable = true
        frame.Parent = stealHelperGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = frame
        
        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(0, 170, 255)
        stroke.Transparency = 0.5
        stroke.Thickness = 1
        stroke.Parent = frame
        
        local titleBar = Instance.new("Frame")
        titleBar.Size = UDim2.new(1, 0, 0, 25)
        titleBar.Position = UDim2.new(0, 0, 0, 0)
        titleBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        titleBar.BackgroundTransparency = 0.3
        titleBar.BorderSizePixel = 0
        titleBar.Parent = frame
        
        local titleCorner = Instance.new("UICorner")
        titleCorner.CornerRadius = UDim.new(0, 10)
        titleCorner.Parent = titleBar
        
        local titleFix = Instance.new("Frame")
        titleFix.Size = UDim2.new(1, 0, 0, 10)
        titleFix.Position = UDim2.new(0, 0, 1, -10)
        titleFix.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        titleFix.BackgroundTransparency = 0.3
        titleFix.BorderSizePixel = 0
        titleFix.Parent = titleBar
        
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -25, 1, 0)
        title.Position = UDim2.new(0, 5, 0, 0)
        title.BackgroundTransparency = 1
        title.Text = "💰 Steal Helper"
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextSize = 12
        title.Font = Enum.Font.SourceSansBold
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = titleBar
        
        local closeBtn = Instance.new("TextButton")
        closeBtn.Size = UDim2.fromOffset(20, 20)
        closeBtn.Position = UDim2.new(1, -23, 0, 2.5)
        closeBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
        closeBtn.BackgroundTransparency = 0.2
        closeBtn.Text = "×"
        closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeBtn.TextSize = 12
        closeBtn.Font = Enum.Font.SourceSansBold
        closeBtn.Parent = titleBar
        
        local closeCorner = Instance.new("UICorner")
        closeCorner.CornerRadius = UDim.new(0, 5)
        closeCorner.Parent = closeBtn
        
        closeBtn.MouseButton1Click:Connect(function()
            stealHelperGui:Destroy()
        end)
        
        local upBtn = Instance.new("TextButton")
        upBtn.Size = UDim2.new(1, -10, 0, 35)
        upBtn.Position = UDim2.new(0, 5, 0, 30)
        upBtn.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
        upBtn.BackgroundTransparency = 0.2
        upBtn.Text = "⬆️ UP"
        upBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        upBtn.TextSize = 12
        upBtn.Font = Enum.Font.SourceSansBold
        upBtn.Parent = frame
        
        local upCorner = Instance.new("UICorner")
        upCorner.CornerRadius = UDim.new(0, 8)
        upCorner.Parent = upBtn
        
        local downBtn = Instance.new("TextButton")
        downBtn.Size = UDim2.new(1, -10, 0, 35)
        downBtn.Position = UDim2.new(0, 5, 0, 75)
        downBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
        downBtn.BackgroundTransparency = 0.2
        downBtn.Text = "⬇️ DOWN"
        downBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        downBtn.TextSize = 12
        downBtn.Font = Enum.Font.SourceSansBold
        downBtn.Parent = frame
        
        local downCorner = Instance.new("UICorner")
        downCorner.CornerRadius = UDim.new(0, 8)
        downCorner.Parent = downBtn
        
        upBtn.MouseButton1Click:Connect(function()
            local rootPart = getRootPart()
            if rootPart then
                rootPart.CFrame = CFrame.new(rootPart.Position.X, 165, rootPart.Position.Z)
            end
        end)
        
        downBtn.MouseButton1Click:Connect(function()
            local rootPart = getRootPart()
            if rootPart then
                rootPart.CFrame = rootPart.CFrame - Vector3.new(0, 70, 0)
            end
        end)
    end
})

-- Enhanced Base System
Tabs.Misc:AddSection("📍 Base System")

local baseSystemGui = nil

-- Auto-set spawn position when character spawns
player.CharacterAdded:Connect(function(character)
    wait(2) -- Wait for character to fully load
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if rootPart then
        if not basePosition then -- Only auto-set if no base is manually configured
            basePosition = rootPart.Position
            Fluent:Notify({
                Title = "Base System",
                Content = "Spawn position automatically set as base!",
                Duration = 3
            })
        end
    end
end)

Tabs.Misc:AddButton({
    Title = "📍 Open Base System",
    Description = "Advanced multi-method base teleportation",
    Callback = function()
        if baseSystemGui then
            baseSystemGui:Destroy()
        end
        
        baseSystemGui = Instance.new("ScreenGui")
        baseSystemGui.Name = "BaseSystem"
        baseSystemGui.Parent = playerGui
        baseSystemGui.ResetOnSpawn = false
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.fromOffset(220, 220)  -- Increased size for new elements
        frame.Position = UDim2.new(0, 200, 0.4, 0)
        frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        frame.BackgroundTransparency = 0.1
        frame.BorderSizePixel = 0
        frame.Active = true
        frame.Draggable = true
        frame.Parent = baseSystemGui
        
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = frame
        
        local stroke = Instance.new("UIStroke")
        stroke.Color = Color3.fromRGB(0, 170, 255)
        stroke.Transparency = 0.5
        stroke.Thickness = 1
        stroke.Parent = frame
        
        local titleBar = Instance.new("Frame")
        titleBar.Size = UDim2.new(1, 0, 0, 25)
        titleBar.Position = UDim2.new(0, 0, 0, 0)
        titleBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        titleBar.BackgroundTransparency = 0.3
        titleBar.BorderSizePixel = 0
        titleBar.Parent = frame
        
        local titleCorner = Instance.new("UICorner")
        titleCorner.CornerRadius = UDim.new(0, 8)
        titleCorner.Parent = titleBar
        
        local titleFix = Instance.new("Frame")
        titleFix.Size = UDim2.new(1, 0, 0, 8)
        titleFix.Position = UDim2.new(0, 0, 1, -8)
        titleFix.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        titleFix.BackgroundTransparency = 0.3
        titleFix.BorderSizePixel = 0
        titleFix.Parent = titleBar
        
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, -25, 1, 0)
        title.Position = UDim2.new(0, 5, 0, 0)
        title.BackgroundTransparency = 1
        title.Text = "📍 Base System"
        title.TextColor3 = Color3.fromRGB(255, 255, 255)
        title.TextSize = 11
        title.Font = Enum.Font.SourceSansBold
        title.TextXAlignment = Enum.TextXAlignment.Left
        title.Parent = titleBar
        
        local closeBtn = Instance.new("TextButton")
        closeBtn.Size = UDim2.fromOffset(20, 20)
        closeBtn.Position = UDim2.new(1, -22, 0, 2.5)
        closeBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
        closeBtn.BackgroundTransparency = 0.2
        closeBtn.Text = "×"
        closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        closeBtn.TextSize = 12
        closeBtn.Font = Enum.Font.SourceSansBold
        closeBtn.Parent = titleBar
        
        local closeCorner = Instance.new("UICorner")
        closeCorner.CornerRadius = UDim.new(0, 4)
        closeCorner.Parent = closeBtn
        
        closeBtn.MouseButton1Click:Connect(function()
            baseSystemGui:Destroy()
        end)
        
        -- Base status section
        local statusSection = Instance.new("Frame")
        statusSection.Size = UDim2.new(1, -10, 0, 25)
        statusSection.Position = UDim2.new(0, 5, 0, 30)
        statusSection.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        statusSection.BackgroundTransparency = 0.3
        statusSection.BorderSizePixel = 0
        statusSection.Parent = frame
        
        local statusCorner = Instance.new("UICorner")
        statusCorner.CornerRadius = UDim.new(0, 6)
        statusCorner.Parent = statusSection
        
        local statusLabel = Instance.new("TextLabel")
        statusLabel.Size = UDim2.new(1, -10, 1, 0)
        statusLabel.Position = UDim2.new(0, 5, 0, 0)
        statusLabel.BackgroundTransparency = 1
        statusLabel.Text = basePosition and "✅ Base Position Set" or "❌ Base Position Not Set"
        statusLabel.TextColor3 = basePosition and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
        statusLabel.TextSize = 10
        statusLabel.Font = Enum.Font.SourceSans
        statusLabel.TextXAlignment = Enum.TextXAlignment.Left
        statusLabel.Parent = statusSection
        
        -- Coordinates display
        local coordsSection = Instance.new("Frame")
        coordsSection.Size = UDim2.new(1, -10, 0, 30)
        coordsSection.Position = UDim2.new(0, 5, 0, 60)
        coordsSection.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        coordsSection.BackgroundTransparency = 0.3
        coordsSection.BorderSizePixel = 0
        coordsSection.Parent = frame
        
        local coordsCorner = Instance.new("UICorner")
        coordsCorner.CornerRadius = UDim.new(0, 6)
        coordsCorner.Parent = coordsSection
        
        local coordsLabel = Instance.new("TextLabel")
        coordsLabel.Size = UDim2.new(1, -10, 1, 0)
        coordsLabel.Position = UDim2.new(0, 5, 0, 0)
        coordsLabel.BackgroundTransparency = 1
        coordsLabel.Text = basePosition and string.format("📍 X:%.1f Y:%.1f Z:%.1f", basePosition.X, basePosition.Y, basePosition.Z) or "📍 No coordinates set"
        coordsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        coordsLabel.TextSize = 9
        coordsLabel.Font = Enum.Font.SourceSans
        coordsLabel.TextXAlignment = Enum.TextXAlignment.Left
        coordsLabel.Parent = coordsSection
        
        -- Set Base button (always visible)
        local setBtn = Instance.new("TextButton")
        setBtn.Size = UDim2.new(1, -10, 0, 30)
        setBtn.Position = UDim2.new(0, 5, 0, 95)
        setBtn.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
        setBtn.BackgroundTransparency = 0.2
        setBtn.Text = "SET BASE POSITION"
        setBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        setBtn.TextSize = 10
        setBtn.Font = Enum.Font.SourceSansBold
        setBtn.Parent = frame
        
        local setCorner = Instance.new("UICorner")
        setCorner.CornerRadius = UDim.new(0, 6)
        setCorner.Parent = setBtn
        
        -- Method selection dropdown
        local dropdownFrame = Instance.new("Frame")
        dropdownFrame.Size = UDim2.new(1, -10, 0, 25)
        dropdownFrame.Position = UDim2.new(0, 5, 0, 130)
        dropdownFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        dropdownFrame.BackgroundTransparency = 0.2
        dropdownFrame.BorderSizePixel = 0
        dropdownFrame.Parent = frame
        
        local dropdownCorner = Instance.new("UICorner")
        dropdownCorner.CornerRadius = UDim.new(0, 6)
        dropdownCorner.Parent = dropdownFrame
        
        local dropdownButton = Instance.new("TextButton")
        dropdownButton.Size = UDim2.new(1, -20, 1, 0)
        dropdownButton.Position = UDim2.new(0, 3, 0, 0)
        dropdownButton.BackgroundTransparency = 1
        dropdownButton.Text = "Auto (All Methods)"
        dropdownButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        dropdownButton.TextSize = 9
        dropdownButton.Font = Enum.Font.SourceSans
        dropdownButton.TextXAlignment = Enum.TextXAlignment.Left
        dropdownButton.Parent = dropdownFrame
        
        local dropdownArrow = Instance.new("TextLabel")
        dropdownArrow.Size = UDim2.new(0, 15, 1, 0)
        dropdownArrow.Position = UDim2.new(1, -18, 0, 0)
        dropdownArrow.BackgroundTransparency = 1
        dropdownArrow.Text = "▼"
        dropdownArrow.TextColor3 = Color3.fromRGB(255, 255, 255)
        dropdownArrow.TextSize = 8
        dropdownArrow.Font = Enum.Font.SourceSans
        dropdownArrow.Parent = dropdownFrame
        
        -- Dropdown options
        local dropdownOptions = {
            {text = "Auto (All Methods)", value = 0},
            {text = "Try TP 1 (Direct CFrame)", value = 1},
            {text = "Try TP 2 (High Altitude)", value = 2},
            {text = "Try TP 3 (Smooth Flying)", value = 3},
            {text = "Try TP 4 (BodyPosition)", value = 4},
            {text = "Try TP 5 (Step-by-Step)", value = 5},
            {text = "Try TP 6 (Velocity-Based)", value = 6}
        }
        
        local selectedMethod = 0
        local dropdownOpen = false
        local optionsFrame = nil
        
        local function closeDropdown()
            if optionsFrame then
                optionsFrame:Destroy()
                optionsFrame = nil
            end
            dropdownOpen = false
            dropdownArrow.Text = "▼"
            frame.Draggable = true
        end
        
        local function openDropdown()
            if optionsFrame then
                closeDropdown()
                return
            end
            
            dropdownOpen = true
            dropdownArrow.Text = "▲"
            frame.Draggable = false
            
            optionsFrame = Instance.new("Frame")
            optionsFrame.Size = UDim2.new(1, 0, 0, #dropdownOptions * 22)
            optionsFrame.Position = UDim2.new(0, 0, 1, 2)
            optionsFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            optionsFrame.BackgroundTransparency = 0.1
            optionsFrame.BorderSizePixel = 0
            optionsFrame.ZIndex = 10
            optionsFrame.Parent = dropdownFrame
            
            local optionsCorner = Instance.new("UICorner")
            optionsCorner.CornerRadius = UDim.new(0, 6)
            optionsCorner.Parent = optionsFrame
            
            local optionsStroke = Instance.new("UIStroke")
            optionsStroke.Color = Color3.fromRGB(0, 170, 255)
            optionsStroke.Transparency = 0.7
            optionsStroke.Thickness = 1
            optionsStroke.Parent = optionsFrame
            
            for i, option in ipairs(dropdownOptions) do
                local optionButton = Instance.new("TextButton")
                optionButton.Size = UDim2.new(1, -4, 0, 20)
                optionButton.Position = UDim2.new(0, 2, 0, (i-1) * 22 + 1)
                optionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                optionButton.BackgroundTransparency = selectedMethod == option.value and 0.3 or 0.8
                optionButton.Text = option.text
                optionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                optionButton.TextSize = 9
                optionButton.Font = Enum.Font.SourceSans
                optionButton.TextXAlignment = Enum.TextXAlignment.Left
                optionButton.ZIndex = 11
                optionButton.Parent = optionsFrame
                
                local optionCorner = Instance.new("UICorner")
                optionCorner.CornerRadius = UDim.new(0, 4)
                optionCorner.Parent = optionButton
                
                optionButton.MouseEnter:Connect(function()
                    if selectedMethod ~= option.value then
                        optionButton.BackgroundTransparency = 0.5
                    end
                end)
                
                optionButton.MouseLeave:Connect(function()
                    if selectedMethod ~= option.value then
                        optionButton.BackgroundTransparency = 0.8
                    end
                end)
                
                optionButton.MouseButton1Click:Connect(function()
                    selectedMethod = option.value
                    dropdownButton.Text = option.text
                    closeDropdown()
                end)
            end
        end
        
        dropdownButton.MouseButton1Click:Connect(openDropdown)
        dropdownFrame.MouseButton1Click:Connect(openDropdown)
        
        -- Try TP button (works with dropdown selection)
        local tryTPBtn = Instance.new("TextButton")
        tryTPBtn.Size = UDim2.new(1, -10, 0, 30)
        tryTPBtn.Position = UDim2.new(0, 5, 0, 160)
        tryTPBtn.BackgroundColor3 = Color3.fromRGB(255, 193, 7)
        tryTPBtn.BackgroundTransparency = 0.2
        tryTPBtn.Text = "TRY TP"
        tryTPBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        tryTPBtn.TextSize = 10
        tryTPBtn.Font = Enum.Font.SourceSansBold
        tryTPBtn.Parent = frame
        
        local tryTPCorner = Instance.new("UICorner")
        tryTPCorner.CornerRadius = UDim.new(0, 6)
        tryTPCorner.Parent = tryTPBtn
        
        -- Info label
        local infoLabel = Instance.new("TextLabel")
        infoLabel.Size = UDim2.new(1, -10, 0, 25)
        infoLabel.Position = UDim2.new(0, 5, 0, 195)
        infoLabel.BackgroundTransparency = 1
        infoLabel.Text = "Auto spawn detection enabled"
        infoLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
        infoLabel.TextSize = 8
        infoLabel.Font = Enum.Font.SourceSansItalic
        infoLabel.TextXAlignment = Enum.TextXAlignment.Center
        infoLabel.Parent = frame
        
        -- Function to update display elements
        local function updateDisplay()
            if basePosition then
                statusLabel.Text = "✅ Base Position Set"
                statusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
                coordsLabel.Text = string.format("📍 X:%.1f Y:%.1f Z:%.1f", basePosition.X, basePosition.Y, basePosition.Z)
                coordsLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
            else
                statusLabel.Text = "❌ Base Position Not Set"
                statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
                coordsLabel.Text = "📍 No coordinates set"
                coordsLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
            end
        end
        
        -- Event handlers
        setBtn.MouseButton1Click:Connect(function()
            local character = player.Character
            local rootPart = character and character:FindFirstChild("HumanoidRootPart")
            
            if rootPart then
                basePosition = rootPart.Position
                updateDisplay()
                
                -- Visual feedback on button
                local originalColor = setBtn.BackgroundColor3
                local originalText = setBtn.Text
                setBtn.BackgroundColor3 = Color3.fromRGB(100, 255, 100)
                setBtn.Text = "✅ BASE SET!"
                
                task.spawn(function()
                    task.wait(1.5)
                    if setBtn and setBtn.Parent then
                        setBtn.BackgroundColor3 = originalColor
                        setBtn.Text = originalText
                    end
                end)
                
                Fluent:Notify({
                    Title = "Base System",
                    Content = string.format("Manual base set at X:%.1f Y:%.1f Z:%.1f", basePosition.X, basePosition.Y, basePosition.Z),
                    Duration = 4
                })
            else
                Fluent:Notify({
                    Title = "Base System",
                    Content = "Error: Cannot detect player position. Please ensure your character is loaded.",
                    Duration = 4
                })
            end
        end)
        
        tryTPBtn.MouseButton1Click:Connect(function()
            closeDropdown()
            
            if not basePosition then
                Fluent:Notify({
                    Title = "Try TP",
                    Content = "Base position must be configured before attempting teleportation. Please set a base first.",
                    Duration = 4
                })
                
                -- Highlight set button
                local originalColor = setBtn.BackgroundColor3
                setBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
                task.spawn(function()
                    task.wait(1.5)
                    if setBtn and setBtn.Parent then
                        setBtn.BackgroundColor3 = originalColor
                    end
                end)
                return
            end
            
            if selectedMethod == 0 then
                Fluent:Notify({
                    Title = "Try TP",
                    Content = "Executing automatic multi-method teleportation sequence...",
                    Duration = 2
                })
                advancedBaseTeleport(basePosition)
            else
                Fluent:Notify({
                    Title = "Try TP",
                    Content = "Testing teleportation method " .. selectedMethod .. "...",
                    Duration = 2
                })
                singleMethodTeleport(basePosition, selectedMethod)
            end
        end)
        
        -- Close dropdown when clicking outside
        baseSystemGui.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 and dropdownOpen then
                local mousePos = input.Position
                local framePos = dropdownFrame.AbsolutePosition
                local frameSize = dropdownFrame.AbsoluteSize
                
                if mousePos.X < framePos.X or mousePos.X > framePos.X + frameSize.X or
                   mousePos.Y < framePos.Y or mousePos.Y > framePos.Y + frameSize.Y + (#dropdownOptions * 22) then
                    closeDropdown()
                end
            end
        end)
        
        -- Initial display update
        updateDisplay()
    end
})

-- MONEY TAB
local moneyLabel = Tabs.Money:AddParagraph({
    Title = "💰 Current Money",
    Content = "Loading..."
})

Tabs.Money:AddToggle("AutoCollectMoney", {
    Title = "🔄 Auto Collect Money",
    Description = "Automatically collect money items",
    Default = false,
    Callback = function(value)
        states.autoCollectMoney = value
    end
})

Tabs.Money:AddButton({
    Title = "📦 Give All Items",
    Description = "Collect all available items in the game",
    Callback = function()
        local collected = 0
        local character = getCharacter()
        if not character then return end
        
        local backpack = player:FindFirstChild("Backpack")
        if not backpack then return end
        
        local rootPart = getRootPart()
        if not rootPart then return end
        
        for _, obj in ipairs(Workspace:GetDescendants()) do
            if obj:IsA("Tool") and not obj.Parent:IsA("Model") then
                pcall(function()
                    obj.Parent = backpack
                    collected = collected + 1
                end)
            elseif obj:IsA("BasePart") then
                local name = obj.Name:lower()
                if name:match("item") or name:match("coin") or name:match("collectible") or 
                   name:match("pickup") or name:match("drop") or name:match("loot") then
                    pcall(function()
                        obj.CFrame = rootPart.CFrame
                        collected = collected + 1
                    end)
                end
            elseif obj:IsA("ProximityPrompt") then
                pcall(function()
                    fireproximityprompt(obj)
                    collected = collected + 1
                end)
            end
        end
        
        for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
            if obj:IsA("Tool") then
                pcall(function()
                    local clone = obj:Clone()
                    clone.Parent = backpack
                    collected = collected + 1
                end)
            end
        end
        
        Fluent:Notify({
            Title = "Item Collector",
            Content = "Collected " .. collected .. " items!",
            Duration = 3
        })
    end
})

-- SERVER TAB
Tabs.Server:AddSection("🔄 Server Controls")

Tabs.Server:AddButton({
    Title = "🔄 Rejoin Server",
    Description = "Rejoin the current server",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, player)
    end
})

Tabs.Server:AddButton({
    Title = "🚪 Leave Game",
    Description = "Leave the current game",
    Callback = function()
        player:Kick("Left the game via Water Hub")
    end
})

Tabs.Server:AddButton({
    Title = "🌐 Server Hop",
    Description = "Find and join a different server",
    Callback = function()
        local servers = {}
        local req = syn and syn.request or http_request or request
        
        if req then
            local success, result = pcall(function()
                return req({
                    Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100",
                    Method = "GET"
                })
            end)
            
            if success and result.Success then
                local data = HttpService:JSONDecode(result.Body)
                for _, server in pairs(data.data) do
                    if server.playing < server.maxPlayers and server.id ~= game.JobId then
                        table.insert(servers, server.id)
                    end
                end
                
                if #servers > 0 then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)])
                else
                    Fluent:Notify({
                        Title = "Server Hop",
                        Content = "No available servers found!",
                        Duration = 3
                    })
                end
            end
        end
    end
})

local playerCountLabel = Tabs.Server:AddParagraph({
    Title = "👥 Players",
    Content = #Players:GetPlayers() .. "/" .. Players.MaxPlayers
})

local serverIdLabel = Tabs.Server:AddParagraph({
    Title = "🆔 Server ID",
    Content = game.JobId:sub(1, 12) .. "..."
})

local pingLabel = Tabs.Server:AddParagraph({
    Title = "📡 Ping",
    Content = "Calculating..."
})

-- Update functions
local function updateMoneyLabel()
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local money = leaderstats:FindFirstChild("Money") or leaderstats:FindFirstChild("Cash") or leaderstats:FindFirstChild("Coins")
        if money then
            moneyLabel:SetDesc("💰 " .. tostring(money.Value))
        end
    else
        moneyLabel:SetDesc("💰 0 (No leaderstats found)")
    end
end

local function autoCollectMoneyFunc()
    if not states.autoCollectMoney then return end
    
    local rootPart = getRootPart()
    if not rootPart then return end
    
    for _, v in pairs(Workspace:GetDescendants()) do
        if v.Name:lower():find("money") or v.Name:lower():find("cash") or v.Name:lower():find("coin") then
            if v:IsA("Part") then
                local distance = (v.Position - rootPart.Position).Magnitude
                if distance <= 50 then
                    pcall(function()
                        firetouchinterest(rootPart, v, 0)
                        firetouchinterest(rootPart, v, 1)
                    end)
                end
            end
        end
    end
end

local function fastStealFunc()
    if not states.fastSteal then return end
    
    for _, v in pairs(Workspace:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            v.HoldDuration = 0
            v.KeyboardKeyCode = Enum.KeyCode.E
            v.ActionText = "Instant Steal"
        end
    end
end

local function updateESP()
    if states.espPlayers then
        for _, targetPlayer in pairs(Players:GetPlayers()) do
            if targetPlayer ~= Players.LocalPlayer and targetPlayer.Character then
                local highlight = targetPlayer.Character:FindFirstChild("Highlight")
                if not highlight then
                    highlight = Instance.new("Highlight")
                    highlight.Parent = targetPlayer.Character
                    highlight.FillColor = Color3.fromRGB(255, 0, 0)
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.FillTransparency = 0.5
                    highlight.OutlineTransparency = 0
                end
            end
        end
    end
    
    if states.espBox then
        for _, targetPlayer in pairs(Players:GetPlayers()) do
            if targetPlayer ~= Players.LocalPlayer and targetPlayer.Character then
                if not targetPlayer.Character:FindFirstChild("ESPBox") then
                    createESPBox(targetPlayer.Character)
                end
            end
        end
    end
end

-- Event handlers
Players.PlayerAdded:Connect(function(newPlayer)
    newPlayer.CharacterAdded:Connect(function(character)
        wait(1)
        if states.espPlayers and newPlayer ~= Players.LocalPlayer then
            local highlight = Instance.new("Highlight")
            highlight.Parent = character
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.5
        end
        if states.espBox and newPlayer ~= Players.LocalPlayer then
            createESPBox(character)
        end
    end)
end)

Players.PlayerRemoving:Connect(function(leavingPlayer)
    if leavingPlayer.Character then
        local highlight = leavingPlayer.Character:FindFirstChild("Highlight")
        if highlight then
            highlight:Destroy()
        end
        removeESPBox(leavingPlayer.Character)
    end
end)

player.CharacterAdded:Connect(function(character)
    wait(1)
    
    local restoredFeatures = {}
    
    if states.speedBoost then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = originalWalkSpeed * 8
            humanoid.JumpPower = originalJumpPower * 4
            table.insert(restoredFeatures, "Speed Boost")
        end
    end
    
    if states.godMode then
        if connections.godMode then
            connections.godMode:Disconnect()
        end
        connections.godMode = RunService.Heartbeat:Connect(function()
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Health = humanoid.MaxHealth
            end
        end)
        table.insert(restoredFeatures, "God Mode")
    end
    
    if states.antiStun then
        toggleAntiStun(true)
        table.insert(restoredFeatures, "Anti Stun")
    end
    
    if states.infiniteJump then
        toggleInfiniteJump(true)
        table.insert(restoredFeatures, "Infinite Jump")
    end
    
    if #restoredFeatures > 0 then
        Fluent:Notify({
            Title = "Features Restored",
            Content = "Restored: " .. table.concat(restoredFeatures, ", "),
            Duration = 3
        })
    end
end)

-- Main update loop
RunService.Heartbeat:Connect(function()
    updateMoneyLabel()
    autoCollectMoneyFunc()
    fastStealFunc()
    updateESP()
    
    if tick() % 2 < 0.016 then
        playerCountLabel:SetDesc("👥 " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers)
        
        local ping = player:GetNetworkPing()
        if ping then
            pingLabel:SetDesc("📡 " .. math.floor(ping * 1000) .. "ms")
        end
    end
end)

-- Configure managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
InterfaceManager:SetFolder("FluentMobile")
SaveManager:SetFolder("FluentMobile/config")

Window:SelectTab(1)

Fluent:Notify({
    Title = "💧 Water HUB Loaded",
    Content = "Enhanced multi-method base teleportation system activated!",
    Duration = 5,
    Image = "rbxassetid://6034684930"
})

SaveManager:LoadAutoloadConfig()
