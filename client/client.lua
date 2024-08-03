local function repairVehicle()
    local playerPed = PlayerPedId()
    local vehicle = lib.getClosestVehicle(GetEntityCoords(playerPed), 5.0)
    
    if vehicle then

        SetVehicleDoorOpen(vehicle, 4, false, false)
        
        if lib.progressCircle({
            duration = Config.FixingDuration,
            label = Config.Translation.FixingCar,
            position = 'bottom',
            useWhileDead = false,
            canCancel = true,
            disable = {car = true, combat = true, move = true},
            anim = {
                dict = 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@',
                clip = 'machinic_loop_mechandplayer'
            }
        }) then

            SetVehicleFixed(vehicle)
            SetVehicleDeformationFixed(vehicle)
            SetVehicleUndriveable(vehicle, false)
            lib.notify({description = Config.Translation.Fixed, type = 'success'})
            SetVehicleDoorShut(vehicle, 4, false)
            TriggerServerEvent('lnd:repair')
        else
            lib.notify({description = Config.Translation.Canceled ,type = 'error'})
            SetVehicleDoorShut(vehicle, 4, false)
        end
    else
        lib.notify({
            description = Config.Translation.NoVehicleNearby,
            type = 'error'
        })
    end
end



exports.ox_target:addGlobalVehicle({
    {
        name = 'repair_vehicle',
        label = Config.Translation.FixCar,
        icon = 'fa-solid fa-wrench',
        distance = 2.0,
        items = Config.RepairItem,
        canInteract = function(entity, distance, coords, name)
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)
            local vehicleCoords = GetEntityCoords(entity)
            local forwardVector = GetEntityForwardVector(entity)
            local toPlayer = playerCoords - vehicleCoords
            local dotProduct = DotProduct(forwardVector, toPlayer)

            return not IsPedInAnyVehicle(playerPed, false) and dotProduct > 0.5
        end,
        onSelect = function()

            local item = Config.RepairItem
            local itemCount = exports.ox_inventory:Search('count', item)

            if itemCount >= 1 then
                repairVehicle()
            else
                lib.notify({description = Config.Translation.NoKit,type = 'error'})
            end
        end
    }
})

function DotProduct(v1, v2)
    return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z
end
