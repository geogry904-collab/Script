local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AntiCheatWarning"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.Position = UDim2.new(0, 0, 0, 0)
textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
textLabel.BackgroundTransparency = 0.3
textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
textLabel.TextScaled = true
textLabel.Font = Enum.Font.FredokaOne
textLabel.Text = "НЕ ИСПОЛЬЗУЙ ЧИТЫ"
textLabel.Parent = screenGui
