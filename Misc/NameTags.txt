if shared.Misc5 then
    local function CreateTag(c,player)
        GUI = Instance.new("BillboardGui", player.Character:WaitForChild("Head"))
        GUI.Name="PlayerTag"
        GUI.StudsOffsetWorldSpace = Vector3.new(0,2.5,0)
        GUI.AlwaysOnTop = true 
        GUI.Size = UDim2.new(0,100,0, 50)
        TextLabel = Instance.new("TextLabel", GUI)
        TextLabel.Text =  player.DisplayName 
        TextLabel.BackgroundTransparency = 1 
        TextLabel.Font = "ArialBold" 
        TextLabel.TextSize = 15 
        TextLabel.TextColor3 = c TextLabel.Size = UDim2.new(1,0,1,0) 
    end
    local function AddTag(player)
        local Color=Color3.new(255, 0, 0)
        if shared.Misc5 and player.Character:WaitForChild("Head",5) and not player.Character.Head:FindFirstChild("PlayerTag") then
        --if player.Team and Player.TeamColor then Color=Player.TeamColor.Color end --<<CAN IMPLEMENT TEAM COLOR IF NEEDED
        CreateTag(Color, player)end
    end
            
    for _,v in pairs(game.Players:GetChildren()) do
        P1Connection = v.CharacterAdded:Connect(function()AddTag(v)end)AddTag(v)
    end
            
    P2Connection=game.Players.PlayerAdded:Connect(function(player)
        P3Connection=player.CharacterAdded:Connect(function()AddTag(player)end)
    end)
end