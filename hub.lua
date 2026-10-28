local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local LocalizationService = game:GetService("LocalizationService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

-- Sprache erkennen (Deutsch/Englisch)
local isGerman = false
pcall(function()
    local countryCode = LocalizationService:GetCountryRegionForPlayerAsync(player)
    if countryCode == "DE" or countryCode == "AT" or countryCode == "CH" then
        isGerman = true
    end
end)

local txtNotifTitle = "Kryx Hub BLUE"
local txtNotifDesc = isGerman and "Blaues Pro-Menü erfolgreich geladen! Drücke 'K'." or "Blue Pro Menu loaded successfully! Press 'K'."

if CoreGui:FindFirstChild("KryxWideHub") then
    CoreGui.KryxWideHub:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KryxWideHub"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    screenGui.Parent = CoreGui
end)
if not screenGui.Parent then
    screenGui.Parent = player:WaitForChild("PlayerGui")
end

-- 1. Runder "K" Floating Button (Blau)
local toggleBtn = Instance.new("TextButton", screenGui)
toggleBtn.Size = UDim2.new(0, 50, 0, 50)
toggleBtn.Position = UDim2.new(0, 30, 0, 150)
toggleBtn.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
toggleBtn.TextColor3 = Color3.fromRGB(0, 150, 255)
toggleBtn.TextSize = 22
toggleBtn.Font = Enum.Font.Code
toggleBtn.Text = "K"
toggleBtn.Draggable = true

local btnCorner = Instance.new("UICorner", toggleBtn)
btnCorner.CornerRadius = UDim.new(1, 0)
local btnStroke = Instance.new("UIStroke", toggleBtn)
btnStroke.Color = Color3.fromRGB(0, 150, 255)
btnStroke.Thickness = 2

-- 2. Das breite Hauptfenster (Blau akzentuiert)
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 460, 0, 320)
mainFrame.Position = UDim2.new(0.5, -230, 0.5, -160)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
mainFrame.BackgroundTransparency = 0.05
mainFrame.Visible = true
mainFrame.Draggable = true

local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 10)
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = Color3.fromRGB(0, 150, 255)
mainStroke.Thickness = 2

-- Titel-Leiste oben
local titleBar = Instance.new("Frame", mainFrame)
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
titleBar.BorderSizePixel = 0

local titleCorner = Instance.new("UICorner", titleBar)
titleCorner.CornerRadius = UDim.new(0, 10)

local titleText = Instance.new("TextLabel", titleBar)
titleText.Size = UDim2.new(1, -20, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.TextColor3 = Color3.fromRGB(0, 150, 255)
titleText.TextSize = 14
titleText.Font = Enum.Font.Code
titleText.Text = "🔥 KRYX WIDE HUB [BLUE EDITION]"
titleText.TextXAlignment = Enum.TextXAlignment.Left

-- Schließen-Button oben rechts
local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -35, 0.5, -15)
closeBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 14
closeBtn.Text = "X"
local closeCorner = Instance.new("UICorner", closeBtn)
closeCorner.CornerRadius = UDim.new(0, 6)

closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
end)

-- Linke Seite: Tabs / Kategorien
local tabList = Instance.new("ScrollingFrame", mainFrame)
tabList.Size = UDim2.new(0, 130, 1, -50)
tabList.Position = UDim2.new(0, 5, 0, 45)
tabList.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
tabList.BorderSizePixel = 0
tabList.CanvasSize = UDim2.new(0, 0, 0, 0)
tabList.ScrollBarThickness = 2

local tabLayout = Instance.new("UIListLayout", tabList)
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 5)

-- Rechte Seite: Inhalt
local contentArea = Instance.new("Frame", mainFrame)
contentArea.Size = UDim2.new(1, -145, 1, -50)
contentArea.Position = UDim2.new(0, 140, 0, 45)
contentArea.BackgroundTransparency = 1

local pages = {}

local function createPage(name)
    local scroll = Instance.new("ScrollingFrame", contentArea)
    scroll.Size = UDim2.new(1, 0, 1, 0)
    scroll.BackgroundTransparency = 1
    scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    scroll.ScrollBarThickness = 4
    scroll.Visible = false
    
    local layout = Instance.new("UIListLayout", scroll)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    
    local tBtn = Instance.new("TextButton", tabList)
    tBtn.Size = UDim2.new(1, -5, 0, 35)
    tBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    tBtn.TextSize = 13
    tBtn.Font = Enum.Font.SourceSansBold
    tBtn.Text = name
    local tCorner = Instance.new("UICorner", tBtn)
    tCorner.CornerRadius = UDim.new(0, 6)
    
    tBtn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        scroll.Visible = true
    end)
    
    pages[name] = scroll
    return scroll
end

local function showFirstPage(name)
    if pages[name] then pages[name].Visible = true end
end

-- ================= TAB 1: PLAYER & STATS =================
local pagePlayer = createPage("Player & Stats")

local function addBtn(parent, text, cb)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.new(1, -10, 0, 32)
    b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.TextSize = 13
    b.Font = Enum.Font.SourceSansBold
    b.Text = text
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    b.MouseButton1Click:Connect(function() cb(b) end)
end

-- Speed Input (Blau)
local speedBox = Instance.new("TextBox", pagePlayer)
speedBox.Size = UDim2.new(1, -10, 0, 32)
speedBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
speedBox.TextColor3 = Color3.fromRGB(0, 150, 255)
speedBox.TextSize = 13
speedBox.Font = Enum.Font.Code
speedBox.PlaceholderText = "WalkSpeed (z.B. 100)"
speedBox.Text = ""
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0, 6)

speedBox.FocusLost:Connect(function()
    local val = tonumber(speedBox.Text)
    if val then
        local char = player.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid").WalkSpeed = val
        end
    end
end)

-- JumpPower Input (Blau)
local jumpBox = Instance.new("TextBox", pagePlayer)
jumpBox.Size = UDim2.new(1, -10, 0, 32)
jumpBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
jumpBox.TextColor3 = Color3.fromRGB(0, 150, 255)
jumpBox.TextSize = 13
jumpBox.Font = Enum.Font.Code
jumpBox.PlaceholderText = "JumpPower (z.B. 120)"
jumpBox.Text = ""
Instance.new("UICorner", jumpBox).CornerRadius = UDim.new(0, 6)

jumpBox.FocusLost:Connect(function()
    local val = tonumber(jumpBox.Text)
    if val then
        local char = player.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            local hum = char:FindFirstChildOfClass("Humanoid")
            hum.UseJumpPower = true
            hum.JumpPower = val
        end
    end
end)

local infJump = false
addBtn(pagePlayer, "🔄 Infinite Jump: OFF", function(b)
    infJump = not infJump
    b.Text = infJump and "🔄 Infinite Jump: ON" or "🔄 Infinite Jump: OFF"
end)

UserInputService.JumpRequest:Connect(function()
    if infJump then
        local char = player.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

local noclip = false
addBtn(pagePlayer, "👻 Noclip: OFF", function(b)
    noclip = not noclip
    b.Text = noclip and "👻 Noclip: ON" or "👻 Noclip: OFF"
end)

RunService.Stepped:Connect(function()
    if noclip then
        local char = player.Character
        if char then
            for _, p in ipairs(char:GetDescendants()) do
                if p:IsA("BasePart") then p.CanCollide = false end
            end
        end
    end
end)

-- ================= TAB 2: PERFORMANCE =================
local pagePerf = createPage("Performance")

addBtn(pagePerf, "🔓 FPS Unlocker (999)", function(b)
    pcall(function()
        if setfpscap then setfpscap(999) end
        b.Text = "🔓 FPS Unlocked: 999"
    end)
end)

addBtn(pagePerf, "🚀 FPS Boost / Lag Remover", function(b)
    b.Text = "🚀 FPS Boost: ACTIVE"
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        end
    end
end)

addBtn(pagePerf, "💡 Fullbright (No Dark)", function(b)
    b.Text = "💡 Fullbright: ON"
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.FogEnd = 100000
    Lighting.GlobalShadows = false
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
end)

-- ================= TAB 3: TELEPORT =================
local pageTp = createPage("Player TP")

local function updateTpList()
    for _, child in ipairs(pageTp:GetChildren()) do
        if child:GetAttribute("IsTpBtn") then child:Destroy() end
    end
    for _, tp in ipairs(Players:GetPlayers()) do
        if tp ~= player then
            local b = Instance.new("TextButton", pageTp)
            b.Size = UDim2.new(1, -10, 0, 32)
            b.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            b.TextColor3 = Color3.fromRGB(255, 255, 255)
            b.TextSize = 13
            b.Font = Enum.Font.SourceSansBold
            b.Text = "TP ➔ " .. tp.Name
            b:SetAttribute("IsTpBtn", true)
            Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
            
            b.MouseButton1Click:Connect(function()
                local c1, c2 = player.Character, tp.Character
                if c1 and c1:FindFirstChild("HumanoidRootPart") and c2 and c2:FindFirstChild("HumanoidRootPart") then
                    c1.HumanoidRootPart.CFrame = c2.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                end
            end)
        end
    end
end
Players.PlayerAdded:Connect(updateTpList)
Players.PlayerRemoving:Connect(updateTpList)
updateTpList()

showFirstPage("Player & Stats")

toggleBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = not mainFrame.Visible
end)

pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = txtNotifTitle,
        Text = txtNotifDesc,
        Duration = 5
    })
end)
