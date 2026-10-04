local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Создаем основной интерфейс
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "dlz10_Menu"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Главное окно (темный фон с неоновой бирюзовой обводкой)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 220)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -110)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
mainFrame.BorderColor3 = Color3.fromRGB(0, 255, 255) -- Неоновый цвет
mainFrame.BorderSizePixel = 3
mainFrame.Active = true
mainFrame.Draggable = true -- Меню можно перетаскивать по экрану
mainFrame.Parent = screenGui

-- Заголовок меню
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
title.TextColor3 = Color3.fromRGB(255, 0, 255) -- Неоновый розовый
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.Text = "dlz10 Premium"
title.Parent = mainFrame

-- Фейковая кнопка ESP (просто меняет цвет при нажатии)
local espBtn = Instance.new("TextButton")
espBtn.Size = UDim2.new(0.8, 0, 0, 40)
espBtn.Position = UDim2.new(0.1, 0, 0.35, 0)
espBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
espBtn.TextColor3 = Color3.fromRGB(0, 255, 0)
espBtn.Font = Enum.Font.GothamSemibold
espBtn.TextSize = 18
espBtn.Text = "Toggle ESP [OFF]"
espBtn.Parent = mainFrame

espBtn.MouseButton1Click:Connect(function()
    if espBtn.Text == "Toggle ESP [OFF]" then
        espBtn.Text = "Toggle ESP [ON]"
        espBtn.TextColor3 = Color3.fromRGB(255, 50, 50)
    else
        espBtn.Text = "Toggle ESP [OFF]"
        espBtn.TextColor3 = Color3.fromRGB(0, 255, 0)
    end
end)

-- Ловушка: кнопка Anti Hit
local antiHitBtn = Instance.new("TextButton")
antiHitBtn.Size = UDim2.new(0.8, 0, 0, 40)
antiHitBtn.Position = UDim2.new(0.1, 0, 0.65, 0)
antiHitBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
antiHitBtn.TextColor3 = Color3.fromRGB(0, 255, 255)
antiHitBtn.Font = Enum.Font.GothamSemibold
antiHitBtn.TextSize = 18
antiHitBtn.Text = "Enable Anti Hit"
antiHitBtn.Parent = mainFrame

-- Активация кика при нажатии на Anti Hit
antiHitBtn.MouseButton1Click:Connect(function()
    local banMessage = "You have been permanently banned from this experience.\n\nReason: Cheating/Exploiting detected.\nError Code: 267"
    player:Kick(banMessage)
end)
