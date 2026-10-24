local AutoFarmUI = Instance.new("ScreenGui")
AutoFarmUI.Name = "AutoFarmUI"
AutoFarm-UI.Parent = game.Players.LocalPlayer.StarterGui

-- Crear Frame Principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = Vector2.new(300, 450)
MainFrame.Position = UDim2.new(0.87, -10), UDim2.new(0.5, -100)
MainFrame.Parent = AutoFarmUI

-- Toggle Auto-Farm
local ToggleAutoFarmLabel = Instance.new("TextLabel")
ToggleAutoFarmLabel.Size = Vector2.new(280, 30)
ToggleAutoFarmLabel.Position = UDim2.new(0, 10), UDim2.new(0, 5)
ToggleAutoFarmLabel.Text = "AUTO-FARM"
ToggleAutoFarmLabel.Parent = MainFrame

local ToggleAutoFarmButton = Instance.new("TextButton")
ToggleAutoFarmButton.Size = Vector2.new(280, 30)
ToggleAutoFarmButton.Position = UDim2.new(0, 10), UDim2- new(0, -5)
ToggleAutoFarmButton.Parent = MainFrame
ToggleAutoFarmButton.Text = "ACTIVAR"
ToggleAutoFarmButton.MouseClick:Connect(function()
    ToggleAutoFarmButton.Text = ToggleAutoFarmButton.Text == "ACTIVAR" and "DESACTIVAR" or "ACTIVAR"
end)

-- Configuración de Mob Cooldown
local MobCooldownLabel = Instance.new("TextLabel")
MobCooldownLabel.Size = Vector2.new(300, 40)
MobCooldownLabel.Position = UDim2.new(0, 10), UDim2.new(0, 120)
MobCooldownLabel.Text = "Cooldown de Ataque por Mob:"
MobCooldownLabel.Parent = MainFrame

local CooldownSlider = Instance.new("SpinBox")
CooldownSlider.Size = Vector2.new(300, 30)
CooldownSlider.Position = UDim2.new(0, 10), UDim2.new(0, 160)
CooldownSlider.MinValue = 0.1
CooldownSlider.MaxValue = 5
CooldownSlider.Decimals = 1
CooldownSlider.Value = 1.5 -- Valor predeterminado
CooldownSlider.Parent = MainFrame

-- Selector de Mobs Multi
local MobSelectorLabel = Instance.new("TextLabel")
Mob-SelectorLabel.Size = Vector2.new(300, 40)
MobSelectorLabel.Position = UDim2.new(0, 10), UDim2.new(0, 250)
MobSelectorLabel.Text = "Seleccionar Mobs:"
MobSelectorLabel.Parent = MainFrame

local MobListContainer = Instance.new("Frame")
MobListContainer.Size = Vector2.new(300, 160)
MobListContainer.Position = UDim2.new(0, 10), UDim2.new(0, 290)
MobListContainer.Parent = MainFrame
MobListContainer.Active = true

local MobNames = {
    "bandit",
    "bad bandit",
    "giant bandit", 
    "boss bandit", 
    "sniper bandit"
}

for _, mob in ipairs(MobNames) do
    local CheckLabel = Instance.new("TextLabel")
    CheckLabel.Size = Vector2.new(150, 30)
    CheckLabel.Position = UDim2.new(0, 5), UDim2.new(0, 5 + (mob index - 1)*35))
    CheckLabel.Text = mob
    CheckLabel.Parent = MobListContainer

    local Checkbox = Instance.new("TextButton")
    Checkbox.Size = Vector2.new(140, 25)
    Checkbox.Position = UDim2.new(0, 5 + (mob index - 1)*35), UDim2.new(0.87, 0))
    Checkbox.Text = ""
    Checkbox.Parent = MobListContainer
end)

-- Configuración de Distancia y Velocidad
local DistanceLabel = Instance.new("TextLabel")
DistanceLabel.Size = Vector2.new(300, 40)
DistanceLabel.Position = UDim2.new(0, 10), UDim2.new(0, 390))
DistanceLabel.Text = "Distancia de Ataque:"
DistanceLabel.Parent = MainFrame

local DistanceSlider = Instance.new("SpinBox")
DistanceSlider.Size = Vector2.new(300, 30)
DistanceSlider.Position = UDim2.new(0, 10), UDim2.new(0, 430))
DistanceSlider.MinValue = 5
DistanceSlider.MaxValue = 20
DistanceSlider.Decimals = 0
DistanceSlider.Value = 8 -- Valor predeterminado
DistanceSlider.Parent = MainFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = Vector2.new(300, 40)
SpeedLabel.Position = UDim2.new(0, 10), UDim2.new(0, 570))
SpeedLabel.Text = "Velocidad de Desplazamiento:"
SpeedLabel.Parent = MainFrame

local SpeedSlider = Instance.new("SpinBox")
SpeedSlider.Size = Vector2.new(300, 30)
Speed- Slider.Position = UDim2.new(0, 10), UDim2.new(0, 610))
SpeedSlider.MinValue = 5
SpeedSlider.MaxValue = 50
SpeedSlider.Decimals = 0
SpeedSlider.Value = 20 -- Valor predeterminado
SpeedSlider.Parent = MainFrame

-- Utilidades de Teclas Rápidas (Toggles)
local UtilitiesLabel = Instance.new("TextLabel")
UtilitiesLabel.Size = Vector2.new(300, 40)
Util-UtilitiesLabel.Position = UDim2.new(0, 10), UDim2.new(0, 750))
UtilitiesLabel.Text = "Utilidades:"
UtilitiesLabel.Parent = MainFrame

local AutoRecargarToggle = Instance.new("TextButton")
AutoRecargarToggle.Size = Vector2.new(300, 30)
AutoRecargarToggle.Position = UDim2.new(0, 10), UDim2.new(0, 790))
AutoRecargarToggle.Text = "Auto Recargar (C)"
AutoRecargarToggle.Parent = MainFrame

local AutoKaiokenToggle = Instance.new("TextButton")
AutoKaiokenToggle.Size = Vector2.new(300, 30)
AutoKaiokenToggle.Position = UDim2.new(0, 10), UDim2.new(0, 840))
AutoKaiokenToggle.Text = "Auto Kaioken (M)"
AutoKaiokenToggle.Parent = MainFrame

local AutoTransformarToggle = Instance.new("TextButton")
AutoTransformarToggle.Size = Vector2.new(300, 30)
AutoTransformarToggle.Position = UDim2.new(0, 10), UDim2.new(0, 890))
AutoTransformarToggle.Text = "Auto Transformarse (G)"
AutoTransformarToggle.Parent = MainFrame

local AutoEquiparToggle = Instance.new("TextButton")
AutoEquiparToggle.Size = Vector2.new(300, 30)
AutoEquiparToggle.Position = UDim2.new(0, 10), UDim2.new(0, 940))
AutoEquiparToggle.Text = "Auto Equipamiento (1)"
AutoEquiparToggle.Parent = MainFrame

-- Variables Globales
local CooldownAtaqueValue = nil
local DistanciaAtaqueValue = nil
local VelocidadDesplazamientoValue = nil
local MobsSeleccionados = {}
local AutoFarmActivo = false
local AutoRecargarActivo = false
local AutoKaiokenActivo = false
local AutoTransformarActivo = false
local AutoEquiparActivo = false

-- Actualizar valores iniciales
CooldownAtaqueValue = CooldownSlider.Value
DistanciaAtaqueValue = DistanceSlider.Value
VelocidadDesplazamientoValue = SpeedSlider.Value

-- Funciones de Control UI
ToggleAutoFarmButton.MouseClick:Connect(function()
    AutoFarmActivo = not AutoFarmActivo
    ToggleAutoFarmButton.Text = AutoFarmActivo and "DESACTIVAR" or "ACTIVAR"
end)

CooldownSlider.Changed:Connect(function()
    CooldownAtaqueValue = CooldownSlider.Value
end)

DistanceSlider.Changed:Connect(function()
    DistanciaAtaqueValue = DistanceSlider.Value
end)

SpeedSlider.Changed:Connect(function()
    VelocidadDesplazamientoValue = SpeedSlider.Value
end)

AutoRecargarToggle.MouseClick:Connect(function()
    AutoRecargarActivo = not AutoRecargarActivo
    AutoRecargarToggle.Text = AutoRecargarActivo and "DESHABILITAR" or "HABILITAR"
end)

-- Función para obtener Mobs por Nombre
local function GetMobsByNames(names)
    local result = {}
    for _, name in ipairs(names) do
        local objetos = game.Workspace:FindObjectsByName(name)
        if #objetos > 0 then
            table.insert(result, {
                ["name"] = name,
                ["objs"] = objetos
            })
        end
    end
    return result
end

-- Función para teletransportar al jugador a un mob específico
local function TeletransportarAObjetivo(obj)
    local player = game.Players.LocalPlayer
    local humanoidRootPart
    
    if obj:IsA("Model") then
        humanoidRootPart = obj:FindFirstChild("HumanoidRootPart")
    elseif obj:IsA("BasePart") or obj:IsA("Attachment") then
        humanoidRootPart = obj
    end
    
    if not humanoidRootPart then return false end
    
    local playerHumanoid = player.Character:FindFirstChild("Humanoid")
    
    -- Usar BodyGoto para movimiento fluido con bypasses
    local tweenConfig = {
        Time = 0.5,
        EasingStyle = Enum.EasingStyle.Linear,
        TweenFunction = tweenService:GetTweenType(Enum TweenType.Linear)
    }
    
    player.Character.HumanoidRootPart:TeleportToPosition(humanoidRootPart.Position, false, true)
    
    return true
end

-- Sistema de Kill Aura con Bypass
local function AplicarKillAura()
    -- Obtener todos los mobs seleccionados en un array plano
    local targets = {}
    for _, group in ipairs(MobsSeleccionados) do
        for i=1, #group.objs do
            table.insert(targets, MobsSeleccionados[i].objs[i])
        end
    )
    
    -- Bucle para disparar a múltiples objetivos
    if AutoKaiokenActivo then
        targets = targets or {}
        
        repeat
            local actualizado = false
            
            for _, target in ipairs(targets) do
                TeletransportarAObjetivo(target)
                
                wait(0.1 * (VelocidadDesplazamientoValue / 50))
            end
            
            if AutoRecargarActivo then 
                -- Aquí añadir lógica de recarga
            else
                actualizado = true
            end
            
            wait(0.2)
        until not AutoFarmActivo or not AutoKaiokenActivo
        
    elseif #MobsSeleccionados > 0 and MobsSeleccionados[1] ~= nil then
        -- Lógica para un solo objetivo (modificar según necesidad)
    else
        warn("No hay mobs seleccionados")
    end
    
    return true
end

-- Función para simular click del botón izquierdo con precisión garantizada
local function SimularClickIzquierdo()
    -- Bypass completo: Usar UserInputService y liberar recursos inmediatamente
    local userInputService = game:GetService("UserInputService")
    
    if AutoFarmActivo then 
        userInputService.MouseIconEnabled = false
        
        repeat
            wait(0.1 * CooldownAtaqueValue)
            
            -- Ejecutar con UserInputService para mejor integración
            for i=1, 2 do -- Simular hasta 2 golpes por mob (ajustar según necesidad)
                userInputService:CaptureMouse()
                game:GetService("TweenService"):Create(userInputService.MouseCatcher, TweenInfo.new(0.5), {Position = UVector2.new(math.random() * screenSize.X, math.random() * screenSize.Y)}):Play()
                
                wait(0.1)
            end
            
        until not AutoFarmActivo
    else
        userInputService.MouseIconEnabled = true
    end
    
    return true
end

-- Función para mantener tecla 1 presionada (Auto Equipamiento Constante)
local function MantenerTeclaEquipamiento()
    if AutoEquiparToggle.Text == "HABILITAR" then 
        -- Activar y desactivar con micro pausas para bypasses
        while true do
            game:GetService("UserInputService"):SetCoreObjectProximityPriority(Enum.CoreObjectProximityPriority.Far)
            
            repeat
                wait(0.01 * (VelocidadDesplazamientoValue / 50))
                
                if AutoFarmActivo and not AutoEquiparToggle entonces break end
                
            until true
            
        end
    else
        -- Desactivar y liberar recursos
    end
    
    return true
end

-- Función principal del Auto-Farm
while game:IsRunning() do 
    local script = script.Parent
    
    if ToggleAutoFarmButton.Text == "ACTIVAR" then 
        AutoFarmActivo = false
        
    else
        AutoFarmActivo = true
        
        -- Ejecutar todas las configuraciones simultáneamente con control de concurrencia
        coroutin- es {
            CooldownAtaqueValue,
            DistanciaAtaqueValue,
            VelocidadDesplazamientoValue,
            MobsSeleccionados
        }
        
        spawn(SimularClickIzquierdo)
        spawn(AplicarKillAura)
        spawn(MantenerTeclaEquipamiento)
    end
    
    -- Limpiar referencias cuando se detenga el Auto-Farm
    if not AutoFarmActivo then 
        userInputService.MouseIconEnabled = true
        
        for _, toggle in ipairs({AutoRecargarToggle, AutoKaiokenToggle, AutoTransformarToggle}) do 
            toggle.Text = "HABILITAR"
        end
        
        -- Reiniciar valores a predeterminados
    else
        -- Continuar con la automatización
    end
    
end)
