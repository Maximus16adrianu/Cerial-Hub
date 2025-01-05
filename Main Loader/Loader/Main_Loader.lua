local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local InfoLabel = Instance.new("TextLabel")
local WorkingLabel = Instance.new("TextLabel")
local ExecutorList = Instance.new("TextLabel")
local NotWorkingLabel = Instance.new("TextLabel")
local NotWorkingList = Instance.new("TextLabel")
local UsernameBox = Instance.new("TextBox")
local PasswordBox = Instance.new("TextBox")
local SubmitButton = Instance.new("TextButton")
local CloseButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UICorner2 = Instance.new("UICorner")
local UICorner3 = Instance.new("UICorner")
local UICorner4 = Instance.new("UICorner")
local UICorner5 = Instance.new("UICorner")

-- Check for existing instances
local existingInstances = game.CoreGui:FindFirstChild("CerialLoaderScreenGui")
if existingInstances then
    game.Players.LocalPlayer:Kick("Only execute the script once")
    return
end

-- Rename ScreenGui to prevent duplicate checks
ScreenGui.Name = "CerialLoaderScreenGui"
ScreenGui.Parent = game.CoreGui

-- Frame Settings (made taller to accommodate new elements)
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Frame.BorderSizePixel = 0
Frame.Size = UDim2.new(0, 350, 0, 400)
Frame.Position = UDim2.new(0.5, -175, 0.5, -200)
Frame.Draggable = true
Frame.Active = true
Frame.Selectable = true
Frame.ClipsDescendants = true
UICorner.Parent = Frame
UICorner.CornerRadius = UDim.new(0, 10)

-- Info Label (New)
InfoLabel.Parent = Frame
InfoLabel.Text = "INFO"
InfoLabel.Size = UDim2.new(0, 200, 0, 40)
InfoLabel.Position = UDim2.new(0.5, -100, 0.05, 0)
InfoLabel.BackgroundTransparency = 1
InfoLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
InfoLabel.Font = Enum.Font.GothamBold
InfoLabel.TextSize = 28

-- Working Label (New)
WorkingLabel.Parent = Frame
WorkingLabel.Text = "Working executors:"
WorkingLabel.Size = UDim2.new(0, 200, 0, 30)
WorkingLabel.Position = UDim2.new(0.5, -100, 0.15, 0)
WorkingLabel.BackgroundTransparency = 1
WorkingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
WorkingLabel.Font = Enum.Font.GothamBold
WorkingLabel.TextSize = 16

-- Executor List (New)
ExecutorList.Parent = Frame
ExecutorList.Text = "Solara | JJSploit | Wave"
ExecutorList.Size = UDim2.new(0, 200, 0, 40)
ExecutorList.Position = UDim2.new(0.5, -100, 0.2, 0)
ExecutorList.BackgroundTransparency = 1
ExecutorList.TextColor3 = Color3.fromRGB(0, 255, 0)
ExecutorList.Font = Enum.Font.Gotham
ExecutorList.TextSize = 14

-- Not Working Label (New)
NotWorkingLabel.Parent = Frame
NotWorkingLabel.Text = "Not working:"
NotWorkingLabel.Size = UDim2.new(0, 200, 0, 30)
NotWorkingLabel.Position = UDim2.new(0.5, -100, 0.3, 0)
NotWorkingLabel.BackgroundTransparency = 1
NotWorkingLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
NotWorkingLabel.Font = Enum.Font.GothamBold
NotWorkingLabel.TextSize = 16

-- Not Working List (New)
NotWorkingList.Parent = Frame
NotWorkingList.Text = "-"
NotWorkingList.Size = UDim2.new(0, 200, 0, 30)
NotWorkingList.Position = UDim2.new(0.5, -100, 0.35, 0)
NotWorkingList.BackgroundTransparency = 1
NotWorkingList.TextColor3 = Color3.fromRGB(255, 0, 0)
NotWorkingList.Font = Enum.Font.Gotham
NotWorkingList.TextSize = 14

-- Title
Title.Parent = Frame
Title.Text = "Cerial Loader"
Title.Size = UDim2.new(0, 200, 0, 40)
Title.Position = UDim2.new(0.5, -100, 0.45, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24

-- UsernameBox (adjusted position)
UsernameBox.Parent = Frame
UsernameBox.PlaceholderText = "Username"
UsernameBox.Size = UDim2.new(0, 300, 0, 40)
UsernameBox.Position = UDim2.new(0.5, -150, 0.6, 0)
UsernameBox.Text = ""
UsernameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
UsernameBox.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
UsernameBox.BorderSizePixel = 0
UsernameBox.Font = Enum.Font.Gotham
UsernameBox.TextSize = 14
UICorner2.Parent = UsernameBox
UICorner2.CornerRadius = UDim.new(0, 6)

-- PasswordBox (adjusted position)
PasswordBox.Parent = Frame
PasswordBox.PlaceholderText = "Password"
PasswordBox.Size = UDim2.new(0, 300, 0, 40)
PasswordBox.Position = UDim2.new(0.5, -150, 0.75, 0)
PasswordBox.Text = ""
PasswordBox.TextColor3 = Color3.fromRGB(255, 255, 255)
PasswordBox.BackgroundColor3 = Color3.fromRGB(45, 45, 50)
PasswordBox.BorderSizePixel = 0
PasswordBox.Font = Enum.Font.Gotham
PasswordBox.TextSize = 14
UICorner3.Parent = PasswordBox
UICorner3.CornerRadius = UDim.new(0, 6)

-- SubmitButton (adjusted position)
SubmitButton.Parent = Frame
SubmitButton.Text = "Login"
SubmitButton.Size = UDim2.new(0, 150, 0, 40)
SubmitButton.Position = UDim2.new(0.5, -75, 0.9, 0)
SubmitButton.BackgroundColor3 = Color3.fromRGB(65, 140, 240)
SubmitButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SubmitButton.Font = Enum.Font.GothamBold
SubmitButton.TextSize = 16
SubmitButton.BorderSizePixel = 0
UICorner4.Parent = SubmitButton
UICorner4.CornerRadius = UDim.new(0, 6)

-- CloseButton
CloseButton.Parent = Frame
CloseButton.Text = "×"
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -40, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 95, 95)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 20
CloseButton.BorderSizePixel = 0
UICorner5.Parent = CloseButton
UICorner5.CornerRadius = UDim.new(0, 6)

-- Spam protection
local lastRequestTime = 0
local requestCooldown = 5

-- Background Sound
local backgroundSound = Instance.new("Sound")
backgroundSound.SoundId = "rbxassetid://1837282067"
backgroundSound.Volume = 0.5
backgroundSound.Looped = true
backgroundSound.Parent = game:GetService("Workspace")
backgroundSound:Play()

-- Function to fetch GitHub data
local function fetchGitHubData(url)
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)

    if not success then
        print("Error fetching data: " .. tostring(response))
        return false, response
    end

    return true, response
end

local function checkCredentials(username, password)
    local url = "https://raw.githubusercontent.com/Maximus16adrianu/Cerial-Hub/refs/heads/main/Main%20Loader/Loader/database.json"
    local success, data = fetchGitHubData(url)

    if not success then
        print("Error: " .. data)
        return false
    end

    for line in data:gmatch("[^\r\n]+") do
        local storedUsername, storedPassword = line:match("([^:]+):([^:]+)")
        if storedUsername == username and storedPassword == password then
            print("Login successful!")
            return true
        end
    end

    print("Invalid username or password.")
    return false
end

SubmitButton.MouseButton1Click:Connect(function()
    local currentTime = tick()
    if currentTime - lastRequestTime < requestCooldown then
        print("Please wait " .. math.ceil(requestCooldown - (currentTime - lastRequestTime)) .. " seconds before trying again.")
        return
    end

    lastRequestTime = currentTime

    local username = UsernameBox.Text
    local password = PasswordBox.Text

    if username == "" or password == "" then
        print("Please fill in both fields!")
        return
    end

    print("Checking credentials...")
    local loginSuccessful = checkCredentials(username, password)

    if loginSuccessful then
        ScreenGui:Destroy()

        -- Stop background sound
        backgroundSound:Stop()
        backgroundSound:Destroy()

        -- Play login sound
        local loginSound = Instance.new("Sound")
        loginSound.SoundId = "rbxassetid://1000294392"
        loginSound.Volume = 1.0
        loginSound.Parent = game:GetService("Workspace")
        loginSound:Play()
        loginSound.Ended:Connect(function()
            loginSound:Destroy()
        end)

        print("Executing additional script...")
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Maximus16adrianu/Cerial-Hub/refs/heads/main/Main%20Loader/Script_Hub_Loader/Script_Hub_Loader.lua"))()
    end
end)

CloseButton.MouseButton1Click:Connect(function()
    -- Stop background sound when GUI is closed
    backgroundSound:Stop()
    backgroundSound:Destroy()

    ScreenGui:Destroy()
end)
