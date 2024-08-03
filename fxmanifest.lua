fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'lnd'

shared_script {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
    'config.lua'
}


client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}
