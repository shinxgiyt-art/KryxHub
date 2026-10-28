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

-- Automatic language detection
local isGerman = false
pcall(function()
    local countryCode = LocalizationService:GetCountryRegionForPlayerAsync(player)
    if countryCode == "DE" or countryCode == "AT" or countryCode == "CH" then
        isGerman = true
    end
end)

local txtTitle = "🔥 KRYX HUB [ULTIMATE OP]"
local txtNotifTitle = "Kryx Hub OP"
local txtNotifDesc = isGerman and "MUAHAHA! 1000x OP Modus aktiv! Drücke 'K'." or "MUAHAHA! 1000x OP Mode Active! Press 'K'."

-- Remove old GUI if present
if CoreGui:FindFirstChild("KryxBoosterHub") then
    CoreGui.KryxBoosterHub:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "KryxBoosterHub"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    screenGui.Parent = CoreGui
end)
if not screenGui.Parent then
    screenGui.Parent = player:WaitForChild("PlayerGui")
end

-- 1. Animated Floating "K" Button with Pulse Glow
local toggleBtn = Instance.new("TextButton", screenGui)
toggleBtn.Size = UDim2.new(0, 55, 0, 55)
toggleBtn.Position = UDim2.new(0, 20, 0, 100)
toggleBtn.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
toggleBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
toggleBtn.TextSize = 24
toggleBtn.Font = Enum.Font.Code
toggleBtn.Text = "K"
toggleBtn.Draggable = true

local cornerBtn = Instance.new("UICorner", toggleBtn)
cornerBtn.CornerRadius = UDim.new(1, 0)
local strokeBtn = Instance.new("UIStroke", toggleBtn)
strokeBtn.Color = Color3.fromRGB(0, 255, 100)
strokeBtn.Thickness = 2.5

-- Pulse Animation for K Button
task.spawn(function()
    while true do
        TweenService:Create(strokeBtn, TweenInfo.new(0.8), {Transparency = 0.5}):Play()
        task.wait(0.8)
        TweenService:Create(strokeBtn, TweenInfo.new(0.8), {Transparency = 0}):Play()
        task.wait(0.8)
    end
end)

-- 2. Main Window with Smooth Open/Close Animation
local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Size = UDim2.new(0, 300, 0, 480)
mainFrame.Position = UDim2.new(0, 90, 0, 100)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
mainFrame.BackgroundTransparency = 0.05
mainFrame.Visible = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true

local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 10)
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = Color3.fromRGB(0, 255, 100)
mainStroke.Thickness = 2

-- Title Header with Neon Glow effect
local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
title.TextColor3 = Color3.fromRGB(0, 255, 100)
title.TextSize = 16
title.Font = Enum.Font.Code
title.Text = txtTitle

local titleCorner = Instance.new("UICorner", title)
titleCorner.CornerRadius = UDim.new(0, 10)

-- Scrolling Frame for 1000x Content
local scroll = Instance.new("ScrollingFrame", mainFrame)
scroll.Size = UDim2.new(1, -10, 1, -55)
scroll.Position = UDim2.new(0, 5, 0, 50)
scroll.BackgroundTransparency = 1
scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
scroll.ScrollBarThickness = 5

local layout = Instance.new("UIListLayout", scroll)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 8)

-- UI Helpers with Hover Animations
local function createCategory(name)
    local sep = Instance.new("TextLabel", scroll)
    sep.Size = UDim2.new(1, -5, 0, 26)
    sep.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
    sep.TextColor3 = Color3.fromRGB(0, 255, 100)
    sep.TextSize = 13
    sep.Font = Enum.Font.Code
    sep.Text = "⚡ " .. name
    local sc = Instance.new("UICorner", sep)
    sc.CornerRadius = UDim.new(0, 5)
end

local function createButton(text, callback)
    local btn = Instance.new("TextButton", scroll)
    btn.Size = UDim2.new(1, -5, 0, 34)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 13
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text

    local btnCorner = Instance.new("UICorner", btn)
    btnCorner.CornerRadius = UDim.new(0, 6)
    
    local btnStroke = Instance.new("UIStroke", btn)
    btnStroke.Color = Color3.fromRGB(50, 50, 50)
    btnStroke.Thickness = 1

    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(0, 255, 100)}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
        TweenService:Create(btnStroke, TweenInfo.new(0.2), {Color = Color3.fromRGB(50, 50, 50)}):Play()
    end)

    btn.MouseButton1Click:Connect(function()
        callback(btn)
    end)
    return btn
end

-- ================= 1. OP PERFORMANCE & FPS =================
createCategory("PERFORMANCE & FPS 1000X")

createButton("🔓 FPS Unlocker (Max 999)", function(btn)
    pcall(function()
        if setfpscap then
            setfpscap(999)
            btn.Text = "🔓 FPS Unlocked: 999 [MAX]"
        else
            btn.Text = "⚠️ Unlocker Active (Built-in)"
        end
    end)
end)

createButton("🚀 MEGA FPS Boost / Lag Killer", function(btn)
    btn.Text = "🚀 MEGA FPS BOOST: ACTIVE"
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

createButton("💡 Ultimate Fullbright", function(btn)
    btn.Text = "💡 Fullbright: ON [BRIGHT]"
    Lighting.Brightness = 3
    Lighting.ClockTime = 12
    Lighting.FogEnd = 999999
    Lighting.GlobalShadows = false
    Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
end)


-- ================= 2. GOD & OP PLAYER CHEATS =================
createCategory("OP PLAYER CHEATS")

-- Godmode / Health Hack
createButton("🛡️ Godmode (Infinite Health)", function(btn)
    btn.Text = "🛡️ Godmode: ACTIVE"
    task.spawn(function()
        while task.wait(0.5) do
            pcall(function()
                local char = player.Character
                if char and char:FindFirstChildOfClass("Humanoid") then
                    local hum = char:FindFirstChildOfClass("Humanoid")
                    hum.Health = hum.MaxHealth
                end
            end)
        end
    end)
end)

-- Extreme Speed 500
local speedEnabled = false
createButton("⚡ OP Speed Hack (Speed 300)", function(btn)
    speedEnabled = not speedEnabled
    btn.Text = speedEnabled and "⚡ Speed 300: ON [MUAHAHA]" or "⚡ OP Speed Hack (Speed 300)"
    local char = player.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char:FindFirstChildOfClass("Humanoid").WalkSpeed = speedEnabled and 300 or 16
    end
end)

-- Mega Jump 300
local jumpEnabled = false
createButton("🦘 Mega JumpPower (350)", function(btn)
    jumpEnabled = not jumpEnabled
    btn.Text = jumpEnabled and "🦘 Mega Jump: ON [FLYING]" or "🦘 Mega JumpPower (350)"
    local char = player.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        local hum = char:FindFirstChildOfClass("Humanoid")
        hum.UseJumpPower = true
        hum.JumpPower = jumpEnabled and 350 or 50
    end
end)

-- Infinite Jump
local infJumpEnabled = false
createButton("🔄 Infinite Air Jump: OFF", function(btn)
    infJumpEnabled = not infJumpEnabled
    btn.Text = infJumpEnabled and "🔄 Infinite Air Jump: ON" or "🔄 Infinite Air Jump: OFF"
end)

UserInputService.JumpRequest:Connect(function()
    if infJumpEnabled then
        local char = player.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            char:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- Noclip Ghost Mode
local noclipEnabled = false
createButton("👻 Ghost Noclip: OFF", function(btn)
    noclipEnabled = not noclipEnabled
    btn.Text = noclipEnabled and "👻 Ghost Noclip: ON" or "👻 Ghost Noclip: OFF"
end)

RunService.Stepped:Connect(function()
    if noclipEnabled then
        local char = player.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)


-- ================= 3. GODLY VISUALS & ESP =================
createCategory("VISUALS & ESP")

createButton("🔭 God FOV (120 Wide)", function(btn)
    Camera.FieldOfView = 120
    btn.Text = "🔭 God FOV: 120"
end)

local espEnabled = false
createButton("👁️ Master Player ESP: OFF", function(btn)
    espEnabled = not espEnabled
    btn.Text = espEnabled and "👁️ Master Player ESP: ON" or "👁️ Master Player ESP: OFF"
    
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player then
            if espEnabled then
                if p.Character and p.Character:FindFirstChild("Head") and not p.Character.Head:FindFirstChild("KryxESP") then
                    local blip = Instance.new("BillboardGui", p.Character.Head)
                    blip.Name = "KryxESP"
                    blip.Size = UDim2.new(0, 60, 0, 60)
                    blip.AlwaysOnTop = true
                    
                    local txt = Instance.new("TextLabel", blip)
                    txt.Size = UDim2.new(1, 0, 1, 0)
                    txt.BackgroundTransparency = 1
                    txt.TextColor3 = Color3.fromRGB(0, 255, 100)
                    txt.TextSize = 13
                    txt.Font = Enum.Font.Code
                    txt.Text = "[ " .. p.Name .. " ]"
                end
            else
                if p.Character and p.Character:FindFirstChild("Head") then
                    local esp = p.Character.Head:FindFirstChild("KryxESP")
                    if esp then esp:Destroy() end
                end
            end
        end
    end
end)


-- ================= 4. PLAYER TELEPORT =================
createCategory("PLAYER TELEPORT PORTAL")

local function updatePlayerList()
    for _, child in ipairs(scroll:GetChildren()) do
        if child:GetAttribute("IsPlayerBtn") then
            child:Destroy()
        end
    end

    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if targetPlayer ~= player then
            local btn = Instance.new("TextButton", scroll)
            btn.Size = UDim2.new(1, -5, 0, 32)
            btn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.TextSize = 13
            btn.Font = Enum.Font.SourceSansBold
            btn.Text = "⚡ Instant TP ➔ " .. targetPlayer.Name
            btn:SetAttribute("IsPlayerBtn", true)

            local btnCorner = Instance.new("UICorner", btn)
            btnCorner.CornerRadius = UDim.new(0, 6)

            btn.MouseButton1Click:Connect(function()
                local char = player.Character
                local tChar = targetPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") and tChar and tChar:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = tChar.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                end
            end)
        end
    end
    
    task.wait(0.1)
    scroll.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 15)
end

Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()


-- ================= 5. MISC & SERVER OP =================
createCategory("MISC & SERVER TOOLS")

createButton("🔄 Instant Rejoin Server", function()
    local TeleportService = game:GetService("TeleportService")
    TeleportService:Teleport(game.PlaceId, player)
end)

createButton("🌐 Fast Server Hop", function()
    local Http = game:GetService("HttpService")
    local TPS = game:GetService("TeleportService")
    local servers = Http:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
    for _, s in ipairs(servers.data) do
        if s.playing < s.maxPlayers then
            TPS:TeleportToPlaceInstance(game.PlaceId, s.id, player)
            break
        end
    end
end)

-- Smooth Animated Toggle with Tween for Open/Close
local isOpen = true
toggleBtn.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    if isOpen then
        mainFrame.Visible = true
        TweenService:Create(mainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 300, 0, 480)}):Play()
    else
        local tw = TweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
        tw:Play()
        tw.Completed:Connect(function()
            if not isOpen then mainFrame.Visible = false end
        end)
    end
end)

-- Notification
pcall(function()
    StarterGui:SetCore("SendNotification", {
        Title = txtNotifTitle,
        Text = txtNotifDesc,
        Duration = 5
    })
end)
