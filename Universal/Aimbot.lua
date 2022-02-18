local lplayer = game.Players.LocalPlayer
local mouse = lplayer:GetMouse()
local Current = game.Workspace.CurrentCamera
local GuiService = game:GetService("StarterGui")
local enabled = false
local aimbot = true
local aimat = 'Torso'
local Track = false
local User = game:GetService("UserInputService")
GuiService:SetCore("SendNotification", {Title = "Aimlock", Text = "Script Loaded";})
function GetNearestPlayerToMouse()
local Users = {}
local lplayer_hold = {}
local Distances = {}
for i, v in pairs(game.Players:GetPlayers()) do
if v ~= lplayer then
table.insert(Users, v)
end
end
for i, v in pairs(Users) do
if aimbot == false then
if v and (v.Character) ~= nil and v.TeamColor ~= lplayer.TeamColor then
local aim = v.Character:FindFirstChild(aimat)
if aim ~= nil then
local Distance = (aim.Position - game.Workspace.CurrentCamera.CoordinateFrame.p).magnitude
local ray = Ray.new(game.Workspace.CurrentCamera.CoordinateFrame.p, (mouse.Hit.p - Current.CoordinateFrame.p).unit * Distance)
local hit,pos = game.Workspace:FindPartOnRay(ray, game.Workspace)
local diff = math.floor((pos - aim.Position).magnitude)
lplayer_hold[v.Name .. i] = {}
lplayer_hold[v.Name .. i].dist = Distance
lplayer_hold[v.Name .. i].plr = v
lplayer_hold[v.Name .. i].diff = diff
table.insert(Distances, diff)
end
end
elseif aimbot == true then
local aim = v.Character:FindFirstChild(aimat)
if aim ~= nil then
local Distance = (aim.Position - game.Workspace.CurrentCamera.CoordinateFrame.p).magnitude
local ray = Ray.new(game.Workspace.CurrentCamera.CoordinateFrame.p, (mouse.Hit.p - Current.CoordinateFrame.p).unit * Distance)
local hit,pos = game.Workspace:FindPartOnRay(ray, game.Workspace)
local diff = math.floor((pos - aim.Position).magnitude)
lplayer_hold[v.Name .. i] = {}
lplayer_hold[v.Name .. i].dist = Distance
lplayer_hold[v.Name .. i].plr = v
lplayer_hold[v.Name .. i].diff = diff
table.insert(Distances, diff)
end
end
end
if unpack(Distances) == nil then
return false
end
local L_Distance = math.floor(math.min(unpack(Distances)))
if L_Distance > 20 then
return false
end
for i, v in pairs(lplayer_hold) do
if v.diff == L_Distance then
return v.plr
end
end
return false
end
function Find()
Clear()
Track = true
spawn(function()
while wait() do
if Track then
Clear()
for i,v in pairs(game.Players:GetChildren()) do
if v.Character and v.Character:FindFirstChild('Head') then
if aimbot == false then
if v.TeamColor ~= lplayer.TeamColor then
if v.Character:FindFirstChild('Head') then
create(v.Character.Head, true)
end
end
else
if v.Character:FindFirstChild('Head') then
create(v.Character.Head, true)
end
end
end
end
end
end
wait(1)
end)
end
game:GetService('RunService').RenderStepped:connect(function()
if enabled then
local target = GetNearestPlayerToMouse()
if (target ~= false) then
local aim = target.Character:FindFirstChild(aimat)
if aim then
Current.CoordinateFrame = CFrame.new(Current.CoordinateFrame.p, aim.CFrame.p)
end
else
end
end
end)
mouse.KeyDown:connect(function(key)
if key == "q" then
if aimat == 'Head' then
aimat = 'Torso'
GuiService:SetCore("SendNotification", {Title = "Aimlock", Text = "Aimlock now set to Torso";})
elseif aimat == 'Torso' then
aimat = 'Head'
GuiService:SetCore("SendNotification", {Title = "Aimlock", Text = "Aimlock now set to Head";})
end
end
end)
User.InputBegan:Connect(function(inputObject)
if(inputObject.KeyCode==Enum.KeyCode.LeftControl) then
enabled = true
end
end)
User.InputEnded:Connect(function(inputObject)
if(inputObject.KeyCode==Enum.KeyCode.LeftControl) then
enabled = false
end
end)
