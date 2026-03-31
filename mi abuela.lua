local function scan()
    for _,v in pairs(game:GetDescendants()) do
        if v:IsA("TextLabel") then
            local txt = v.Text

            -- detectar dinero
            local money = txt:match("%+%$(%d+%.?%d*)M")

            if money then
                local total = tonumber(money) * 1e6

                -- buscar mult y lvl cerca (padre)
                local parent = v.Parent
                local mult, lvl

                for _,obj in pairs(parent:GetChildren()) do
                    if obj:IsA("TextLabel") then
                        local t = obj.Text
                        mult = mult or t:match("%[x(%d+)%]")
                        lvl = lvl or t:match("%[(%d+)%]")
                    end
                end

                if mult and lvl then
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
end
