-- ATM Cash Amounts in Server file

Config = {}

Config.InputKey = 47 -- G
Config.InputKeyLabel = '[G]'

Config.RayCastDistance = 3.0

Config.SwingAnimDict = 'melee@large_wpn@streamed_core'
Config.SwingAnimName = 'car_down_attack'

Config.StealAnimDict = 'oddjobs@shop_robbery@rob_till'
Config.StealAnimName = 'loop'

Config.GlobalCooldown = 720000 -- ms
Config.IndividualCooldown = 2700000 -- ms

Config.MinBreakInTime = 12 -- seconds
Config.MaxBreakInTime = 15 -- seconds

Config.StealCashInterval = 3000 -- ms

Config.MinStealInterval = 80
Config.MaxStealInterval = 105

Config.CopsOnlineBonus = 250

Config.TabletAnimDict = 'amb@code_human_in_bus_passenger_idles@female@tablet@base'
Config.TabletAnimName = 'base'

Config.ATMCamCommandName = 'patm'
Config.ATMCheckCommandName = 'check'
Config.ATMHelpCommandName = 'help'

Config.PoliceJobName = 'police'

Config.ForceQuitDistance = 3.0

Config.AttachPropList = {
    ["tablet01"] = { 
      ["model"] = "prop_cs_tablet", ["bone"] = 60309, ["x"] = 0.03,["y"] = 0.002,["z"] = -0.0,["xR"] = 10.0,["yR"] = 160.0, ["zR"] = 0.0 
    }
  }

Config.WeaponHashes = {
    -2067956739, -- Crowbar
    1317494643, -- Hammer
    419712736, -- Wrench
}

Config.ATMLocations = {
    {
        hash = -1126237515,
        locations = {
            { ['vector'] = vector3(-821.8936, -1081.555, 10.13664), ['camHeading'] = 211.1 },
            { ['vector'] = vector3(1077.779, -776.9664, 57.25652), ['camHeading'] = 359.8 },
            { ['vector'] = vector3(285.3485, 142.9751, 103.1623), ['camHeading'] = 340.71 },
            { ['vector'] = vector3(289.2679, -1282.32, 28.65519), ['camHeading'] = 90.75 },
            { ['vector'] = vector3(289.53, -1256.788, 28.44057), ['camHeading'] = 90.32 },
            { ['vector'] = vector3(-262.3608, -2012.054, 29.16964), ['camHeading'] = 226.99 },
            { ['vector'] = vector3(-273.3665, -2024.208, 29.16964), ['camHeading'] = 215.82 },
            { ['vector'] = vector3(-712.9357, -818.4827, 22.74066), ['camHeading'] = 182.79 },
            { ['vector'] = vector3(296.8775, -894.3196, 28.26148), ['camHeading'] = 70.14 },
            { ['vector'] = vector3(296.1756, -896.2318, 28.29015), ['camHeading'] = 70.14 },
        },
    },
    {
        hash = -870868698,
        locations = {
            { ['vector'] = vector3(-57.17029, -92.37918, 56.75069), ['camHeading'] = 117.37 },
            { ['vector'] = vector3(380.6558, 322.8424, 102.5663), ['camHeading'] = 349.03 },
            { ['vector'] = vector3(314.5653, -593.5123, 42.29851), ['camHeading'] = 253.21 },
            { ['vector'] = vector3(33.19432, -1348.806, 28.49696), ['camHeading'] = 358.79 },
            { ['vector'] = vector3(-57.40224, -1751.747, 28.42094), ['camHeading'] = 229.07 },
            { ['vector'] = vector3(1153.111, -326.9019, 68.20503), ['camHeading'] = 277.76 },
            { ['vector'] = vector3(-3240.028, 1008.545, 11.83064), ['camHeading'] = 86.41 },
            { ['vector'] = vector3(-3040.205, 593.2969, 6.908859), ['camHeading'] = 107.26 },
            { ['vector'] = vector3(-1827.689, 784.465, 137.3152), ['camHeading'] = 310.01 },
            { ['vector'] = vector3(-718.2614, -915.7128, 18.21553), ['camHeading'] = 270.93 },
        },
    },
    {
        hash = -1364697528,
        locations = {
            { ['vector'] = vector3(112.4761, -819.808, 30.33955), ['camHeading'] = 338.64 },
            { ['vector'] = vector3(89.81339, 2.880325, 67.35214), ['camHeading'] = 160.57 },
            { ['vector'] = vector3(-165.5844, 232.6955, 93.92897), ['camHeading'] = 269.41 },
            { ['vector'] = vector3(-165.5844, 234.7659, 93.92897), ['camHeading'] = 269.41 },
            { ['vector'] = vector3(111.3886, -774.8401, 30.43766), ['camHeading'] = 163.71 },
            { ['vector'] = vector3(114.5474, -775.9721, 30.41736), ['camHeading'] = 163.71 },
            { ['vector'] = vector3(112.4761, -819.808, 30.33955), ['camHeading'] = 339.29 },
            { ['vector'] = vector3(-301.6573, -829.5886, 31.41977), ['camHeading'] = 159.55 },
            { ['vector'] = vector3(-303.2257, -829.3121, 31.41977), ['camHeading'] = 159.55 },
            { ['vector'] = vector3(-537.8052, -854.9357, 28.27543), ['camHeading'] = 1.7 },
            { ['vector'] = vector3(-254.5219, -692.8869, 32.57825), ['camHeading'] = 340.09 },
        },
    },
}