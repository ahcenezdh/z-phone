RegisterNUICallback('get-profile', function(_, cb)
    local profile = lib.callback.await('z-phone:server:GetProfile', false)
    if not profile then
        --TODO: debug here
        cb(false)
        return
    end
    profile.signal = Config.Signal.Zones[PhoneData.SignalZone].ChanceSignal
    cb(profile)
end)

RegisterNUICallback('update-profile', function(body, cb)
    local updateProfile = lib.callback.await('z-phone:server:UpdateProfile', false, body)
    if not updateProfile then
        --TODO: debug here
        cb(false)
        return
    end
    
    local profile = lib.callback.await('z-phone:server:GetProfile', false)
    if not profile then
        --TODO: debug here
        cb(false)
        return
    end
    
    Profile = profile
    profile.signal = Config.Signal.Zones[PhoneData.SignalZone].ChanceSignal
    cb(profile)
end)