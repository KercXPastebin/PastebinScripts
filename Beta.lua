local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

-- Создаём окно (фрейм)
local Window = Rayfield:CreateWindow({
    Name = "TEST GUI",
    LoadingTitle = "WAIT TO....",
    LoadingSubtitle = "by KERC912",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = nil,
        FileName = "MyConfig"
    }
})

-- Добавляем вкладку
local Tab = Window:CreateTab("Главная", 4483362458) -- ID иконки можно поменять

-- Кнопка
Tab:CreateButton({
    Name = "Пример кнопки",
    Callback = function()
        print("Кнопка нажата!")
    end
})

-- Слайдер
Tab:CreateSlider({
    Name = "Скорость",
    Range = {16, 100},
    Increment = 1,
    Suffix = "WalkSpeed",
    CurrentValue = 16,
    Flag = "SpeedSlider",
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end,
})
