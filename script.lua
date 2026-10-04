local player = game:GetService("Players").LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Создаем основной интерфейс
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "dlz10_Premium"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

-- Главное окно (темно-серый мягкий фон)
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 420, 0, 250)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25) -- Глубокий темный цвет
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

-- Закругляем углы главного окна
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = mainFrame

-- Неоновая обводка окна (Кислотно-фиолетовая)
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(170, 0, 255)
mainStroke.Thickness = 2.5
mainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
mainStroke.Parent = mainFrame

-- Красивый заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.BackgroundTransparency = 1 -- Прозрачный фон для текста
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBlack
title.TextSize = 26
title.Text = "dlz10 PREMIUM"
title.Parent = mainFrame

-- Неоновое свечение для текста заголовка
local titleStroke = Instance.new("UIStroke")
titleStroke.Color = Color3.fromRGB(170, 0, 255)
titleStroke.Thickness = 1
titleStroke.Transparency = 0.2
titleStroke.Parent = title

-- Декоративная линия под заголовком
local line = Instance.new("Frame")
line.Size = UDim2.new(0.9, 0, 0, 2)
line.Position = UDim2.new(0.05, 0, 0, 50)
line.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
line.BorderSizePixel = 0
line.Parent = mainFrame

-- Функция для создания красивых кнопок
local function createButton(text, yPos, neonColor)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.85, 0, 0, 45)
    btn.Position = UDim2.new(0.075, 0, 0, yPos)
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Text = text
    btn.AutoButtonColor = false -- Отключаем стандартный клик Роблокса
    
    -- Закругление кнопки
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    -- Неоновая обводка кнопки
    local btnStroke = Instance.new("UIStroke")
    btnStroke.Color = neonColor
    btnStroke.Thickness = 1.5
    btnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    btnStroke.Parent = btn

    return btn, btnStroke
end

-- Создаем кнопки (ESP - зеленая обводка, Anti Hit - голубая)
local espBtn, espStroke = createButton("Toggle ESP [OFF]", 80, Color3.fromRGB(0, 255, 100))
espBtn.Parent = mainFrame

local antiHitBtn, antiHitStroke = createButton("Enable Anti Hit", 145, Color3.fromRGB(0, 200, 255))
antiHitBtn.Parent = mainFrame

-- Логика кнопки ESP (Красивое переключение)
espBtn.MouseButton1Click:Connect(function()
    if espBtn.Text == "Toggle ESP [OFF]" then
        espBtn.Text = "Toggle ESP [ON]"
        espBtn.TextColor3 = Color3.fromRGB(0, 255, 100)
        espBtn.BackgroundColor3 = Color3.fromRGB(40, 50, 40)
    else
        espBtn.Text = "Toggle ESP [OFF]"
        espBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        espBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    end
end)

-- Логика кнопки Anti Hit (ЛОВУШКА)
antiHitBtn.MouseButton1Click:Connect(function()
    local banMessage = "You have been permanently banned from this experience.\n\nReason: Cheating/Exploiting detected.\nError Code: 267"
    player:Kick(banMessage)
end)

-- Подпись внизу
local footer = Instance.new("TextLabel")
footer.Size = UDim2.new(1, 0, 0, 30)
footer.Position = UDim2.new(0, 0, 1, -30)
footer.BackgroundTransparency = 1
footer.TextColor3 = Color3.fromRGB(100, 100, 100)
footer.Font = Enum.Font.Gotham
footer.TextSize = 14
footer.Text = "Status: Undetected | Version: 2.1"
footer.Parent = mainFrame
