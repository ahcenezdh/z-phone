RegisterNUICallback('get-garages', function(_, cb)
    local vehicles = lib.callback.await('z-phone:server:GetVehicles', false)
    if not vehicles then
        --TODO: debug here
        return
    end

    local VehiclesFormatted = {}
    for _, v in pairs(vehicles) do
        local VehicleData = QBCore.Shared.Vehicles[v.vehicle]

        VehiclesFormatted[#VehiclesFormatted + 1] = {
            name = VehicleData['name'] or 'Unknown Vehicle',
            image = "https://raw.githubusercontent.com/alfaben12/kmrp-assets/main/images/".. v.vehicle ..".png",
            brand = VehicleData and VehicleData['brand'] or '',
            model = VehicleData and VehicleData['model'] or '',
            type = VehicleData and VehicleData['type'] or '',
            category = VehicleData and VehicleData['category'] or '',
            plate = v.plate,
            garage = v.garage,
            state = v.state,
            fuel = v.fuel,
            engine = v.engine,
            body = v.body,
            created_at = v.created_at,
        }
    end

    cb(VehiclesFormatted)
end)