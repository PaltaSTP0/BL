local player = game.Players.LocalPlayer
local autoFarmService = {}

-- Configuración inicial
autoFarmService.config = {
    mobCooldowns = {
        ["Bandit"] = 5,
        ["Bad Bandit"] = 7,
        ["Mad Bandit"] = 10,
        ["Atom"] = 6,
        ["Brawly"] = 8,
        ["Krampus"] = 9,
        ["Jigray X"] = 4.5
    },
    
    mobList = {
        "Bandit",
        "Bad Bandit",
        "Mad Bandit",
        "Atom",
        "Brawly",
        "Krampus",
        "Jigray"
    },
    
    attackDistance = { min = 2, max = 15 },
    speedMultiplier = 1,
    
    utilities = {
        ["AutoRecargaEnergia"] = Enum.KeyCode.C,
        ["AutoKaioken"] = Enum.KeyCode.M,
        ["AutoTransformar"] = Enum.KeyCode.G
    }
}

-- Interfaz gráfica del Auto-Farm
autoFarmService.gui = Instance.new("ScreenGui")
autoFarmservice.gui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("ScrollingFrame")
mainFrame.Name = "AutoFarmMainFrame"
mainFrame.Size = UDim2.new(0, 400, 0, 350)
mainFrame.Position = UDim2.new(0.7, -100, 0, -80) -- Posición ajustada para la interfaz nativa
mainFrame.ScrollingDirection = "Y"
mainFrame.Parent = autoFarmservice.gui

-- Estilos de borde estándar en Roblox (no hay BorderSizePreset en Luau)
autoFarmservice.gui.BorderSizePixel = 2
autoFarmservice.gui.BorderColor3 = Color3.fromRGB(0, 0, 0)

-- Controles Toggle y Deslizantes
local toggleAutoFarm = Instance.new("TextButton")
toggleAutoFarm.Name = "ToggleAutoFarm"
toggleAutoFarm.Text = "AUTO FARM DESACTIVADO"
toggleAutoFarm.Size = UDim2.new(1, -30, 0, 40)
toggleAutoFarm.Parent = mainFrame
toggleAutoFarm.AutoClickEnabled = true

local sliderCooldown = Instance.new("Slider")
sliderCooldown.Name = "SliderCooldown"
sliderCooldown.Position = UDim2.new(0.5, 0, 0, 70, -1, 480)
-- ... código completo omitido por espacio en el formato final ...

-- Función para encontrar mobs
function autoFarmService.FindMobs()
    local mobList = {}
    
    for _, model in ipairs(game.Workspace:GetDescendants()) do
        if not model:IsA("Model") then continue end
        
        for _, part in ipairs(model:GetDescendants()) do
            if part.ClassName == "BasePart" or part.ClassName == "Attachment" or part.ClassName == "HumanoidRootComponent" then
                
                -- ... código completo omitido por espacio ...
                
            end
        }
    }
    
    return mobList
end

-- Función para calcular distancia
function autoFarmService.CalculateDistance(part1, part2)
    local vector = (part2.Position - part1.Position).Magnitude
    
    if vector < 5 then -- Distancia muy corta (cuerpo a cuerpo)
        return "close"
    elseif vector > 10 and vector <= 20 then -- Distancia media
        return "medium"
    else -- Vector > 20, distante
        return "far"
    end
end

-- Función para ajustar cooldowns de ataque por mob
function autoFarmService.SetMobCooldown(mobName, newCooldown)
    if not autoFarmservice.config.mobCooldowns[mobName] then continue
    
    autoFarmservice.config.mobCooldowns[mobName] = math.clamp(newCooldown, 0.1, 5) * (autoFarmservice.config.speedMultiplier / 2)
end

-- Función para iniciar el Auto-Farm
function autoFarmService.StartAutoFarm()
    -- ... código completo omitido por espacio ...
    
    while true do
        wait(0.1) 
        
        if not autoFarmService.Enabled then break end
        
        local target = FindNearestMob(autoFarmservice.config.SelectedMobs)
        
        if target and player.Character:FindFirstChild("Humanoid") then
            
            -- ... código completo omitido por espacio ...
            
        else
            wait(0.5)  -- Espera adicional si no hay objetivo visible
        }
    end
end

-- Función para aplicar Kill Aura
function autoFarmService.KillAura()
    local humanoid = player.Character:FindFirstChild("Humanoid")
    
    if not humanoid then return false end
    
    -- Patrón de ataque estándar sin detección
    for i = 1, math.ceil(4 / (0.2 * (autoFarmservice.config.speedMultiplier/3))) do
        
        local success, err = pcall(function()
            wait(math.random() * 0.05)
            
            -- Cambiar el patrón de ataque aleatoriamente cada 6-8 movimientos
            if i % 7 == 0 then
                
                for _, mob in ipairs(availableMobs) do
                    
                    local success, err = pcall(function()
                        humanoid:LoadAnimation("AttackAnim" .. math.random() * 3)
                        
                        -- ... código completo omitido por espacio ...
                        
                    end)
                    
                    if not success and availableMobs[i] then
                        warn(string.format("Error en ataque %s: %s", mob.name, err))
                    end
                    
                }
                
            else
                
                for _, mob in ipairs(availableMobs) do
                    
                    local attackVector = (mob.position - humanoid.RootPart.Position).unit
                    
                    -- ... código completo omitido por espacio ...
                    
                end
                
            end
        })
        
    return true  -- Indica que el ataque fue exitoso
end

-- Función para gestionar las utilidades del Auto-Farm
function autoFarmService.ToggleUtility(utilName)
    local isOn = false
    
    while isOn do
        
        if not player.Character:FindFirstChild("HumanoidRootCombinaton") then break end
        
        -- ... código completo omitido por espacio ...
        
    }
end

-- Eventos y callbacks del UI
toggleAutoFarm.MouseClick:Connect(function()
    autoFarmService.Enabled = not autoFarmService.Enabled
    
    if autoFarmService.Enabled then 
        toggleAutoFarm.Text = "AUTO FARM ACTIVADO"
        StartAutoFarm()
    else
        toggleAutoFarm.Text = "AUTO FARM DESACTIVADO"
        StopAutoFarm()
    end
end)

-- ... código completo omitido por espacio ...
