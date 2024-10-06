RegisterNUICallback('get-internet-data', function(_, cb)
    local result = lib.callback.await('z-phone:server:GetInternetData', false)
    if not result then
        --TODO: debug here
        return
    end
    cb(result)
end)

RegisterNUICallback('topup-internet-data', function(body, cb)
    if not IsAllowToSendOrCall() then
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = Config.App.InetMax.Name,
            message = Config.MsgSignalZone
        })
        cb(false)
        return
    end
    
    local purchaseInKB = lib.callback.await('z-phone:server:TopupInternetData', false, body)
    if not purchaseInKB then
        --TODO: debug here
        return
    end
    Profile.inetmax_balance = Profile.inetmax_balance + purchaseInKB
    cb(purchaseInKB)
end)

RegisterNetEvent('z-phone:client:usage-internet-data', function(app, usageInKB)
    --TODO: do a check here
    Profile.inetmax_balance = Profile.inetmax_balance - usageInKB
end)