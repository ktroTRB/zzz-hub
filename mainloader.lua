-- Universal Hub Chooser
-- Supports multiple games with multiple script options each

-- Game configurations
local GAMES = {
    -- Steal a Brainrot
    {
        placeIds = {96342491571673, 109983668079237},
        name = "Steal a Brainrot",
        emoji = "🧠",
        scripts = {
            {name = "Ghost Hub", url = "https://raw.githubusercontent.com/ktroTRB/zzz-hub/refs/heads/main/Ghost%20hub", color = Color3.fromRGB(0, 170, 255)},
            {name = "Zeta Hub", url = "https://raw.githubusercontent.com/ktroTRB/zzz-hub/refs/heads/main/zeta%20hub", color = Color3.fromRGB(255, 100, 0)}
        }
    },
    
    -- Murder Mystery 2
    {
        placeIds = {142823291, 335132309, 379614936},
        name = "Murder Mystery 2",
        emoji = "🔪",
        scripts = {
            {name = "Basic MM2", url = "your-mm2-basic-url", color = Color3.fromRGB(255, 0, 0)},
            {name = "Advanced MM2", url = "your-mm2-advanced-url", color = Color3.fromRGB(150, 0, 0)}
        }
    },
    
    -- Dig Game
    {
        placeIds = {126244816328678},
        name = "Dig Game",
        emoji = "⛏️",
        scripts = {
            {name = "ZZZ Hub", url = "https://raw.githubusercontent.com/ktroTRB/zzz-hub/refs/heads/main/dig.lua", color = Color3.fromRGB(139, 69, 19)}
        }
    },
    
    -- Dead Rails
    {
        placeIds = {70876832253163, 11649582918852},
        name = "Dead Rails",
        emoji = "🚂",
        scripts = {
            {name = "A Lot of Features dont work rn", url = "https://raw.githubusercontent.com/ktroTRB/zzz-hub/refs/heads/main/Ringta%20hub", color = Color3.fromRGB(128, 0, 128)},
            {name = "Best Auto Bone", url = "https://raw.githubusercontent.com/ktroTRB/zzz-hub/refs/heads/main/zzzhubautobone", color = Color3.fromRGB(75, 0, 130)}
        }
    },
    
    -- Blade Ball
    {
        placeIds = {13772394625, 14732610803},
        name = "Blade Ball",
        emoji = "⚔️",
        scripts = {
            {name = "Basic Blade", url = "your-blade-basic-url", color = Color3.fromRGB(128, 0, 128)},
            {name = "Advanced Blade", url = "your-blade-advanced-url", color = Color3.fromRGB(75, 0, 130)}
        }
    }
}

-- Function to check if current place is in a game's place list
local function isInPlaceList(placeId, placeList)
    for _, id in pairs(placeList) do
        if id == placeId then
            return true
        end
    end
    return false
end

-- Function to find current game configuration
local function findCurrentGame()
    local currentPlaceId = game.PlaceId
    
    for _, gameConfig in pairs(GAMES) do
        if isInPlaceList(currentPlaceId, gameConfig.placeIds) then
            return gameConfig
        end
    end
    
    return nil
end

-- Function to create choice menu
local function createChoiceMenu(gameConfig)
    local Players = game:GetService("Players")
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")
    
    -- Create GUI
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "zzz hub "
    screenGui.Parent = playerGui
    
    -- Calculate frame height based on number of scripts
    local frameHeight = 120 + (#gameConfig.scripts * 55)
    
    -- Main frame
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 380, 0, frameHeight)
    frame.Position = UDim2.new(0.5, -190, 0.5, -frameHeight/2)
    frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    frame.BorderSizePixel = 2
    frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
    frame.Parent = screenGui
    
    -- Add corner rounding
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = frame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 60)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = gameConfig.emoji .. " " .. gameConfig.name .. " Hub Chooser"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextScaled = true
    title.Font = Enum.Font.SourceSansBold
    title.Parent = frame
    
    -- Subtitle
    local subtitle = Instance.new("TextLabel")
    subtitle.Size = UDim2.new(1, 0, 0, 25)
    subtitle.Position = UDim2.new(0, 0, 0, 60)
    subtitle.BackgroundTransparency = 1
    subtitle.Text = "Choose your preferred script:"
    subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
    subtitle.TextScaled = true
    subtitle.Font = Enum.Font.SourceSans
    subtitle.Parent = frame
    
    -- Create buttons for each script
    for i, script in pairs(gameConfig.scripts) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(0.85, 0, 0, 45)
        button.Position = UDim2.new(0.075, 0, 0, 90 + (i-1) * 55)
        button.BackgroundColor3 = script.color
        button.Text = script.name
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextScaled = true
        button.Font = Enum.Font.SourceSansBold
        button.Parent = frame
        
        -- Button corner
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 6)
        buttonCorner.Parent = button
        
        -- Hover effect
        local originalColor = script.color
        local hoverColor = Color3.fromRGB(
            math.max(0, originalColor.R * 255 - 20),
            math.max(0, originalColor.G * 255 - 20),
            math.max(0, originalColor.B * 255 - 20)
        )
        
        button.MouseEnter:Connect(function()
            button.BackgroundColor3 = hoverColor
        end)
        
        button.MouseLeave:Connect(function()
            button.BackgroundColor3 = originalColor
        end)
        
        -- Click event
        button.MouseButton1Click:Connect(function()
            -- Show loading message
            title.Text = "Loading " .. script.name .. "..."
            button.Text = "Loading..."
            
            -- Hide other buttons
            for j, otherScript in pairs(gameConfig.scripts) do
                if j ~= i then
                    frame:FindFirstChild("TextButton"):Destroy()
                end
            end
            
            -- Load script
            pcall(function()
                loadstring(game:HttpGet(script.url))()
            end)
            
            -- Close GUI after loading
            wait(1)
            screenGui:Destroy()
        end)
    end
    
    -- Close button (X)
    local closeButton = Instance.new("TextButton")
    closeButton.Size = UDim2.new(0, 25, 0, 25)
    closeButton.Position = UDim2.new(1, -30, 0, 5)
    closeButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    closeButton.Text = "X"
    closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeButton.TextScaled = true
    closeButton.Font = Enum.Font.SourceSansBold
    closeButton.Parent = frame
    
    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 4)
    closeCorner.Parent = closeButton
    
    closeButton.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Auto-close after 30 seconds
    spawn(function()
        wait(30)
        if screenGui.Parent then
            screenGui:Destroy()
        end
    end)
    
    -- Notification
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = gameConfig.name .. " Hub Chooser";
        Text = "Choose your preferred script!";
        Duration = 3;
    })
end

-- Main execution
local currentGame = findCurrentGame()

if currentGame then
    -- Game is supported, show chooser
    createChoiceMenu(currentGame)
else
    -- Game not supported
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Game Not Supported";
        Text = "This game is not supported by the universal loader.";
        Duration = 5;
    })
end
