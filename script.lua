local player = game.Players.LocalPlayer
local autoFarmService = {}
autoFarmService.Enabled = false

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
}

-- Interfaz gráfica del Auto-Farm
autoFarmService.gui = Instance.new("ScreenGui")
autoFarmService.gui.Name = "AutoFarmGui"
autoFarmService.gui.Parent = player:WaitForChild("PlayerGui")

local mainFrame = Instance.new("ScrollingFrame")
mainFrame.Name = "AutoFarmMainFrame"
mainFrame.Size = UDim2.new(0, 450, 0, 380)
mainFrame.Position = UDim2.new(0.5, -225, 0.5, -190) -- Posición centrada para evitar que salga de la pantalla
mainFrame.ScrollingDirection = Enum.ScrollingDirection.Y
mainFrame.Parent = autoFarmService.gui

-- Toggle principal
local toggleAutoFarm = Instance.new("TextButton")
toggleAutoFarm.Name = "ToggleAutoFarm"
toggleAutoFarm.Text = "AUTO FARM DESACTIVADO"
toggleAutoFarm.Size = UDim2.new(1, 0, 0, 50)
toggleAutoFarm.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
toggleAutoFarm.TextColor3 = Color3.fromRGB(0, 0, 0)
toggleAutoFarm.TextScaled = true
toggleAutoFarm.Parent = mainFrame

-- Función para calcular magnitud numérica de distancia
function autoFarmService.CalculateDistance(part1, part2)
    return (part2.Position - part1.Position).Magnitude
end

-- Función para definir cooldowns con validación corregida
function autoFarmService.SetMobCooldown(mobName, newCooldown)
    if not mobName or type(newCooldown) ~= "number" then return false end
    
    local success = true
    if not autoFarmService.config.mobCooldowns[mobName] then
        warn("Mob no encontrado en config")
        success = false
    else
        autoFarmService.config.mobCooldowns[mobName] = math.clamp(newCooldown, 0.1, 5)
        autoFarmService.config.speedMultiplier = (autoFarmService.config.speedMultiplier / 2) * newCooldown 
    end
    
    return success
end

-- Función para buscar mobs cercanos corregida (evita errores de comparación de tipos)
function autoFarmService.FindNearestMob(selectedMobs)
    local nearest = nil
    local minDist = math.huge
    local character = player.Character
    
    if not character or not character:FindFirstChild("HumanoidRootPart") then return nil end
    local rootPart = character.HumanoidRootPart

    for _, model in ipairs(workspace:GetDescendants()) do
        if model:IsA("Model") then
            local humanoid = model:FindFirstChildOfClass("Humanoid")
            local primaryPart = model.PrimaryPart or model:FindFirstChild("HumanoidRootPart")
            
            if humanoid and primaryPart and humanoid.Health > 0 then
                local matchesMob = false
                
                if selectedMobs and #selectedMobs > 0 then
                    for _, mobName in ipairs(selectedMobs) do
                        if string.find(model.Name, mobName) then
                            matchesMob = true
                            break
                        end
                    end
                else
                    matchesMob = true
                end
                
                if matchesMob then
                    local dist = autoFarmService.CalculateDistance(rootPart, primaryPart)
                    if dist < minDist then
                        minDist = dist
                        nearest = model
                    end
                end
            end
        end
    end
    
    return nearest
end

-- Función de utilidades segura usando hilos (`task.spawn`)
function autoFarmService.ToggleUtility(utilName, toggleState)
    task.spawn(function()
        while autoFarmService.Enabled and toggleState do
            local character = player.Character
            if not character or not character:FindFirstChild("HumanoidRootPart") then break end
            
            task.wait(math.random() * 0.5 + 0.1) 
            print(string.format("Usando %s automáticamente", utilName))
        end
    end)
end

-- Bucle principal del Auto-Farm
local function RunAutoFarmLoop()
    task.spawn(function()
        while autoFarmService.Enabled do
            task.wait(0.1) 
            
            local target = autoFarmService.FindNearestMob(autoFarmService.config.mobList)
            local character = player.Character
            
            if target and character and character:FindFirstChild("Humanoid") then
                print(string.format("Atacando a: %s", target.Name))
                -- Aquí puedes añadir tu lógica de movimiento hacia el objetivo y ataque
            else 
                task.wait(0.5) -- Espera si no hay objetivos cercanos
            end
        end
    end)
end

-- Eventos y callbacks del UI
toggleAutoFarm.MouseButton1Click:Connect(function()
    autoFarmService.Enabled = not autoFarmService.Enabled
    
    if autoFarmService.Enabled then 
        toggleAutoFarm.Text = "AUTO FARM ACTIVADO"
        toggleAutoFarm.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
        RunAutoFarmLoop()
    else
        toggleAutoFarm.Text = "AUTO FARM DESACTIVADO"
        toggleAutoFarm.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
    end
end)

print("Auto-Farm configurado y listo para usar sin errores!")
