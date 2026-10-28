local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local LocalizationService = game:GetService("LocalizationService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera
local player = Players.LocalPlayer

-- Sprache erkennen (Deutsch/Englisch)
local isGerman = false
pcall(function()
    local countryCode = LocalizationService:GetCountryRegionForPlayerAsync(player)
    if countryCode == "DE" or countryCode == "AT" or countryCode == "CH" then
        isGerman = true
    end
end)

local txtNotifTitle = "Kryx Hub PRO"
local txtNotifDesc = isGerman and "Kryx Hub erfolgreich geladen! Drücke 'K'." or "Kryx Hub successfully loaded! Tap 'K'."

-- Funktion für Benachrichtigungen (Notifications)
local function sendNotif(title, text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title,
            Text = text,
            Duration = 3
        })
    end)
end

if CoreGui:FindFirstChild("KryRealHub") then
    CoreGui.KryRealHub:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KryRealHub"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    screenGui.Parent = CoreGui
end)
if not screenGui.Parent then
    screenGui.Parent = player:WaitForChild("PlayerGui")
end

-- 1. Runder "K" Floating Button mit Puls-Animation
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

task.spawn(function()
    while true do
        TweenService:Create(btnStroke, TweenInfo.new(0.8), {Transparency = 0.6}):Play()
        task.wait(0.8)
        TweenService:Create(btnStroke, TweenInfo.new(0.8), {Transparency = 0}):Play()
        task.wait(0.8)
    end
end)

-- 2. Das breite Hauptfenster
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 480, 0, 340)
mainFrame.Position = UDim2.new(0.5, -240, 0.5, -170)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
mainFrame.BackgroundTransparency = 0.05
mainFrame.Visible = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true

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
titleText.Size = UDim2.new(1, -90, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.TextColor3 = Color3.fromRGB(0, 150, 255)
titleText.TextSize = 14
titleText.Font = Enum.Font.Code
titleText.Text = "🔥 KRYX WIDE HUB [REAL EDITION]"
titleText.TextXAlignment = Enum.TextXAlignment.Left

local container = Instance.new("Frame", mainFrame)
container.Size = UDim2.new(1, 0, 1, -40)
container.Position = UDim2.new(0, 0, 0, 40)
container.BackgroundTransparency = 1

-- MINUS-Button (-) zum Minimieren
local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0, 25, 0, 25)
minBtn.Position = UDim2.new(1, -65, 0.5, -12.5)
minBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.TextSize = 14
minBtn.Font = Enum.Font.SourceSansBold
minBtn.Text = "-"
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 5)

local isMinimized = false
minBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        minBtn.Text = "+"
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = UDim2.new(0, 480, 0, 40)}):Play()
        container.Visible = false
    else
        minBtn.Text = "-"
        container.Visible = true
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 480, 0, 340)}):Play()
    end
end)

-- X-Button zum Schließen
local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 25, 0, 25)
closeBtn.Position = UDim2.new(1, -35, 0.5, -12.5)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.TextSize = 13
closeBtn.Font = Enum.Font.SourceSansBold
closeBtn.Text = "X"
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 5)

closeBtn.MouseButton1Click:Connect(function()
    local tw = TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
    tw:Play()
    tw.Completed:Connect(function()
        screenGui:Destroy()
    end)
end)

-- Linke Seite: Tabs / Kategorien
local tabList = Instance.new("ScrollingFrame", container)
tabList.Size = UDim2.new(0, 130, 1, -10)
tabList.Position = UDim2.new(0, 5, 0, 5)
tabList.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
tabList.BorderSizePixel = 0
tabList.CanvasSize = UDim2.new(0, 0, 0, 0)
tabList.ScrollBarThickness = 2

local tabLayout = Instance.new("UIListLayout", tabList)
tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabLayout.Padding = UDim.new(0, 5)

-- Rechte Seite: Inhalt
local contentArea = Instance.new("Frame", container)
contentArea.Size = UDim2.new(1, -145, 1, -10)
contentArea.Position = UDim2.new(0, 140, 0, 5)
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
    tBtn.Size = UDim2.new(1, -5, 0, 32)
    tBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    tBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
    tBtn.TextSize = 12
    tBtn.Font = Enum.Font.SourceSansBold
    tBtn.Text = name
    Instance.new("UICorner", tBtn).CornerRadius = UDim.new(0, 6)
    
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


-- ================= 1. PLAYER STATS =================
local pagePlayer = createPage("Player Stats")

local speedBox = Instance.new("TextBox", pagePlayer)
speedBox.Size = UDim2.new(1, -10, 0, 32)
speedBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
speedBox.TextColor3 = Color3.fromRGB(0, 150, 255)
speedBox.TextSize = 13
speedBox.Font = Enum.Font.Code
speedBox.PlaceholderText = "WalkSpeed (z.B. 16)"
speedBox.Text = ""
Instance.new("UICorner", speedBox).CornerRadius = UDim.new(0, 6)

speedBox.FocusLost:Connect(function()
    local val = tonumber(speedBox.Text)
    if val then
        local char = player.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid").WalkSpeed = val
            sendNotif("Player Stats", "WalkSpeed gesetzt auf: " .. val)
        end
    end
end)

local jumpBox = Instance.new("TextBox", pagePlayer)
jumpBox.Size = UDim2.new(1, -10, 0, 32)
jumpBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
jumpBox.TextColor3 = Color3.fromRGB(0, 150, 255)
jumpBox.TextSize = 13
jumpBox.Font = Enum.Font.Code
jumpBox.PlaceholderText = "JumpPower (z.B. 50)"
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
            sendNotif("Player Stats", "JumpPower gesetzt auf: " .. val)
        end
    end
end)


-- ================= 2. MOVEMENT =================
local pageMove = createPage("Movement")

local infJump = false
addBtn(pageMove, "🔄 Infinite Jump: OFF", function(b)
    infJump = not infJump
    b.Text = infJump and "🔄 Infinite Jump: ON" or "🔄 Infinite Jump: OFF"
    sendNotif("Movement", infJump and "Infinite Jump aktiviert!" or "Infinite Jump deaktiviert!")
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
addBtn(pageMove, "👻 Noclip: OFF", function(b)
    noclip = not noclip
    b.Text = noclip and "👻 Noclip: ON" or "👻 Noclip: OFF"
    sendNotif("Movement", noclip and "Noclip aktiviert!" or "Noclip deaktiviert!")
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


-- ================= 3. PERFORMANCE =================
local pagePerf = createPage("Performance")

addBtn(pagePerf, "🚀 FPS Boost (Lag Remover)", function(b)
    b.Text = "🚀 FPS Boost: ACTIVE"
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        end
    end
    sendNotif("Performance", "FPS Boost aktiviert! Schatten & Texturen entfernt.")
end)

addBtn(pagePerf, "💡 Fullbright (No Dark)", function(b)
    b.Text = "💡 Fullbright: ON"
    Lighting.Brightness = 2
    Lighting.ClockTime = 14
    Lighting.GlobalShadows = false
    Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    sendNotif("Performance", "Fullbright aktiviert! Welt ist nun hell.")
end)


-- ================= 4. VISUALS / ESP =================
local pageVis = createPage("Visuals & ESP")

addBtn(pageVis, "🔭 FOV Changer (90)", function(b)
    Camera.FieldOfView = 90
    b.Text = "🔭 FOV: 90 (Standard)"
    sendNotif("Visuals", "FOV auf Standard (90) gesetzt.")
end)

addBtn(pageVis, "🔭 FOV Changer (120 Wide)", function(b)
    Camera.FieldOfView = 120
    b.Text = "🔭 FOV: 120 (Wide)"
    sendNotif("Visuals", "FOV auf Weitwinkel (120) gesetzt.")
end)

local espOn = false
addBtn(pageVis, "👁️ Player ESP: OFF", function(b)
    espOn = not espOn
    b.Text = espOn and "👁️ Player ESP: ON" or "👁️ Player ESP: OFF"
    sendNotif("Visuals", espOn and "Player ESP aktiviert!" or "Player ESP deaktiviert!")
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
            if espOn and not p.Character.Head:FindFirstChild("RealESP") then
                local bg = Instance.new("BillboardGui", p.Character.Head)
                bg.Name = "RealESP"
                bg.Size = UDim2.new(0, 50, 0, 50)
                bg.AlwaysOnTop = true
                local txt = Instance.new("TextLabel", bg)
                txt.Size = UDim2.new(1, 0, 1, 0)
                txt.BackgroundTransparency = 1
                txt.TextColor3 = Color3.fromRGB(0, 150, 255)
                txt.TextSize = 12
                txt.Font = Enum.Font.Code
                txt.Text = p.Name
            elseif not espOn then
                local esp = p.Character.Head:FindFirstChild("RealESP")
                if esp then esp:Destroy() end
            end
        end
    end
end)


-- ================= 5. TELEPORT =================
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
                    sendNotif("Teleport", "Zu Spieler teleportiert: " .. tp.Name)
                end
            end)
        end
    end
end
Players.PlayerAdded:Connect(updateTpList)
Players.PlayerRemoving:Connect(updateTpList)
updateTpList()


-- ================= 6. MISC / SERVER =================
local pageMisc = createPage("Misc & Server")

addBtn(pageMisc, "🔄 Rejoin Server", function()
    sendNotif("Server", "Verbinde neu zum Server...")
    task.wait(0.5)
    game:GetService("TeleportService"):Teleport(game.PlaceId, player)
end)


showFirstPage("Player Stats")

-- K-Button animierter Toggle
local isHubOpen = true
toggleBtn.MouseButton1Click:Connect(function()
    isHubOpen = not isHubOpen
    if isHubOpen then
        mainFrame.Visible = true
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 480, 0, 340)}):Play()
    else
        local tw = TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
        tw:Play()
        tw.Completed:Connect(function()
            if not isHubOpen then mainFrame.Visible = false end
        end)
    end
end)

-- Ausführungs-Nachricht (beim Executen)
sendNotif(txtNotifTitle, txtNotifDesc)
