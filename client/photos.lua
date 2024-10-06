RegisterNUICallback('get-photos', function(_, cb)
    local photos = lib.callback.await('z-phone:server:GetPhotos', false)
    if not photos then
        --TODO: debug here
        cb(false)
        return
    end
    cb(photos)
end)

RegisterNUICallback('save-photos', function(body, cb)
    body.location = GetStreetName()
    local savePhotos = lib.callback.await('z-phone:server:SavePhotos', false, body)
    if not savePhotos then
        --TODO: debug here
        cb(false)
        return
    end
    QBCore.Functions.Notify("Successful save to gallery!", 'success')
    cb(true)
end)

RegisterNUICallback('delete-photos', function(body, cb)
    local deletePhotos = lib.callback.await('z-phone:server:DeletePhotos', false, body)
    if not deletePhotos then
        --TODO: debug here
        cb(false)
        return
    end
    QBCore.Functions.Notify("Successful delete from gallery!", 'success')
    
    local photos = lib.callback.await('z-phone:server:GetPhotos', false)
    if not photos then
        --TODO: debug here
        cb(false)
        return
    end
    cb(photos)
end)