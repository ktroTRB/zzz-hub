 -- Universal Hub Chooser - Fixed Version
-- 50% screen size with scrollable buttons that actually show up

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

-- Game configurations
local GAMES = {
    -- Steal a Brainrot
    {
        placeIds = {96342491571673, 109983668079237},
        name = "Steal a Brainrot",
        emoji = "🧠",
        scripts = {
            {name = "Ghost Hub", url = "https://raw.githubusercontent.com/ktroTRB/zzz-hub/refs/heads/main/Ghost%20hub", color = Color3.fromRGB(0, 170, 255)},
            {name = "Zeta Hub", url = "https://raw.githubusercontent.com/ktroTRB/zzz-hub/refs/heads/main/zeta%20hub", color = Color3.fromRGB(255, 100, 0)},
            {name = "Arbix Hub", url = "https://raw.githubusercontent.com/ktroTRB/zzz-hub/refs/heads/main/Arbix%20Hub", color = Color3.fromRGB(0, 255, 127)},
            {name = "Water Hub", url = "https://raw.githubusercontent.com/ktroTRB/zzz-hub/refs/heads/main/water%20hub.lua", color = Color3.fromRGB(0, 191, 255)},
            {name = "Luno Hub", url = "https://raw.githubusercontent.com/ktroTRB/zzz-hub/refs/heads/main/Luno%20hub", color = Color3.fromRGB(138, 43, 226)} 
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
            {name = "A Lot of Features", url = "https://raw.githubusercontent.com/ktroTRB/zzz-hub/refs/heads/main/Ringta%20hub", color = Color3.fromRGB(128, 0, 128)},
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
    },
    
    -- Musical Chairs
    {
        placeIds = {113323927469374},
        name = "Musical Chairs",
        emoji = "🪑",
        scripts = {
            {name = "Musical Chairs", url = "https://raw.githubusercontent.com/ktroTRB/perfect-hub/refs/heads/main/Musical%20Chairs.lua", color = Color3.fromRGB(255, 105, 180)}
        }
    },
    
    -- Ink Game
    {
        placeIds = {125009265613167, 99567941238278},
        name = "Ink Game",
        emoji = "🟢",
        scripts = {
            {name = "Help players only green light red light", url = "https://raw.githubusercontent.com/ktroTRB/perfect-hub/refs/heads/main/Ink%20Game%20%7C%20Help%20players", color = Color3.fromRGB(0, 255, 0)},
            {name = "ink op", url = "https://raw.githubusercontent.com/ktroTRB/zzz-hub/refs/heads/main/INK%20GAME%20OP.lua", color = Color3.fromRGB(34, 139, 34)}
        }
    },
    
    -- Brookhaven
    {
        placeIds = {4924922222},
        name = "Brookhaven",
        emoji = "🏠",
        scripts = {
            {name = "zzz hub op", url = "https://raw.githubusercontent.com/ktroTRB/zzz-hub/refs/heads/main/Brookhaven%20RP.lua", color = Color3.fromRGB(64, 224, 208)}
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
    screenGui.Name = "zzz hub chooser"
    screenGui.Parent = playerGui
    
    -- Main frame - 70% of screen size
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0.7, 0, 0.7, 0)
    frame.Position = UDim2.new(0.15, 0, 0.15, 0)
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
    
    -- Create ScrollingFrame for buttons
    local scrollFrame = Instance.new("ScrollingFrame")
    scrollFrame.Size = UDim2.new(1, -10, 1, -95)
    scrollFrame.Position = UDim2.new(0, 5, 0, 85)
    scrollFrame.BackgroundTransparency = 1
    scrollFrame.BorderSizePixel = 0
    scrollFrame.ScrollBarThickness = 10
    scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(150, 150, 150)
    scrollFrame.ScrollBarImageTransparency = 0.3
    scrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y
    scrollFrame.ScrollingEnabled = true
    scrollFrame.Parent = frame
    
    -- Add UIListLayout for automatic button positioning
    local listLayout = Instance.new("UIListLayout")
    listLayout.FillDirection = Enum.FillDirection.Vertical
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Padding = UDim.new(0, 10)
    listLayout.Parent = scrollFrame
    
    -- Add padding to the scroll area
    local topPadding = Instance.new("UIPadding")
    topPadding.PaddingTop = UDim.new(0, 5)
    topPadding.PaddingLeft = UDim.new(0, 15)
    topPadding.PaddingRight = UDim.new(0, 15)
    topPadding.PaddingBottom = UDim.new(0, 5)
    topPadding.Parent = scrollFrame
    
    -- Update canvas size after layout
    listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
    end)
    
    -- Create buttons for each script
    for i, script in pairs(gameConfig.scripts) do
        local button = Instance.new("TextButton")
        button.Size = UDim2.new(1, -10, 0, 45)
        button.BackgroundColor3 = script.color
        button.Text = script.name
        button.TextColor3 = Color3.fromRGB(255, 255, 255)
        button.TextScaled = true
        button.Font = Enum.Font.SourceSansBold
        button.LayoutOrder = i
        button.Parent = scrollFrame
        
        -- Button corner
        local buttonCorner = Instance.new("UICorner")
        buttonCorner.CornerRadius = UDim.new(0, 6)
        buttonCorner.Parent = button
        
        -- Hover effect
        local originalColor = script.color
        local hoverColor = Color3.fromRGB(
            math.min(255, originalColor.R * 255 + 30),
            math.min(255, originalColor.G * 255 + 30),
            math.min(255, originalColor.B * 255 + 30)
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
            
            -- Hide scrollFrame and show loading
            scrollFrame.Visible = false
            
            -- Create loading indicator
            local loadingLabel = Instance.new("TextLabel")
            loadingLabel.Size = UDim2.new(1, 0, 0, 50)
            loadingLabel.Position = UDim2.new(0, 0, 0.5, -25)
            loadingLabel.BackgroundTransparency = 1
            loadingLabel.Text = "Loading " .. script.name .. "..."
            loadingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            loadingLabel.TextScaled = true
            loadingLabel.Font = Enum.Font.SourceSansBold
            loadingLabel.Parent = frame
            
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
