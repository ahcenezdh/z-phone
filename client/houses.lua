RegisterNUICallback('get-houses', function(_, cb)
    local houses = lib.callback.await('z-phone:server:GetHouses', false)
    if not houses then
        --TODO: debug here
        return
    end
    for i, v in pairs(houses) do
        houses[i].image = "https://raw.githubusercontent.com/alfaben12/kmrp-assets/main/houses/".. v.id ..".jpg"
        houses[i].keyholders = json.decode(v.keyholders)
    end
    cb(houses)
end)

RegisterNUICallback('get-direction', function(body, cb)
    SetNewWaypoint(body.coords.enter.x, body.coords.enter.y)
    QBCore.Functions.Notify('GPS has been set to ' .. body.name .. '!', 'success')
    cb("ok")
end)