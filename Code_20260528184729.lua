--[[
    ========================================
    Old Cat Cheat - Loader v2.0
    作者：老猫
    日期：2026-05-28
    ========================================
]]

-- // ====================== 配置区 ====================== \\
local CONFIG = {
    SkinScriptUrl = "https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua",
    GeneralScriptUrl = "https://pastefy.app/2uwPck6l/raw"
}

-- // ====================== 核心服务 ====================== \\
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- 防止重复创建
if LocalPlayer.PlayerGui:FindFirstChild("LaomaoUI_Final") then
    LocalPlayer.PlayerGui.LaomaoUI_Final:Destroy()
end

-- // ====================== UI 框架 ====================== \\
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LaomaoUI_Final"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer.PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 450, 0, 300)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

-- 标题栏
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
TitleBar.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -80, 1, 0)
TitleLabel.Position = UDim2.new(0, 10, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "Old Cat Cheat"
TitleLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

-- // ===== 猫咪关闭按钮 ===== \\
local CloseButton = Instance.new("ImageButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -32, 0, 2)
CloseButton.BackgroundTransparency = 1
CloseButton.Parent = TitleBar

-- 加载猫咪图片（你的 GitHub 仓库里的 cat.png）
local ImageSuccess, ImageResult = pcall(function()
    CloseButton.Image = "https://raw.githubusercontent.com/qweasdtbb/qqGame/main/cat.png"
end)

if not ImageSuccess then
    CloseButton.Image = "rbxassetid://657041784"
    warn("猫咪图片加载失败，已使用默认图标")
end

CloseButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Tab 容器
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, 0, 0, 30)
TabFrame.Position = UDim2.new(0, 0, 0, 35)
TabFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
TabFrame.Parent = MainFrame

local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, 0, 1, -65)
ContentFrame.Position = UDim2.new(0, 0, 0, 65)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Tab 创建函数
local function CreateTab(name, index)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 110, 1, 0)
    btn.Position = UDim2.new(0, (index * 115), 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 80)
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 14
    btn.Parent = TabFrame
    return btn
end

-- // ====================== 功能模块 ====================== \\

-- 1. 主页
local HomeTab = CreateTab("Home", 0)
local HomeContent = Instance.new("Frame")
HomeContent.Size = UDim2.new(1, 0, 1, 0)
HomeContent.BackgroundTransparency = 1
HomeContent.Visible = true
HomeContent.Parent = ContentFrame

local NoticeLabel = Instance.new("TextLabel")
NoticeLabel.Size = UDim2.new(1, -20, 1, 0)
NoticeLabel.Position = UDim2.new(0, 10, 0, 0)
NoticeLabel.BackgroundTransparency = 1
NoticeLabel.TextColor3 = Color3.fromRGB(200, 255, 200)
NoticeLabel.Font = Enum.Font.SourceSans
NoticeLabel.TextSize = 14
NoticeLabel.TextWrapped = true
NoticeLabel.Text = string.format(
    "Announcement\nPlayer: %s\nUsername: %s\nInjector: Old Cat Cheat\nBeijing Time: %s",
    LocalPlayer.DisplayName,
    LocalPlayer.Name,
    os.date("%Y-%m-%d %H:%M:%S", os.time() + 8)
)
NoticeLabel.Parent = HomeContent

-- 2. 玩家功能（含开关）
local PlayerTab = CreateTab("Player", 1)
local PlayerContent = Instance.new("Frame")
PlayerContent.Size = UDim2.new(1, 0, 1, 0)
PlayerContent.BackgroundTransparency = 1
PlayerContent.Visible = false
PlayerContent.Parent = ContentFrame

local PlayerEnabled = false
local DefaultWalkSpeed = 16
local DefaultJumpPower = 50
local DefaultHipHeight = 2

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0.8, 0, 0, 40)
ToggleButton.Position = UDim2.new(0.1, 0, 0.05, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(120, 60, 60)
ToggleButton.Text = "Player: OFF"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Font = Enum.Font.SourceSansBold
ToggleButton.TextSize = 16
ToggleButton.Parent = PlayerContent

local function EnablePlayerFeatures(value)
    PlayerEnabled = value
    ToggleButton.Text = PlayerEnabled and "Player: ON" or "Player: OFF"
    ToggleButton.BackgroundColor3 = PlayerEnabled and Color3.fromRGB(60, 120, 60) or Color3.fromRGB(120, 60, 60)

    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        if PlayerEnabled then
            hum.WalkSpeed = tonumber(SpeedBox.Text) or DefaultWalkSpeed
            hum.JumpPower = tonumber(JumpBox.Text) or DefaultJumpPower
            hum.HipHeight = tonumber(HeightBox.Text) or DefaultHipHeight
        else
            hum.WalkSpeed = DefaultWalkSpeed
            hum.JumpPower = DefaultJumpPower
            hum.HipHeight = DefaultHipHeight
        end
    end
end

ToggleButton.MouseButton1Click:Connect(function()
    EnablePlayerFeatures(not PlayerEnabled)
end)

local SpeedBox = Instance.new("TextBox")
SpeedBox.Size = UDim2.new(0.8, 0, 0, 35)
SpeedBox.Position = UDim2.new(0.1, 0, 0.2, 0)
SpeedBox.PlaceholderText = "WalkSpeed"
SpeedBox.Parent = PlayerContent

local JumpBox = Instance.new("TextBox")
JumpBox.Size = UDim2.new(0.8, 0, 0, 35)
JumpBox.Position = UDim2.new(0.1, 0, 0.35, 0)
JumpBox.PlaceholderText = "JumpPower"
JumpBox.Parent = PlayerContent

local HeightBox = Instance.new("TextBox")
HeightBox.Size = UDim2.new(0.8, 0, 0, 35)
HeightBox.Position = UDim2.new(0.1, 0, 0.5, 0)
HeightBox.PlaceholderText = "HipHeight"
HeightBox.Parent = PlayerContent

local FlyButton = Instance.new("TextButton")
FlyButton.Size = UDim2.new(0.8, 0, 0, 40)
FlyButton.Position = UDim2.new(0.1, 0, 0.7, 0)
FlyButton.Text = "Fly"
FlyButton.BackgroundColor3 = Color3.fromRGB(80, 80, 200)
FlyButton.Parent = PlayerContent

FlyButton.MouseButton1Click:Connect(function()
    loadstring("\108\111\97\100\115\116\114\105\110\103\40\103\97\109\101\58\72\116\116\112\71\101\116\40\40\39\104\116\116\112\115\58\47\47\103\105\115\116\46\103\105\116\104\117\98\117\115\101\114\99\111\110\116\101\110\116\46\99\111\109\47\109\101\111\122\111\110\101\89\84\47\98\102\48\51\55\100\102\102\57\102\48\97\55\48\48\49\55\51\48\52\100\100\100\54\55\102\100\99\100\51\55\48\47\114\97\119\47\101\49\52\101\55\52\102\52\50\53\98\48\54\48\100\102\53\50\51\51\52\51\99\102\51\48\98\55\56\55\48\55\52\101\98\51\99\53\100\50\47\97\114\99\101\117\115\37\50\53\50\48\120\37\50\53\50\48\102\108\121\37\50\53\50\48\50\37\50\53\50\48\111\98\102\108\117\99\97\116\111\114\39\41\44\116\114\117\101\41\41\40\41\10\10")()
end)

-- 3. 皮脚本
local SkinTab = CreateTab("Skin", 2)
local SkinContent = Instance.new("Frame")
SkinContent.Size = UDim2.new(1, 0, 1, 0)
SkinContent.BackgroundTransparency = 1
SkinContent.Visible = false
SkinContent.Parent = ContentFrame

local SkinButton = Instance.new("TextButton")
SkinButton.Size = UDim2.new(0.8, 0, 0, 45)
SkinButton.Position = UDim2.new(0.1, 0, 0.3, 0)
SkinButton.BackgroundColor3 = Color3.fromRGB(100, 60, 150)
SkinButton.Text = "Execute Skin Script"
SkinButton.Parent = SkinContent

SkinButton.MouseButton1Click:Connect(function()
    getgenv().XiaoPi = "皮脚本QQ群894995244"
    loadstring(game:HttpGet(CONFIG.SkinScriptUrl, true))()
end)

-- 4. 通用脚本
local GeneralTab = CreateTab("General", 3)
local GeneralContent = Instance.new("Frame")
GeneralContent.Size = UDim2.new(1, 0, 1, 0)
GeneralContent.BackgroundTransparency = 1
GeneralContent.Visible = false
GeneralContent.Parent = ContentFrame

local GeneralButton = Instance.new("TextButton")
GeneralButton.Size = UDim2.new(0.8, 0, 0, 45)
GeneralButton.Position = UDim2.new(0.1, 0, 0.3, 0)
GeneralButton.BackgroundColor3 = Color3.fromRGB(60, 100, 120)
GeneralButton.Text = "Open Script Center"
GeneralButton.Parent = GeneralContent

GeneralButton.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet(CONFIG.GeneralScriptUrl, true))()
end)

-- // ====================== Tab 切换逻辑 ====================== \\
HomeTab.MouseButton1Click:Connect(function()
    HomeContent.Visible = true
    PlayerContent.Visible = false
    SkinContent.Visible = false
    GeneralContent.Visible = false
end)

PlayerTab.MouseButton1Click:Connect(function()
    HomeContent.Visible = false
    PlayerContent.Visible = true
    SkinContent.Visible = false
    GeneralContent.Visible = false
end)

SkinTab.MouseButton1Click:Connect(function()
    HomeContent.Visible = false
    PlayerContent.Visible = false
    SkinContent.Visible = true
    GeneralContent.Visible = false
end)

GeneralTab.MouseButton1Click:Connect(function()
    HomeContent.Visible = false
    PlayerContent.Visible = false
    SkinContent.Visible = false
    GeneralContent.Visible = true
end)

print("Old Cat Cheat v2.0 Loaded Successfully!")
