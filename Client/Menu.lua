RMenu.Add('PasteMenu', 'Principal', RageUI.CreateMenu("", "Copy/Paste Menu", nil, nil, "IseDict", "Banner"), true)
RMenu:Get('PasteMenu', 'Principal'):DisplayGlare(false);

Copy = {
    First = nil,
    FirstState = false,
    Second = nil,
    SecondState = false,
    Third = nil,
    ThirdState = false
}

Citizen.CreateThread( function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(1, 344) then
            RageUI.Visible(RMenu:Get('PasteMenu', 'Principal'), not RageUI.Visible(RMenu:Get('PasteMenu', 'Principal')))
        end
        
        RageUI.IsVisible(RMenu:Get('PasteMenu', 'Vehicle'), function()
            RageUI.Item.Checkbox("First coords", Copy.First, Copy.FirstState, {}, {
                onChecked = function()
                    local Coords = GetEntityCoords(PlayerPedId())
                    local x, y, z = table.unpack(Coords)
                    local Heading = GetEntityHeading(PlayerPedId())
                    Copy.First = "{x = "..x..", y = "..y..", z = "..z..", h = "..Heading.."},"
                    Copy.FirstState = true
                end,
            })
            if Copy.First ~= nil then
                RageUI.Item.Checkbox("Second coords", Copy.Second, Copy.SecondState, {}, {
                    onChecked = function()
                        local Coords = GetEntityCoords(PlayerPedId())
                        local x, y, z = table.unpack(Coords)
                        local Heading = GetEntityHeading(PlayerPedId())
                        Copy.Second = "{x2 = "..x..", y2 = "..y..", z2 = "..z..", h2 = "..Heading.."},"
                        Copy.SecondState = true
                    end,
                })
            end
            if Copy.First ~= nil and Copy.Second ~= nil then
                RageUI.Item.Checkbox("Third coords", Copy.Third, Copy.ThirdState, {}, {
                    onChecked = function()
                        local Coords = GetEntityCoords(PlayerPedId())
                        local x, y, z = table.unpack(Coords)
                        local Heading = GetEntityHeading(PlayerPedId())
                        Copy.Third = "{x3 = "..x..", y3 = "..y..", z3 = "..z..", h3 = "..Heading.."},"
                        Copy.ThirdState = true
                    end,
                })
            end
            if Copy.First ~= nil and Copy.Second ~= nil and Copy.Third ~= nil then
                RageUI.Item.Button("Copy coords", Copy.First..Copy.Second..Copy.Third, {}, true, {
                    onSelected = function()
                        SendNUIMessage({
                            Copy = Copy.First..Copy.Second..Copy.Third
                        })
					    Copy.First = nil
					    Copy.FirstState = false
					    Copy.Second = nil
					    Copy.SecondState = false
					    Copy.Third = nil
					    Copy.ThirdState = false
                    end,
                })
            end
        end)
    end
end)

function sendNotif(Txt)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(Txt)
	DrawNotification(0,1)
end

