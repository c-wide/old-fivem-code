fx_version 'bodacious'

game 'gta5'

ui_page "ui/html/index.html"

files { "ui/html/main.js", "ui/html/index.html" }

client_scripts {
    'config.lua',
    'client/*.lua',
}

server_scripts {
    'config.lua',
    'server/*.lua',
}