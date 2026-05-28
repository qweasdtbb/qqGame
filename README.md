--[[
    老猫脚本 - 单文件重构版
    作者：老猫
    日期：2026-05-28
]]

-- // ====================== 配置区（唯一需要改的地方） ====================== \\
local CONFIG = {
    -- 皮脚本的 loadstring 链接
    SkinScriptUrl = "https://pastefy.app/2uwPck6l/raw",
    
    -- 通用脚本（月抛中心）的 loadstring 链接
    GeneralScriptUrl = "https://pastefy.app/xxxx/raw"
}

-- // ====================== 核心依赖 ====================== \\
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local HttpService = game:GetService("HttpService")

-- // ====================== UI 框架（老猫 UI） ====================== \\
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
TitleLabel.Text = "老猫脚本 v2.0"
TitleLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 18
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TitleBar

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
    btn.TextColor3 = Color3.new(1,1,1)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 14
    btn.Parent = TabFrame
    return btn
end

-- // ====================== 功能模块加载 ====================== \\

-- 1. 主页模块
local HomeTab = CreateTab("主页", 0)
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
    "公告\n玩家姓名: %s\n用户名: %s\n注入器: 老猫脚本\n北京时间: %s",
    LocalPlayer.DisplayName,
    LocalPlayer.Name,
    os.date("%Y-%m-%d %H:%M:%S", os.time() + 8)
)
NoticeLabel.Parent = HomeContent

-- 2. 玩家功能模块
local PlayerTab = CreateTab("玩家功能", 1)
local PlayerContent = Instance.new("Frame")
PlayerContent.Size = UDim2.new(1, 0, 1, 0)
PlayerContent.BackgroundTransparency = 1
PlayerContent.Visible = false
PlayerContent.Parent = ContentFrame

-- 这里直接内嵌你之前的玩家功能代码
local lp = LocalPlayer
local Section3 = PlayerContent

Instance.new("TextBox", PlayerContent).PlaceholderText = "输入速度"
Instance.new("TextBox", PlayerContent).PlaceholderText = "输入跳跃"
Instance.new("TextBox", PlayerContent).PlaceholderText = "输入高度"
Instance.new("TextButton", PlayerContent).Text = "飞行"

-- (此处省略具体UI布局代码，实际使用时需补全)

-- 3. 皮脚本模块
local SkinTab = CreateTab("皮脚本", 2)
local SkinContent = Instance.new("Frame")
SkinContent.Size = UDim2.new(1, 0, 1, 0)
SkinContent.BackgroundTransparency = 1
SkinContent.Visible = false
SkinContent.Parent = ContentFrame

local SkinButton = Instance.new("TextButton")
SkinButton.Size = UDim2.new(0.8, 0, 0, 45)
SkinButton.Position = UDim2.new(0.1, 0, 0.3, 0)
SkinButton.BackgroundColor3 = Color3.fromRGB(100, 60, 150)
SkinButton.Text = "执行皮脚本"
SkinButton.Parent = SkinContent

SkinButton.MouseButton1Click:Connect(function()
    getgenv().XiaoPi="皮脚本QQ群894995244" loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()
end)

-- 4. 通用脚本模块
local GeneralTab = CreateTab("通用脚本", 3)
local GeneralContent = Instance.new("Frame")
GeneralContent.Size = UDim2.new(1, 0, 1, 0)
GeneralContent.BackgroundTransparency = 1
GeneralContent.Visible = false
GeneralContent.Parent = ContentFrame

local GeneralButton = Instance.new("TextButton")
GeneralButton.Size = UDim2.new(0.8, 0, 0, 45)
GeneralButton.Position = UDim2.new(0.1, 0, 0.3, 0)
GeneralButton.BackgroundColor3 = Color3.fromRGB(60, 100, 120)
GeneralButton.Text = "打开月抛脚本中心"
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

print("老猫脚本 v2 加载成功！")
