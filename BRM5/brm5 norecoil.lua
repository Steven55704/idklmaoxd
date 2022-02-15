--brm5 2v2/5v5 | no recoil / weapon modifier script
--execute before equipping weapon, might need to requip for it to work every time idk lol

local Frame = game:GetService("Players").LocalPlayer.PlayerGui.HUDInterface.Container.Weapon

local function ModWeapon()
    if Frame.Visible then
        for _, Ballsack in next, getgc(true) do
            if type(Ballsack) == "table" and rawget(Ballsack, "Recoil") then
                if type(Ballsack.Recoil) == "number" then
                    Ballsack.Recoil = 0 --Ballsack.Velocity = 9e9 --instant fast bullets idk
                end
            end
        end
    end
end

Frame:GetPropertyChangedSignal("Visible"):Connect(ModWeapon)
