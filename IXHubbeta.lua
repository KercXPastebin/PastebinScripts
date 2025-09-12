-- Загружаем WindUI
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- Создаем окно
local window = WindUI:CreateWindow({
    Name = "IX Hub",
    Size = UDim2.new(0, 400, 0, 350),
    Theme = "Dark",
    Icon = "Star"
})

-- Добавляем тег BETA
window:Tag({
    Title = "BETA",
    Color = Color3.fromHex("#FFD700") -- жёлтый цвет
})

-- Вкладка LocalPlayer
local localPlayerTab = window:CreateTab("LocalPlayer", "User")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local originalPower = LocalPlayer:GetAttribute("_EquippedPower") -- сохраняем оригинальный Power

-- Speed TextBox
localPlayerTab:CreateTextBox({
    Name = "Speed (on/off)",
    Placeholder = "on / off",
    Callback = function(value)
        if value:lower() == "on" then
            humanoid.WalkSpeed = 100
        elseif value:lower() == "off" then
            humanoid.WalkSpeed = 16
        else
            warn("Введите 'on' или 'off'")
        end
    end
})

-- JumpPower TextBox
localPlayerTab:CreateTextBox({
    Name = "JumpPower (on/off)",
    Placeholder = "on / off",
    Callback = function(value)
        if value:lower() == "on" then
            humanoid.JumpPower = 150
        elseif value:lower() == "off" then
            humanoid.JumpPower = 50
        else
            warn("Введите 'on' или 'off'")
        end
    end
})

-- Noclip TextBox
local noclipConnection
localPlayerTab:CreateTextBox({
    Name = "Noclip (on/off)",
    Placeholder = "on / off",
    Callback = function(value)
        if value:lower() == "on" then
            noclipConnection = RunService.Stepped:Connect(function()
                for _, part in pairs(character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end)
            humanoid.Died:Connect(function()
                if noclipConnection then noclipConnection:Disconnect() end
            end)
        elseif value:lower() == "off" then
            if noclipConnection then noclipConnection:Disconnect() end
            for _, part in pairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        else
            warn("Введите 'on' или 'off'")
        end
    end
})

-- UnlockDash Button
localPlayerTab:CreateButton({
    Name = "UnlockDash",
    Callback = function()
        if not LocalPlayer then return warn("LocalPlayer не найден") end
        if not originalPower then
            originalPower = LocalPlayer:GetAttribute("_EquippedPower")
        end

        local success, dashModule = pcall(function()
            return require(game:GetService("ReplicatedStorage"):WaitForChild("DashModule"))
        end)

        if success and dashModule then
            dashModule.Enabled = true
            print("Dash успешно разблокирован!")
        else
            warn("Не найден модуль Dash (возможно другой путь в вашей игре)")
        end
    end
})
