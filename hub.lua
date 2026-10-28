local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI erstellen
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "KryxBooster"
gui.ResetOnSpawn = false

-- Status Label (oben links)
local label = Instance.new("TextLabel", gui)
label.Size = UDim2.new(0, 180, 0, 30)
label.Position = UDim2.new(0, 10, 0, 10)
label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
label.BackgroundTransparency = 0.5
label.TextColor3 = Color3.fromRGB(0, 255, 0)
label.TextSize = 14
label.Font = Enum.Font.Code
label.Text = "🔥 Kryx Booster [Mobile]"

-- Teleport Menü Frame
local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 180, 0, 240)
frame.Position = UDim2.new(0, 10, 0, 45)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.3

-- Spieler auflisten und Teleport-Buttons erstellen
local function updateList()
    -- Alte Buttons erst löschen
    for _, child in ipairs(frame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    local yPos = 10
    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if targetPlayer ~= player then
            local btn = Instance.new("TextButton", frame)
            btn.Size = UDim2.new(1, -20, 0, 25)
            btn.Position = UDim2.new(0, 10, 0, yPos)
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            btn.TextSize = 13
            btn.Font = Enum.Font.SourceSansBold
            btn.Text = "TP: " .. targetPlayer.Name

            btn.MouseButton1Click:Connect(function()
                local char = player.Character
                local tChar = targetPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") and tChar and tChar:FindFirstChild("HumanoidRootPart") then
                    char.HumanoidRootPart.CFrame = tChar.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                end
            end)

            yPos = yPos + 30
        end
    end
end

Players.PlayerAdded:Connect(updateList)
Players.PlayerRemoving:Connect(updateList)
updateList()
