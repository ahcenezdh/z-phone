RegisterNUICallback('get-news', function(_, cb)
    local getNews = lib.callback.await('z-phone:server:GetNews', false)
    if not getNews then
        --TODO: debug here
        return
    end
    cb(getNews)
end)

RegisterNUICallback('create-news', function(body, cb)
    local createNews = lib.callback.await('z-phone:server:CreateNews', false, body)
    if not createNews then
        --TODO: debug here
        return
    end
    cb(createNews)
end)