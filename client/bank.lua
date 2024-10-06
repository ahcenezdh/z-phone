RegisterNUICallback('get-bank', function(_, cb)
    local getBank = lib.callback.await('z-phone:server:GetBank', false)
    if not getBank then
        --TODO: debug here
        return
    end
    cb(getBank)
end)

RegisterNUICallback('pay-invoice', function(body, cb)
    local payInvoice = lib.callback.await('z-phone:server:PayInvoice', false, body)
    if not payInvoice then
        --TODO: debug here
        return
    end
    cb(payInvoice)
end)

RegisterNUICallback('transfer-check', function(body, cb)
    if not IsAllowToSendOrCall() then
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = Config.App.InetMax.Name,
            message = Config.MsgSignalZone
        })
        cb(false)
        return
    end

    if Profile.inetmax_balance < Config.App.InetMax.InetMaxUsage.BankCheckTransferReceiver then
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = Config.App.InetMax.Name,
            message = Config.MsgNotEnoughInternetData
        })
        cb(false)
        return
    end

    local transferCheck = lib.callback.await('z-phone:server:TransferCheck', false, body)
    if not transferCheck then
        --TODO: debug here
        return
    end

    TriggerServerEvent('z-phone:server:usage-internet-data', Config.App.Wallet.Name, Config.App.InetMax.InetMaxUsage.BankCheckTransferReceiver)
    cb(transferCheck)
end)

RegisterNUICallback('transfer', function(body, cb)
    if not IsAllowToSendOrCall() then
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = Config.App.InetMax.Name,
            message = Config.MsgSignalZone
        })
        cb(false)
        return
    end
    
    if Profile.inetmax_balance < Config.App.InetMax.InetMaxUsage.BankTransfer then
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = Config.App.InetMax.Name,
            message = Config.MsgNotEnoughInternetData
        })
        cb(false)
        return
    end

    local transfer = lib.callback.await('z-phone:server:Transfer', false, body)
    if not transfer then
        --TODO: debug here
        return
    end

    TriggerServerEvent("z-phone:server:usage-internet-data", Config.App.Wallet.Name, Config.App.InetMax.InetMaxUsage.BankTransfer)
    cb(transfer)
end)