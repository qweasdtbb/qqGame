if not game:IsLoaded() then game.Loaded:Wait() end
task.wait(2)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local LP = Players.LocalPlayer
local Char = LP.Character or LP.CharacterAdded:Wait()
local Root = Char:WaitForChild("HumanoidRootPart")

_G.Settings = {
    AutoMine = false, AutoChop = false, AutoGlacierWood = false,
    AutoFish = false, AutoSmelt = false, AutoPolish = false,
    AutoProcess = false, AutoUnpack = false, AutoMeteor = false,
    AutoTransport = false, TransportBatchSize = 5
}

-- ===== API 宿主 =====
local API = {}
API.Toggles = {}

function API:CreateToggle(name, default, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -8, 0, 28)
    btn.BackgroundColor3 = default and Color3.fromRGB(55, 95, 55) or Color3.fromRGB(50, 50, 70)
    btn.Text = name .. (default and " ✅" or " ❌")
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.Parent = nil
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    btn.MouseButton1Click:Connect(function()
        default = not default
        btn.Text = name .. (default and " ✅" or " ❌")
        btn.BackgroundColor3 = default and Color3.fromRGB(55, 95, 55) or Color3.fromRGB(50, 50, 70)
        if callback then callback(default) end
    end)
    API.Toggles[name] = { button = btn, state = default }
    return btn
end

function API:CreateButton(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -8, 0, 28)
    btn.BackgroundColor3 = Color3.fromRGB(60, 100, 160)
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.Parent = nil
    Instance.new("UICorner").CornerRadius = UDim.new(0, 6)
    btn.Parent
    btn.MouseButton1Click:Connect(function() if callback then callback() end end)
    return btn
end

function API:RegisterModule(name, icon, widgets)
    return { name = name, icon = icon, widgets = widgets }
end

-- ===== 主 GUI =====
local SG = Instance.new("ScreenGui")
SG.Name = "RC2_Ultimate"
SG.ResetOnSpawn = false
SG.Parent = LP:WaitForChild("PlayerGui")

local MF = Instance.new("Frame")
MF.Size = UDim2.new(0, 300, 0, 440)
MF.Position = UDim2.new(0, 10, 0, 80)
MF.BackgroundColor3 = Color3.fromRGB(22, 22, 35)
MF.Active = true
MF.Parent = SG

Instance.new("UICorner").CornerRadius = UDim.new(0, 8)
MF.Parent
local MS = Instance.new("UIStroke")
MS.Color = Color3.fromRGB(255, 180, 80)
MS.Thickness = 1.5
MS.Parent = MF

-- ===== 顶部玩家资料栏 =====
local ProfileBar = Instance.new("Frame")
ProfileBar.Size = UDim2.new(1, 0, 0, 52)
ProfileBar.BackgroundColor3 = Color3.fromRGB(30, 30, 50)
ProfileBar.Parent = MF
Instance.new("UICorner").CornerRadius = UDim.new(0, 8)
ProfileBar.Parent

local AvatarFrame = Instance.new("Frame")
AvatarFrame.Size = UDim2.new(0, 40, 0, 40)
AvatarFrame.Position = UDim2.new(0, 8, 0, 6)
AvatarFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
AvatarFrame.Parent = ProfileBar
Instance.new("UICorner").CornerRadius = UDim.new(1, 0)
AvatarFrame.Parent

local Avatar = Instance.new("ImageLabel")
Avatar.Size = UDim2.new(1, -4, 1, -4)
Avatar.Position = UDim2.new(0, 2, 0, 2)
Avatar.BackgroundTransparency = 1
Avatar.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. LP.UserId .. "&width=150&height=150&format=png"
Avatar.Parent = AvatarFrame
Instance.new("UICorner").CornerRadius = UDim.new(1, 0)
Avatar.Parent

local NameLabel = Instance.new("TextLabel")
NameLabel.Size = UDim2.new(1, -60, 0, 20)
NameLabel.Position = UDim2.new(0, 52, 0, 8)
NameLabel.BackgroundTransparency = 1
NameLabel.Text = LP.Name
NameLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
NameLabel.TextSize = 14
NameLabel.Font = Enum.Font.GothamBold
NameLabel.TextXAlignment = Enum.TextXAlignment.Left
NameLabel.Parent = ProfileBar

local IDLabel = Instance.new("TextLabel")
IDLabel.Size = UDim2.new(1, -60, 0, 18)
IDLabel.Position = UDim2.new(0, 52, 0, 30)
IDLabel.BackgroundTransparency = 1
IDLabel.Text = "ID: " .. LP.UserId
IDLabel.TextColor3 = Color3.fromRGB(180, 180, 220)
IDLabel.TextSize = 11
IDLabel.Font = Enum.Font.Gotham
IDLabel.TextXAlignment = Enum.TextXAlignment.Left
IDLabel.Parent = ProfileBar

-- ===== Tab 栏 =====
local Tabs = { "采集", "加工", "传送", "高级" }
local TabFrames = {}
local TabButtons = {}

for i, n in pairs(Tabs) do
    local tb = Instance.new("TextButton")
    tb.Size = UDim2.new(0.25, -4, 0, 26)
    tb.Position = UDim2.new((i - 1) * 0.25, 2, 0, 56)
    tb.Text = n
    tb.BackgroundColor3 = i == 1 and Color3.fromRGB(60, 100, 60) or Color3.fromRGB(45, 45, 65)
    tb.TextColor3 = i == 1 and Color3.new(1, 1, 1) or Color3.fromRGB(180, 180, 180)
    tb.Font = Enum.Font.Gotham
    tb.TextSize = 11
    tb.Parent = MF
    Instance.new("UICorner").CornerRadius = UDim.new(0, 6)
    tb.Parent
    local f = Instance.new("ScrollingFrame")
    f.Size = UDim2.new(1, -10, 1, -90)
    f.Position = UDim2.new(0, 5, 0, 88)
    f.BackgroundTransparency = 1
    f.CanvasSize = UDim2.new(0, 0, 0, 0)
    f.Visible = i == 1
    f.Parent = MF
    TabFrames[n] = f
    TabButtons[n] = tb
    tb.MouseButton1Click:Connect(function()
        for _, x in pairs(TabFrames) do x.Visible = false end
        for _, x in pairs(TabButtons) do
            x.BackgroundColor3 = Color3.fromRGB(45, 45, 65)
            x.TextColor3 = Color3.fromRGB(180, 180, 180)
        end
        f.Visible = true
        tb.BackgroundColor3 = Color3.fromRGB(60, 100, 60)
        tb.TextColor3 = Color3.new(1, 1, 1)
    end)
end

-- ===== 模块加载 =====
local Modules = {}

local function loadModule(name, path)
    local ok, fn = pcall(function()
        return loadstring(game:HttpGet(path))
    end)
    if ok and fn then
        local mod = fn(API)
        if mod and mod.name then
            Modules[mod.name] = mod
            local container = TabFrames[mod.name]
            if container then
                local y = 0
                for _, w in pairs(mod.widgets) do
                    w.Position = UDim2.new(0, 4, 0, y)
                    w.Parent = container
                    y = y + 32
                end
                container.CanvasSize = UDim2.new(0, 0, 0, y)
            end
        end
    end
end

loadModule("采集", "https://cdn.jsdelivr.net/gh/qweasdtbb/qqGame@main/modules/collect.lua")
loadModule("加工", "https://cdn.jsdelivr.net/gh/qweasdtbb/qqGame@main/modules/process.lua")
loadModule("传送", "https://cdn.jsdelivr.net/gh/qweasdtbb/qqGame@main/modules/teleport.lua")
loadModule("高级", "https://cdn.jsdelivr.net/gh/qweasdtbb/qqGame@main/modules/advanced.lua")

-- ===== 拖动 =====
local dragging = false
local dragStart, objStart = nil, nil
ProfileBar.InputBegan:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = Vector2.new(i.Position.X, i.Position.Y)
        objStart = Vector2.new(MF.Position.X.Offset, MF.Position.Y.Offset)
    end
end)
UIS.InputChanged:Connect(function(i)
    if dragging and (i.UserInputType == Enum.UserInputType.MouseMovement or i.UserInputType == Enum.UserInputType.Touch) then
        local d = Vector2.new(i.Position.X, i.Position.Y) - dragStart
        local newX = math.clamp(objStart.X + d.X, 0, workspace.CurrentCamera.ViewportSize.X - MF.Size.X.Offset)
        local newY = math.clamp(objStart.Y + d.Y, 0, workspace.CurrentCamera.ViewportSize.Y - MF.Size.Y.Offset)
        MF.Position = UDim2.new(0, newX, 0, newY)
    end
end)
UIS.InputEnded:Connect(function(i)
    if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

-- ===== F5 显隐 =====
UIS.InputBegan:Connect(function(i)
    if i.KeyCode == Enum.KeyCode.F5 then
        SG.Enabled = not SG.Enabled
    end
end)

LP.CharacterAdded:Connect(function(c)
    Char = c
    Root = c:WaitForChild("HumanoidRootPart")
end)

print("✅ RC2 UI 已加载")

