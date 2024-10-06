RegisterNUICallback('loops-login', function(body, cb)
    local res = lib.callback.await('z-phone:server:LoopsLogin', false, body)
    if not res then
        --TODO: debug here
        return
    end
    cb(res)
end)

RegisterNUICallback('loops-signup', function(body, cb)
    local res = lib.callback.await('z-phone:server:LoopsSignup', false, body)
    if not res then
        --TODO: debug here
        return
    end
    cb(res)
end)

RegisterNUICallback('get-tweets', function(_, cb)
    local tweets = lib.callback.await('z-phone:server:GetTweets', false)
    if not tweets then
        --TODO: debug here
        return
    end
    cb(tweets)
end)

RegisterNUICallback('send-tweet', function(body, cb)
    if not IsAllowToSendOrCall() then
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = Config.App.InetMax.Name,
            message = Config.MsgSignalZone
        })
        cb(false)
        return
    end

    if Profile.inetmax_balance < Config.App.InetMax.InetMaxUsage.LoopsPostTweet then
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = Config.App.InetMax.Name,
            message = Config.MsgNotEnoughInternetData
        })
        cb(false)
        return
    end

    local isOk = lib.callback.await('z-phone:server:SendTweet', false, body)
    if not isOk then
        --TODO: debug here
        return
    end
    TriggerServerEvent("z-phone:server:usage-internet-data", Config.App.Loops.Name, Config.App.InetMax.InetMaxUsage.LoopsPostTweet)
    local tweets = lib.callback.await('z-phone:server:GetTweets', false)
    if not tweets then
        --TODO: debug here
        return
    end
    cb(tweets)
end)

RegisterNUICallback('get-tweet-comments', function(body, cb)
    local comments = lib.callback.await('z-phone:server:GetComments', false, body)
    if not comments then
        --TODO: debug here
        return
    end
    cb(comments)
end)

RegisterNUICallback('send-tweet-comments', function(body, cb)
    if not IsAllowToSendOrCall() then
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = Config.App.InetMax.Name,
            message = Config.MsgSignalZone
        })
        cb(false)
        return
    end
    
    if Profile.inetmax_balance < Config.App.InetMax.InetMaxUsage.LoopsPostComment then
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = Config.App.InetMax.Name,
            message = Config.MsgNotEnoughInternetData
        })
        cb(false)
        return
    end

    local isOk = lib.callback.await('z-phone:server:SendTweetComment', false, body)
    if not isOk then
        --TODO: debug here
        return
    end
    TriggerServerEvent("z-phone:server:usage-internet-data", Config.App.Loops.Name, Config.App.InetMax.InetMaxUsage.LoopsPostComment)
    cb(isOk)
end)

RegisterNUICallback('update-loops-profile', function(body, cb)
    local profile = lib.callback.await('z-phone:server:UpdateLoopsProfile', false, body)
    if not profile then
        --TODO: debug here
        return
    end
    cb(profile)
end)

RegisterNUICallback('get-loops-profile', function(body, cb)
    local profile = lib.callback.await('z-phone:server:GetLoopsProfile', false, body)
    if not profile then
        --TODO: debug here
        return
    end
    cb(profile)
end)

RegisterNUICallback('loops-logout', function(_, cb)
    local isOk = lib.callback.await('z-phone:server:UpdateLoopsLogout', false)
    if not isOk then
        --TODO: debug here
        return
    end
    cb(isOk)
end)