local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local Animatronics = {
{Name = "Chica", Path = workspace.Animatronics.Chica.ChicaNPC, Color = Color3.new(0.537255, 0.494118, 0.223529)},
{Name = "Bonnie", Path = workspace.Animatronics.Bonnie.BonnieNPC, Color = Color3.new(0.321569, 0.101961, 0.529412)},
{Name = "Foxy", Path = workspace.Animatronics.Foxy.FoxyNPC, Color = Color3.fromRGB(255, 69, 0)},
{Name = "Fredbear", Path = workspace.Animatronics.Fredbear.FredbearNPC, Color = Color3.new(0.580392, 0.411765, 0.043137)},
{Name = "Nightmare", Path = workspace.Animatronics.Nightmare.NightmareNPC, Color = Color3.new(0.019608, 0.031373, 0.113725)},
{Name = "Plushtrap", Path = workspace.Animatronics.Plushtrap.PlushtrapNPC, Color = Color3.new(0.129412, 0.274510, 0.070588)},
    -- Add more animatronics here as needed
}

local espEnabled = {}
for _, animatronic in ipairs(Animatronics) do
    espEnabled[animatronic.Name] = false
end

-- Modern GUI Creation with Glassmorphism effect
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local BlurEffect = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Container = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UICorner_Main = Instance.new("UICorner")
local UICorner_Container = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local ToggleButtons = {}
local ToggleKey = Enum.KeyCode.RightShift
local EspToggleKey = Enum.KeyCode.P

local InstructionText = Instance.new("TextLabel")
InstructionText.Parent = ScreenGui
InstructionText.BackgroundTransparency = 1
InstructionText.Position = UDim2.new(0.5, -150, 0, 20)  -- Adjust position as needed
InstructionText.Size = UDim2.new(0, 300, 0, 30)
InstructionText.Text = "Open with RightShift and press ESC to be able to move your mouse"
InstructionText.TextColor3 = Color3.fromRGB(255, 255, 255)
InstructionText.Font = Enum.Font.GothamSemibold
InstructionText.TextSize = 16
InstructionText.TextStrokeTransparency = 0.8
InstructionText.TextTransparency = 0.2

ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false

-- Blur Effect Background
BlurEffect.Parent = MainFrame
BlurEffect.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
BlurEffect.BackgroundTransparency = 0.9
BlurEffect.Size = UDim2.new(1, 0, 1, 0)
BlurEffect.ZIndex = 0

MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0.3, 0, 0.4, 0)
MainFrame.Visible = false
MainFrame.ClipsDescendants = true

UIGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 35)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 40, 45))
})
UIGradient.Parent = MainFrame
UIGradient.Rotation = 45

UICorner_Main.Parent = MainFrame
UICorner_Main.CornerRadius = UDim.new(0, 15)

Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Size = UDim2.new(1, 0, 0.1, 0)
Title.Font = Enum.Font.GothamBold
Title.Text = "FNAF Koop V1 - Cerial Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.TextStrokeTransparency = 0.8

Container.Parent = MainFrame
Container.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Container.BackgroundTransparency = 0.3
Container.Position = UDim2.new(0.05, 0, 0.18, 0)
Container.Size = UDim2.new(0.9, 0, 0.77, 0)

UICorner_Container.Parent = Container
UICorner_Container.CornerRadius = UDim.new(0, 12)

-- Create a ScrollingFrame inside the container
ScrollingFrame.Parent = Container
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
ScrollingFrame.ScrollingEnabled = true

-- Dynamically adjust canvas size based on the number of animatronics
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, #Animatronics * 50)  -- Adjust button height for more space

-- Modern Keybind Info
local KeybindInfo = Instance.new("TextLabel")
KeybindInfo.Parent = MainFrame
KeybindInfo.BackgroundTransparency = 1
KeybindInfo.Position = UDim2.new(0, 0, 0.1, 0)
KeybindInfo.Size = UDim2.new(1, 0, 0.05, 0)
KeybindInfo.Font = Enum.Font.GothamSemibold
KeybindInfo.Text = "RightShift to hide • Press 'P' to toggle all • PS: Very buggy, dont use toggle "
KeybindInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
KeybindInfo.TextSize = 12
KeybindInfo.TextTransparency = 0.2

-- Modern Toggle Button Creation
local function createToggleButton(name, yPosition)
    local Button = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")
    local Background = Instance.new("Frame")
    local UICorner_BG = Instance.new("UICorner")
    local StatusIndicator = Instance.new("Frame")
    local UICorner_Status = Instance.new("UICorner")
    
    Background.Parent = ScrollingFrame
    Background.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    Background.BackgroundTransparency = 0.4
    Background.Position = UDim2.new(0.05, 0, yPosition, 0)
    Background.Size = UDim2.new(0.9, 0, 0.1, 0)  -- Adjusted button height to 0.1 for more buttons

    UICorner_BG.Parent = Background
    UICorner_BG.CornerRadius = UDim.new(0, 8)
    
    Button.Parent = Background
    Button.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
    Button.BackgroundTransparency = 0.2
    Button.Size = UDim2.new(1, 0, 1, 0)
    Button.Text = name .. " ESP: OFF"
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 14
    Button.Font = Enum.Font.GothamSemibold
    Button.AutoButtonColor = false
    
    UICorner.Parent = Button
    UICorner.CornerRadius = UDim.new(0, 8)
    
    StatusIndicator.Parent = Button
    StatusIndicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    StatusIndicator.Position = UDim2.new(0.02, 0, 0.5, 0)
    StatusIndicator.AnchorPoint = Vector2.new(0, 0.5)
    StatusIndicator.Size = UDim2.new(0.04, 0, 0.4, 0)
    
    UICorner_Status.Parent = StatusIndicator
    UICorner_Status.CornerRadius = UDim.new(1, 0)
    
    -- Enhanced Hover Effect
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.3), {
            BackgroundTransparency = 0,
            BackgroundColor3 = Color3.fromRGB(70, 70, 80)
        }):Play()
    end)

    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.3), {
            BackgroundTransparency = 0.2,
            BackgroundColor3 = Color3.fromRGB(50, 50, 55)
        }):Play()
    end)

    Button.MouseButton1Click:Connect(function()
        espEnabled[name] = not espEnabled[name]
        if espEnabled[name] then
            Button.Text = name .. " ESP: ON"
            StatusIndicator.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
        else
            Button.Text = name .. " ESP: OFF"
            StatusIndicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
        end
    end)
end

-- Create all the toggle buttons
for i, animatronic in ipairs(Animatronics) do
    createToggleButton(animatronic.Name, (i - 1) * 0.1)
end

-- Keybind toggles
UserInputService.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Keyboard then
        if input.KeyCode == ToggleKey then
            MainFrame.Visible = not MainFrame.Visible
        elseif input.KeyCode == EspToggleKey then
            for animatronicName, enabled in pairs(espEnabled) do
                espEnabled[animatronicName] = not enabled
            end
            for i, animatronic in ipairs(Animatronics) do
                local button = ToggleButtons[animatronic.Name]
                local statusIndicator = button:FindFirstChild("StatusIndicator")
                if espEnabled[animatronic.Name] then
                    statusIndicator.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
                else
                    statusIndicator.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
                end
            end
        end
    end
end)

-- Skeleton ESP Drawing Function (without arms)
local function drawLine(part1, part2, color)
    if not part1 or not part2 then return nil end

    local Line = Drawing.new("Line")
    Line.Color = color
    Line.Thickness = 2

    local function update()
        if part1.Parent and part2.Parent then
            local part1Pos, part2Pos = part1.Position, part2.Position
            local screenPos1, onScreen1 = workspace.CurrentCamera:WorldToViewportPoint(part1Pos)
            local screenPos2, onScreen2 = workspace.CurrentCamera:WorldToViewportPoint(part2Pos)

            if onScreen1 and onScreen2 then
                Line.Visible = true
                Line.From = Vector2.new(screenPos1.X, screenPos1.Y)
                Line.To = Vector2.new(screenPos2.X, screenPos2.Y)
            else
                Line.Visible = false
            end
        else
            Line.Visible = false
        end
    end

    RunService.RenderStepped:Connect(update)
    return Line
end

-- Create Distance Text
local function createDistanceText()
    local text = Drawing.new("Text")
    text.Color = Color3.fromRGB(255, 255, 255)
    text.Center = true
    text.Outline = true
    text.OutlineColor = Color3.fromRGB(0, 0, 0)
    text.Font = 2
    return text
end

-- Create Name Tag
local function createNameTag()
    local text = Drawing.new("Text")
    text.Color = Color3.fromRGB(255, 255, 255)
    text.Center = true
    text.Outline = true
    text.OutlineColor = Color3.fromRGB(0, 0, 0)
    text.Font = 2
    return text
end

local function createSkeleton(animatronic)
    -- Skeleton parts (removed arms)
    local skeletonParts = {
        {animatronic.Path.Head, animatronic.Path.UpperTorso},
        {animatronic.Path.UpperTorso, animatronic.Path.LowerTorso},
        {animatronic.Path.LowerTorso, animatronic.Path.LeftUpperLeg},
        {animatronic.Path.LeftUpperLeg, animatronic.Path.LeftLowerLeg},
        {animatronic.Path.LeftLowerLeg, animatronic.Path.LeftFoot},
        {animatronic.Path.LowerTorso, animatronic.Path.RightUpperLeg},
        {animatronic.Path.RightUpperLeg, animatronic.Path.RightLowerLeg},
        {animatronic.Path.RightLowerLeg, animatronic.Path.RightFoot},
    }

    local lines = {}
    for _, parts in ipairs(skeletonParts) do
        table.insert(lines, drawLine(parts[1], parts[2], animatronic.Color))
    end

    -- Add distance text and name tag
    local distanceText = createDistanceText()
    local nameTag = createNameTag()

    return {
        lines = lines,
        distanceText = distanceText,
        nameTag = nameTag
    }
end

-- Box ESP Drawing Function
local function drawBox(animatronic)
    local box = Drawing.new("Square")
    box.Color = animatronic.Color
    box.Thickness = 1
    box.Filled = false
    box.Transparency = 0.7

    local function update()
        if animatronic.Path and animatronic.Path.PrimaryPart then
            local position, onScreen = workspace.CurrentCamera:WorldToViewportPoint(animatronic.Path.PrimaryPart.Position)
            if onScreen then
                local size = workspace.CurrentCamera:WorldToViewportPoint(animatronic.Path.PrimaryPart.Position + Vector3.new(2, 2, 2)) - workspace.CurrentCamera:WorldToViewportPoint(animatronic.Path.PrimaryPart.Position - Vector3.new(2, 2, 2))
                box.Size = Vector2.new(size.X, size.Y)
                box.Position = Vector2.new(position.X - size.X / 2, position.Y - size.Y / 2)
                box.Visible = true
            else
                box.Visible = false
            end
        end
    end

    RunService.RenderStepped:Connect(update)
    return box
end

local activeEsp = {}

local function updateESP()
    for _, animatronic in ipairs(Animatronics) do
        if espEnabled[animatronic.Name] and not activeEsp[animatronic.Name] then
            local esp = createSkeleton(animatronic)
            esp.box = drawBox(animatronic)
            activeEsp[animatronic.Name] = esp
        elseif not espEnabled[animatronic.Name] and activeEsp[animatronic.Name] then
            for _, line in ipairs(activeEsp[animatronic.Name].lines) do
                line:Remove()
            end
            activeEsp[animatronic.Name].box:Remove()
            activeEsp[animatronic.Name].distanceText:Remove()
            activeEsp[animatronic.Name].nameTag:Remove()
            activeEsp[animatronic.Name] = nil
        elseif espEnabled[animatronic.Name] and activeEsp[animatronic.Name] then
            -- Update distance text and name tag
            if animatronic.Path and animatronic.Path.PrimaryPart then
                local position = animatronic.Path.PrimaryPart.Position
                local distance = (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) and 
                    (LocalPlayer.Character.HumanoidRootPart.Position - position).Magnitude or 0
                
                local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(position)
                
                if onScreen then
                    -- Update distance text
                    activeEsp[animatronic.Name].distanceText.Visible = true
                    activeEsp[animatronic.Name].distanceText.Position = Vector2.new(screenPos.X, screenPos.Y + 40)
                    activeEsp[animatronic.Name].distanceText.Text = string.format("%.1f studs", distance)
                    activeEsp[animatronic.Name].distanceText.Size = math.clamp(30 - distance/10, 12, 30) -- Scale text size with distance
                    
                    -- Update name tag
                    activeEsp[animatronic.Name].nameTag.Visible = true
                    activeEsp[animatronic.Name].nameTag.Position = Vector2.new(screenPos.X, screenPos.Y - 40)
                    activeEsp[animatronic.Name].nameTag.Text = animatronic.Name
                    activeEsp[animatronic.Name].nameTag.Size = math.clamp(30 - distance/10, 12, 30) -- Scale text size with distance
                else
                    activeEsp[animatronic.Name].distanceText.Visible = false
                    activeEsp[animatronic.Name].nameTag.Visible = false
                end
            end
        end
    end
end

RunService.RenderStepped:Connect(updateESP)

-- GUI Toggle Functionality
local guiOpen = false

local function toggleGui()
    guiOpen = not guiOpen
    MainFrame.Visible = guiOpen
    
    if guiOpen then
        -- Store the original mouse behavior and enable mouse
        originalMouseBehavior = UserInputService.MouseBehavior
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        UserInputService.MouseIconEnabled = true
    else
        -- Restore the original mouse behavior
        UserInputService.MouseBehavior = originalMouseBehavior
        UserInputService.MouseIconEnabled = false
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end

    if input.KeyCode == ToggleKey then
        toggleGui()
    elseif input.KeyCode == EspToggleKey then
        for animatronic, _ in pairs(espEnabled) do
            espEnabled[animatronic] = not espEnabled[animatronic]
            ToggleButtons[animatronic].Text = animatronic .. " ESP: " .. (espEnabled[animatronic] and "ON" or "OFF")
        end
    end
end)