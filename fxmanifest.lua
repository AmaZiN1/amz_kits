fx_version 'adamant'
game 'gta5'
description 'amazin18 - kits script'
version '1.0'

ui_page('html/index.html')

client_scripts {
    '@es_extended/locale.lua',
    'locales/en.lua',
    'locales/pl.lua',
    'config.lua',
    'client/client.lua'
}
server_scripts{
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'locales/en.lua',
    'locales/pl.lua',
    'config.lua',
    'server/server.lua'
} 

files({
    'html/index.html',
    'html/script.js',
    'html/jquery-3.4.1.min.js',
    'html/style.css',
    'html/logo.png',
    'html/icons/*.*'
})

dependency 'es_extended'