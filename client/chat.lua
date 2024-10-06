RegisterNUICallback('new-or-continue-chat', function(body, cb)
    local chatting = lib.callback.await('z-phone:server:StartOrContinueChatting', false, body)
    if not chatting then
        --TODO: debug here
        return
    end
    cb(chatting)
end)

RegisterNUICallback('get-chats', function(_, cb)
    local chats = lib.callback.await('z-phone:server:GetChats', false)
    if not chats then
        --TODO: debug here
        return
    end
    cb(chats)
end)

RegisterNUICallback('get-chatting', function(body, cb)
    local chatting = lib.callback.await('z-phone:server:GetChatting', false, body)
    if not chatting then
        --TODO: debug here
        return
    end
    cb(chatting)
end)

RegisterNUICallback('send-chatting', function(body, cb)
    if not IsAllowToSendOrCall() then
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = Config.App.InetMax.Name,
            message = Config.MsgSignalZone
        })
        cb(false)
        return
    end
    
    if Profile.inetmax_balance < Config.App.InetMax.InetMaxUsage.MessageSend then
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = Config.App.InetMax.Name,
            message = Config.MsgNotEnoughInternetData
        })
        cb(false)
        return
    end

    local sendChatting = lib.callback.await('z-phone:server:SendChatting', false, body)
    if not sendChatting then
        --TODO: debug here
        return
    end
    TriggerServerEvent("z-phone:server:usage-internet-data", Config.App.Message.Name, Config.App.InetMax.InetMaxUsage.MessageSend)
    cb(sendChatting)
end)

RegisterNUICallback('delete-message', function(body, cb)
    local deleteMessage = lib.callback.await('z-phone:server:DeleteMessage', false, body)
    if not deleteMessage then
        --TODO: debug here
        return
    end
    cb(deleteMessage)
end)

RegisterNUICallback('create-group', function(body, cb)
    local createGroup = lib.callback.await('z-phone:server:CreateGroup', false, body)
    if not createGroup then
        --TODO: debug here
        return
    end
    TriggerEvent("z-phone:client:sendNotifInternal", {
        type = "Notification",
        from = "Message",
        message = "Group chat created!"
    })
    cb(createGroup)
end)