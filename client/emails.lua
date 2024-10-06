RegisterNUICallback('get-emails', function(_, cb)
    local emails = lib.callback.await('z-phone:server:GetEmails', false)
    if not emails then
        --TODO: debug here
        return
    end

    for i, v in pairs(emails) do
        local job = QBCore.Shared.Jobs[v.institution]
        emails[i].avatar = 'https://raw.githubusercontent.com/alfaben12/kmrp-assets/main/logo/business/'.. v.institution ..'.png'
        emails[i].name = job and job.label or v.institution:gsub("(%l)(%w*)", function(a,b) return string.upper(a)..b end)
    end

    cb(emails)
end)