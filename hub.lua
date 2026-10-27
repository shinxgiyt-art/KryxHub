loadstring([[
    local CoreGui = game:GetService("CoreGui")
    local Players = game:GetService("Players")
    local Lighting = game:GetService("Lighting")
    local UserInputService = game:GetService("UserInputService")
    local TweenService = game:GetService("TweenService")
    local RunService = game:GetService("RunService")
    local VirtualUser = game:GetService("VirtualUser")
    local Terrain = workspace:FindFirstChildOfClass("Terrain")
    local player = Players.LocalPlayer

    if CoreGui:FindFirstChild("KryxBoosterGui") then CoreGui.KryxBoosterGui:Destroy() end

    local Gui = Instance.new("ScreenGui", CoreGui)
    Gui.Name = "KryxBoosterGui"
    Gui.ResetOnSpawn = false

    local MiniBtn = Instance.new("TextButton", Gui)
    MiniBtn.Name = "MiniCircle"
    MiniBtn.Size = UDim2.new(0, 56, 0, 56)
    MiniBtn.Position = UDim2.new(0, 30, 0.4, 0)
    MiniBtn.BackgroundColor3 = Color3.fromRGB(10, 14, 26)
    MiniBtn.Text = "⚡"
    MiniBtn.TextColor3 = Color3.fromRGB(0, 162, 255)
    MiniBtn.TextSize = 24
    MiniBtn.Font = Enum.Font.GothamBold
    MiniBtn.Visible = true
    MiniBtn.Active = true

    Instance.new("UICorner", MiniBtn).CornerRadius = UDim.new(1, 0)
    local MiniStroke = Instance.new("UIStroke", MiniBtn)
    MiniStroke.Color = Color3.fromRGB(0, 162, 255)
    MiniStroke.Thickness = 2.5

    local MiniStatLabel = Instance.new("TextLabel", MiniBtn)
    MiniStatLabel.Name = "MiniStat"
    MiniStatLabel.Size = UDim2.new(0, 95, 0, 20)
    MiniStatLabel.Position = UDim2.new(1, 8, 0.5, -10)
    MiniStatLabel.BackgroundColor3 = Color3.fromRGB(8, 11, 20)
    MiniStatLabel.TextColor3 = Color3.fromRGB(0, 162, 255)
    MiniStatLabel.Text = "FPS: -- | 0ms"
    MiniStatLabel.Font = Enum.Font.GothamBold
    MiniStatLabel.TextSize = 10
    MiniStatLabel.Visible = true
    Instance.new("UICorner", MiniStatLabel).CornerRadius = UDim.new(0, 6)
    local StatStroke = Instance.new("UIStroke", MiniStatLabel)
    StatStroke.Color = Color3.fromRGB(0, 162, 255)
    StatStroke.Thickness = 1

    local Main = Instance.new("Frame", Gui)
    Main.Name = "MainFrame"
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.Position = UDim2.new(0.5, 0, 0.35, 0)
    Main.BackgroundColor3 = Color3.fromRGB(8, 11, 20)
    Main.ClipsDescendants = true
    Main.Visible = false
    Main.Active = true
    Main.BackgroundTransparency = 1

    Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 16)
    local MainStroke = Instance.new("UIStroke", Main)
    MainStroke.Color = Color3.fromRGB(0, 162, 255)
    MainStroke.Thickness = 1.5

    local Header = Instance.new("Frame", Main)
    Header.Size = UDim2.new(1, 0, 0, 52)
    Header.BackgroundColor3 = Color3.fromRGB(13, 17, 30)
    Header.BorderSizePixel = 0
    Instance.new("UICorner", Header).CornerRadius = UDim.new(0, 16)

    local Title = Instance.new("TextLabel", Header)
    Title.Text = "  ⚡ KRYX HUB"
    Title.Size = UDim2.new(0.4, 0, 0.5, 0)
    Title.TextColor3 = Color3.fromRGB(0, 162, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 13
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1

    local MinimizeBtn = Instance.new("TextButton", Header)
    MinimizeBtn.Text = "─"
    MinimizeBtn.Size = UDim2.new(0, 26, 0, 26)
    MinimizeBtn.Position = UDim2.new(1, -32, 0, 6)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(20, 26, 45)
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.TextSize = 13
    Instance.new("UICorner", MinimizeBtn).CornerRadius = UDim.new(0, 6)

    local TabBar = Instance.new("Frame", Header)
    TabBar.Size = UDim2.new(1, -10, 0, 22)
    TabBar.Position = UDim2.new(0, 5, 0.5, 2)
    TabBar.BackgroundTransparency = 1

    local tabs = {"Booster", "Player", "Visuals", "World"}
    local tabButtons = {}
    local tabContents = {}

    local function createTab(name, index)
        local btn = Instance.new("TextButton", TabBar)
        btn.Text = name
        btn.Size = UDim2.new(0.24, -3, 1, 0)
        btn.Position = UDim2.new((index-1)*0.25, 0, 0, 0)
        btn.BackgroundColor3 = index == 1 and Color3.fromRGB(0, 162, 255) or Color3.fromRGB(20, 26, 45)
        btn.TextColor3 = index == 1 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(180, 180, 180)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 10
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
        tabButtons[name] = btn

        local content = Instance.new("ScrollingFrame", Main)
        content.Size = UDim2.new(1, -20, 1, -72)
        content.Position = UDim2.new(0, 10, 0, 60)
        content.BackgroundTransparency = 1
        content.CanvasSize = UDim2.new(0, 0, 0, 320)
        content.ScrollBarThickness = 3
        content.Visible = (index == 1)
        tabContents[name] = content

        btn.MouseButton1Click:Connect(function()
            for _, c in pairs(tabContents) do c.Visible = false end
            for _, b in pairs(tabButtons) do
                TweenService:Create(b, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(20, 26, 45), TextColor3 = Color3.fromRGB(180, 180, 180)}):Play()
            end
            content.Visible = true
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 162, 255), TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        end)
    end

    for i, name in ipairs(tabs) do createTab(name, i) end

    local BoosterTab = tabContents["Booster"]
    local StatsCard = Instance.new("Frame", BoosterTab)
    StatsCard.Size = UDim2.new(1, 0, 0, 46)
    StatsCard.Position = UDim2.new(0, 0, 0, 0)
    StatsCard.BackgroundColor3 = Color3.fromRGB(13, 17, 30)
    Instance.new("UICorner", StatsCard).CornerRadius = UDim.new(0, 10)

    local StatsLabel = Instance.new("TextLabel", StatsCard)
    StatsLabel.Text = "  FPS: -- | Ping: -- ms"
    StatsLabel.Size = UDim2.new(1, 0, 1, 0)
    StatsLabel.TextColor3 = Color3.fromRGB(0, 162, 255)
    StatsLabel.Font = Enum.Font.GothamBold
    StatsLabel.TextSize = 12
    StatsLabel.TextXAlignment = Enum.TextXAlignment.Left
    StatsLabel.BackgroundTransparency = 1

    local lastUpdate = 0
    local frameCount = 0
    RunService.RenderStepped:Connect(function()
        frameCount = frameCount + 1
        local now = tick()
        if now - lastUpdate >= 0.5 then
            local currentFPS = math.floor(frameCount / (now - lastUpdate))
            frameCount = 0; lastUpdate = now
            local pingVal = 0
            pcall(function() pingVal = math.floor(player:GetNetworkPing() * 1000) end)
            
            StatsLabel.Text = string.format("  FPS: %d | Ping: %d ms", currentFPS, pingVal)
            MiniStatLabel.Text = string.format(" %dFPS | %dms", currentFPS, pingVal)
        end
    end)

    local states = { FPS = false, Ping = false, Fly = false, Noclip = false, Fullbright = false, ESP = false, InfiniteJump = false, RemoveFog = false }
    local connections = { AntiAFK = nil, FlyConn = nil, NoclipConn = nil, JumpConn = nil, BrightConn = nil, ESPConn = nil }

    connections.AntiAFK = player.Idled:Connect(function()
        VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)

    local function createCard(parent, y, title, featureKey, callbackOn, callbackOff)
        local card = Instance.new("Frame", parent)
        card.Size = UDim2.new(1, 0, 0, 52)
        card.Position = UDim2.new(0, 0, 0, y)
        card.BackgroundColor3 = Color3.fromRGB(13, 17, 30)
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)
        
        local label = Instance.new("TextLabel", card)
        label.Text = " " .. title
        label.Size = UDim2.new(0.6, 0, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.TextColor3 = Color3.fromRGB(240, 240, 240)
        label.Font = Enum.Font.GothamBold
        label.TextSize = 12
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1

        local toggleBg = Instance.new("TextButton", card)
        toggleBg.Text = ""
        toggleBg.Size = UDim2.new(0, 46, 0, 24)
        toggleBg.Position = UDim2.new(1, -56, 0.5, -12)
        toggleBg.BackgroundColor3 = Color3.fromRGB(25, 32, 52)
        Instance.new("UICorner", toggleBg).CornerRadius = UDim.new(1, 0)

        local toggleCircle = Instance.new("Frame", toggleBg)
        toggleCircle.Size = UDim2.new(0, 18, 0, 18)
        toggleCircle.Position = UDim2.new(0, 3, 0.5, -9)
        toggleCircle.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        Instance.new("UICorner", toggleCircle).CornerRadius = UDim.new(1, 0)

        toggleBg.MouseButton1Click:Connect(function()
            if states[featureKey] and featureKey == "FPS" then return end
            
            if featureKey == "FPS" then
                label.Text = " 🚀 Max Boost aktiv..."
                pcall(function() setfpscap(999) end)
                pcall(function()
                    Lighting.GlobalShadows = false
                    Lighting.FogEnd = 9e9
                    Lighting.Brightness = 1.5
                    for _, v in pairs(Lighting:GetChildren()) do
                        if v:IsA("PostEffect") or v:IsA("Atmosphere") or v:IsA("Clouds") or v:IsA("Sky") then v.Enabled = false end
                    end
                end)
                if Terrain then pcall(function() Terrain.WaterWaveSize = 0; Terrain.WaterWaveTransparency = 1 end) end
                
                task.spawn(function()
                    pcall(function()
                        for _, v in pairs(workspace:GetDescendants()) do
                            if v:IsA("BasePart") and not v:IsDescendantOf(player.Character) and not v.Parent:FindFirstChild("Humanoid") then
                                v.CastShadow = false
                            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                                v.Enabled = false
                            end
                        end
                    end)
                end)

                states.FPS = true
                label.Text = " 🚀 Max FPS: Fertig!"
                TweenService:Create(toggleBg, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 162, 255)}):Play()
                TweenService:Create(toggleCircle, TweenInfo.new(0.2), {Position = UDim2.new(1, -21, 0.5, -9), BackgroundColor3 = Color3.fromRGB(8, 11, 20)}):Play()
                return
            end

            states[featureKey] = not states[featureKey]
            local active = states[featureKey]
            TweenService:Create(toggleBg, TweenInfo.new(0.2), {BackgroundColor3 = active and Color3.fromRGB(0, 162, 255) or Color3.fromRGB(25, 32, 52)}):Play()
            TweenService:Create(toggleCircle, TweenInfo.new(0.2), {Position = active and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9), BackgroundColor3 = active and Color3.fromRGB(8, 11, 20) or Color3.fromRGB(200, 200, 200)}):Play()

            if active then callbackOn() else callbackOff() end
        end)
    end

    createCard(tabContents["Booster"], 54, "🚀 Max FPS & Render Boost", "FPS", function() end, function() pcall(function() setfpscap(60) end) end)
    createCard(tabContents["Booster"], 112, "🌐 Network & Ping Fix", "Ping", function() settings().Network.IncomingReplicationLag = 0 end, function() settings().Network.IncomingReplicationLag = 0.1 end)

    local PlayerTab = tabContents["Player"]
    local function createInputCard(y, title, defaultVal, callback)
        local card = Instance.new("Frame", PlayerTab)
        card.Size = UDim2.new(1, 0, 0, 52)
        card.Position = UDim2.new(0, 0, 0, y)
        card.BackgroundColor3 = Color3.fromRGB(13, 17, 30)
        Instance.new("UICorner", card).CornerRadius = UDim.new(0, 10)
        
        local label = Instance.new("TextLabel", card)
        label.Text = " " .. title
        label.Size = UDim2.new(0.5, 0, 1, 0)
        label.Position = UDim2.new(0, 10, 0, 0)
        label.TextColor3 = Color3.fromRGB(240, 240, 240)
        label.Font = Enum.Font.GothamBold
        label.TextSize = 12
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1

        local textBox = Instance.new("TextBox", card)
        textBox.Text = tostring(defaultVal)
        textBox.Size = UDim2.new(0, 75, 0, 28)
        textBox.Position = UDim2.new(1, -85, 0.5, -14)
        textBox.BackgroundColor3 = Color3.fromRGB(20, 26, 45)
        textBox.TextColor3 = Color3.fromRGB(0, 162, 255)
        textBox.Font = Enum.Font.GothamBold
        textBox.TextSize = 12
        Instance.new("UICorner", textBox).CornerRadius = UDim.new(0, 6)

        textBox.FocusLost:Connect(function()
            local num = tonumber(textBox.Text)
            if num then callback(num) end
        end)
    end

    createInputCard(0, "🏃 WalkSpeed", 16, function(val) pcall(function() player.Character.Humanoid.WalkSpeed = val end) end)
    createInputCard(58, "🦘 JumpPower", 50, function(val) pcall(function() player.Character.Humanoid.UseJumpPower = true; player.Character.Humanoid.JumpPower = val end) end)
    
    createCard(PlayerTab, 116, "👻 Noclip Mode", "Noclip", function()
        connections.NoclipConn = RunService.Stepped:Connect(function()
            pcall(function() for _, v in pairs(player.Character:GetDescendants()) do if v:IsA("BasePart") then v.CanCollide = false end end end)
        end)
    end, function() if connections.NoclipConn then connections.NoclipConn:Disconnect() end end)

    createCard(PlayerTab, 174, "✈️ Fly Mode", "Fly", function()
        local bg, bv
        connections.FlyConn = RunService.RenderStepped:Connect(function()
            pcall(function()
                local char = player.Character; local hrp = char and char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    if not hrp:FindFirstChild("KryxFlyBG") then
                        bg = Instance.new("BodyGyro", hrp); bg.Name = "KryxFlyBG"; bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                        bv = Instance.new("BodyVelocity", hrp); bv.Name = "KryxFlyBV"; bv.MaxForce = Vector3.new(9e9, 9e9, 9e9); bv.Velocity = Vector3.new(0,0,0)
                    end
                    bg.CFrame = workspace.CurrentCamera.CFrame; bv.Velocity = workspace.CurrentCamera.CFrame.LookVector * 50
                end
            end)
        end)
    end, function()
        if connections.FlyConn then connections.FlyConn:Disconnect() end
        pcall(function() local hrp = player.Character.HumanoidRootPart; if hrp:FindFirstChild("KryxFlyBG") then hrp.KryxFlyBG:Destroy() end; if hrp:FindFirstChild("KryxFlyBV") then hrp.KryxFlyBV:Destroy() end end)
    end)

    createCard(PlayerTab, 232, "🚀 Infinite Jump", "InfiniteJump", function()
        connections.JumpConn = UserInputService.JumpRequest:Connect(function()
            pcall(function() player.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end)
        end)
    end, function()
        if connections.JumpConn then connections.JumpConn:Disconnect() end
    end)

    local VisualsTab = tabContents["Visuals"]
    createCard(VisualsTab, 0, "💡 Fullbright", "Fullbright", function()
        connections.BrightConn = RunService.RenderStepped:Connect(function()
            Lighting.Brightness = 2; Lighting.ClockTime = 14; Lighting.GlobalShadows = false; Lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
        end)
    end, function()
        if connections.BrightConn then connections.BrightConn:Disconnect() end
        Lighting.Brightness = 1; Lighting.GlobalShadows = true
    end)

    createCard(VisualsTab, 58, "📦 Simple ESP", "ESP", function()
        connections.ESPConn = RunService.RenderStepped:Connect(function()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= player and p.Character and p.Character:FindFirstChild("Head") then
                    local head = p.Character.Head
                    if not head:FindFirstChild("KryxESP") then
                        local bb = Instance.new("BillboardGui", head); bb.Name = "KryxESP"; bb.Size = UDim2.new(0, 40, 0, 40); bb.AlwaysOnTop = true
                        local lbl = Instance.new("TextLabel", bb); lbl.Size = UDim2.new(1, 0, 1, 0); lbl.BackgroundTransparency = 1
                        lbl.Text = p.Name; lbl.TextColor3 = Color3.fromRGB(0, 162, 255); lbl.TextSize = 10; lbl.Font = Enum.Font.GothamBold
                    end
                end
            end
        end)
    end, function()
        if connections.ESPConn then connections.ESPConn:Disconnect() end
        for _, p in pairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Head") and p.Character.Head:FindFirstChild("KryxESP") then
                p.Character.Head.KryxESP:Destroy()
            end
        end
    end)

    local WorldTab = tabContents["World"]
    createCard(WorldTab, 0, "🌫️ Remove Fog", "RemoveFog", function()
        Lighting.FogEnd = 9e9
        for _, v in pairs(Lighting:GetChildren()) do if v:IsA("Atmosphere") then v.Density = 0 end end
    end, function()
        Lighting.FogEnd = 100000
    end)

    local dragging, dragStart, startPos
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true; dragStart = input.Position; startPos = Main.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    Header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)

    MinimizeBtn.MouseButton1Click:Connect(function()
        TweenService:Create(Main, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}):Play()
        task.wait(0.22)
        Main.Visible = false
        MiniBtn.Visible = true
        TweenService:Create(MiniBtn, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 56, 0, 56)}):Play()
    end)

    MiniBtn.MouseButton1Click:Connect(function()
        MiniBtn.Visible = false
        Main.Visible = true
        Main.Size = UDim2.new(0, 0, 0, 0)
        Main.BackgroundTransparency = 1
        TweenService:Create(Main, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.new(0, 370, 0, 390), BackgroundTransparency = 0}):Play()
    end)

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "⚡ Kryx Hub",
        Text = "GitHub Script erfolgreich geladen!",
        Duration = 3
    })
]])()
