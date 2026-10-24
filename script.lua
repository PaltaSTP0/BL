-- Import necessary services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local VirtualInputManager = game:GetService("VirtualInputManager")

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

-- Lista original en formato array para el Dropdown de Rayfield
local ListaMobsDropdown = {
    "Bandit", "Mad Bandit", "Evil Thug", "Tigreal Tribe", "Gorilla Tribe",
    "Jinbu", "Jinbu Hyper", "Ultimate Jinbu", "Super Jinbu", "Jinbu Minion",
    "Puriza", "Puriza Minion", "Droid 17", "Droid 17 Minion", "Droid 18", "Droid 18 Minion",
    "Coolest", "Coolest Minion", "Baby Veggy", "BabyVeggy Minion",
    "Black Karrot", "BlackKarrot Minion", "Brawly", "Brawly Minion",
    "Jigray", "Jigray Minion", "Atom", "Atom Minion", "Destroyer", "Zaja"
}

-- Function to create Rayfield UI elements
local function InitializeRayfieldUI(Library)
    -- Main Window
    local Window = Library:CreateWindow({
       Name = 'Control Panel | RPG Action',
       LoadingTitle = 'Roblox GUI',
       Subtitle = 'by CrezVr',
       ConfigurationSaving = { Enabled = false }
    })

    -- Tabs
    local TabMain = Window:CreateTab('Main')
    local TabEvent = Window:CreateTab('Event')
    local TabDungeons = Window:CreateTab('Dungeons')
    local TabSupport = Window:CreateTab('Support')

    ---------------------------------------------------------
    -- PESTAÑA "EVENT"
    ---------------------------------------------------------

    -- Farm Token (Prioridad Absoluta)
    TabEvent:CreateToggle({
       Name = "Farm Token (Prioridad Absoluta)",
       CurrentValue = false,
       Callback = function(Value)
          if Value then
             task.spawn(function()
                while _G_AutoFarm and Value do
                   pcall(function()
                      for _, obj in pairs(game.Workspace:GetDescendants()) do
                         if obj:IsA("ProximityPrompt") and string.match(obj.Name, "Token", 1, true) then
                            local parentPart = obj.Parent
                            if parentPart and (parentPart:IsA("BasePart") or parentPart:IsA("Model")) then
                               local Player = Players.LocalPlayer
                               local Character = Player.Character or Player.CharacterAdded:Wait()
                               local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart')

                               _G_AutoFarm = false

                               local targetPos = parentPart:IsA("Model") and parentPart:GetPivot().Position or parentPart.Position
                               local tween = TweenService:Create(HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetPos)})
                               tween:Play()
                               tween.Completed:Wait()

                               fireproximityprompt(obj)
                               task.wait(1)
                               _G_AutoFarm = true
                            end
                         end
                      end
                   end)
                   task.wait(CooldownTime)
                end
             end)
          end
       end,
    })

    -- Auto Quest Wish Token
    TabEvent:CreateToggle({
       Name = "Auto Quest Wish Token",
       CurrentValue = false,
       Callback = function(Value)
          if Value then
             task.spawn(function()
                while _G_AutoFarm and Value do
                   pcall(function()
                      local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
                      if PlayerGui then
                         local RewardsFrame = PlayerGui:FindFirstChild("BoardQuests") or PlayerGui:FindFirstChild("SpecialQuestBoard")
                         if RewardsFrame and RewardsFrame:FindFirstChild("QuestRewards") then
                            for _, reward in pairs(RewardsFrame.QuestRewards:GetDescendants()) do
                               if reward:IsA("TextLabel") and string.match(reward.Text, "Wish Token", 1, true) then
                                  local QuestButton = reward.Parent:FindFirstChild("AcceptQuest")
                                  if QuestButton then
                                     VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                                     task.wait(0.1)
                                     VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                                  end

                                  local enemyName = string.match(reward.Text, "(%w+)")
                                  if enemyName and ListaMobsExactos[enemyName] then
                                     SelectedMobs[enemyName] = true
                                  end
                               end
                            end
                         end
                      end
                   end)
                   task.wait(CooldownTime)
                end
             end)
          end
       end,
    })

    -- Auto Refresh Board
    TabEvent:CreateToggle({
       Name = "Auto Refresh Board",
       CurrentValue = false,
       Callback = function(Value)
          if Value then
             task.spawn(function()
                while _G_AutoFarm and Value do
                   pcall(function()
                      local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui")
                      if PlayerGui and PlayerGui:FindFirstChild("Board") then
                         local RefreshButton = PlayerGui.Board:FindFirstChild("RefreshButton", true)
                         if RefreshButton and RefreshButton:IsA("TextButton") and RefreshButton.Text == "0s" then
                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                            task.wait(0.1)
                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                         end
                      end
                   end)
                   task.wait(1)
                end
             end)
          end
       end,
    })

    ---------------------------------------------------------
    -- PESTAÑA "MAIN"
    ---------------------------------------------------------

    TabMain:CreateToggle({
       Name = "Interruptor Principal de Auto Farm",
       CurrentValue = false,
       Callback = function(Value)
           _G_AutoFarm = Value
       end,
    })

    TabMain:CreateDropdown({
       Name = "Seleccionar Mobs (Múltiple)",
       Options = ListaMobsDropdown,
       CurrentOption = {},
       Multiple = true,
       Callback = function(Option)
          SelectedMobs = {}
          if type(Option) == "table" then
              for _, mobName in pairs(Option) do
                  SelectedMobs[mobName] = true
              end
          end
       end,
    })

    TabMain:CreateSlider({
       Name = "Radio de Farmeo (Hasta 300 Studs)",
       Range = {10, 300},
       Increment = 5,
       CurrentValue = 50,
       Callback = function(Value)
          FarmRadius = Value
          if VisualizerPart and VisualizerPart.Parent then
             VisualizerPart.Size = Vector3.new(1, Value * 2, Value * 2)
          end
       end,
    })

    TabMain:CreateToggle({
       Name = "Mostrar Visualizador de Studs (Radio)",
       CurrentValue = false,
       Callback = function(Value)
          _G_StudsVisualizer = Value
          if _G_StudsVisualizer then
             if not VisualizerPart then
                VisualizerPart = Instance.new("Part")
                VisualizerPart.Shape = Enum.PartType.Cylinder
                VisualizerPart.Anchored = true
                VisualizerPart.CanCollide = false
                VisualizerPart.Material = Enum.Material.Neon
                VisualizerPart.Transparency = 0.2
                VisualizerPart.Color = VisualizerColor
                VisualizerPart.Size = Vector3.new(1, FarmRadius * 2, FarmRadius * 2)
                VisualizerPart.CFrame = CFrame.new() * CFrame.Angles(0, 0, math.rad(90))
                VisualizerPart.Parent = workspace
             end
          else
             if VisualizerPart then
                VisualizerPart:Destroy()
                VisualizerPart = nil
             end
          end
       end,
    })

    TabMain:CreateColorPicker({
       Name = "Color del Visualizador de Studs",
       Color = Color3.fromRGB(0, 255, 255),
       Callback = function(Value)
          VisualizerColor = Value
          if VisualizerPart then
             VisualizerPart.Color = VisualizerColor
          end
       end,
    })

    TabMain:CreateSection("Selección de Habilidades de Lanza")

    local SelectedSkills = {}
    local skillKeys = {"E", "Y", "F", "Z", "T", "X"}
    for _, key in ipairs(skillKeys) do
        TabMain:CreateToggle({
            Name = "Usar Habilidad [" .. key .. "]",
            CurrentValue = false,
            Callback = function(Value)
               SelectedSkills[key] = Value
            end,
        })
    end

    TabMain:CreateToggle({
       Name = "Auto-Loot (Recoger Ítems / Tecla E)",
       CurrentValue = false,
       Callback = function(Value)
          _G_AutoLoot = Value
       end,
    })

    TabMain:CreateSlider({
       Name = "Cooldown entre Acciones (Segundos)",
       Range = {0.1, 2.0},
       Increment = 0.1,
       CurrentValue = 0.5,
       Callback = function(Value)
          CooldownTime = Value
       end,
    })

    -- Auto Farm Individual & Auto Punch
    TabMain:CreateButton({
        Name = "Start Auto Farm",
        Callback = function()
            task.spawn(function()
                while true do
                    task.wait(0.1)
                    pcall(function()
                        if _G_AutoFarm then
                            local Player = Players.LocalPlayer
                            local Character = Player.Character or Player.CharacterAdded:Wait()
                            local HumanoidRootPart = Character:WaitForChild('HumanoidRootPart')

                            for _, model in pairs(game.Workspace:GetChildren()) do
                                if model:IsA("Model") and model:FindFirstChildOfClass("Humanoid") and model:FindFirstChild("PrimaryPart") then
                                    local humanoid = model.Humanoid
                                    if humanoid.Health > 0 and SelectedMobs[model.Name] then
                                        local targetPos = Vector3.new(model.PrimaryPart.Position.X, HumanoidRootPart.Position.Y, model.PrimaryPart.Position.Z)
                                        local tween = TweenService:Create(HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetPos)})
                                        tween:Play()
                                        tween.Completed:Wait()

                                        if SelectedSkills["E"] then
                                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                                            task.wait(0.1)
                                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                                        end
                                        task.wait(CooldownTime)
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
        end,
    })

    -- Kill Aura Multi-Objetivo
    TabMain:CreateButton({
        Name = "Start Kill Aura",
        Callback = function()
            task.spawn(function()
                while true do
                    task.wait(0.1)
                    pcall(function()
                        if _G_AutoFarm then
                            local Player = Players.LocalPlayer
                            local Character = Player.Character or Player.CharacterAdded:Wait()
                            let HumanoidRootPart = Character:WaitForChild('HumanoidRootPart') -- Wait, let's keep local

                            for _, model in pairs(game.Workspace:GetChildren()) do
                                if model:IsA("Model") and model:FindFirstChildOfClass("Humanoid") and model:FindFirstChild("PrimaryPart") then
                                    local humanoid = model.Humanoid
                                    if humanoid.Health > 0 and SelectedMobs[model.Name] then
                                        local distance = (HumanoidRootPart.Position - model.PrimaryPart.Position).magnitude
                                        if distance <= FarmRadius then
                                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                                            task.wait(0.1)
                                            VirtualInputManager:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                                            task.wait(CooldownTime)
                                        end
                                    end
                                end
                            end
                        end
                    end)
                end
            end)
        end,
    })
end

-- Load Rayfield UI safely from GitHub source
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()
end)

if not success or not Rayfield then
    warn("No se pudo cargar Rayfield UI desde GitHub.")
    return
end

InitializeRayfieldUI(Rayfield)
