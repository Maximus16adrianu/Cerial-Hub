-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Create GUI elements
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local NotificationFrame = Instance.new("Frame")
local NotificationText = Instance.new("TextLabel")
local NotificationUICorner = Instance.new("UICorner")
local ToggleButton = Instance.new("TextButton")
local FriendButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

-- Configure ScreenGui
ScreenGui.Name = "AutoTargetGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Configure Notification Frame
NotificationFrame.Name = "NotificationFrame"
NotificationFrame.Size = UDim2.new(0, 300, 0, 50)
NotificationFrame.Position = UDim2.new(0.5, -150, 0, -60)
NotificationFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
NotificationFrame.Parent = ScreenGui

-- Add corner radius to NotificationFrame
NotificationUICorner.Parent = NotificationFrame

-- Configure Notification Text
NotificationText.Size = UDim2.new(1, -20, 1, 0)
NotificationText.Position = UDim2.new(0, 10, 0, 0)
NotificationText.Text = "Most games have anti-cheat, but we've found ways around them. Use at your own risk!"
NotificationText.TextColor3 = Color3.fromRGB(255, 255, 255)
NotificationText.TextWrapped = true
NotificationText.BackgroundTransparency = 1
NotificationText.Font = Enum.Font.GothamBold
NotificationText.TextSize = 14
NotificationText.Parent = NotificationFrame

-- Configure MainFrame
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 120)
MainFrame.Position = UDim2.new(0.5, -110, 0, 50)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.Parent = ScreenGui

-- Add corner radius to MainFrame
UICorner.Parent = MainFrame
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 220, 0, 120) -- Increased height for new button
MainFrame.Position = UDim2.new(0.5, -110, 0, 50)
MainFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
MainFrame.Parent = ScreenGui

-- Add corner radius to MainFrame
UICorner.Parent = MainFrame

-- Configure Toggle Button
ToggleButton.Size = UDim2.new(0, 200, 0, 40)
ToggleButton.Position = UDim2.new(0.5, -100, 0, 15)
ToggleButton.Text = "Auto Target: OFF"
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 14
ToggleButton.Parent = MainFrame

-- Configure Friend Button
FriendButton.Size = UDim2.new(0, 200, 0, 40)
FriendButton.Position = UDim2.new(0.5, -100, 0, 65)
FriendButton.Text = "Target Friends: ON"
FriendButton.BackgroundColor3 = Color3.fromRGB(60, 180, 75)
FriendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
FriendButton.Font = Enum.Font.GothamBold
FriendButton.TextSize = 14
FriendButton.Parent = MainFrame

-- Configure Close Button
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Position = UDim2.new(1, -25, 0, 5)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 14
CloseButton.Parent = MainFrame

local notificationTween = TweenService:Create(NotificationFrame, 
    TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    {Position = UDim2.new(0.5, -150, 0, 20)}
)
notificationTween:Play()

-- Remove notification after 15 seconds
task.spawn(function()
    task.wait(14.5) -- Wait 14.5 seconds before starting fade out
    local fadeOutTween = TweenService:Create(NotificationFrame,
        TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
        {Position = UDim2.new(0.5, -150, 0, -60)}
    )
    fadeOutTween:Play()
    fadeOutTween.Completed:Wait()
    NotificationFrame:Destroy()
end)

-- Make GUI draggable
local dragging
local dragInput
local dragStart
local startPos

local function updateDrag(input)
    local delta = input.Position - dragStart
    MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
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

MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        updateDrag(input)
    end
end)

-- Variables
local enabled = false
local targetFriends = true
local LocalPlayer = Players.LocalPlayer

-- Function to check if player is a friend
local function isFriend(player)
    return player:IsFriendsWith(LocalPlayer.UserId)
end

-- Function to find the closest smaller target
local function findClosestSmallerTarget()
    local localPlayerSize = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character.HumanoidRootPart.Size
    if not localPlayerSize then return end
    
    local localMagnitude = localPlayerSize.Magnitude
    local closestDifference = math.huge
    local targetPlayer = nil
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            -- Check friend status
            if targetFriends or not isFriend(player) then
                local targetSize = player.Character.HumanoidRootPart.Size
                local targetMagnitude = targetSize.Magnitude
                
                -- Only consider players smaller than us
                if targetMagnitude < localMagnitude then
                    local difference = localMagnitude - targetMagnitude
                    -- Find the player closest to our size (smallest difference)
                    if difference < closestDifference then
                        closestDifference = difference
                        targetPlayer = player
                    end
                end
            end
        end
    end
    
    return targetPlayer
end

-- Function to teleport to target (Infinite Yield style)
local function teleportToTarget(target)
    if not target or not target.Character or not LocalPlayer.Character then return end
    
    local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
    local localRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local localHumanoid = LocalPlayer.Character:FindFirstChild("Humanoid")
    
    if not targetRoot or not localRoot or not localHumanoid then return end
    
    -- Disable character control during teleport
    if localHumanoid.SeatPart then
        localHumanoid.Sit = false
        task.wait(0.1)
    end
    
    -- Set CFrame directly to target
    localRoot.CFrame = CFrame.new(targetRoot.Position)
    
    -- Ensure character state is proper
    localHumanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
end

-- Function to check if target is alive
local function isTargetAlive(target)
    return target and target.Character and target.Character:FindFirstChild("HumanoidRootPart")
end

-- Main function with reduced delays
local function autoTarget()
    while enabled do
        local target = findClosestSmallerTarget()
        while enabled and target and isTargetAlive(target) do
            teleportToTarget(target)
            task.wait(0.01)
        end
        task.wait(0.1)
    end
end

-- Toggle Button Functionality
ToggleButton.MouseButton1Click:Connect(function()
    enabled = not enabled
    ToggleButton.Text = enabled and "Auto Target: ON" or "Auto Target: OFF"
    ToggleButton.BackgroundColor3 = enabled and Color3.fromRGB(60, 180, 75) or Color3.fromRGB(60, 60, 60)
    if enabled then
        autoTarget()
    end
end)

-- Friend Toggle Button Functionality
FriendButton.MouseButton1Click:Connect(function()
    targetFriends = not targetFriends
    FriendButton.Text = targetFriends and "Target Friends: ON" or "Target Friends: OFF"
    FriendButton.BackgroundColor3 = targetFriends and Color3.fromRGB(60, 180, 75) or Color3.fromRGB(60, 60, 60)
end)

-- Close Button Functionality
CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    enabled = false
end)