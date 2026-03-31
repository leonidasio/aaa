-- UI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "PCBaseFinder"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 300, 0, 400)
frame.Position = UDim2.new(0, 20, 0.3, 0)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)

local layout = Instance.new("UIListLayout", frame)

-- CONFIG
local levelBoostPerLevel = 68

-- FUNCION CALCULO
local function calcularBase(total, mult, levels)
    local basePoints = total / mult
    local levelBonus = levels * levelBoostPerLevel
    local approx = basePoints / (1 + (levelBonus / 4000))
    return math.floor(approx)
end

-- DETECTAR TEXTOS
local function scan()
    for _,v in pairs(game:GetDescendants()) do
        if v:IsA("TextLabel") then
            local txt = v.Text

            -- intenta encontrar numeros tipo "55.2M x30 54"
            local money = txt:match("(%d+%.?%d*)M")
            local mult = txt:match("x(%d+)")
            local lvl = txt:match("(%d+)%s*[Ll]")

            if money and mult and lvl then
                local total = tonumber(money) * 1e6
                local m = tonumber(mult)
                local l = tonumber(lvl)

                local base = calcularBase(total, m, l)

                local label = Instance.new("TextLabel", frame)
                label.Size = UDim2.new(1,0,0,25)
                label.Text = "Base: "..base
                label.TextColor3 = Color3.new(1,1,1)
                label.BackgroundTransparency = 1
            end
        end
    end
end

-- LOOP
while true do
    frame:ClearAllChildren()
    layout.Parent = frame
    scan()
    task.wait(2)
end
