local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Just3itx/3itx-UI-LIB/refs/heads/main/Lib"))()
local FlagsManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/Just3itx/3itx-UI-LIB/refs/heads/main/ConfigManager"))()

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
local Debris = game:GetService("Debris")

-- Variables
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local camera = Workspace.CurrentCamera

-- Global state management
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
    fly = false,
}

local connections = {} -- Centralized table for all connections for easy cleanup

-- Helper variables
local originalWalkSpeed = 16
local originalJumpPower = 50
local espBoxes = {}
local basePosition = nil
local lastAttacker = nil -- For Anti-Stun
local characterLoadedInitial = false -- Flag for initial character load for basePosition

-- Utility Functions (Essential game-related helpers)
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

-- Notification Function (using 3itx-UI-LIB)
local function sendNotification(title, text, duration, image)
    lib:Notification(title, text, duration or 3, image)
end

-- Mobile UI check (Adjusted for 3itx-UI-LIB philosophy)
-- 3itx-UI-LIB is generally responsive, so explicit mobile optimization might be less critical for the main window.
-- The persistent button UI is handled separately below.

---
### Persistent Toggle Button UI
---

-- 3itx-UI-LIB doesn't have a direct "persistent button." We'll create a custom ScreenGui for it.
local persistentGui = Instance.new("ScreenGui")
persistentGui.Name = "WaterHubPersistentButton"
persistentGui.Parent = playerGui
persistentGui.ResetOnSpawn = false
persistentGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
persistentGui.Enabled = true

local imageButton = Instance.new("ImageButton")
imageButton.Name = "PersistentControl"
imageButton.Size = UDim2.fromOffset(70, 70)
imageButton.Position = UDim2.new(0, 20, 0.5, -35)
imageButton.AnchorPoint = Vector2.new(0, 0.5)
imageButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
imageButton.BorderSizePixel = 0
imageButton.Image = "rbxassetid://6034684930" -- Water drop icon
imageButton.ScaleType = Enum.ScaleType.Fit
imageButton.Parent = persistentGui

-- Transparency effect
imageButton.BackgroundTransparency = 0.5
imageButton.ImageTransparency = 0.2

-- Rounded corners
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0.3, 0)
corner.Parent = imageButton

-- Hover effect (client-side only, won't directly affect 3itx-UI-LIB main window)
-- 3itx-UI-LIB's main window will handle its own visibility.
local hoverTween = TweenService:Create(imageButton, TweenInfo.new(0.15), {
    BackgroundTransparency = 0.2,
    ImageTransparency = 0,
    Size = UDim2.fromOffset(75, 75)
})
local normalTween = TweenService:Create(imageButton, TweenInfo.new(0.15), {
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

-- Dragging variables for the custom button
local draggingCustomButton = false
local dragStartPos = nil
local originalPos = nil

imageButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingCustomButton = true
        dragStartPos = input.Position
        originalPos = imageButton.Position
    end
end)

imageButton.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingCustomButton = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) and draggingCustomButton then
        local delta = input.Position - dragStartPos
        imageButton.Position = UDim2.new(
            originalPos.X.Scale,
            originalPos.X.Offset + delta.X,
            originalPos.Y.Scale,
            originalPos.Y.Offset + delta.Y
        )
    end
end)

-- Toggle main 3itx-UI-LIB window visibility
local function toggleMainWindow()
    -- 3itx-UI-LIB's main window visibility is usually managed by its internal state
    -- We can interact with it if the library exposes a method, or assume it's tied to the toggle button.
    -- For now, we'll assume `lib:Load` creates a main window that can be hidden/shown via its own mechanism or directly by manipulating its parent.
    -- In 3itx-UI-LIB, the main UI element's visibility is tied to the `BindGui` key.
    -- To programmatically toggle it, we would need to simulate a key press or, if the lib exposes it, a `SetVisible` method.
    -- Since it's not explicitly exposed, we will rely on the `BindGui` key for now, and the image button itself just controls the visual aspect.
    -- For actual visibility, the user would press `LeftControl`.
    sendNotification("UI", "Press LeftControl to toggle the main UI.", 2)
end

-- Click handler for the custom button (triggers main UI toggle logic)
imageButton.MouseButton1Click:Connect(function()
    if not draggingCustomButton then
        toggleMainWindow()
    end
end)

-- Rotation animation for water drop
connections.imageButtonRotation = RunService.Heartbeat:Connect(function()
    if imageButton and imageButton.Parent then
        imageButton.Rotation = (imageButton.Rotation + 2) % 360
    end
end)


---
### UI Initialization (using 3itx-UI-LIB)
---
local main = lib:Load({
    Title = "💧 Water HUB",
    ToggleButton = "rbxassetid://6034684930", -- Water drop icon
    BindGui = Enum.KeyCode.LeftControl, -- Matches original's minimize key
})

-- Fluent has separate SaveManager and InterfaceManager. 3itx-UI-LIB uses FlagsManager for config.
-- InterfaceManager's concept of setting a folder for the UI isn't directly applicable in 3itx-UI-LIB's `lib:Load`.
FlagsManager:SetLibrary(main) -- Pass the main UI instance to FlagsManager
FlagsManager:SetIgnoreIndexes({}) -- Not typically used for general saving in 3itx-UI-LIB unless specific fields are ignored
FlagsManager:SetFolder("WaterHubConfig") -- A general folder for saves.
-- We'll assume 3itx-UI-LIB handles loading autoload config internally if configured via FlagsManager.

---
### Core Feature Implementations (adapted for 3itx-UI-LIB structure and with bypasses)
---

-- Enhanced Anti-Stun with attacker detection
local function toggleAntiStun(enabled)
    states.antiStun = enabled

    if connections.antiStunLoop then
        connections.antiStunLoop:Disconnect()
        connections.antiStunLoop = nil
    end

    if connections.damageDetectionLoop then
        connections.damageDetectionLoop:Disconnect()
        connections.damageDetectionLoop = nil
    end

    if enabled then
        connections.damageDetectionLoop = RunService.Heartbeat:Connect(function()
            local humanoid = getHumanoid()
            if humanoid then
                local currentHealth = humanoid.Health
                -- Detect significant health drop (configurable threshold)
                if currentHealth < humanoid.MaxHealth * 0.9 then
                    local rootPart = getRootPart()
                    if rootPart then
                        local closestPlayer = nil
                        local closestDistance = math.huge

                        for _, targetPlayer in pairs(Players:GetPlayers()) do
                            if targetPlayer ~= player and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                local distance = (targetPlayer.Character.HumanoidRootPart.Position - rootPart.Position).Magnitude
                                if distance < 20 and distance < closestDistance then -- Within 20 studs range
                                    closestDistance = distance
                                    closestPlayer = targetPlayer
                                end
                            end
                        end

                        if closestPlayer then
                            lastAttacker = closestPlayer
                            sendNotification("Anti-Stun Alert", "Potential attacker: " .. closestPlayer.Name, 2)
                            -- Optional: Trigger a counter-measure here if needed, like a small teleport or knockback
                        end
                    end
                end
            end
        end)

        connections.antiStunLoop = RunService.Heartbeat:Connect(function()
            local humanoid = getHumanoid()
            local rootPart = getRootPart()

            if humanoid and rootPart then
                -- Reset common stun states
                if humanoid:GetState() == Enum.HumanoidStateType.PlatformStanding or
                   humanoid:GetState() == Enum.HumanoidStateType.FallingDown or
                   humanoid:GetState() == Enum.HumanoidStateType.Ragdoll or
                   humanoid:GetState() == Enum.HumanoidStateType.Flying then
                    humanoid:ChangeState(Enum.HumanoidStateType.Running)
                end

                -- Prevent vertical velocity spikes (common for knockback/stuns)
                if math.abs(rootPart.Velocity.Y) > 50 then
                    rootPart.Velocity = Vector3.new(rootPart.Velocity.X, 0, rootPart.Velocity.Z)
                end

                -- Destroy common physical constraints that cause stuns/traps
                for _, child in pairs(rootPart:GetChildren()) do
                    if child:IsA("BodyPosition") or child:IsA("BodyVelocity") or
                       child:IsA("BodyAngularVelocity") or child:IsA("BodyThrust") or
                       child:IsA("AlignPosition") or child:IsA("AlignOrientation") then -- Add newer physics constraints
                        child:Destroy()
                    end
                end

                -- Ensure character isn't anchored or sitting
                humanoid.PlatformStand = false
                humanoid.Sit = false
                rootPart.Anchored = false -- Crucial for preventing anchoring traps

                -- Auto-heal if attacked recently (basic bypass for damage stuns)
                if lastAttacker and humanoid.Health < humanoid.MaxHealth * 0.9 then -- If health is below a threshold after being attacked
                    humanoid.Health = humanoid.MaxHealth
                    lastAttacker = nil -- Reset attacker after healing
                end
            end
        end)
    else
        lastAttacker = nil
    end
end

-- Infinite Jump implementation with bypass considerations
local function toggleInfiniteJump(enabled)
    states.infiniteJump = enabled

    if connections.infiniteJumpRequest then
        connections.infiniteJumpRequest:Disconnect()
        connections.infiniteJumpRequest = nil
    end

    if connections.infiniteJumpLoop then
        connections.infiniteJumpLoop:Disconnect()
        connections.infiniteJumpLoop = nil
    end

    if enabled then
        connections.infiniteJumpRequest = UserInputService.JumpRequest:Connect(function()
            local humanoid = getHumanoid()
            local rootPart = getRootPart()

            if humanoid and rootPart and humanoid:GetState() ~= Enum.HumanoidStateType.Dead then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)

                -- Using BodyVelocity for a more controlled, persistent jump
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Name = "InfiniteJumpBV" -- Name for easier identification/cleanup
                bodyVelocity.MaxForce = Vector3.new(0, math.huge, 0) -- Infinite force upwards
                bodyVelocity.Velocity = Vector3.new(0, 60, 0) -- Consistent upward velocity
                bodyVelocity.Parent = rootPart
                Debris:AddItem(bodyVelocity, 0.1) -- Destroy after a short duration to prevent stacking

                -- Optional: Bypass jump cooldown by rapidly changing jump states
                humanoid:ChangeState(Enum.HumanoidStateType.Freefall) -- Force freefall state
                task.wait(0.01) -- Small delay
                humanoid:ChangeState(Enum.HumanoidStateType.Landed) -- Force landed state (resets jump counter)
            end
        end)

        -- Keep jump power high, even if game tries to reset it
        connections.infiniteJumpLoop = RunService.Heartbeat:Connect(function()
            local humanoid = getHumanoid()
            if humanoid then
                humanoid.JumpPower = 100 -- Higher than default for better jumps
                humanoid.JumpHeight = 7.2 -- Default jump height value, ensuring it's not lowered
            end
        end)
    else
        -- Restore original jump properties when disabled
        local humanoid = getHumanoid()
        if humanoid then
            humanoid.JumpPower = originalJumpPower
        end
    end
end

-- NoClip Bypass
local function toggleNoClip(enabled)
    states.noclip = enabled

    if connections.noclipLoop then
        connections.noclipLoop:Disconnect()
        connections.noclipLoop = nil
    end

    if enabled then
        connections.noclipLoop = RunService.Stepped:Connect(function()
            local character = getCharacter()
            if character then
                -- Iterate through character parts and make them non-collidable
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                        -- Optional: Make parts transparent for visual feedback
                        -- part.Transparency = 0.5
                    end
                end
                -- To counter server-side corrections, sometimes it's necessary to also
                -- disable the client's physics ownership or constantly set CFrame,
                -- but making parts non-collidable is the primary method.
                -- For strong bypasses, consider:
                -- game.Players.LocalPlayer.Character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false) -- Might not be exploitable
                -- setting network ownership to nil (game.Players.LocalPlayer.Character.HumanoidRootPart:SetNetworkOwner(nil)) -- Less reliable
            end
        end)
    else
        local character = getCharacter()
        if character then
            -- Restore collision when NoClip is disabled
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    -- This attempts to revert, but some games might detect rapid changes.
                    -- A more robust system would save original states.
                    part.CanCollide = true
                    -- part.Transparency = 0
                end
            end
        end
    end
end

-- Fly (basic implementation - for a strong bypass, it needs continuous CFrame/BodyVelocity control)
local function toggleFly(enabled)
    states.fly = enabled

    if connections.flyLoop then
        connections.flyLoop:Disconnect()
        connections.flyLoop = nil
    end

    if enabled then
        connections.flyLoop = RunService.RenderStepped:Connect(function()
            local character = getCharacter()
            local humanoid = getHumanoid()
            local rootPart = getRootPart()

            if character and humanoid and rootPart then
                humanoid.PlatformStand = true -- Keep character airborne
                rootPart.Anchored = true -- Prevent falling
                humanoid.WalkSpeed = 0 -- Disable walking to prevent interference

                local flySpeed = 10 -- Base fly speed

                local direction = Vector3.new(0,0,0)
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then direction = direction + camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then direction = direction - camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then direction = direction - camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then direction = direction + camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then direction = direction + Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then direction = direction - Vector3.new(0,1,0) end

                -- Apply movement by directly setting CFrame (stronger bypass)
                if direction.Magnitude > 0 then
                    rootPart.CFrame = rootPart.CFrame + direction.Unit * flySpeed * RunService.RenderStepped:Wait()
                end

                -- Optionally disable gravity for the player
                -- if not player.Character:FindFirstChild("BodyGravity") then
                --     local bodyGravity = Instance.new("BodyForce", rootPart)
                --     bodyGravity.Name = "FlyGravity"
                --     bodyGravity.Force = Vector3.new(0, game.Workspace.Gravity * rootPart:GetMass(), 0) -- Counteract gravity
                -- end
            end
        end)
    else
        local humanoid = getHumanoid()
        local rootPart = getRootPart()
        if humanoid then
            humanoid.PlatformStand = false
            humanoid.WalkSpeed = originalWalkSpeed -- Restore speed
        end
        if rootPart then
            rootPart.Anchored = false
            -- if rootPart:FindFirstChild("FlyGravity") then
            --     rootPart.FlyGravity:Destroy()
            -- end
        end
    end
end

-- Single Method Teleportation System (adapted for 3itx-UI-LIB, with NoClip integration)
local function singleMethodTeleport(targetPosition, methodNumber)
    local rootPart = getRootPart()
    if not rootPart or not targetPosition then return false end

    local startTime = tick()
    local attemptConnection
    local success = false
    local wasNoclipActive = states.noclip -- Check if NoClip was already active
    local timeout = 10 -- 10 seconds timeout for single method

    -- Temporarily enable NoClip for teleportation
    if not wasNoclipActive then
        toggleNoClip(true)
    end

    -- Cleanup function
    local function cleanup()
        for _, child in pairs(rootPart:GetChildren()) do
            if child.Name:find("Teleport") or child:IsA("BodyPosition") or child:IsA("BodyVelocity") then
                child:Destroy()
            end
        end

        if not wasNoclipActive then -- Only disable NoClip if it was activated by this function
            toggleNoClip(false)
        end
    end

    -- Success function
    local function onSuccess()
        success = true
        if attemptConnection then
            attemptConnection:Disconnect()
        end
        cleanup()
        sendNotification("Base TP", "Successfully teleported using method " .. methodNumber .. "!", 3)
    end

    -- Method execution functions (these remain largely the same, but benefit from the consistent NoClip)
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
            task.wait(0.1) -- Small wait to allow server to register high position
            rootPart.CFrame = CFrame.new(target)
        end,

        -- Method 3: Smooth flying movement (can be used for short distances)
        function(target)
            local currentPos = rootPart.Position
            local direction = (target - currentPos).Unit
            local distance = (target - currentPos).Magnitude

            if distance > 1 then -- Small threshold for movement
                local speed = math.min(80, distance * 2) -- Adjusted speed
                local newPos = currentPos + direction * speed * RunService.Heartbeat:Wait()
                rootPart.CFrame = CFrame.new(newPos)
                rootPart.Velocity = Vector3.new(0, 0, 0)
            end
        end,

        -- Method 4: BodyPosition method (more stable for continuous movement)
        function(target)
            local bodyPos = rootPart:FindFirstChild("TeleportBodyPosition")
            if not bodyPos then
                bodyPos = Instance.new("BodyPosition")
                bodyPos.Name = "TeleportBodyPosition"
                bodyPos.MaxForce = Vector3.new(math.huge, math.huge, math.huge) -- More force for better stability
                bodyPos.P = 100000 -- Increased P for responsiveness
                bodyPos.D = 10000 -- Increased D for damping
                bodyPos.Parent = rootPart
            end
            bodyPos.Position = target
        end,

        -- Method 5: Step-by-step teleportation (can be effective against certain checks)
        function(target)
            local currentPos = rootPart.Position
            local distance = (target - currentPos).Magnitude
            local steps = math.ceil(distance / 15)

            for i = 1, steps do
                local alpha = i / steps
                local stepPos = currentPos:Lerp(target, alpha)
                rootPart.CFrame = CFrame.new(stepPos)
                rootPart.Velocity = Vector3.new(0, 0, 0)
                task.wait(0.01) -- Smaller wait for smoother steps
                if (rootPart.Position - target).Magnitude < 2 then break end -- Early exit if close
            end
        end,

        -- Method 6: Velocity-based teleportation (less reliable for precise TPs but can bypass)
        function(target)
            local bodyVel = rootPart:FindFirstChild("TeleportBodyVelocity")
            if not bodyVel then
                bodyVel = Instance.new("BodyVelocity")
                bodyVel.Name = "TeleportBodyVelocity"
                bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                bodyVel.Parent = rootPart
            end

            local direction = (target - rootPart.Position).Unit
            local distance = (target - rootPart.Position).Magnitude

            if distance > 1 then
                bodyVel.Velocity = direction * math.min(200, distance * 10) -- Increased max speed
            else
                bodyVel.Velocity = Vector3.new(0, 0, 0)
            end
        end
    }

    if not methods[methodNumber] then
        sendNotification("Base TP", "Invalid method number!", 3)
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
            sendNotification("Base TP", "Method " .. methodNumber .. " failed - timeout reached!", 4)
        end
    end)

    return true
end

-- Enhanced Multi-Method Base Teleportation System (adapted for 3itx-UI-LIB, with NoClip integration)
local function advancedBaseTeleport(targetPosition)
    local rootPart = getRootPart()
    if not rootPart or not targetPosition then return false end

    local startTime = tick()
    local attemptConnection
    local success = false
    local currentMethod = 1
    local methodStartTime = startTime
    local wasNoclipActive = states.noclip
    local methodTimeouts = {2, 3, 4, 3, 3, 3} -- Timeout for each method

    -- Temporarily enable NoClip for teleportation
    if not wasNoclipActive then
        toggleNoClip(true)
    end

    -- Cleanup function
    local function cleanup()
        for _, child in pairs(rootPart:GetChildren()) do
            if child.Name:find("Teleport") or child:IsA("BodyPosition") or child:IsA("BodyVelocity") then
                child:Destroy()
            end
        end

        if not wasNoclipActive then
            toggleNoClip(false)
        end
    end

    -- Success function
    local function onSuccess(methodUsed)
        success = true
        if attemptConnection then
            attemptConnection:Disconnect()
        end
        cleanup()
        sendNotification("Base TP", "Successfully teleported using method " .. methodUsed .. "!", 3)
    end

    -- Teleportation methods array (same as singleMethodTeleport)
    local methods = {
        function(target) rootPart.CFrame = CFrame.new(target); rootPart.Velocity = Vector3.new(0, 0, 0) end,
        function(target)
            local highTarget = Vector3.new(target.X, target.Y + 150, target.Z)
            rootPart.CFrame = CFrame.new(highTarget)
            rootPart.Velocity = Vector3.new(0, 0, 0)
            task.wait(0.1)
            rootPart.CFrame = CFrame.new(target)
        end,
        function(target)
            local currentPos = rootPart.Position
            local direction = (target - currentPos).Unit
            local distance = (target - currentPos).Magnitude
            if distance > 1 then
                local speed = math.min(80, distance * 2)
                local newPos = currentPos + direction * speed * RunService.Heartbeat:Wait()
                rootPart.CFrame = CFrame.new(newPos)
                rootPart.Velocity = Vector3.new(0, 0, 0)
            end
        end,
        function(target)
            local bodyPos = rootPart:FindFirstChild("TeleportBodyPosition")
            if not bodyPos then bodyPos = Instance.new("BodyPosition"); bodyPos.Name = "TeleportBodyPosition"; bodyPos.MaxForce = Vector3.new(math.huge, math.huge, math.huge); bodyPos.P = 100000; bodyPos.D = 10000; bodyPos.Parent = rootPart end
            bodyPos.Position = target
        end,
        function(target)
            local currentPos = rootPart.Position
            local distance = (target - currentPos).Magnitude
            local steps = math.ceil(distance / 15)
            for i = 1, steps do
                local alpha = i / steps
                local stepPos = currentPos:Lerp(target, alpha)
                rootPart.CFrame = CFrame.new(stepPos)
                rootPart.Velocity = Vector3.new(0, 0, 0)
                task.wait(0.01)
                if (rootPart.Position - target).Magnitude < 2 then break end
            end
        end,
        function(target)
            local bodyVel = rootPart:FindFirstChild("TeleportBodyVelocity")
            if not bodyVel then bodyVel = Instance.new("BodyVelocity"); bodyVel.Name = "TeleportBodyVelocity"; bodyVel.MaxForce = Vector3.new(math.huge, math.huge, math.huge); bodyVel.Parent = rootPart end
            local direction = (target - rootPart.Position).Unit
            local distance = (target - rootPart.Position).Magnitude
            if distance > 1 then bodyVel.Velocity = direction * math.min(200, distance * 10) else bodyVel.Velocity = Vector3.new(0, 0, 0) end
        end
    }

    sendNotification("Base TP", "Starting method 1...", 1)

    attemptConnection = RunService.Heartbeat:Connect(function()
        local currentTime = tick()
        local totalElapsed = currentTime - startTime
        local methodElapsed = currentTime - methodStartTime

        local distance = (rootPart.Position - targetPosition).Magnitude
        if distance < 4 then
            onSuccess(currentMethod)
            return
        end

        local currentTimeout = methodTimeouts[currentMethod] or 3
        if methodElapsed > currentTimeout then
            for _, child in pairs(rootPart:GetChildren()) do
                if child.Name:find("Teleport") or child:IsA("BodyPosition") or child:IsA("BodyVelocity") then
                    child:Destroy()
                end
            }

            currentMethod = currentMethod + 1
            methodStartTime = currentTime

            if currentMethod <= #methods then
                sendNotification("Base TP", "Method " .. (currentMethod - 1) .. " failed. Trying method " .. currentMethod .. "...", 1)
            else
                if attemptConnection then attemptConnection:Disconnect() end
                rootPart.CFrame = CFrame.new(rootPart.Position.X, 500, rootPart.Position.Z)
                cleanup()
                sendNotification("Base TP", "All methods failed - Emergency exit!", 4)
                return
            end
        end

        if currentMethod <= #methods then
            pcall(function()
                methods[currentMethod](targetPosition)
            end)
        end

        if totalElapsed > 25 then
            if attemptConnection then attemptConnection:Disconnect() end
            rootPart.CFrame = CFrame.new(rootPart.Position.X, 1000, rootPart.Position.Z)
            cleanup()
            sendNotification("Base TP", "Ultimate timeout - Emergency exit!", 4)
        end
    end)

    return true
end


---
### UI Tab Creation
---
local Tabs = {
    Main = main:AddTab("🛡️ Main"),
    Visual = main:AddTab("👁️ Visual"),
    Misc = main:AddTab("🔧 Misc"),
    Money = main:AddTab("💰 Money"),
    Server = main:AddTab("🌐 Server")
}

---
#### MAIN TAB
---
local MainSection = Tabs.Main:AddSection({ Title = "Movement & Protection" })
MainSection:AddToggle("SpeedBoost", {
    Title = "⚡ Speed Boost 8x (Enhanced)",
    Description = "Increases movement speed significantly.",
    Default = false,
    Callback = function(value)
        states.speedBoost = value
        local humanoid = getHumanoid()
        if humanoid then
            if value then
                humanoid.WalkSpeed = originalWalkSpeed * 8
                humanoid.JumpPower = originalJumpPower * 4
            else
                humanoid.WalkSpeed = originalWalkSpeed
                humanoid.JumpPower = originalJumpPower
            end
        end
    end
})

MainSection:AddToggle("AntiTrap", {
    Title = "🚫 Anti Trap (Movement Freedom)",
    Description = "Prevents being trapped by other players.",
    Default = false,
    Callback = function(value)
        states.antiTrap = value

        if connections.antiTrapLoop then
            connections.antiTrapLoop:Disconnect()
            connections.antiTrapLoop = nil
        end

        if value then
            connections.antiTrapLoop = RunService.Heartbeat:Connect(function()
                local humanoid = getHumanoid()
                local rootPart = getRootPart()

                if humanoid and rootPart then
                    humanoid.PlatformStand = false
                    humanoid.Sit = false
                    rootPart.Anchored = false

                    -- Aggressively destroy physics constraints
                    for _, v in pairs(rootPart:GetChildren()) do
                        if v:IsA("BodyPosition") or v:IsA("BodyVelocity") or v:IsA("BodyAngularVelocity") or
                           v:IsA("AlignPosition") or v:IsA("AlignOrientation") or v:IsA("PrismaticConstraint") then
                            v:Destroy()
                        end
                    end
                end
            end)
        end
    end
})

MainSection:AddToggle("AntiStun", {
    Title = "🛡️ Anti Stun (Enhanced with Attacker Detection)",
    Description = "Prevents stunning and detects who attacks you.",
    Default = false,
    Callback = function(value)
        toggleAntiStun(value)
    end
})

MainSection:AddToggle("InfiniteJump", {
    Title = "🦘 Infinite Jump (Enhanced)",
    Description = "Jump infinitely without touching ground.",
    Default = false,
    Callback = function(value)
        toggleInfiniteJump(value)
    end
})

MainSection:AddToggle("GodMode", {
    Title = "🛡️ God Mode",
    Description = "Complete invincibility with health and state protection.",
    Default = false,
    Callback = function(value)
        states.godMode = value

        if connections.godModeLoop then
            connections.godModeLoop:Disconnect()
            connections.godModeLoop = nil
        end
        if connections.godModeHealthWatcher then
            connections.godModeHealthWatcher:Disconnect()
            connections.godModeHealthWatcher = nil
        end
        if connections.godModeStateWatcher then
            connections.godModeStateWatcher:Disconnect()
            connections.godModeStateWatcher = nil
        end

        if value then
            connections.godModeLoop = RunService.Heartbeat:Connect(function()
                local humanoid = getHumanoid()
                local character = getCharacter()
                if humanoid then
                    humanoid.Health = humanoid.MaxHealth

                    -- Prevent specific states by resetting them
                    if humanoid:GetState() == Enum.HumanoidStateType.Dead or
                       humanoid:GetState() == Enum.HumanoidStateType.FallingDown or
                       humanoid:GetState() == Enum.HumanoidStateType.Ragdoll or
                       humanoid:GetState() == Enum.HumanoidStateType.Physics then
                        humanoid:ChangeState(Enum.HumanoidStateType.Running)
                    end

                    -- ForceField for visual invincibility (optional, can be visible/invisible)
                    if character and not character:FindFirstChild("ForceField") then
                        local ff = Instance.new("ForceField")
                        ff.Visible = false -- Set to true if you want it visible
                        ff.Parent = character
                    end
                end
            end)

            -- More robust health protection (listen for changes and revert)
            local humanoid = getHumanoid()
            if humanoid then
                connections.godModeHealthWatcher = humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                    if states.godMode and humanoid.Health < humanoid.MaxHealth then
                        humanoid.Health = humanoid.MaxHealth
                    end
                end)
                -- Also ensure states like PlatformStand are always off
                connections.godModeStateWatcher = humanoid:GetPropertyChangedSignal("PlatformStand"):Connect(function()
                    if states.godMode then
                        humanoid.PlatformStand = false
                    end
                end)
            end

        else
            local character = getCharacter()
            if character and character:FindFirstChild("ForceField") then
                character.ForceField:Destroy()
            end
            local humanoid = getHumanoid()
            if humanoid then
                -- Re-enable states if necessary, though usually they revert on respawn
                -- humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
                -- humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, true)
                -- humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, true)
            end
        end
    end
})

MainSection:AddToggle("Noclip", {
    Title = "👻 Noclip (Strong Bypass)",
    Description = "Walk through walls without being sent back.",
    Default = false,
    Callback = function(value)
        toggleNoClip(value)
    end
})

MainSection:AddToggle("Fly", {
    Title = "✈️ Fly (Experimental Bypass)",
    Description = "Allows free-form flight (may be detectable).",
    Default = false,
    Callback = function(value)
        toggleFly(value)
    end
})

---
#### VISUAL TAB
---
local VisualSection = Tabs.Visual:AddSection({ Title = "ESP Settings" })
VisualSection:AddToggle("ESPPlayers", {
    Title = "👥 ESP Player Highlights",
    Description = "Highlight all players.",
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
                        highlight.FillTransparency = 0.5
                        highlight.OutlineTransparency = 0
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
    billboardGui.Size = UDim2.new(0, 150, 0, 100) -- Adjusted size
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

VisualSection:AddToggle("ESPBox", {
    Title = "📦 ESP Box",
    Description = "Show boxes around players.",
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

---
#### MISC TAB
---
local StealingToolsSection = Tabs.Misc:AddSection({ Title = "🚀 Stealing Tools" })
StealingToolsSection:AddToggle("FastSteal", {
    Title = "⚡ Fast Steal",
    Description = "Instantly steal without hold duration.",
    Default = false,
    Callback = function(value)
        states.fastSteal = value
    end
})

StealingToolsSection:AddButton({
    Title = "💰 Steal Helper",
    Description = "Compact stealing assistance tool.",
    Callback = function()
        -- 3itx-UI-LIB does not have a direct "pop-up mini-window" like Fluent's custom frame.
        -- Replicating this would mean creating a custom ScreenGui with UI elements
        -- and making it draggable, similar to the persistent button.
        -- For simplicity, I'll create a basic notification about the functionality.
        sendNotification("Steal Helper", "Steal Helper functionality is handled by 'Fast Steal' toggle. The detailed UI for Up/Down is not directly transferable to 3itx-UI-LIB without custom GUI creation.", 5)
    end
})

local BaseSystemSection = Tabs.Misc:AddSection({ Title = "📍 Base System" })
-- Auto-set spawn position when character spawns
player.CharacterAdded:Connect(function(character)
    if not characterLoadedInitial then
        task.wait(2) -- Wait for character to fully load
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            if not basePosition then -- Only auto-set if no base is manually configured
                basePosition = rootPart.Position
                sendNotification("Base System", "Spawn position automatically set as base!", 3)
                characterLoadedInitial = true -- Ensure this runs only once on initial load
            end
        end
    end
end)

BaseSystemSection:AddButton({
    Title = "📍 Set Base Position",
    Description = "Sets your current position as the base for teleportation methods.",
    Callback = function()
        local character = player.Character
        local rootPart = character and character:FindFirstChild("HumanoidRootPart")

        if rootPart then
            basePosition = rootPart.Position
            sendNotification("Base System", string.format("Manual base set at X:%.1f Y:%.1f Z:%.1f", basePosition.X, basePosition.Y, basePosition.Z), 4)
        else
            sendNotification("Base System", "Error: Cannot detect player position. Please ensure your character is loaded.", 4)
        end
    end
})

BaseSystemSection:AddDropdown("TeleportMethod", {
    Title = "Teleport Method",
    Description = "Choose a teleportation method or try all automatically.",
    Options = { "Auto (All Methods)", "Method 1 (Direct CFrame)", "Method 2 (High Altitude)", "Method 3 (Smooth Flying)", "Method 4 (BodyPosition)", "Method 5 (Step-by-Step)", "Method 6 (Velocity-Based)" },
    Default = "Auto (All Methods)",
    Callback = function(selectedOption)
        -- Store the selected method for the "Try TP" button
        if selectedOption == "Auto (All Methods)" then
            CurrentTeleportMethod = 0
        elseif selectedOption == "Method 1 (Direct CFrame)" then
            CurrentTeleportMethod = 1
        elseif selectedOption == "Method 2 (High Altitude)" then
            CurrentTeleportMethod = 2
        elseif selectedOption == "Method 3 (Smooth Flying)" then
            CurrentTeleportMethod = 3
        elseif selectedOption == "Method 4 (BodyPosition)" then
            CurrentTeleportMethod = 4
        elseif selectedOption == "Method 5 (Step-by-Step)" then
            CurrentTeleportMethod = 5
        elseif selectedOption == "Method 6 (Velocity-Based)" then
            CurrentTeleportMethod = 6
        end
    end
})

local CurrentTeleportMethod = 0 -- Default to Auto

BaseSystemSection:AddButton({
    Title = "🚀 Try TP",
    Description = "Attempt teleportation to the set base using the selected method.",
    Callback = function()
        if not basePosition then
            sendNotification("Try TP", "Base position must be configured before attempting teleportation. Please set a base first.", 4)
            return
        end

        if CurrentTeleportMethod == 0 then
            sendNotification("Try TP", "Executing automatic multi-method teleportation sequence...", 2)
            advancedBaseTeleport(basePosition)
        else
            sendNotification("Try TP", "Testing teleportation method " .. CurrentTeleportMethod .. "...", 2)
            singleMethodTeleport(basePosition, CurrentTeleportMethod)
        end
    end
})

---
#### MONEY TAB
---
local MoneySection = Tabs.Money:AddSection({ Title = "Economy Tools" })
local moneyParagraph = MoneySection:AddParagraph({
    Title = "💰 Current Money",
    Description = "Loading..."
})

MoneySection:AddToggle("AutoCollectMoney", {
    Title = "🔄 Auto Collect Money",
    Description = "Automatically collect money items within range.",
    Default = false,
    Callback = function(value)
        states.autoCollectMoney = value
    end
})

MoneySection:AddButton({
    Title = "📦 Give All Items",
    Description = "Attempts to collect all available items in the game.",
    Callback = function()
        local collected = 0
        local character = getCharacter()
        local backpack = player:FindFirstChild("Backpack")
        local rootPart = getRootPart()

        if not character or not backpack or not rootPart then
            sendNotification("Error", "Character, Backpack or RootPart not found!", 3)
            return
        end

        for _, obj in ipairs(Workspace:GetDescendants()) do
            -- Collect tools
            if obj:IsA("Tool") and not obj.Parent:IsA("Model") then -- Check if it's a loose tool in workspace
                pcall(function()
                    obj.Parent = backpack
                    collected = collected + 1
                end)
            -- Collect pickable parts (coins, items etc.)
            elseif obj:IsA("BasePart") then
                local name = obj.Name:lower()
                if name:match("item") or name:match("coin") or name:match("collectible") or
                   name:match("pickup") or name:match("drop") or name:match("loot") then
                    local distance = (obj.Position - rootPart.Position).Magnitude
                    if distance <= 100 then -- Increase range for "Give All"
                        pcall(function()
                            -- Teleport item to player for interaction
                            obj.CFrame = rootPart.CFrame
                            collected = collected + 1
                        end)
                    end
                end
            -- Activate ProximityPrompts
            elseif obj:IsA("ProximityPrompt") then
                pcall(function()
                    fireproximityprompt(obj)
                    collected = collected + 1
                end)
            end
        end

        -- Also try to clone items from ReplicatedStorage (might not work in all games)
        for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
            if obj:IsA("Tool") then
                pcall(function()
                    local clone = obj:Clone()
                    clone.Parent = backpack
                    collected = collected + 1
                end)
            end
        end

        sendNotification("Item Collector", "Attempted to collect " .. collected .. " items!", 3)
    end
})

---
#### SERVER TAB
---
local ServerControlsSection = Tabs.Server:AddSection({ Title = "🌐 Server Controls" })
ServerControlsSection:AddButton({
    Title = "🔄 Rejoin Server",
    Description = "Rejoin the current server.",
    Callback = function()
        TeleportService:Teleport(game.PlaceId, player)
    end
})

ServerControlsSection:AddButton({
    Title = "🚪 Leave Game",
    Description = "Leave the current game.",
    Callback = function()
        player:Kick("Left the game via Water Hub")
    end
})

ServerControlsSection:AddButton({
    Title = "🌐 Server Hop",
    Description = "Find and join a different server.",
    Callback = function()
        local servers = {}
        local req = syn and syn.request or http_request or request -- Universal request function

        if req then
            local success, result = pcall(function()
                return req({
                    Url = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100",
                    Method = "GET"
                })
            end)

            if success and result and result.Success then
                local data = HttpService:JSONDecode(result.Body)
                for _, server in pairs(data.data) do
                    if server.playing < server.maxPlayers and server.id ~= game.JobId then
                        table.insert(servers, server.id)
                    end
                end

                if #servers > 0 then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, servers[math.random(1, #servers)])
                    sendNotification("Server Hop", "Attempting to hop to a new server...", 3)
                else
                    sendNotification("Server Hop", "No available servers found!", 3)
                end
            else
                sendNotification("Server Hop", "Failed to get server list. HTTP Request failed.", 3)
                warn("Server Hop Error:", result and result.Body or "No result body")
            end
        else
            sendNotification("Server Hop", "HTTP Request function not available. Cannot hop servers.", 3)
        end
    end
})

local ServerInfoSection = Tabs.Server:AddSection({ Title = "📊 Server Info" })
local playerCountParagraph = ServerInfoSection:AddParagraph({
    Title = "👥 Players",
    Description = #Players:GetPlayers() .. "/" .. Players.MaxPlayers
})

local serverIdParagraph = ServerInfoSection:AddParagraph({
    Title = "🆔 Server ID",
    Description = game.JobId:sub(1, 12) .. "..."
})

local pingParagraph = ServerInfoSection:AddParagraph({
    Title = "📡 Ping",
    Description = "Calculating..."
})

---
### Main Loops & Initializers
---

-- Auto-collect money loop
local autoCollectMoneyLoop = nil
RunService.Heartbeat:Connect(function()
    if states.autoCollectMoney then
        autoCollectMoneyFunc()
    end
end)

-- Fast Steal loop
local fastStealLoop = nil
RunService.Heartbeat:Connect(function()
    if states.fastSteal then
        fastStealFunc()
    end
end)

-- Update various UI elements in a single Heartbeat connection for efficiency
connections.mainUpdateLoop = RunService.Heartbeat:Connect(function()
    -- Update Money Label
    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        local money = leaderstats:FindFirstChild("Money") or leaderstats:FindFirstChild("Cash") or leaderstats:FindFirstChild("Coins")
        if money then
            moneyParagraph:SetDesc("💰 " .. tostring(money.Value))
        else
            moneyParagraph:SetDesc("💰 0 (No money stat found)")
        end
    else
        moneyParagraph:SetDesc("💰 0 (No leaderstats found)")
    end

    -- Update player count and ping less frequently (e.g., every second)
    if tick() % 1 < 0.05 then -- Update roughly once per second
        playerCountParagraph:SetDesc("👥 " .. #Players:GetPlayers() .. "/" .. Players.MaxPlayers)

        local ping = player:GetNetworkPing()
        if ping then
            pingParagraph:SetDesc("📡 " .. math.floor(ping * 1000) .. "ms")
        end
    end

    -- Update ESP visibility for players already in game
    updateESP()
end)

-- Event handlers for character specific features after respawn
player.CharacterAdded:Connect(function(character)
    task.wait(1) -- Give character time to load and stabilize

    local restoredFeatures = {}

    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        -- Restore Speed Boost
        if states.speedBoost then
            humanoid.WalkSpeed = originalWalkSpeed * 8
            humanoid.JumpPower = originalJumpPower * 4
            table.insert(restoredFeatures, "Speed Boost")
        end

        -- Restore God Mode (health regen)
        if states.godMode then
            -- Re-establish god mode connections for new character
            if connections.godModeLoop then connections.godModeLoop:Disconnect() end
            connections.godModeLoop = RunService.Heartbeat:Connect(function()
                if humanoid.Health < humanoid.MaxHealth then humanoid.Health = humanoid.MaxHealth end
                -- Additional god mode protections for new character
                if humanoid:GetState() == Enum.HumanoidStateType.Dead or humanoid:GetState() == Enum.HumanoidStateType.FallingDown then
                    humanoid:ChangeState(Enum.HumanoidStateType.Running)
                end
            end)
            if character and not character:FindFirstChild("ForceField") then
                local ff = Instance.new("ForceField")
                ff.Visible = false
                ff.Parent = character
            end
            table.insert(restoredFeatures, "God Mode")
        end

        -- Restore Anti-Stun
        if states.antiStun then
            toggleAntiStun(true) -- Re-enables the loop for the new character
            table.insert(restoredFeatures, "Anti Stun")
        end

        -- Restore Infinite Jump
        if states.infiniteJump then
            toggleInfiniteJump(true) -- Re-enables the jump listener for the new character
            table.insert(restoredFeatures, "Infinite Jump")
        end

        -- Restore NoClip
        if states.noclip then
            toggleNoClip(true) -- Re-applies NoClip to the new character
            table.insert(restoredFeatures, "NoClip")
        end

        -- Restore Fly
        if states.fly then
            toggleFly(true)
            table.insert(restoredFeatures, "Fly")
        end
    end

    if #restoredFeatures > 0 then
        sendNotification("Features Restored", "Restored: " .. table.concat(restoredFeatures, ", "), 3)
    end
end)

-- Initial population of ESP for players already in game
Players.PlayerAdded:Connect(function(newPlayer)
    newPlayer.CharacterAdded:Connect(function(character)
        task.wait(1) -- Wait for character to fully load
        if states.espPlayers and newPlayer ~= Players.LocalPlayer then
            local highlight = Instance.new("Highlight")
            highlight.Parent = character
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
            highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            highlight.FillTransparency = 0.5
            highlight.OutlineTransparency = 0
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


-- Final initialization
main:SelectTab(1) -- Select the first tab (Main) by default

sendNotification("💧 Water HUB Loaded", "Ultimate Edition v5.3. Enhanced features activated!", 5, "rbxassetid://6034684930")

-- Save and load configuration using FlagsManager
-- FlagsManager automatically saves/loads toggles and dropdowns with unique keys.
-- The provided `SaveManager:LoadAutoloadConfig()` is specific to Fluent; FlagsManager in 3itx-UI-LIB
-- usually handles loading upon initialization if its folder is set.
-- To explicitly save/load, you might add buttons in a 'Config' tab, for example.

-- Example of Save/Load buttons (optional, you can add a new "Config" tab for these)
-- local ConfigTab = main:AddTab("⚙️ Config")
-- local ConfigSection = ConfigTab:AddSection("Save/Load Settings")
-- ConfigSection:AddButton({
--     Title = "Save Settings",
--     Callback = function()
--         FlagsManager:SaveConfig()
--         sendNotification("Config", "Settings saved!", 2)
--     end
-- })
-- ConfigSection:AddButton({
--     Title = "Load Settings",
--     Callback = function()
--         FlagsManager:LoadConfig()
--         sendNotification("Config", "Settings loaded!", 2)
--     end
-- })

-- Cleanup on script end (Crucial for preventing memory leaks and lingering effects)
game:BindToClose(function()
    -- Disconnect all stored connections
    for _, conn in pairs(connections) do
        if type(conn) == "table" then -- For tables of connections like ESP
            for _, c in pairs(conn) do
                if type(c) == "userdata" and typeof(c) == "RBXScriptConnection" then
                    pcall(function() c:Disconnect() end)
                end
            end
        elseif type(conn) == "userdata" and typeof(conn) == "RBXScriptConnection" then
            pcall(function() conn:Disconnect() end)
        end
    end

    -- Destroy all created ESP visuals
    for _, folder in pairs(espBoxes) do
        if folder then folder:Destroy() end
    end
    for _, folder in pairs(espFolders) do -- For Highlight-based ESP
        if folder then folder:Destroy() end
    end

    -- Destroy custom UI elements
    if persistentGui then
        persistentGui:Destroy()
    end
    if stealHelperGui then
        stealHelperGui:Destroy()
    end
    if baseSystemGui then
        baseSystemGui:Destroy()
    end

    -- Revert any persistent changes
    local humanoid = getHumanoid()
    if humanoid then
        humanoid.WalkSpeed = originalWalkSpeed
        humanoid.JumpPower = originalJumpPower
        if humanoid:FindFirstChild("ForceField") then humanoid.ForceField:Destroy() end
    end
    local character = getCharacter()
    if character then
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true -- Revert NoClip
            end
        end
    end
end)
