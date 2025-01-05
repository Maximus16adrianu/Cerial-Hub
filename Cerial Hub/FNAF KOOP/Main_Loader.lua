local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- Function to check if the player is on the correct server for a given server ID
local function isCorrectServer(scriptServerID)
    if scriptServerID == "false" then
        return true
    else
        return game.PlaceId == tonumber(scriptServerID)
    end
end

-- Function to auto-execute if the game ID matches
local function autoExecuteIfGameMatches(scriptList)
    for _, scriptInfo in pairs(scriptList) do
        if isCorrectServer(scriptInfo.serverID) then
            pcall(function()
                loadstring(scriptInfo.script)()
            end)
            game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("ExecutorHub"):Destroy()
            return -- Exit after successful execution
        end
    end
    warn("No matching script found for this server. Script cannot be loaded here.")
end

-- Main GUI Creation
local ExecutorHub = Instance.new("ScreenGui")
ExecutorHub.Name = "ExecutorHub"
ExecutorHub.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
ExecutorHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 350, 0, 400)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ExecutorHub

-- Rounded Corner
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

-- Top Bar Corner
local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 12)
TopBarCorner.Parent = TopBar

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Text = "FNAF Koop - Cerial Hub" -- Changed title
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24 -- Increased text size
Title.BackgroundTransparency = 1
Title.Parent = TopBar

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 5)
CloseButton.Text = "X"
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
CloseButton.BorderSizePixel = 0
CloseButton.Parent = TopBar

-- Scripts Container
local ScriptsContainer = Instance.new("ScrollingFrame")
ScriptsContainer.Name = "ScriptsContainer"
ScriptsContainer.Size = UDim2.new(1, -20, 1, -60)
ScriptsContainer.Position = UDim2.new(0, 10, 0, 50)
ScriptsContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ScriptsContainer.BorderSizePixel = 0
ScriptsContainer.ScrollBarThickness = 5
ScriptsContainer.Parent = MainFrame

-- List Layout
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 25) -- Increased padding for description
UIListLayout.Parent = ScriptsContainer

-- Function to create script button with server ID check
local function CreateScriptButton(name, description, script, scriptServerID)
    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Size = UDim2.new(1, 0, 0, 60) -- Increased container size
    ButtonContainer.BackgroundTransparency = 1
    
    -- Description (now above the button)
    local Description = Instance.new("TextLabel")
    Description.Size = UDim2.new(1, -10, 0, 20)
    Description.Position = UDim2.new(0, 10, 0, 0)
    Description.Text = description
    Description.Font = Enum.Font.Gotham
    Description.TextColor3 = Color3.fromRGB(150, 150, 150)
    Description.TextSize = 14 -- Increased text size
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.BackgroundTransparency = 1
    Description.Parent = ButtonContainer
    
    local Button = Instance.new("TextButton")
    Button.Name = name .. "Button"
    Button.Size = UDim2.new(1, 0, 0, 40)
    Button.Position = UDim2.new(0, 0, 0, 20) -- Positioned below description
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.BorderSizePixel = 0
    
    -- Button Corner
    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = Button
    
    -- Button Text
    local ButtonText = Instance.new("TextLabel")
    ButtonText.Size = UDim2.new(1, -10, 1, 0)
    ButtonText.Position = UDim2.new(0, 10, 0, 0)
    ButtonText.Text = name
    ButtonText.Font = Enum.Font.Gotham
    ButtonText.TextColor3 = Color3.fromRGB(220, 220, 220)
    ButtonText.TextSize = 16 -- Increased text size
    ButtonText.TextXAlignment = Enum.TextXAlignment.Left
    ButtonText.BackgroundTransparency = 1
    ButtonText.Parent = Button
    
    -- Hover Effects
    Button.MouseEnter:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)
    
    Button.MouseLeave:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)
    
    -- Script Execution with server ID check
    Button.MouseButton1Click:Connect(function()
        if isCorrectServer(scriptServerID) then
            pcall(function()
                loadstring(script)()
            end)
        else
            warn("This script cannot be loaded on this server.")
        end
    end)
    
    Button.Parent = ButtonContainer
    ButtonContainer.Parent = ScriptsContainer
    return ButtonContainer
end

-- Example Scripts (you can add/remove these with their respective server IDs)
local scripts = {
    { name = "FNAF 1", description = "Fnaf Koop game 1 gui", script = [[
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Maximus16adrianu/Cerial-Hub/refs/heads/main/Cerial%20Hub/FNAF%20KOOP/FNAF_1.lua"))()
    ]], serverID = "12497348201" },
    
    { name = "FNAF 2", description = "Fnaf Koop game 2 gui", script = [[
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Maximus16adrianu/Cerial-Hub/refs/heads/main/Cerial%20Hub/FNAF%20KOOP/FNAF_2.lua"))()
    ]], serverID = "12497354347" },
    
    { name = "FNAF 3", description = "Fnaf Koop game 3 gui", script = [[
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Maximus16adrianu/Cerial-Hub/refs/heads/main/Cerial%20Hub/FNAF%20KOOP/FNAF_3.lua"))()
    ]], serverID = "12497360072" },
    
    { name = "FNAF 4", description = "Fnaf Koop game 4 gui", script = [[
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Maximus16adrianu/Cerial-Hub/refs/heads/main/Cerial%20Hub/FNAF%20KOOP/FNAF_4.lua"))()
    ]], serverID = "12497365956" },
}

-- Create buttons for scripts
for _, scriptInfo in pairs(scripts) do
    CreateScriptButton(scriptInfo.name, scriptInfo.description, scriptInfo.script, scriptInfo.serverID)
end

-- Auto-execute matching script
autoExecuteIfGameMatches(scripts)

-- Drag Functionality
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Close Button Functionality
CloseButton.MouseButton1Click:Connect(function()
    ExecutorHub:Destroy()
end)

return ExecutorHub