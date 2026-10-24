local AutoFarmUI = Instance.new("ScreenGui")
AutoFarmUI.Name = "AutoFarmUI"
AutoFarmUI.Parent = game.Players.LocalPlayer.StarterGui

-- Crear Frame Principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = Vector2.new(300, 650)
MainFrame.Position = UDim2.new(0.87, -10), UDim2.new(0.5, -200)
MainFrame.Parent = AutoFarmUI

-- Función para obtener el tamaño de la pantalla
local function GetScreenSize()
    local UISize = Vector2.new(
        game:GetService("GuiService"):GetPhysicalScreenResolution().X,
        game:GetService("GuiService"):GetPhysicalScreenResolution().Y
    )
    return UDim2.new(0, 300), UDim2.new(0.5, -150)
end

-- Función para actualizar las coordenadas de los elementos UI cuando cambia la pantalla
local function UpdateUIPositions()
    MainFrame.Size = Vector2.new(300, 650)
    MainFrame.Position = GetScreenSize()
end

game:GetService("GuiService").PhysicalScreenResolutionChanged:Connect(function()
    UpdateUIPositions()
end)

-- Crear los elementos de la interfaz gráfica
local ToggleAutoFarmLabel = Instance.new("TextLabel")
ToggleAutoFarmLabel.Size = Vector2.new(300, 40)
ToggleAutoFarmLabel.Position = UDim2.new(0, 15), UDim2.new(0, 10)
ToggleAutoFarmLabel.Text = "AUTO-FARM"
ToggleAutoFarmLabel.Font = Enum.Font.SourceSans
ToggleAutoFarmLabel.TextColor3 = Color3.new(1, 1, 1)
ToggleAutoFarmLabel.Parent = MainFrame

local ToggleAutoFarmButton = Instance.new("TextButton")
ToggleAutoFarmButton.Size = Vector2.new(300, 40)
ToggleAutoFarmButton.Position = UDim2.new(0, 15), UDim2.new(0, 60)
ToggleAutoFarmButton.Text = "ACTIVAR"
ToggleAutoFarmButton.Font = Enum.Font.SourceSans
ToggleAutoFarmLabel.Parent = MainFrame

-- Configuración de Mob Cooldown
local CooldownLabel = Instance.new("TextLabel")
CooldownLabel.Size = Vector2.new(300, 40)
CooldownLabel.Position = UDim2.new(0, 15), UDim2.new(0, 160)
CooldownLabel.Text = "Cooldown de Ataque por Mob:"
CooldownLabel.Font = Enum.Font.SourceSans
CooldownLabel.TextColor3 = Color3.new(1, 1, 1)
CooldownLabel.Parent = MainFrame

local CooldownValueLabel = Instance.new("TextLabel")
CooldownValueLabel.Size = Vector2.new(60, 40)
CooldownValueLabel.Position = UDim2.new(0.5, -30), UDim2.new(0, 160)
CooldownValueLabel.Text = "1.5"
CooldownValueLabel.Font = Enum.Font.SourceSans
CooldownValueLabel.TextColor3 = Color3.new(1, 1, 1)
CooldownValueLabel.Parent = MainFrame

local CooldownSlider = Instance.new("TextButton")
CooldownSlider.Size = Vector2.new(240, 40)
CooldownSlider.Position = UDim2.new(0.5, -60), UDim2.new(0, 160)
CooldownSlider.Text = "SpinBox"
-- Crear un control deslizante personalizado
local CooldownFrame = Instance.new("Frame")
CooldownFrame.Size = Vector2.new(300, 70)
CooldownFrame.Position = UDim2.new(0, 15), UDim2.new(0, 200)
CooldownFrame.Parent = MainFrame

-- Configuración de Distancia y Velocidad
local SettingsLabel = Instance.new("TextLabel")
SettingsLabel.Size = Vector2.new(300, 40)
SettingsLabel.Position = UDim2.new(0, 15), UDim2.new(0, 260)
SettingsLabel.Text = "Distancia de Ataque y Velocidad:"
SettingsLabel.Font = Enum.Font.SourceSans
SettingsLabel.TextColor3 = Color3.new(1, 1, 1)
SettingsLabel.Parent = MainFrame

local DistanceLabel = Instance.new("TextLabel")
DistanceLabel.Size = Vector2.new(150, 40)
DistanceLabel.Position = UDim2.new(0.37, -68), UDim2.new(0, 290))
DistanceLabel.Text = "Distancia:"
DistanceLabel.Font = Enum.Font.SourceSans
DistanceLabel.TextColor3 = Color3.new(1, 1, 1)
DistanceLabel.Parent = MainFrame

local DistanceValueLabel = Instance.new("TextLabel")
DistanceValueLabel.Size = Vector2.new(60, 40)
DistanceValueLabel.Position = UDim2.new(0.5, -87), UDim2.new(0, 290))
DistanceValueLabel.Text = "10"
DistanceValueLabel.Font = Enum.Font.SourceSans
DistanceValueLabel.TextColor3 = Color3.new(1, 1, 1)
DistanceValueLabel.Parent = MainFrame

local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = Vector2.new(75, 40)
SpeedLabel.Position = UDim2.new(0.68, -90), UDim2.new(0, 320))
SpeedLabel.Text = "Velocidad:"
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
SpeedLabel.Parent = MainFrame

local SpeedValueLabel = Instance.new("TextLabel")
SpeedValueLabel.Size = Vector2.new(60, 40)
SpeedValueLabel.Position = UDim2.new(0.75, -90), UDim2.new(0, 320))
SpeedValueLabel.Text = "1"
SpeedValueLabel.Font = Enum.Font.SourceSans
SpeedValueLabel.TextColor3 = Color3.new(1, 1, 1)
SpeedValueLabel.Parent = MainFrame

-- Crear deslizador de distancia usando un frame con scrollbars
local DistanceSlider = Instance.new("Frame")
DistanceSlider.Size = Vector2.new(300, 45)
DistanceSlider.Position = UDim2.new(0.37, -68), UDim2.new(0, 330))
DistanceSlider.Parent = MainFrame

local DistanceThumb = Instance.new("TextButton")
DistanceThumb.Size = Vector2.new(30, 40)
DistanceThumb.Position = UDim2.new(0, 15), UDim2.new(0, 368))
DistanceThumb.Text = ""
DistanceThumb.BackgroundColorColor = Color3.new(1, 0, 0)
DistanceThumb.Parent = DistanceSlider

local SpeedSliderContainer = Instance.new("UICornerContainer")
SpeedSliderContainer.Size = Vector2.new(5, -40) -- Solo decoración
local SpeedSlider = Instance.new("Frame")
SpeedSlider.Size = Vector2.new(300, 45)
SpeedSlider.Position = UDim2.new(0.75, -90), UDim2.new(0, 280))
SpeedSlider.Parent = MainFrame

-- Crear scrollbar para velocidad
local SpeedThumb = Instance.new("TextButton")
SpeedThumb.Size = Vector2.new(30, 40)
SpeedThumb.Position = UDim2.new(0, 75), UDim2.new(0, 288))
SpeedThumb.Text = ""
SpeedThumb.BackgroundColorColor = Color3.new(0, 1, 0)

-- Crear barra de fondo para los sliders
local function CreateSliderBackground(slider)
    local Background = Instance.new("Frame")
    Background.Size = Vector2.new(300, 5)
    Background.Position = UDim2.new(0.75, -168), UDim2.new(0, slider.Position.Y.Offset))
    Background.Parent = MainFrame
    Background.BorderSizePreset = 0
    
    local Rail = Instance.new("TextButton")
    Rail.Size = Vector2.new(-300, 5)
    Rail.Text = ""
    Rail.BackgroundColorColor = Color3.fromRGB(180, 180, 180)
    
    local Knob = Instance.new("TextButton")
    Knob.Size = Vector2.new(-slider.Size.X.Offset - 40, slider.Size.Y.Offset + 5))
    Knob.Text = ""
    Knob.BackgroundColorColor = Color3.fromRGB(100, 100, 100)
    
    -- No puedo implementar esto completamente en Luau sin usar eventos más avanzados
end

-- Utilidades y Teclas Rápidas (Toggles)
local UtilitiesLabel = Instance.new("TextLabel")
UtilitiesLabel.Size = Vector2.new(300, 40)
UtilitiesLabel.Position = UDim2.new(0.75, -90), UDim2.new(0, 380))
UtilitiesLabel.Text = "Utilidades:"
UtilitiesLabel.Font = Enum.Font.SourceSans
UtilitiesLabel.TextColor3 = Color3.new(1, 1, 1)
UtilitiesLabel.Parent = MainFrame

-- Botón de Auto Recargar Energía (C)
local AutoRecargarToggle = Instance.new("TextButton")
AutoRecargarToggle.Size = Vector2.new(200, 40)
AutoRecargarToggle.Position = UDim2.new(0.375, -81), UDim2.new(0, 495))
AutoRecargarToggle.Text = "Auto Recargar (C)"
AutoRecargarToggle.Font = Enum.Font.SourceSans
AutoRecargarToggle.Parent = MainFrame

-- Botón de Auto Kaioken (M)
local AutoKaiokenToggle = Instance.new("TextButton")
AutoKaiokenToggle.Size = Vector2.new(200, 40)
AutoKaiokenToggle.Position = UDim2.new(0.375, -81), UDim2.new(0, 530))
AutoKaiokenToggle.Text = "Auto Kaioken (M)"
AutoKaiokenToggle.Font = Enum.Font.SourceSans
AutoKaiokenToggle.Parent = MainFrame

-- Botón de Auto Transformarse (G)
local AutoTransformarToggle = Instance.new("TextButton")
AutoTransformarToggle.Size = Vector2.new(200, 40)
AutoTransformarToggle.Position = UDim2.new(0.375, -81), UDim2.new(0, 565))
AutoTransformarToggle.Text = "Auto Transformarse (G)"
AutoKaiokenToggle.Font = Enum.Font.SourceSans
AutoTransformarToggle.Parent = MainFrame

-- Auto Equipamiento Constante (1)
local AutoEquiparToggle = Instance.new("TextButton")
AutoEquiparToggle.Size = Vector2.new(200, 40)
AutoEquiparToggle.Position = UDim2.new(0.375, -81), UDim2.new(0, 600))
AutoEquiparToggle.Text = "Auto Equipamiento (1)"
AutoEquiparToggle.Font = Enum.Font.SourceSans
AutoEquiparToggle.Parent = MainFrame

-- Variables Globales
local AutoFarmConfig = {
    CooldownAtaqueValue = 1.5,
    DistanciaAtaqueValue = 10,
    VelocidadDesplazamientoValue = 20,
    
    AutoRecargarActivo = false,
    AutoKaiokenActivo = false,
    AutoTransformarActivo = false,
    AutoEquiparActivo = true
}

local MobsSeleccionados = {
    { name = "Bandit", enabled = false },
    { name = "Bad Bandit", enabled = false },
    { name = "Giant Bandit", enabled = false },
    { name = "Boss Bandit", enabled = false }
}

-- Función para obtener Mobs por Nombre
local function GetMobsByNames(names)
    local result = {}
    for _, name in ipairs(names) do
        -- En Roblox, no existe FindObjectsByName nativo en la API estándar
        -- Necesitaríamos hacer una búsqueda manual:
        local objetosEncontrados = game.Workspace:FindFirstChild(name) or nil
        
        if objetoEncontrado then
            table.insert(result, {
                ["name"] = name,
                ["objetos"] = {objetoEncontrado},
                ["cooldown"] = AutoFarmConfig.CooldownAtaqueValue
            })
        end
    )
    
    return result
end

-- Función para teletransportar al jugador a un mob específico con bypass anti-cheat
local function Teletransportar(player, objetivo)
    local tweenService = game:GetService("TweenService")
    local character = player.Character
    
    if not character then
        wait(0.2)
