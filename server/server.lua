RegisterNetEvent('lnd:repair')
AddEventHandler('lnd:repair', function()
    local source = source
    local item = exports.ox_inventory:GetItemCount(source, Config.RepairItem)
    if item >= 1 then
        exports.ox_inventory:RemoveItem(source, Config.RepairItem, 1)
    else
        TriggerClientEvent('ox_lib:notify', source, {description = Config.Translation.NoKit,type = 'error'})
        print('WTF?')
    end
end)

