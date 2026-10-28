local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI erstellen
local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "KryxBooster"
gui.ResetOnSpawn = false

-- Status Label
local label = Instance.new("TextLabel", gui)
label.Size = UDim2.new(0, 180, 0, 30)
label.Position = UDim2.new(0, 10, 0, 10)
label.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
label.BackgroundTransparency = 0.5
label.TextColor3 = Color3.fromRGB(0, 255, 0)
label.TextSize = 14
label.Font = Enum.Font.Code
label.Text = "🔥 Kryx Booster [Mobile]"

-- Scrolling Frame für viele Spieler (mobil-kompatibel)
local frame = Instance.new("ScrollingFrame", gui)
frame.Size = UDim2.new(0, 190, 0, 260)
frame.Position = UDim2.new(0, 10, 0, 45)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.3
frame.CanvasSize = UDim2.new(0, 0, 0, 0)
frame.ScrollBarThickness = 6

local layout = Instance.new("UIListLayout", frame)
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0, 5)

-- Spieler-Liste aktualisieren
local function updateList()
    for _, child in ipairs(frame:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end

    for _, targetPlayer in ipairs(Players:GetPlayers()) do
        if targetPlayer ~= player then
            local btn = Instance.new("TextButton", frame)
            btn.Size = UDim2.new(1, -10, 0, 30)
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
        end
    }
    
    task.wait(0.1)
    frame.CanvasSize = UDim2.new(0, 0, 0, layout.AbsoluteContentSize.Y + 10)
end

Players.PlayerAdded:Connect(updateList)
Players.PlayerRemoving:Connect(updateList)
updateList()
