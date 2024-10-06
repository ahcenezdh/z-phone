local services <const> = {
    "goverment",
    "police",
    "ambulance",
    "realestate",
    "kmmechanic",
    "taxi",
    "kmpedagang",
    "reporter",
}

local logo <const> = 'https://raw.githubusercontent.com/alfaben12/kmrp-assets/main/logo/business/goverment.png'

RegisterNUICallback('get-services', function(_, cb)
    local ServicesFormatted = {}

    for i, v in ipairs(services) do
        if QBCore.Shared.Jobs[v] ~= nil then
            ServicesFormatted[#ServicesFormatted + 1] = {
                logo = logo,
                service = QBCore.Shared.Jobs[v].label,
                job = v,
                type = QBCore.Shared.Jobs[v].type and QBCore.Shared.Jobs[v].type or "General",
            }
        end
    end

    local messages = lib.callback.await('z-phone:server:GetServices', false)
    if not messages then
        --TODO: more debug here
        return
    end

    cb({ list = ServicesFormatted, reports = messages})
end)

RegisterNUICallback('send-message-service', function(body, cb)
    if not IsAllowToSendOrCall() then
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = Config.App.InetMax.Name,
            message = Config.MsgSignalZone
        })
        cb(false)
        return
    end

    if Profile.inetmax_balance < Config.App.InetMax.InetMaxUsage.ServicesMessage then
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = Config.App.InetMax.Name,
            message = Config.MsgNotEnoughInternetData
        })
        cb(false)
        return
    end

    local sendMessageService = lib.callback.await('z-phone:server:SendMessageService', false, body)
    if not sendMessageService then
        cb(false)
        return
    end

    TriggerServerEvent("z-phone:server:usage-internet-data", Config.App.Services.Name, Config.App.InetMax.InetMaxUsage.ServicesMessage)
    cb(sendMessageService)
end)

RegisterNUICallback('solved-message-service', function(body, cb)
    local solvedMessageService = lib.callback.await('z-phone:server:SolvedMessageService', false, body)
    if not solvedMessageService then
        cb(false)
        return
        --TODO: more debug here 
    end

    cb(solvedMessageService)
end)