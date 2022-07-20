Config = {}

Config.Locale = 'en'

Config.Command = "kit"

Config.ServerName = "My Server"

Config.Kits = { -- Right now scipt support only 3 kits, of course you can add less like you see below
    {
        ["title"] = "Daily Kit",
        ["name"] = "daily", -- Name without spaces used in databes to verify kit
        ["icon"] = "daily.png",
        ["duration"] = 24, -- in hours
        ["money"] = 1000, -- if you don't want to give money set to 0
        ["weapons"] = nil, --{ -- if you don't want to give any weapon set ["weapons"] = nil
        --     {
        --         ["weaponModel"] = "WEAPON_PISTOL"
        --         ["ammo"] = 100
        --     },
        --     {
        --         ["weaponModel"] = "WEAPON_COMBATPISTOL"
        --         ["ammo"] = 50
        --     }
        -- },
        ["items"] = { -- if you don't want to give any items set ["items"] = nil
            {
                ["itemName"] = "apple",
                ["amount"] = 10
            },
            {
                ["itemName"] = "goldbar",
                ["amount"] = 5
            }
        }
    },
    {
        ["title"] = "Weapons Kit",
        ["name"] = "weapons", -- Name without spaces used in databes to verify kit
        ["icon"] = "weapons.png",
        ["duration"] = 24, -- in hours
        ["money"] = 1000, -- if you don't want to give money set to 0
        ["weapons"] = nil,
        ["items"] = { -- if you don't want to give any items set ["items"] = nil
            {
                ["itemName"] = "apple",
                ["amount"] = 10
            },
            {
                ["itemName"] = "goldbar",
                ["amount"] = 5
            }
        }
    }
}