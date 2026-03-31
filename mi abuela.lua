local Players = game:GetService("Players")

-- CONFIG
local interval = 1 -- cada cuánto suma (segundos)

-- función para calcular dinero total del jugador
local function getIncome(player)
    local total = 0
    
    if player:FindFirstChild("PCs") then
        for _,pc in pairs(player.PCs:GetChildren()) do
            local base = pc:FindFirstChild("Base")
            local level = pc:FindFirstChild("Level")
            local mult = pc:FindFirstChild("Multiplier")
            
            if base and level and mult then
                local lvlBoost = level.Value * 68
                local value = (base.Value + lvlBoost) * mult.Value
                total += value
            end
        end
    end
    
    return total
end

-- loop
while true do
    for _,player in pairs(Players:GetPlayers()) do
        local leaderstats = player:FindFirstChild("leaderstats")
        if leaderstats and leaderstats:FindFirstChild("Money") then
            
            local income = getIncome(player)
            leaderstats.Money.Value += income
            
        end
    end
    
    task.wait(interval)
end
