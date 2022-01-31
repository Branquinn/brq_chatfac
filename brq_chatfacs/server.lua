local perms = {
    ['ballas.permissao'] = {r = 106,g = 13,b = 173, s = 1, f = 6},
    ['vagos.permissao'] = {r = 249, g = 215, b = 28, s = 1, f = 5},
    ['families.permissao'] = {r = 51, g = 255, b = 70, s = 1, f = 8},
    ['crips.permissao'] = {r = 0, g = 102, b = 255, s = 1, f = 5},
	['israelita.permissao'] = {r = 0, g = 102, b = 0, s = 1, f = 9},
    ['bloods.permissao'] = {r = 255, g = 0, b = 0, s = 1, f = 6},
    ['yardie.permissao'] = {r = 24, g = 153, b = 232, s = 1, f = 6},
    ['siciliana.permissao'] = {r = 117, g = 27, b = 255, s = 1, f = 9},
	['russkaya.permissao'] = {r = 117, g = 27, b = 255, s = 1, f = 8},
    ['bahamas.permissao'] = {r = 186, g = 12, b = 221, s = 1, f = 7},
    ['lifeinvader.permissao'] = {r = 255, g = 153, b = 102, s = 1, f = 11},
}

function checkPerm(source)
    local user_id = vRP.getUserId(source)
    for k,v in pairs(perms) do
        if vRP.hasPermission(user_id,k) then
            return k
        end
    end
end

RegisterCommand('cf', function(source,args,rawCommand)
    if args[1] then
        if checkPerm(source) then
            local user_id = vRP.getUserId(source)
            local fac = checkPerm(source)
            local identity = vRP.getUserIdentity(user_id)
            local vida = vRPclient.getHealth(source)

        	if vida <= 101 then TriggerClientEvent('Notify', source, 'negado','Negado', 'Você não pode fazer isso em coma.') return end
            local membros = vRP.getUsersByPermission(fac)
            for _,v in pairs(membros) do
                local playerB = vRP.getUserSource(parseInt(v))
                if playerB then
                    async(function()
                        TriggerClientEvent('chatMessage',playerB, string.upper(string.sub(fac ,perms[fac].s, perms[fac].f)).." - "..identity.name.." "..identity.firstname..":",{perms[fac].r,perms[fac].g,perms[fac].b},string.sub(rawCommand, 4))
                    end)
                end
            end
        end
    end
end)