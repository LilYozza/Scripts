local Players=game:GetService("Players") local Player=Players.LocalPlayer local virtual=game:GetService("VirtualUser")
local FullBright = loadstring(game:HttpGet('https://raw.githubusercontent.com/LilYozza/Scripts/main/Misc/FullBright.txt'))
local NameTag = loadstring(game:HttpGet('https://raw.githubusercontent.com/LilYozza/Scripts/main/Misc/NameTags.txt'))
local InvFling = loadstring(game:HttpGet('https://raw.githubusercontent.com/LilYozza/Scripts/main/Misc/InvFling.txt'))
local Fly = loadstring(game:HttpGet('https://raw.githubusercontent.com/LilYozza/Scripts/main/Misc/Fly.txt'))


local GPlayers = w:CreateFolder("Players")
local Misc = w:CreateFolder("Misc")

local PlayerSelect_M
local PlayerList_M={}

-->Exploit Fix<--
if not pcall(function() return syn.protect_gui end) then syn = {}syn.protect_gui = function(A_1)A_1.Parent = CoreGui end end

local FlingLabel=GPlayers:Label("Inv Fling: OFF",{
    TextSize = 20;
    TextColor = Color3.fromRGB(255,0,0);
    BgColor = Color3.fromRGB(0,0,0);
    
})

P1Connection,P2Connection,P3Connection=nil
GPlayers:Toggle("PlayerNames",function(bool)
    shared.Misc5 = bool
    spawn(function()
        if shared.Misc5 then NameTag() else
            if P1Connection then P1Connection:Disconnect()end if P2Connection then P2Connection:Disconnect()end if P3Connection then P3Connection:Disconnect()end
            for _,v in pairs(Players:GetChildren()) do
                if v.Character:WaitForChild("Head",5) and v.Character.Head:FindFirstChild("PlayerTag") then
                    v.Character.Head:FindFirstChild("PlayerTag"):Destroy()
                end
            end 
        end
        task.wait()
    end)
end)

local DropList = GPlayers:Dropdown("Select Player",PlayerList_M,true,function(SItem)
    for _,v in pairs(Players:GetChildren())do
        if  v.DisplayName==SItem then
            PlayerSelect_M = v break
        end
    end
end)

---------------------------Player List Controller---------------------------
local function RemoveItem(t,i)if t then for _,v in pairs(t)do if v==i then table.remove(t,_) break end end end end
local function AddPlayer(player)if not table.find(PlayerList_M,player.DisplayName) then table.insert(PlayerList_M, player.DisplayName)DropList:Refresh(PlayerList_M)end end
local function RemovePlayer(player)if table.find(PlayerList_M,player.DisplayName) then RemoveItem(PlayerList_M, player.DisplayName)DropList:Refresh(PlayerList_M)end end
local function GetPlayers()if not PlayerList_M[1] then for _,v in pairs(Players:GetChildren())do table.insert(PlayerList_M, v.DisplayName)v.CharacterAdded:Connect(function()AddPlayer(v)end)end end DropList:Refresh(PlayerList_M)end GetPlayers()
Players.PlayerAdded:Connect(function(player)player.CharacterAdded:Connect(function()AddPlayer(player)end)end)
Players.PlayerRemoving:Connect(function(player)RemovePlayer(player)end)
----------------------------------------------------------------------------

GPlayers:Button("TeleportTo",function()
    spawn (function()
        if PlayerSelect_M then Player.Character:WaitForChild("HumanoidRootPart").CFrame=PlayerSelect_M.Character:WaitForChild("HumanoidRootPart").CFrame end
    end)
end)

isON,isFlingOn=false
F1Connection,F2Connection,F3Connection=nil
GPlayers:Button("InvFling",function()
    spawn(function()
        if isFlingOn then isFlingOn=false FlingLabel:Refresh("Inv Fling: OFF") else isFlingOn=true FlingLabel:Refresh("Inv Fling: ON") end
        if isFlingOn then 
            InvFling()
        elseif isON then
            local ch = game.Players.LocalPlayer.Character
            local prt=Instance.new("Model", workspace)
            local z1 =  Instance.new("Part", prt)
            z1.Name="Torso"
            z1.CanCollide = false
            z1.Anchored = true
            local z2  =Instance.new("Part", prt)
            z2.Name="Head"
            z2.Anchored = false
            z2.CanCollide = true
            local z3 =Instance.new("Humanoid", prt)
            z3.Name="Humanoid"
            z1.Position = Vector3.new(0,9999,0)
            z2.Position = Vector3.new(0,9991,0)
            game.Players.LocalPlayer.Character=prt task.wait(5)
            --game.Players.LocalPlayer.Character=ch
            local poop = nil
        	repeat task.wait() poop = game.Players.LocalPlayer.Character:FindFirstChild("Head") until poop ~= nil
        	local function Cleanup()
                for _,v in pairs(Workspace:GetChildren())do
                    if v.Name=="Model"and v:FindFirstChild("Torso")and v:FindFirstChild("Head")and v:FindFirstChild("Humanoid") and #v:GetChildren()==3 then
                        v:Destroy()
                    end
                end
        	end Cleanup() isON=false
        	if F1Connection then F1Connection:Disconnect() F2Connection:Disconnect() F3Connection:Disconnect()end
        end
    end)
end)

Misc:Button("Sword Aura",function()
    spawn (function()
        local credit='guardscripts'local url=('https://raw.githubusercontent.com/%s/myscripts/main/scriptinit.lua'):format(credit)init=loadstring(game:HttpGet(url,true))
        getgenv().xscriptId='NDA5MzBy'init()
    end)
end)

Fly1Connection,Fly2Connection=nil
Misc:Toggle("Fly",function(bool)
    isFly = bool
    spawn (function()
        Fly()
        if not isFly and Fly1Connection then Fly1Connection:Disconnect() Fly2Connection:Disconnect()end
    end)
end)

Misc:Toggle("Full Bright",function(bool)
    shared.Misc2 = bool
    spawn (function()FullBright()end)
end)

Misc:Toggle("Infinite Jump",function(bool)
    shared.Misc3 = bool
    spawn (function()
        game:GetService("UserInputService").JumpRequest:Connect(function()
            if shared.Misc3 then
                Player.character:WaitForChild("Humanoid"):ChangeState("Jumping")
            end
        end)
    end)
end)

Misc:Toggle("Teleport",function(bool)
    shared.Misc4 = bool
    spawn(function()
        local mouse = Player:GetMouse()
        mouse.KeyDown:Connect(function(key)
            if key == "q" and shared.Misc4 then
                if mouse.Target then
                    Player.character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(mouse.Hit.x, mouse.Hit.y + 5, mouse.Hit.z)
                end
            end
        end)
    end)
end)

local Speed = Misc:Slider("Walk Speed",{
    ['default'] = 16;
    ['min'] = 0;
    ['max'] = 200;
    ['precise'] = true;
},function(value)
    game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = value
    local Players = game:GetService("Players")
end)

Misc:Button("3rd Person",function()
    game:GetService('Players').LocalPlayer.CameraMode = 'Classic'
    Player.CameraMaxZoomDistance = 150
    Player.CameraMinZoomDistance = 0
end)

Misc:DestroyGui()

game:GetService("Players").LocalPlayer.Idled:connect(function()
virtual:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
wait(1)
virtual:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)end)