--https://web.roblox.com/games/45146873/Tower-Battles-WINTER
repeat wait() until game:IsLoaded()
local Tb = {}
function survival() if game.PlaceId == 49707852 then return true else return false end end
function lobby() if game.PlaceId == 45146873 then return true else return false end end

function Tb:Join(m)
spawn(function()
    if lobby() then
        wait(2)
            workspace.SurvivalAnalysis:InvokeServer()
                repeat wait() until workspace.Rooms["SurvivalSolo"]["1"].Value == "Empty"
                local render = game:GetService("RunService").RenderStepped:Connect(function()
                workspace.Enter:InvokeServer(m,1)
                workspace.BeginSurvivalGame:InvokeServer(m,1)
                    end)
                    wait(0.5)
                        render:Disconnect()
        end
    end)
end

function Tb:SelectMap(m)
spawn(function()
    if survival() then
        repeat task.wait(0.0001)
        if not workspace.Map1.Type.Value ~= m and workspace.Map2.Type.Value ~= m and workspace.Map3.Type.Value ~= m then
        workspace.Vote:InvokeServer('Veto')
        end
        if workspace.Map1.Type.Value == m then
        workspace.Vote:InvokeServer('Map1')
        task.wait(0.0001)
        workspace.SkipWaitVote:InvokeServer()
        elseif workspace.Map2.Type.Value == m then
        workspace.Vote:InvokeServer('Map2')
        task.wait(0.0001)
        workspace.SkipWaitVote:InvokeServer()
        elseif workspace.Map3.Type.Value == m then
        workspace.Vote:InvokeServer('Map3')
        task.wait(0.0001)
        workspace.SkipWaitVote:InvokeServer()
        end
        until workspace.Map1.Type.Value == m or workspace.Map2.Type.Value == m or workspace.Map3.Type.Value == m
        end
    end)
end

function Tb:Place(p1,p2,p3,tower,wave)
spawn(function()
if survival() then
    repeat wait() until workspace:FindFirstChild("Map")
    repeat wait() until workspace.Waves:FindFirstChild("Wave").Value == wave
    wait()
    workspace.Placed:InvokeServer(Vector3.new(p1,p2,p3),1,tower,workspace.Map.Grass)
        end
    end)
end

function Tb:Upgrade(n,m)
spawn(function()
    if survival() then
        repeat wait() until workspace:FindFirstChild("Map")
	repeat wait() until workspace.Waves:FindFirstChild("Wave").Value == 1
        repeat wait(0.1)
            workspace.UpgradeTower:InvokeServer(n)
            until workspace.Towers[n].Tower.UP1.Value == m
        end
    end)
end

function Tb:Sell(n,wave)
spawn(function()
    if survival() then
        repeat wait() until workspace:FindFirstChild("Map")
        repeat wait() until workspace.Waves:FindFirstChild("Wave").Value == wave
        repeat wait(0.1)
            workspace.SellTower:InvokeServer(n)
            until not workspace.Towers:FindFirstChild(n)
        end
    end)
end
return Tb
