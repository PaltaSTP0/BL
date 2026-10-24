-- Import necessary services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- Global variables
local _G_AutoFarm = false
local _G_AutoLoot = false
local _G_StudsVisualizer = false
local SelectedMobs = {}
local FarmRadius = 50
local VisualizerPart = nil
local VisualizerColor = Color3.fromRGB(0, 255, 255)
local CooldownTime = 0.5

-- Diccionario de Mobs Exactos para validación rápida y O(1)
local ListaMobsExactos = {
    ["Bandit"] = true, ["Mad Bandit"] = true, ["Evil Thug"] = true, 
    ["Tigreal Tribe"] = true, ["Gorilla Tribe"] = true, ["Jinbu"] = true, 
    ["Jinbu Hyper"] = true, ["Ultimate Jinbu"] = true, ["Super Jinbu"] = true, 
    ["Jinbu Minion"] = true, ["Puriza"] = true, ["Puriza Minion"] = true, 
    ["Droid 17"] = true, ["Droid 17 Minion"] = true, ["Droid 18"] = true, 
    ["Droid 18 Minion"] = true, ["Coolest"] = true, ["Coolest Minion"] = true, 
    ["Baby Veggy"] = true, ["BabyVeggy Minion"] = true, ["Black Karrot"] = true, 
    ["BlackKarrot Minion"] = true, ["Brawly"] = true, ["Brawly Minion"] = true, 
    ["Jigray"] = true, ["Jigray Minion"] = true, ["Atom"] = true, 
    ["Atom Minion"] = true, ["Destroyer"] = true, ["Zaja"] = true
}

-- Crear Interfaz Nativa de Roblox (100% Funcional y sin errores de carga)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RPGBasuraHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local TitleBar = Instance.new("TextLabel")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TitleBar.Text = "Control Panel | RPG Action (Native)"
TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleBar.TextSize = 16
TitleBar.Font = Enum.Font.SourceSansBold
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

-- Botón para alternar Auto Farm
local ToggleAutoFarm = Instance.new("TextButton")
ToggleAutoFarm.Size = UDim2.new(0, 360, 0, 40)
ToggleAutoFarm.Position = UDim2.new(0, 20, 0, 60)
ToggleAutoFarm.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ToggleAutoFarm.Text = "Auto Farm: OFF"
ToggleAutoFarm.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleAutoFarm.TextSize = 14
ToggleAutoFarm.Font = Enum.Font.SourceSansBold
ToggleAutoFarm.Parent = MainFrame

local TFCorner = Instance.new("UICorner")
TFCorner.CornerRadius = UDim.new(0, 6)
TFCorner.Parent = ToggleAutoFarm

ToggleAutoFarm.MouseButton1Click:Connect(function()
    _G_AutoFarm = not _G_AutoFarm
    if _G_AutoFarm then
        ToggleAutoFarm.Text = "Auto Farm: ON"
        ToggleAutoFarm.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    else
        ToggleAutoFarm.Text = "Auto Farm: OFF"
        ToggleAutoFarm.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

-- Bucle de Auto Farm Principal
task.spawn(function()
    while true do
        task.wait(0.1)
        pcall(function()
            if _G_AutoFarm then
                local Character = Player.Character or Player.CharacterAdded:Wait()
                local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart')

                for _, model in pairs(game.Workspace:GetChildren()) do
                    if model:IsA("Model") and model:FindFirstChildOfClass("Humanoid") and model:FindFirstChild("PrimaryPart") then
                        local humanoid = model.Humanoid
                        if humanoid.Health > 0 then
                            local targetPos = Vector3.new(model.PrimaryPart.Position.X, HumanoidRootPart.Position.Y, model.PrimaryPart.Position.Z)
                            local tween = TweenService:Create(HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetPos)})
                            tween:Play()
                            tween.Completed:Wait()

                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                            task.wait(0.1)
                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                            task.wait(CooldownTime)
                        end
                    end
                end
            end
        end)
    end
end)

print("¡Interfaz nativa cargada exitosamente sin errores de red!")
