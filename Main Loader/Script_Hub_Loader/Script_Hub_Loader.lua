local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

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
Title.Text = "Cerial Hub"
Title.Font = Enum.Font.GothamBold
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
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

-- Search Bar
local SearchBar = Instance.new("TextBox")
SearchBar.Size = UDim2.new(1, -20, 0, 30)
SearchBar.Position = UDim2.new(0, 10, 0, 50)
SearchBar.PlaceholderText = "Search..."
SearchBar.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
SearchBar.Font = Enum.Font.Gotham
SearchBar.TextSize = 14
SearchBar.Parent = MainFrame

-- Scripts Container
local ScriptsContainer = Instance.new("ScrollingFrame")
ScriptsContainer.Name = "ScriptsContainer"
ScriptsContainer.Size = UDim2.new(1, -20, 1, -100)
ScriptsContainer.Position = UDim2.new(0, 10, 0, 90)
ScriptsContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ScriptsContainer.BorderSizePixel = 0
ScriptsContainer.ScrollBarThickness = 5
ScriptsContainer.Parent = MainFrame

-- List Layout
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.Parent = ScriptsContainer

-- Create script buttons and dynamic search
local function CreateScriptButton(name, description, script)
    local ButtonContainer = Instance.new("Frame")
    ButtonContainer.Size = UDim2.new(1, 0, 0, 60)
    ButtonContainer.BackgroundTransparency = 1

    local Description = Instance.new("TextLabel")
    Description.Size = UDim2.new(1, -10, 0, 20)
    Description.Position = UDim2.new(0, 10, 0, 0)
    Description.Text = description
    Description.Font = Enum.Font.Gotham
    Description.TextColor3 = Color3.fromRGB(150, 150, 150)
    Description.TextSize = 14
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.BackgroundTransparency = 1
    Description.Parent = ButtonContainer

    local Button = Instance.new("TextButton")
    Button.Name = name .. "Button"
    Button.Size = UDim2.new(1, 0, 0, 40)
    Button.Position = UDim2.new(0, 0, 0, 20)
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.BorderSizePixel = 0

    local ButtonCorner = Instance.new("UICorner")
    ButtonCorner.CornerRadius = UDim.new(0, 8)
    ButtonCorner.Parent = Button

    local ButtonText = Instance.new("TextLabel")
    ButtonText.Size = UDim2.new(1, -10, 1, 0)
    ButtonText.Position = UDim2.new(0, 10, 0, 0)
    ButtonText.Text = name
    ButtonText.Font = Enum.Font.Gotham
    ButtonText.TextColor3 = Color3.fromRGB(220, 220, 220)
    ButtonText.TextSize = 16
    ButtonText.TextXAlignment = Enum.TextXAlignment.Left
    ButtonText.BackgroundTransparency = 1
    ButtonText.Parent = Button

    Button.MouseEnter:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    end)

    Button.MouseLeave:Connect(function()
        Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    end)

    Button.MouseButton1Click:Connect(function()
        pcall(function()
            loadstring(script)()
        end)
    end)

    Button.Parent = ButtonContainer
    ButtonContainer.Parent = ScriptsContainer
    return ButtonContainer
end

-- Example Scripts
local scriptButtons = {}
table.insert(scriptButtons, CreateScriptButton("Blob", "Loads Cerials universal Blob AC-Bypasser", [[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Maximus16adrianu/Cerial-Hub/refs/heads/main/Cerial%20Hub/BLOB%20GAMES/Main_Loader.lua"))()
]]))
table.insert(scriptButtons, CreateScriptButton("Koop", "Loads Cerials FNAF koop ESP", [[
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Maximus16adrianu/Cerial-Hub/refs/heads/main/Cerial%20Hub/FNAF%20KOOP/Main_Loader.lua"))()
]]))

table.insert(scriptButtons, CreateScriptButton("", "", [[
    loadstring(game:HttpGet(""))()
]]))


-- Dynamically adjust the scrollbar visibility based on the number of buttons
local function UpdateScrollbarVisibility()
    if #ScriptsContainer:GetChildren() > 1 then  -- More than 1 item means scrolling is possible
        ScriptsContainer.CanvasSize = UDim2.new(0, 0, 0, 60 * #ScriptsContainer:GetChildren())  -- Adjusting canvas size based on the number of buttons
        ScriptsContainer.ScrollBarThickness = 5  -- Make sure scrollbar is visible
    else
        ScriptsContainer.ScrollBarThickness = 0  -- Hide scrollbar if only 1 or no items
    end
end

-- Call it initially
UpdateScrollbarVisibility()

-- Search Functionality
SearchBar:GetPropertyChangedSignal("Text"):Connect(function()
    local searchText = SearchBar.Text:lower()
    for _, buttonContainer in ipairs(ScriptsContainer:GetChildren()) do
        if buttonContainer:IsA("Frame") then
            local buttonText = buttonContainer:FindFirstChildOfClass("TextLabel")
            if buttonText and buttonText.Text:lower():find(searchText) then
                buttonContainer.Visible = true
            else
                buttonContainer.Visible = false
            end
        end
    end
end)

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
