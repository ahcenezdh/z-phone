RegisterNUICallback('get-ads', function(_, cb)
    local ads = lib.callback.await("z-phone:server:GetAds", false)
    if not ads then
        --TODO: debug here
        return 
    end
    cb(ads)
end)

RegisterNUICallback('send-ads', function(body, cb)
    if not IsAllowToSendOrCall() then
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = Config.App.InetMax.Name,
            message = Config.MsgSignalZone
        })
        cb(false)
        return
    end
    
    if Profile.inetmax_balance < Config.App.InetMax.InetMaxUsage.AdsPost then
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = Config.App.InetMax.Name,
            message = Config.MsgNotEnoughInternetData
        })
        cb(false)
        return
    end

    local sendAds = lib.callback.await("z-phone:server:SendAds", false, body)
    if not sendAds then
        -- TODO: debug here
        return
    end

    local ads = lib.callback.await("z-phone:server:GetAds", false)
    if not ads then
        -- TODO: debug here
        return
    end 

    TriggerServerEvent("z-phone:server:usage-internet-data", Config.App.Ads.Name, Config.App.InetMax.InetMaxUsage.AdsPost)
    cb(ads)
end)