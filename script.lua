-- language: Lua, file: dlz10_premium.lua
-- Roblox чит-скрипт для Delta Executor (Android).
-- Функции: Fly, ESP игроков, Aimbot, Noclip, Speed, Jump, Teleport, Infinite Jump,
--          Fullbright, Xray, Auto-Click, скрытие UI, сворачивание, анимации.
-- Автор: dlz10. Без подлянок — весь код открыт.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local pg = player:WaitForChild("PlayerGui")

-- ==================== СОСТОЯНИЕ ====================
local S = {
    fly = false,
    flySpeed = 80,
    esp = false,
    espTeam = false,
    aimbot = false,
    noclip = false,
    speed = false,
    speedValue = 50,
    jump = false,
    jumpValue = 100,
    infJump = false,
    fullbright = false,
    xray = false,
    autoClick = false,
    infJumpConn = nil,
    espBoxes = {},
    espLabels = {},
    flyBV = nil,
    flyBG = nil,
    uiHidden = false,
    uiMinimized = false,
}

local function notify(title, text)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = title or "dlz10",
            Text = text or "",
            Duration = 2,
        })
    end)
end

-- ==================== UI ====================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "dlz10_Premium"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = pg

-- ================ ОСНОВНОЕ ОКНО ================
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 460, 0, 520)
main.Position = UDim2.new(0.5, -230, 0.5, -260)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
main.BorderSizePixel = 0
main.Active = true
main.Draggable = true
main.Parent = screenGui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = main

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(170, 0, 255)
mainStroke.Thickness = 2
mainStroke.Parent = main

-- анимация пульсации обводки
task.spawn(function()
    while main.Parent do
        TweenService:Create(mainStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine), 
            {Color = Color3.fromRGB(0, 200, 255)}):Play()
        task.wait(1.5)
        TweenService:Create(mainStroke, TweenInfo.new(1.5, Enum.EasingStyle.Sine), 
            {Color = Color3.fromRGB(170, 0, 255)}):Play()
        task.wait(1.5)
    end
end)

-- ================ ЗАГОЛОВОК ================
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 55)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 33)
titleBar.BorderSizePixel = 0
titleBar.Parent = main

local titleCorner = Instance.new("UICorner")
titleCorner.CornerRadius = UDim.new(0, 14)
titleCorner.Parent = titleBar

local titleHide = Instance.new("Frame")
titleHide.Size = UDim2.new(1, 0, 0.5, 0)
titleHide.Position = UDim2.new(0, 0, 0.5, 0)
titleHide.BackgroundColor3 = Color3.fromRGB(25, 25, 33)
titleHide.BorderSizePixel = 0
titleHide.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -120, 1, 0)
title.Position = UDim2.new(0, 60, 0, 0)
title.BackgroundTransparency = 1
title.Text = "dlz10 PREMIUM"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBlack
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local titleStroke = Instance.new("UIStroke")
titleStroke.Color = Color3.fromRGB(0, 200, 255)
titleStroke.Thickness = 1
titleStroke.Transparency = 0.3
titleStroke.Parent = title

-- аватарка-логотип
local logo = Instance.new("Frame")
logo.Size = UDim2.new(0, 40, 0, 40)
logo.Position = UDim2.new(0, 10, 0.5, -20)
logo.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
logo.BorderSizePixel = 0
logo.Parent = titleBar
local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(1, 0)
logoCorner.Parent = logo

local logoText = Instance.new("TextLabel")
logoText.Size = UDim2.new(1, 0, 1, 0)
logoText.BackgroundTransparency = 1
logoText.Text = "d10"
logoText.TextColor3 = Color3.fromRGB(255, 255, 255)
logoText.Font = Enum.Font.GothamBlack
logoText.TextSize = 16
logoText.Parent = logo

-- кнопка свернуть
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 30, 0, 30)
minBtn.Position = UDim2.new(1, -70, 0.5, -15)
minBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
minBtn.Text = "—"
minBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 18
minBtn.BorderSizePixel = 0
minBtn.Parent = titleBar
local minCorner = Instance.new("UICorner")
minCorner.CornerRadius = UDim.new(0, 8)
minCorner.Parent = minBtn

-- кнопка скрыть
local hideBtn = Instance.new("TextButton")
hideBtn.Size = UDim2.new(0, 30, 0, 30)
hideBtn.Position = UDim2.new(1, -35, 0.5, -15)
hideBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
hideBtn.Text = "X"
hideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
hideBtn.Font = Enum.Font.GothamBold
hideBtn.TextSize = 18
hideBtn.BorderSizePixel = 0
hideBtn.Parent = titleBar
local hideCorner = Instance.new("UICorner")
hideCorner.CornerRadius = UDim.new(0, 8)
hideCorner.Parent = hideBtn

-- ================ КНОПКА ПОКАЗА (когда скрыто) ================
local showBtn = Instance.new("TextButton")
showBtn.Size = UDim2.new(0, 60, 0, 60)
showBtn.Position = UDim2.new(0, 20, 0, 100)
showBtn.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
showBtn.Text = "d10"
showBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
showBtn.Font = Enum.Font.GothamBlack
showBtn.TextSize = 18
showBtn.BorderSizePixel = 0
showBtn.Visible = false
showBtn.Active = true
showBtn.Draggable = true
showBtn.Parent = screenGui
local showCorner = Instance.new("UICorner")
showCorner.CornerRadius = UDim.new(1, 0)
showCorner.Parent = showBtn
local showStroke = Instance.new("UIStroke")
showStroke.Color = Color3.fromRGB(0, 200, 255)
showStroke.Thickness = 2
showStroke.Parent = showBtn

-- ================ ТАБЫ ================
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, -20, 0, 40)
tabBar.Position = UDim2.new(0, 10, 0, 65)
tabBar.BackgroundColor3 = Color3.fromRGB(22, 22, 30)
tabBar.BorderSizePixel = 0
tabBar.Parent = main
local tabBarCorner = Instance.new("UICorner")
tabBarCorner.CornerRadius = UDim.new(0, 10)
tabBarCorner.Parent = tabBar

local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -20, 1, -125)
contentArea.Position = UDim2.new(0, 10, 0, 115)
contentArea.BackgroundTransparency = 1
contentArea.Parent = main

local pages = {}
local tabBtns = {}
local currentTab = "main"

local tabs = {
    {"Главное", "main"},
    {"Бой",     "combat"},
    {"Мир",     "world"},
    {"Прочее",  "misc"},
}

for i, tab in ipairs(tabs) do
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1 / #tabs, -4, 1, -6)
    b.Position = UDim2.new((i - 1) / #tabs, 2, 0, 3)
    b.BackgroundColor3 = (i == 1) and Color3.fromRGB(170, 0, 255) or Color3.fromRGB(35, 35, 45)
    b.Text = tab[1]
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.BorderSizePixel = 0
    b.Parent = tabBar
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = b
    tabBtns[tab[2]] = b

    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.ScrollBarImageColor3 = Color3.fromRGB(170, 0, 255)
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    page.Visible = (i == 1)
    page.Parent = contentArea

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page

    pages[tab[2]] = page
end

local function switchTab(name)
    for k, b in pairs(tabBtns) do
        b.BackgroundColor3 = (k == name) and Color3.fromRGB(170, 0, 255) or Color3.fromRGB(35, 35, 45)
    end
    for k, p in pairs(pages) do
        p.Visible = (k == name)
    end
    currentTab = name
end

for k, b in pairs(tabBtns) do
    b.MouseButton1Click:Connect(function() switchTab(k) end)
end

-- ================ ФАБРИКА КНОПОК ================
local function makeToggle(page, labelText, stateKey, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 42)
    btn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.BorderSizePixel = 0
    btn.Parent = page
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = btn
    local st = Instance.new("UIStroke")
    st.Color = Color3.fromRGB(70, 70, 90)
    st.Thickness = 1.5
    st.Parent = btn

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0.7, 0, 1, 0)
    lbl.Position = UDim2.new(0, 12, 0, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = Color3.fromRGB(230, 230, 230)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = btn

    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(0.25, 0, 1, 0)
    status.Position = UDim2.new(0.72, 0, 0, 0)
    status.BackgroundTransparency = 1
    status.Text = "OFF"
    status.TextColor3 = Color3.fromRGB(150, 150, 150)
    status.Font = Enum.Font.GothamBlack
    status.TextSize = 13
    status.Parent = btn

    local on = false

    local function update()
        if on then
            status.Text = "ON"
            status.TextColor3 = Color3.fromRGB(0, 255, 150)
            st.Color = Color3.fromRGB(0, 255, 150)
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 50, 40)}):Play()
        else
            status.Text = "OFF"
            status.TextColor3 = Color3.fromRGB(150, 150, 150)
            st.Color = Color3.fromRGB(70, 70, 90)
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(28, 28, 38)}):Play()
        end
    end

    btn.MouseButton1Click:Connect(function()
        on = not on
        update()
        pcall(callback, on)
    end)

    return btn, function() return on end, function(v) on = v; update() end
end

local function makeSlider(page, labelText, minV, maxV, defV, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 60)
    frame.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    frame.BorderSizePixel = 0
    frame.Parent = page
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 8)
    c.Parent = frame
    local st = Instance.new("UIStroke")
    st.Color = Color3.fromRGB(70, 70, 90)
    st.Thickness = 1.5
    st.Parent = frame

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -20, 0, 22)
    lbl.Position = UDim2.new(0, 12, 0, 5)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText .. " : " .. defV
    lbl.TextColor3 = Color3.fromRGB(230, 230, 230)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 13
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -24, 0, 10)
    bar.Position = UDim2.new(0, 12, 0, 35)
    bar.BackgroundColor3 = Color3.fromRGB(45, 45, 58)
    bar.BorderSizePixel = 0
    bar.Parent = frame
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = bar

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((defV - minV) / (maxV - minV), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(170, 0, 255)
    fill.BorderSizePixel = 0
    fill.Parent = bar
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill

    local dragging = false
    local function setVal(x)
        local rel = math.clamp((x - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        local v = math.floor(minV + (maxV - minV) * rel)
        fill.Size = UDim2.new(rel, 0, 1, 0)
        lbl.Text = labelText .. " : " .. v
        pcall(callback, v)
    end

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            setVal(input.Position.X)
        end
    end)
    bar.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch) then
            setVal(input.Position.X)
        end
    end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
end

-- ==================== ГЛАВНОЕ ====================
makeToggle(pages.main, "Fly", "fly", function(on)
    S.fly = on
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if on then
        S.flyBV = Instance.new("BodyVelocity")
        S.flyBV.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        S.flyBV.Velocity = Vector3.zero
        S.flyBV.Parent = hrp
        S.flyBG = Instance.new("BodyGyro")
        S.flyBG.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        S.flyBG.Parent = hrp
        notify("dlz10", "Fly ON")
    else
        if S.flyBV then S.flyBV:Destroy(); S.flyBV = nil end
        if S.flyBG then S.flyBG:Destroy(); S.flyBG = nil end
        notify("dlz10", "Fly OFF")
    end
end)

makeSlider(pages.main, "Скорость полёта", 20, 500, 80, function(v) S.flySpeed = v end)

makeToggle(pages.main, "Infinite Jump", "infJump", function(on)
    S.infJump = on
    if on then
        S.infJumpConn = UIS.JumpRequest:Connect(function()
            local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
        end)
    else
        if S.infJumpConn then S.infJumpConn:Disconnect(); S.infJumpConn = nil end
    end
end)

makeToggle(pages.main, "Speed Hack", "speed", function(on) S.speed = on end)
makeSlider(pages.main, "Скорость бега", 16, 200, 50, function(v) S.speedValue = v end)

makeToggle(pages.main, "Jump Power", "jump", function(on)
    S.jump = on
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then hum.JumpPower = on and S.jumpValue or 50 end
end)
makeSlider(pages.main, "Сила прыжка", 50, 500, 100, function(v)
    S.jumpValue = v
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum and S.jump then hum.JumpPower = v end
end)

-- ==================== БОЙ ====================
makeToggle(pages.combat, "ESP игроков", "esp", function(on)
    S.esp = on
    if not on then
        for _, box in pairs(S.espBoxes) do if box then box:Destroy() end end
        for _, lb in pairs(S.espLabels) do if lb then lb:Destroy() end end
        S.espBoxes = {}
        S.espLabels = {}
    end
end)

makeToggle(pages.combat, "Aimbot", "aimbot", function(on)
    S.aimbot = on
end)

makeToggle(pages.combat, "Auto Click", "autoClick", function(on)
    S.autoClick = on
end)

-- ==================== МИР ====================
makeToggle(pages.world, "Noclip", "noclip", function(on)
    S.noclip = on
end)

makeToggle(pages.world, "Fullbright", "fullbright", function(on)
    S.fullbright = on
    if on then
        Lighting.Brightness = 3
        Lighting.ClockTime = 14
        Lighting.FogEnd = 1e6
        Lighting.GlobalShadows = false
    else
        Lighting.Brightness = 2
        Lighting.GlobalShadows = true
    end
end)

makeToggle(pages.world, "X-Ray (стены прозрачные)", "xray", function(on)
    S.xray = on
    if on then
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") and obj.Material ~= Enum.Material.ForceField then
                obj.LocalTransparencyModifier = 0.5
            end
        end
    else
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.LocalTransparencyModifier = 1
            end
        end
    end
end)

-- ==================== ПРОЧЕЕ ====================
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(1, -10, 0, 42)
tpBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
tpBtn.Text = "Teleport к случайному игроку"
tpBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
tpBtn.Font = Enum.Font.GothamBold
tpBtn.TextSize = 14
tpBtn.BorderSizePixel = 0
tpBtn.Parent = pages.misc
local tpC = Instance.new("UICorner"); tpC.CornerRadius = UDim.new(0, 8); tpC.Parent = tpBtn
local tpS = Instance.new("UIStroke"); tpS.Color = Color3.fromRGB(70, 70, 90); tpS.Thickness = 1.5; tpS.Parent = tpBtn

tpBtn.MouseButton1Click:Connect(function()
    local targets = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            local hrp = p.Character:FindFirstChild("HumanoidRootPart")
            if hrp then table.insert(targets, hrp) end
        end
    end
    if #targets > 0 then
        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = targets[math.random(1, #targets)].CFrame * CFrame.new(0, 3, 0)
            notify("dlz10", "Телепорт выполнен")
        end
    end
end)

local resetBtn = Instance.new("TextButton")
resetBtn.Size = UDim2.new(1, -10, 0, 42)
resetBtn.BackgroundColor3 = Color3.fromRGB(60, 30, 30)
resetBtn.Text = "Сбросить всё"
resetBtn.TextColor3 = Color3.fromRGB(255, 200, 200)
resetBtn.Font = Enum.Font.GothamBold
resetBtn.TextSize = 14
resetBtn.BorderSizePixel = 0
resetBtn.Parent = pages.misc
local rc = Instance.new("UICorner"); rc.CornerRadius = UDim.new(0, 8); rc.Parent = resetBtn
local rs = Instance.new("UIStroke"); rs.Color = Color3.fromRGB(180, 40, 40); rs.Thickness = 1.5; rs.Parent = resetBtn

resetBtn.MouseButton1Click:Connect(function()
    S.fly = false; S.esp = false; S.aimbot = false; S.noclip = false
    S.speed = false; S.jump = false; S.infJump = false; S.fullbright = false
    S.xray = false; S.autoClick = false
    if S.flyBV then S.flyBV:Destroy(); S.flyBV = nil end
    if S.flyBG then S.flyBG:Destroy(); S.flyBG = nil end
    if S.infJumpConn then S.infJumpConn:Disconnect(); S.infJumpConn = nil end
    for _, box in pairs(S.espBoxes) do if box then box:Destroy() end end
    for _, lb in pairs(S.espLabels) do if lb then lb:Destroy() end end
    S.espBoxes = {}; S.espLabels = {}
    notify("dlz10", "Всё сброшено")
end)

-- ==================== СКРЫТИЕ / СВОРАЧИВАНИЕ ====================
local normalSize = UDim2.new(0, 460, 0, 520)
local minSize = UDim2.new(0, 460, 0, 55)

minBtn.MouseButton1Click:Connect(function()
    S.uiMinimized = not S.uiMinimized
    if S.uiMinimized then
        TweenService:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Size = minSize}):Play()
        for _, p in pairs(pages) do p.Visible = false end
        tabBar.Visible = false
        minBtn.Text = "+"
    else
        TweenService:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Size = normalSize}):Play()
        tabBar.Visible = true
        switchTab(currentTab)
        minBtn.Text = "—"
    end
end)

hideBtn.MouseButton1Click:Connect(function()
    main.Visible = false
    showBtn.Visible = true
    notify("dlz10", "UI скрыт. Нажми d10 чтобы показать")
end)

showBtn.MouseButton1Click:Connect(function()
    main.Visible = true
    showBtn.Visible = false
end)

-- кнопка на клавиатуре RightShift — toggle скрытия
UIS.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        if main.Visible then
            main.Visible = false
            showBtn.Visible = true
        else
            main.Visible = true
            showBtn.Visible = false
        end
    end
end)

-- ==================== ЛОГИКА В КАДРЕ ====================
RunService.RenderStepped:Connect(function()
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return end

    -- FLY
    if S.fly and S.flyBV then
        local cam = workspace.CurrentCamera
        local move = Vector3.zero
        local md = hum.MoveDirection
        if md.Magnitude > 0 then
            move += cam.CFrame:VectorToWorldSpace(md)
        end
        if UIS:IsKeyDown(Enum.KeyCode.Space) then move += Vector3.new(0, 1, 0) end
        if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then move -= Vector3.new(0, 1, 0) end
        if move.Magnitude > 0 then move = move.Unit end
        S.flyBV.Velocity = move * S.flySpeed
        S.flyBG.CFrame = cam.CFrame
    end

    -- SPEED
    if S.speed then
        hum.WalkSpeed = S.speedValue
    end

    -- JUMP
    if S.jump then
        hum.JumpPower = S.jumpValue
        hum.UseJumpPower = true
    end

    -- NOCLIP
    if S.noclip then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end

    -- AUTO CLICK
    if S.autoClick then
        pcall(function()
            local tool = char:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
        end)
    end

    -- ESP
    if S.esp then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local phrp = p.Character:FindFirstChild("HumanoidRootPart")
                if phrp then
                    if not S.espBoxes[p] or not S.espBoxes[p].Parent then
                        local hl = Instance.new("Highlight")
                        hl.FillColor = Color3.fromRGB(255, 40, 40)
                        hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                        hl.FillTransparency = 0.5
                        hl.OutlineTransparency = 0
                        hl.Adornee = p.Character
                        hl.Parent = p.Character
                        S.espBoxes[p] = hl
                    end
                end
            end
        end
        -- очистка мёртвых
        for p, hl in pairs(S.espBoxes) do
            if not p.Character or not p.Character.Parent then
                if hl then hl:Destroy() end
                S.espBoxes[p] = nil
            end
        end
    end

    -- AIMBOT
    if S.aimbot then
        local cam = workspace.CurrentCamera
        local closest, dist = nil, math.huge
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local phrp = p.Character:FindFirstChild("HumanoidRootPart")
                if phrp then
                    local d = (phrp.Position - hrp.Position).Magnitude
                    if d < dist and d < 500 then
                        dist = d
                        closest = phrp
                    end
                end
            end
        end
        if closest then
            cam.CFrame = CFrame.new(cam.CFrame.Position, closest.Position)
        end
    end
end)

-- ==================== СБРОС ПРИ РЕСПАВНЕ ====================
player.CharacterAdded:Connect(function()
    task.wait(1)
    if S.fly and S.flyBV then
        -- пересоздать body-объекты
        S.fly = false
    end
    for _, hl in pairs(S.espBoxes) do if hl then hl:Destroy() end end
    S.espBoxes = {}
end)

-- ==================== СТАРТ ====================
notify("dlz10 PREMIUM", "Загружено. Нажми X чтобы скрыть, — чтобы свернуть, RightShift чтобы toggle")
