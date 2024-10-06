RegisterNUICallback('get-contacts', function(_, cb)
    local contacts = lib.callback.await('z-phone:server:GetContacts', false)
    if not contacts then
        --TODO: debug here
        return
    end
    cb(contacts)
end)

RegisterNUICallback('delete-contact', function(body, cb)
    local deleteContact = lib.callback.await('z-phone:server:DeleteContact', false, body)
    if not deleteContact then
        --TODO: debug here
        return
    end
    cb(deleteContact)
end)

RegisterNUICallback('update-contact', function(body, cb)
    local updateContact = lib.callback.await('z-phone:server:UpdateContact', false, body)
    if not updateContact then
        --TODO: debug here
        return
    end
    cb(updateContact)
end)

RegisterNUICallback('save-contact', function(body, cb)
    local saveContact = lib.callback.await('z-phone:server:SaveContact', false, body)
    if not saveContact then
        --TODO: debug here
        return
    end
    cb(saveContact)
end)

RegisterNUICallback('get-contact-requests', function(_, cb)
    local contactRequests = lib.callback.await('z-phone:server:GetContactRequest', false)
    if not contactRequests then
        --TODO: debug here
        return
    end
    cb(contactRequests)
end)

RegisterNUICallback('share-contact', function(body, cb)
    local closestPlayer, distance = QBCore.Functions.GetClosestPlayer()

    if not (distance ~= -1 and distance < 2 and GetEntitySpeed(cache.ped) < 5.0 and not QBCore.Functions.GetPlayerData().metadata.ishandcuffed and not IsPedRagdoll(cache.ped)) then
        TriggerEvent("z-phone:client:sendNotifInternal", {
            type = "Notification",
            from = "Contact",
            message = "Cannot share contact!"
        })
        cb(false)
        return
    end

    body.to_source = GetPlayerServerId(closestPlayer)
    local shareContact = lib.callback.await('z-phone:server:ShareContact', false, body)
    if not shareContact then
        --TODO: debug here
        return
    end
    TriggerEvent("z-phone:client:sendNotifInternal", {
        type = "Notification",
        from = "Contact",
        message = "Success share contact!"
    })
    cb(shareContact)
end)

RegisterNUICallback('delete-contact-requests', function(body, cb)
    local deleteContactRequests = lib.callback.await('z-phone:server:DeleteContactRequest', false, body)
    if not deleteContactRequests then
        --TODO: debug here
        return
    end
    cb(deleteContactRequests)
end)