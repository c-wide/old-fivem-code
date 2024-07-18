Config = {}

Config.InputKey = 38 -- E
Config.InputKeyLabel = '[E]'

Config.DutyStartLocation = vector3(743.88, -1906, 29.81)
Config.DutyStartMarkerDrawDistance = 5
Config.DutyStartInputKeyUseDistance = 1.5

Config.VehicleName = 'boxville'
Config.LicensePlateText = 'LSDWP'
Config.VehicleHash = -1987130134
Config.VehicleSpawnLocation = vector4(736.99, -1909.67, 29.29, 177.07)
Config.VehicleSpawnMarkerDrawDistance = 20
Config.VehicleSpawnInputKeyUseDistance = 8
Config.VehicleRentalPrice = 500

Config.JobSiteAnchorPointCheckDistance  = 20
Config.JobSiteMarkerDrawDistance = 8
Config.JobSiteInputKeyUseDistance = 5

Config.ProgressBarLabel = 'Repairing...'
Config.ProgressBarDuration = 5000

Config.MinimumPayout = 65
Config.MaximumPayout = 105

Config.MinimumAddition = 20
Config.MaximumAddition = 35

Config.TaskShowKey = 47 -- G KEY

--------------------
-- if nil use cash
--------------------
Config.AccountName = nil

Config.RayCastDistance = 5.0

Config.MaxDistanceBetweenPlayers = 300

Config.BlipDetails = {
    DutyStart = {
        name = 'Los Santos Water & Power',
        sprite = 85,
        color = 81,
        scale = 1.1,
    },
    JobSite = {
        name = 'Jobsite',
        sprite = 402,
        color = 81,
        scale = 1.1,
    },
    Task = {
        name = 'Task',
        sprite = 402,
        color = 81,
        scale = 0.8,
    },
}

Config.Locations = {
    {
        AnchorPoint  = vector3(-1373.01, -330.89, 39.13),
        MaxTasks = 5,
        Objects = {
            {
                hash = -686494084,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
            {
                hash = 1369811908,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
            {
                hash = 1709954128,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(-1382.967, -327.8795, 38.92463),
            vector3(-1392.14, -326.9658, 55.54677),
            vector3(-1393.806, -325.0094, 55.54677),
            vector3(-1369.145, -337.9551, 43.40527),
            vector3(-1340.298, -338.8221, 44.33369),
            vector3(-1388.203, -320.8171, 55.54677),
            vector3(-1389.878, -318.821, 55.54677),
            vector3(-1372.122, -338.4929, 43.43946),
            vector3(-1367.105, -335.3767, 43.43946),
            vector3(-1355.527, -337.9517, 42.89217),
            vector3(-1353.067, -336.4545, 42.89217),
        }
    },
    {
        AnchorPoint = vector3(1158.52, -1496.14, 34.69),
        MaxTasks = 10,
        Objects = {
            {
                hash = -2007495856,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                }
            },
            {
                hash = 1923262137,
                animations = {
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                }
            },
            {
                hash = 1419852836,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                }
            },
            {
                hash = 1709954128,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                }
            },
            {
                hash = -686494084,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                }
            },
        },
        ObjectLocations = {
            vector3(1157.099, -1462.864, 33.80096),
            vector3(1114.989, -1465.365, 33.80096),
            vector3(1097.995, -1470.069, 33.80096),
            vector3(1121.324, -1473.84, 33.80096),
            vector3(1111.269, -1519.118, 33.80096),
            vector3(1139.675, -1494.214, 33.85681),
            vector3(1145.423, -1527.183, 33.82765),
            vector3(1167.765, -1530.212, 33.82765),
            vector3(1207.953, -1491.617, 33.80096),
            vector3(1223.954, -1487.13, 33.80096),
            vector3(1242.374, -1474.125, 33.60684),
            vector3(1218.906, -1535.961, 33.80096),
            vector3(1206.795, -1522.291, 33.82765),
            vector3(1172.318, -1577.593, 33.62605),
            vector3(1166.366, -1589.028, 33.82765),
            vector3(1148.53, -1631.433, 33.82765),
            vector3(1127.284, -1622.199, 33.82765),
            vector3(1216.941, -1460.83, 33.80096),
            vector3(1112.754, -1465.483, 33.84062),
            vector3(1111.165, -1514.462, 33.80077),
            vector3(1170.139, -1486.887, 33.80077),
            vector3(1188.723, -1498.806, 33.83861),
            vector3(1166.035, -1530.341, 33.84058),
            vector3(1246.571, -1491.151, 33.70763),
            vector3(1240.003, -1460.534, 33.88849),
            vector3(1204.051, -1530.756, 33.7891),
            vector3(1159.351, -1581.443, 33.83626),
            vector3(1155.467, -1571.898, 33.83929),
            vector3(1167.249, -1587.724, 33.8383),
            vector3(1152.024, -1596.003, 33.82878),
            vector3(1183.339, -1463.824, 33.81557),
            vector3(1158.835, -1462.935, 33.84143),
            vector3(1139.664, -1492.574, 33.84069),
            vector3(1175.582, -1498.833, 33.88035),
            vector3(1220.133, -1536.053, 33.88035),
            vector3(1188.602, -1565.029, 33.73186),
            vector3(1162.193, -1544.177, 33.66237),
            vector3(1172.404, -1601.482, 33.88035),
            vector3(1151.401, -1628.745, 33.78023),
            vector3(1129.519, -1602.986, 33.88187),
            vector3(1118.318, -1623.361, 33.85131),
            vector3(1127.705, -1477.945, 33.81696),
            vector3(1133.577, -1520.878, 33.80004),
            vector3(1173.353, -1491.87, 33.80981),
            vector3(1212.799, -1498.721, 33.83221),
            vector3(1245.689, -1474.21, 33.64967),
            vector3(1212.377, -1531.59, 33.80766),
            vector3(1191.68, -1527.825, 33.64967),
            vector3(1187.963, -1527.208, 33.66061),
            vector3(1162.344, -1552.574, 33.75831),
            vector3(1168.191, -1578.641, 33.81139),
            vector3(1170.64, -1603.739, 33.82921),
            vector3(1115.651, -1597.954, 33.82921),
            vector3(1114.55, -1566.049, 33.83904),
            vector3(1219.802, -1463.819, 33.80981),
        }
    },
    {
        AnchorPoint = vector3(-367.24, -2179.4, 10.32),
        MaxTasks = 3,
        Objects = {
            {
                hash = -525926661,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1464363276,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = -2007495856,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1923262137,
                animations = {
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = -2008643115,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(-378.1803, -2184.315, 9.291336),
            vector3(-377.943, -2176.335, 9.301834),
            vector3(-351.6798, -2182.959, 9.287636),
            vector3(-351.6798, -2175.388, 9.288647),
            vector3(-376.6263, -2166.3, 9.351341),
            vector3(-371.7471, -2189.305, 9.29694),
            vector3(-370.0049, -2189.435, 9.283821),
            vector3(-353.1107, -2157.31, 9.345592),
        },
    },
    {
        AnchorPoint = vector3(-204.98, -2661.11, 6),
        MaxTasks = 3,
        Objects = {
            {
                hash = 1464363276,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = -525926661,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(-225.6333, -2661.963, 10.79345),
            vector3(-221.6333, -2661.963, 10.79345),
            vector3(-229.6333, -2652.429, 10.79345),
            vector3(-236.2771, -2655.047, 10.79345),
            vector3(-236.2771, -2663.015, 10.79345),
        },
    },
    {
        AnchorPoint = vector3(-142.29, -1425.37, 30.77),
        MaxTasks = 3,
        Objects = {
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(-149.1232, -1430.593, 36.56374),
            vector3(-159.6482, -1426.836, 36.56374),
            vector3(-156.7448, -1441.601, 36.5713),
            vector3(-160.6538, -1447.878, 36.56374),
        },
    },
    {
        AnchorPoint = vector3(122.14, -1076.03, 29.19),
        MaxTasks = 3,
        Objects = {
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(119.6427, -1106.175, 34.65505),
            vector3(119.6427, -1100.238, 34.65505),
            vector3(119.6427, -1094.682, 34.65505),
        },
    },
    {
        AnchorPoint = vector3(-2037.82, -264.18, 23.39),
        MaxTasks = 4,
        Objects = {
            {
                hash = 1948414141,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1923262137,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(-2010.634, -257.2947, 28.37072),
            vector3(-2016.374, -253.2759, 28.37072),
            vector3(-2019.19, -257.2986, 28.37072),
            vector3(-2020.554, -265.3082, 29.57211),
            vector3(-2023.201, -269.0943, 29.57211),
            vector3(-2031.32, -280.7233, 29.57213),
            vector3(-1996.231, -259.6152, 28.08844),
        },
    },
    {
        AnchorPoint = vector3(-1518.67, -882.94, 10.11),
        MaxTasks = 4,
        Objects = {
            {
                hash = -2008643115,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1709954128,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(-1470.906, -915.851, 9.062397),
            vector3(-1498.68, -894.5293, 9.141613),
            vector3(-1513.295, -887.9077, 9.214504),
            vector3(-1538.239, -894.2919, 9.175404),
            vector3(-1515.28, -893.8688, 18.2067),
            vector3(-1516.674, -895.5308, 18.2067),
            vector3(-1524.669, -905.0593, 18.2067),
            vector3(-1516.358, -905.0986, 18.21944),
            vector3(-1499.86, -896.7067, 18.0635),
        },
    },
    {
        AnchorPoint = vector3(-365.95, -147.83, 38.24),
        MaxTasks = 4,
        Objects = {
            {
                hash = 1369811908,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
            {
                hash = 1426534598,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
        },
        ObjectLocations = {
            vector3(-343.6639, -147.9469, 59.71653),
            vector3(-340.7068, -146.2336, 59.71653),
            vector3(-337.7789, -136.3829, 59.71653),
            vector3(-317.669, -132.1108, 59.79169),
            vector3(-314.2394, -132.8449, 59.79169),
            vector3(-326.2296, -156.3497, 59.43047),
            vector3(-319.9146, -152.7663, 59.43047),
        },
    },
    {
        AnchorPoint = vector3(-10.81, -1100.1, 26.67),
        MaxTasks = 2,
        Objects = {
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(-23.03003, -1089.861, 28.82885),
            vector3(-19.9527, -1090.981, 28.82885),
        },
    },
    {
        AnchorPoint = vector3(-576.5, -278.55, 35.12),
        MaxTasks = 8,
        Objects = {
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = -2008643115,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1709954128,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(-583.143, -286.1217, 49.57642),
            vector3(-592.4896, -283.6614, 49.33864),
            vector3(-594.0453, -275.9043, 49.76855),
            vector3(-600.8947, -274.4933, 49.52086),
            vector3(-605.8746, -271.0219, 51.26827),
            vector3(-598.0626, -267.996, 52.38121),
            vector3(-609.515, -273.1237, 51.26827),
            vector3(-614.0565, -270.7108, 51.27687),
            vector3(-603.9144, -257.0275, 51.2746),
            vector3(-608.0992, -251.6019, 51.48898),
            vector3(-619.3942, -244.3756, 50.32102),
            vector3(-622.5159, -246.1779, 50.32102),
            vector3(-624.1733, -242.4053, 54.81665),
            vector3(-629.6971, -227.3323, 54.92567),
            vector3(-631.4316, -219.3237, 52.54203),
            vector3(-633.2137, -211.8837, 52.55918),
            vector3(-634.9241, -208.7106, 52.55918),
            vector3(-637.0407, -211.4796, 52.55978),
            vector3(-641.0692, -214.1608, 52.80526),
            vector3(-647.8753, -212.5458, 52.55755),
        },
    },
    {
        AnchorPoint = vector3(-780.56, -196.13, 37.28),
        MaxTasks = 8,
        Objects = {
            {
                hash = 1709954128,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(-792.6735, -146.4249, 49.78894),
            vector3(-789.9679, -141.5436, 49.82385),
            vector3(-784.5508, -145.4722, 49.82071),
            vector3(-784.4238, -153.469, 51.93789),
            vector3(-790.3776, -156.9064, 51.94263),
            vector3(-774.1394, -155.8771, 45.65295),
            vector3(-780.9319, -161.8794, 45.68423),
            vector3(-784.6552, -167.0167, 45.68423),
            vector3(-778.6642, -166.3613, 45.66711),
            vector3(-773.9027, -163.1343, 45.66711),
            vector3(-776.2614, -169.2435, 45.66711),
            vector3(-766.1631, -184.631, 47.62438),
            vector3(-768.3785, -193.0435, 47.62438),
            vector3(-765.6364, -191.0379, 47.62563),
            vector3(-757.6042, -189.1769, 47.63718),
            vector3(-755.9785, -196.7693, 47.62487),
            vector3(-750.8164, -200.4971, 47.62273),
            vector3(-755.5983, -202.9377, 47.62596),
            vector3(-758.4803, -205.3406, 47.62573),
            vector3(-752.3712, -207.6992, 47.62642),
        },
    },
    {
        AnchorPoint = vector3(-1132.62, -436.87, 35.91),
        MaxTasks = 5,
        Objects = {
            {
                hash = 1369811908,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
            {
                hash = 1426534598,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
            {
                hash = 1195939145,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
        },
        ObjectLocations = {
            vector3(-1150.045, -430.3041, 42.87778),
            vector3(-1146.41, -440.902, 42.91656),
            vector3(-1157.191, -435.1889, 42.93613),
            vector3(-1163.74, -449.9066, 42.93406),
            vector3(-1181.852, -438.8713, 42.86417),
            vector3(-1173.535, -453.5128, 42.91935),
            vector3(-1172.589, -434.5528, 42.88511),
            vector3(-1194.649, -444.2861, 46.34116),
            vector3(-1196.555, -441.377, 46.34116),
            vector3(-1191.498, -453.7465, 46.34385),
            vector3(-1205.995, -463.0606, 46.84612),
            vector3(-1219.732, -465.1452, 46.86362),
            vector3(-1222.25, -472.8907, 46.86362),
            vector3(-1236.827, -483.4966, 47.4072),
            vector3(-1241.943, -488.4284, 47.4072),
            vector3(-1247.097, -496.7455, 47.4072),
        },
    },
    {
        AnchorPoint = vector3(-1104.96, -574.68, 32.67),
        MaxTasks = 4,
        Objects = {
            {
                hash = 1369811908,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
            {
                hash = 1426534598,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
            {
                hash = 1195939145,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
        },
        ObjectLocations = {
            vector3(-1104.98, -559.241, 46.91675),
            vector3(-1097.91, -555.7705, 46.91675),
            vector3(-1100.471, -549.9105, 46.97322),
            vector3(-1094.741, -554.1911, 46.91675),
            vector3(-1132.341, -570.7723, 47.47636),
            vector3(-1137.685, -575.0392, 47.47558),
            vector3(-1137.01, -564.0133, 47.45937),
            vector3(-1142.315, -551.6237, 47.47575),
            vector3(-1137.563, -548.309, 47.4688),
        },
    },
    {
        AnchorPoint = vector3(-1316.22, -589.64, 28.81),
        MaxTasks = 3,
        Objects = {
            {
                hash = 1426534598,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
            {
                hash = 1369811908,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
        },
        ObjectLocations = {
            vector3(-1280.871, -596.7731, 40.95924),
            vector3(-1288.547, -601.2949, 40.98909),
            vector3(-1283.779, -606.9779, 40.98909),
            vector3(-1313.739, -557.603, 40.95924),
            vector3(-1319.335, -564.5756, 40.98909),
            vector3(-1324.104, -558.8925, 40.98909),
        },
    },
    {
        AnchorPoint = vector3(-1324.31, -761.41, 20.39),
        MaxTasks = 4,
        Objects = {
            {
                hash = 1426534598,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
            {
                hash = 1709954128,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1369811908,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
        },
        ObjectLocations = {
            vector3(-1320.45, -744.6051, 30.62009),
            vector3(-1307.063, -738.6742, 30.59464),
            vector3(-1305.779, -729.8383, 30.61176),
            vector3(-1304.544, -735.8937, 30.59464),
            vector3(-1298.167, -732.6991, 30.6409),
            vector3(-1292.957, -734.6991, 30.60599),
            vector3(-1295.031, -726.7881, 30.63776),
            vector3(-1290.484, -744.3315, 35.84145),
            vector3(-1290.719, -747.901, 35.85654),
            vector3(-1287.879, -745.6818, 35.85654),
            vector3(-1290.632, -761.006, 35.81271),
            vector3(-1298.367, -756.3419, 35.84145),
            vector3(-1301.936, -756.1062, 35.85654),
            vector3(-1299.717, -758.9467, 35.85654),
            vector3(-1302.236, -770.0721, 35.81271),
        },
    },
    {
        AnchorPoint = vector3(-1346.07, -749.26, 22.33),
        MaxTasks = 4,
        Objects = {
            {
                hash = 1426534598,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
            {
                hash = 1709954128,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1369811908,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
        },
        ObjectLocations = {
            vector3(-1361.434, -755.822, 40.67972),
            vector3(-1366.749, -748.7793, 40.67972),
            vector3(-1380.221, -741.3512, 40.65723),
            vector3(-1382.957, -738.7833, 40.65723),
            vector3(-1374.145, -740.2218, 40.67435),
            vector3(-1370.856, -734.2921, 40.66965),
            vector3(-1370.559, -730.7274, 40.65456),
            vector3(-1367.978, -732.1228, 40.66965),
        },
    },
    {
        AnchorPoint = vector3(-1409.42, -643.66, 28.67),
        MaxTasks = 5,
        Objects = {
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = -1393761711,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1426534598,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
        },
        ObjectLocations = {
            vector3(-1433.735, -628.188, 37.90385),
            vector3(-1435.413, -621.3878, 37.91837),
            vector3(-1431.59, -637.408, 37.91826),
            vector3(-1428.278, -622.7062, 37.90448),
            vector3(-1417.683, -623.2636, 37.9044),
            vector3(-1422.797, -617.4377, 37.90478),
            vector3(-1417.094, -615.2175, 37.38344),
            vector3(-1406.034, -613.634, 42.24396),
            vector3(-1401.505, -616.991, 42.24813),
            vector3(-1395.206, -617.645, 42.24399),
            vector3(-1388.401, -632.882, 42.2474),
            vector3(-1372.553, -628.7517, 42.2474),
        },
    },
    {
        AnchorPoint = vector3(61.96, -1425.06, 29.31),
        MaxTasks = 3,
        Objects = {
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(70.3522, -1392.152, 33.70309),
            vector3(81.2009, -1400.354, 33.70309),
            vector3(89.47073, -1414.444, 33.70309),
            vector3(75.79599, -1417.322, 33.72225),
            vector3(71.91302, -1423.089, 33.70309),
            vector3(90.93021, -1432.191, 33.70309),
        },
    },
    {
        AnchorPoint = vector3(327.1, -210, 54.09),
        MaxTasks = 3,
        Objects = {
            {
                hash = 1709954128,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(329.2917, -227.9742, 60.52772),
            vector3(341.7026, -226.9395, 60.50201),
            vector3(348.7722, -208.5227, 60.50201),
            vector3(310.6047, -194.0826, 60.52945),
            vector3(303.5351, -212.4993, 60.53991),
            vector3(307.7641, -220.1192, 60.53818),
        },
    },
    {
        AnchorPoint = vector3(2819.49, 1559.6, 24.56),
        MaxTasks = 8,
        Objects = {
            {
                hash = 1870961552,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1464363276,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = -525926661,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(2860.686, 1560.167, 23.76205),
            vector3(2861.445, 1562.819, 23.76365),
            vector3(2858.286, 1564, 23.78796),
            vector3(2854.729, 1564.55, 23.7479),
            vector3(2853.969, 1561.897, 23.7463),
            vector3(2857.526, 1561.347, 23.77007),
            vector3(2858.488, 1553.159, 23.71306),
            vector3(2852.551, 1554.728, 23.71306),
            vector3(2843.194, 1566.224, 23.76715),
            vector3(2837.249, 1567.766, 23.76715),
            vector3(2834.947, 1560.477, 23.77787),
            vector3(2838.066, 1559.669, 23.77787),
            vector3(2841.167, 1558.864, 23.77787),
            vector3(2850.373, 1545.6, 23.61076),
            vector3(2853.48, 1544.822, 23.61076),
            vector3(2856.606, 1544.038, 23.61076),
            vector3(2839.077, 1550.343, 23.70862),
            vector3(2833.144, 1551.93, 23.70862),
            vector3(2848.418, 1538.267, 23.71575),
            vector3(2854.353, 1536.688, 23.71726),
            vector3(2837.438, 1542.597, 23.72897),
            vector3(2836.657, 1539.95, 23.72897),
            vector3(2833.104, 1540.53, 23.60403),
            vector3(2829.955, 1541.736, 23.72897),
            vector3(2830.736, 1544.383, 23.72897),
            vector3(2833.886, 1543.177, 23.60403),
        },
    },
    {
        AnchorPoint = vector3(2803.2, 1507.57, 24.61),
        MaxTasks = 8,
        Objects = {
            {
                hash = -525926661,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1870961552,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1464363276,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(2814.93, 1518.377, 23.76715),
            vector3(2820.876, 1516.836, 23.76715),
            vector3(2832.41, 1515.162, 23.7479),
            vector3(2831.65, 1512.509, 23.7463),
            vector3(2835.208, 1511.959, 23.77007),
            vector3(2838.367, 1510.778, 23.76205),
            vector3(2839.127, 1513.431, 23.76365),
            vector3(2835.967, 1514.612, 23.78796),
            vector3(2836.169, 1503.77, 23.71306),
            vector3(2830.232, 1505.34, 23.71306),
            vector3(2818.848, 1509.475, 23.77787),
            vector3(2815.748, 1510.28, 23.77787),
            vector3(2812.629, 1511.088, 23.77787),
            vector3(2810.825, 1502.542, 23.70862),
            vector3(2816.759, 1500.955, 23.70862),
            vector3(2828.054, 1496.212, 23.61076),
            vector3(2831.162, 1495.433, 23.61076),
            vector3(2834.288, 1494.65, 23.61076),
            vector3(2832.034, 1487.3, 23.71726),
            vector3(2826.099, 1488.879, 23.71575),
            vector3(2815.12, 1493.208, 23.72897),
            vector3(2811.567, 1493.788, 23.60403),
            vector3(2808.418, 1494.995, 23.72897),
            vector3(2807.636, 1492.348, 23.72897),
            vector3(2810.785, 1491.141, 23.60403),
            vector3(2814.339, 1490.562, 23.72897),
        },
    },
    {
        AnchorPoint = vector3(902.2, -183.07, 73.91),
        MaxTasks = 3,
        Objects = {
            {
                hash = 1948414141,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(889.444, -163.5844, 80.58145),
            vector3(887.2152, -162.2452, 80.58145),
            vector3(894.9948, -148.3755, 80.58145),
            vector3(897.2235, -149.7146, 80.58145),
        },
    },
    {
        AnchorPoint = vector3(1232.17, -470.41, 66.63),
        MaxTasks = 3,
        Objects = {
            {
                hash = 1948414141,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(1223.456, -457.2504, 77.89823),
            vector3(1224.229, -454.3628, 77.89823),
            vector3(1214.481, -460.7107, 77.89823),
            vector3(1213.708, -463.5983, 77.89823),
        },
    },
    {
        AnchorPoint = vector3(-186.99, 211.64, 87.9),
        MaxTasks = 5,
        Objects = {
            {
                hash = -2008643115,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1709954128,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1369811908,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
        },
        ObjectLocations = {
            vector3(-188.755, 228.2344, 89.52177),
            vector3(-188.755, 226.5349, 89.52177),
            vector3(-183.2389, 229.988, 97.79807),
            vector3(-182.614, 237.5781, 97.76903),
            vector3(-178.8355, 237.5869, 99.18274),
            vector3(-178.6976, 228.4976, 99.18204),
            vector3(-183.0077, 227.3497, 95.5153),
            vector3(-182.7088, 222.1746, 95.64584),
            vector3(-167.0245, 229.1399, 99.18188),
            vector3(-167.5313, 236.5412, 99.18196),
        },
    },
    {
        AnchorPoint = vector3(959.34, -1719.84, 30.67),
        MaxTasks = 8,
        Objects = {
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1369811908,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
            {
                hash = 1709954128,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = -2007495856,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1426534598,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
        },
        ObjectLocations = {
            vector3(944.8157, -1739.841, 40.06445),
            vector3(945.5586, -1731.35, 39.91792),
            vector3(945.8831, -1727.642, 39.91792),
            vector3(940.4629, -1726.373, 39.9258),
            vector3(936.9221, -1716.91, 37.06231),
            vector3(922.9183, -1719.975, 37.06232),
            vector3(918.7676, -1710.761, 37.06287),
            vector3(911.1499, -1710.431, 41.96402),
            vector3(905.417, -1707.078, 41.9697),
            vector3(898.554, -1700.339, 41.96151),
            vector3(894.2356, -1708.358, 41.9697),
            vector3(894.6721, -1718.601, 41.45092),
            vector3(889.8657, -1715.665, 37.03259),
            vector3(887.4419, -1710.309, 37.06231),
            vector3(880.3613, -1718.577, 40.18916),
            vector3(880.759, -1714.031, 40.18916),
            vector3(881.1492, -1709.572, 40.18916),
            vector3(881.5508, -1704.982, 40.18916),
            vector3(881.9443, -1700.484, 40.18916),
            vector3(937.0826, -1699.208, 41.06145),
            vector3(944.7379, -1677.063, 41.06145),
            vector3(934.9583, -1671.474, 41.00249),
            vector3(912.815, -1699.789, 49.9487),
            vector3(906.7499, -1696.401, 50.13416),
            vector3(894.6892, -1693.623, 46.14043),
            vector3(889.0889, -1693.133, 46.12043),
            vector3(883.7039, -1692.662, 46.13043),
            vector3(890.8064, -1682.948, 46.13416),
            vector3(889.3936, -1671.83, 46.13416),
        },
    },
    {
        AnchorPoint = vector3(-1178.19, -1386.22, 4.8),
        MaxTasks = 3,
        Objects = {
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(-1166.611, -1387.266, 17.77476),
            vector3(-1155.07, -1377.268, 17.77476),
            vector3(-1152.041, -1382.514, 17.77476),
        },
    },
    {
        AnchorPoint = vector3(-529.35, -31.19, 44.52),
        MaxTasks = 4,
        Objects = {
            {
                hash = 1709954128,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1369811908,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
        },
        ObjectLocations = {
            vector3(-500.564, -39.35435, 49.69294),
            vector3(-506.8702, -37.57256, 49.68118),
            vector3(-511.7686, -33.6503, 49.678),
            vector3(-507.5685, -29.79426, 49.67707),
            vector3(-511.9589, -29.55927, 49.67659),
            vector3(-500.1819, -33.12046, 49.69783),
        },
    },
    {
        AnchorPoint = vector3(-461.3, -51.94, 44.52),
        MaxTasks = 4,
        Objects = {
            {
                hash = 1369811908,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
            {
                hash = 1709954128,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(-451.7614, -44.00255, 53.14471),
            vector3(-458.694, -43.63923, 53.14471),
            vector3(-468.3144, -37.54722, 48.50482),
            vector3(-467.0689, -24.52279, 48.50482),
            vector3(-474.7177, -30.97988, 50.28326),
            vector3(-481.8224, -24.33247, 49.49878),
            vector3(-481.8224, -20.74674, 49.49878),
        },
    },
    {
        AnchorPoint = vector3(-1008.11, -1902.69, 13.17),
        MaxTasks = 8,
        Objects = {
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1195939145,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
            {
                hash = 1709954128,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = -1393761711,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(-967.1545, -2001.872, 18.68349),
            vector3(-960.6511, -1989.834, 18.68093),
            vector3(-974.4709, -1984.889, 18.73545),
            vector3(-979.8948, -1984.31, 18.75922),
            vector3(-982.3852, -1984.7, 18.68349),
            vector3(-984.3771, -1979.673, 18.73545),
            vector3(-989.3524, -1982.314, 18.73545),
            vector3(-980.9797, -1988.343, 18.75922), 
            vector3(-972.4471, -1946.762, 18.66884),
            vector3(-981.8635, -1950.564, 18.68349),
            vector3(-984.2766, -1944.387, 18.73545),
            vector3(-986.4079, -1932.394, 18.66884),
            vector3(-999.248, -1948.258, 18.73545),
            vector3(-998.5154, -1952.37, 18.68349),
            vector3(-993.4536, -1947.98, 18.73545),
            vector3(-1001.842, -1943.271, 18.73545),
            vector3(-998.693, -1939.578, 18.68349),
            vector3(-995.5587, -1938.701, 18.75922),
            vector3(-999.0404, -1932.229, 18.73545),
            vector3(-1003.556, -1936.719, 18.68349),
            vector3(-1004.644, -1914.338, 18.68284),
            vector3(-1018.204, -1948.799, 18.68349),
            vector3(-1025.785, -1948.766, 18.73545),
            vector3(-1029.162, -1942.81, 18.73545),
            vector3(-1031.727, -1948.158, 18.73545),
            vector3(-1030.975, -1952.266, 18.68349),
            vector3(-1026.036, -1961.9, 18.73545),
            vector3(-1027.828, -1964.306, 18.68349),
            vector3(-1028.32, -1991.757, 21.54259),
            vector3(-1031.337, -1992.593, 21.49064),
            vector3(-1040.114, -1996.336, 21.54259),
            vector3(-1034.585, -1993.199, 21.54259),
            vector3(-1053.046, -2002.615, 21.55521),
            vector3(-1041.547, -2014.495, 21.54821),
            vector3(-1039.019, -2016.986, 21.54821),
            vector3(-1036.15, -1975.843, 36.21998),
            vector3(-1046.459, -1972.117, 36.22268),
            vector3(-1043.761, -1976.096, 36.632),
            vector3(-1058.901, -1971.461, 36.20399),
            vector3(-1055.32, -1980.439, 36.15203),
            vector3(-1054.419, -1983.42, 36.20399),
            vector3(-1028.87, -2039.11, 35.92467),
            vector3(-1025.396, -2038.765, 35.92527),
            vector3(-1024.281, -2033.679, 35.92527),
            vector3(-1020.132, -2038.412, 35.92467),
            vector3(-1012.639, -2038.513, 35.92527),
            vector3(-1012.626, -2013.973, 35.92527),
            vector3(-1013.358, -2010.834, 35.92467),
            vector3(-1007.864, -2007.61, 35.92527),
            vector3(-1004.656, -2013.329, 35.92467),
            vector3(-997.1722, -2013.422, 35.92527),
        },
    },
    {
        AnchorPoint = vector3(380.73, -904.46, 29.43),
        MaxTasks = 8,
        Objects = {
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1709954128,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(388.1863, -891.934, 38.16273), 
            vector3(382.4149, -891.934, 38.16273),
            vector3(368.9738, -886.5311, 42.67026),
            vector3(368.9738, -883.5526, 42.67026),
            vector3(368.9738, -880.5651, 42.67026),
            vector3(371.5023, -903.4176, 42.83715),
            vector3(380.2701, -913.0195, 40.13474),
            vector3(385.2252, -913.0195, 40.13474),
            vector3(380.7703, -922.8505, 43.04089),
            vector3(383.7824, -922.8505, 43.04089),
            vector3(386.7946, -922.8505, 43.04089),
            vector3(363.4989, -909.7354, 46.95495),
            vector3(363.4989, -917.3118, 46.95495),
            vector3(363.4989, -902.1589, 46.95495),
            vector3(354.7296, -881.9192, 51.03661),
            vector3(354.7296, -886.931, 51.03661),
        },
    },
    {
        AnchorPoint = vector3(212.41, -287.6, 47.82),
        MaxTasks = 3,
        Objects = {
            {
                hash = 1426534598,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
        },
        ObjectLocations = {
            vector3(243.7411, -318.372, 62.4736),
            vector3(241.0122, -325.9404, 62.4736),
            vector3(248.628, -326.9385, 62.4736),
        },
    },
    {
        AnchorPoint = vector3(730.99, -1983.6, 29.29),
        MaxTasks = 5,
        Objects = {
            {
                hash = -525926661,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1464363276,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(747.8151, -2001.51, 28.13772),
            vector3(741.6884, -2000.974, 28.13772),
            vector3(742.7416, -1988.934, 28.18307),
            vector3(748.8683, -1989.47, 28.15964),
            vector3(749.3241, -1984.659, 28.21329),
            vector3(743.172, -1984.121, 28.23492),
            vector3(743.807, -1976.757, 28.19125),
            vector3(749.9337, -1977.292, 28.16426),
        },
    },
    {
        AnchorPoint = vector3(735.47, -1932.67, 29.29),
        MaxTasks = 5,
        Objects = {
            {
                hash = 1464363276,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = -525926661,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1518466392,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
        },
        ObjectLocations = {
            vector3(747.0253, -1940.358, 28.20627),
            vector3(753.1771, -1940.896, 28.29703),
            vector3(747.4647, -1935.516, 28.17904),
            vector3(753.5917, -1936.052, 28.20956),
            vector3(754.6449, -1924.012, 28.17103),
            vector3(748.5182, -1923.476, 28.09503),
            vector3(757.1686, -1915.845, 28.16066),
            vector3(755.9913, -1915.742, 28.16066),
        },
    },
    {
        AnchorPoint = vector3(1119.39, -2510.16, 33.22),
        MaxTasks = 8,
        Objects = {
            {
                hash = 1464363276,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1870961552,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = -525926661,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(1143.856, -2495.829, 32.40173),
            vector3(1138.569, -2497.097, 32.40173),
            vector3(1142.533, -2491.667, 32.37878),
            vector3(1136.418, -2493.133, 32.37389),
            vector3(1125.735, -2494.974, 32.35485),
            vector3(1119.751, -2496.407, 32.35485),
            vector3(1118.106, -2489.542, 32.35485),
            vector3(1124.081, -2488.068, 32.35485),
            vector3(1135.593, -2489.254, 32.33923),
            vector3(1141.567, -2487.78, 32.33923),
            vector3(1139.804, -2480.423, 32.33923),
            vector3(1133.82, -2481.855, 32.33923),
            vector3(1122.579, -2482.433, 32.36572),
            vector3(1117.292, -2483.7, 32.36572),
        },
    },
    {
        AnchorPoint = vector3(207.08, -1459.54, 29.15),
        MaxTasks = 4,
        Objects = {
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1426534598,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
        },
        ObjectLocations = {
            vector3(224.7047, -1467.829, 34.83028),
            vector3(216.0592, -1466.48, 34.82198),
            vector3(214.1451, -1482.655, 34.84366),
            vector3(228.3119, -1491.867, 34.84366),
            vector3(206.1317, -1491.704, 34.84366),
            vector3(213.7509, -1503.07, 34.84366),
            vector3(200.7844, -1515.088, 34.84366),
            vector3(188.7881, -1527.897, 34.84366),
            vector3(216.6968, -1550.198, 34.81807),
            vector3(206.8482, -1548.967, 34.84366),
        },
    },
    {
        AnchorPoint = vector3(452.06, -1129.04, 29.4),
        MaxTasks = 5,
        Objects = {
            {
                hash = 1214250852,
                animations = {
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1426534598,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
        },
        ObjectLocations = {
            vector3(440.7412, -1104.404, 42.05776),
            vector3(432.8418, -1104.428, 42.05776),
            vector3(440.7412, -1089.187, 42.05776),
            vector3(432.8418, -1089.211, 42.05776),
            vector3(426.4722, -1108.438, 42.05),
            vector3(426.4722, -1102.889, 42.04993),
            vector3(426.4722, -1097.34, 42.05),
            vector3(426.5277, -1091.791, 42.05),
            vector3(426.5277, -1086.241, 42.05),
            vector3(456.8631, -1104.134, 42.05707),
            vector3(456.8631, -1098.585, 42.05707),
            vector3(456.8631, -1093.036, 42.05707),
            vector3(456.8631, -1087.487, 42.05707),
            vector3(456.8631, -1081.938, 42.05707),
            vector3(465.6828, -1081.759, 42.05776),
            vector3(477.1887, -1081.759, 42.05776),
            vector3(487.259, -1096.268, 42.05707),
            vector3(487.259, -1101.817, 42.05707),
            vector3(487.259, -1107.366, 42.05707),
            vector3(487.259, -1112.915, 42.05707),
        },
    },
    {
        AnchorPoint = vector3(489.26, -1481.54, 29.14),
        MaxTasks = 4,
        Objects = {
            {
                hash = 1709954128,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(485.4067, -1475.805, 33.92812),
            vector3(484.8929, -1463.977, 33.92123),
            vector3(481, -1464.432, 33.92123),
            vector3(483.033, -1461.5, 33.90083),
        },
    },
    {
        AnchorPoint = vector3(447.51, -1500.99, 29.3),
        MaxTasks = 3,
        Objects = {
            {
                hash = 1709954128,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(455.491, -1495.111, 31.93513),
            vector3(450.6064, -1487.069, 32.07832),
            vector3(444.8719, -1471.629, 32.09033),
        },
    },
    {
        AnchorPoint = vector3(593.91, -1583.48, 27.21),
        MaxTasks = 5,
        Objects = {
            {
                hash = 1426534598,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
            {
                hash = -525926661,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1870961552,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = -1393761711,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(555.1938, -1577.335, 35.42976),
            vector3(552.8831, -1580.089, 35.42976),
            vector3(540.1544, -1594.947, 28.10457),
            vector3(536.0045, -1599.96, 28.10457),
            vector3(546.0538, -1608.265, 27.75266),
            vector3(550.2037, -1603.252, 27.75266),
            vector3(556.1255, -1593.902, 27.37378),
            vector3(559.7137, -1597.009, 27.37378),
            vector3(567.655, -1599.839, 27.42145),
            vector3(560.8044, -1607.902, 27.42329),
            vector3(568.7122, -1614.646, 26.96252),
            vector3(575.5898, -1606.524, 26.96252),
            vector3(544.5294, -1630.548, 33.33534),
            vector3(529.7981, -1648.146, 33.32863),
            vector3(517.6174, -1637.925, 33.32423),
            vector3(532.8929, -1620.784, 33.35744),
            vector3(516.9639, -1623.354, 33.28661),
        },
    },
    {
        AnchorPoint = vector3(352.58, 266.22, 102.97),
        MaxTasks = 4,
        Objects = {
            {
                hash = 1369811908,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
        },
        ObjectLocations = {
            vector3(347.9389, 230.6176, 131.7694),
            vector3(347.7301, 224.8785, 131.7694),
            vector3(358.3347, 205.8253, 131.6183),
            vector3(357.5094, 203.5787, 131.6183),
            vector3(345.2227, 205.8063, 131.6183),
            vector3(344.3974, 203.5597, 131.6183),
            vector3(334.7165, 200.8331, 131.6183),
            vector3(333.8912, 198.5865, 131.6183),
        },
    },
    {
        AnchorPoint = vector3(304.96, 262.58, 105.33),
        MaxTasks = 4,
        Objects = {
            {
                hash = 1369811908,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
            {
                hash = 1426534598,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
        },
        ObjectLocations = {
            vector3(329.2716, 241.2852, 121.2984),
            vector3(330.202, 243.5882, 121.2984),
            vector3(331.0273, 245.8348, 121.2984),
            vector3(333.9677, 253.7166, 121.2141),
            vector3(320.3225, 249.0616, 121.2141),
            vector3(315.9296, 250.5116, 121.2141),
        },
    },
    {
        AnchorPoint = vector3(304.96, 262.58, 105.33),
        MaxTasks = 5,
        Objects = {
            {
                hash = 1426534598,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
            {
                hash = 1369811908,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                    "WORLD_HUMAN_MAID_CLEAN",
                },
            },
        },
        ObjectLocations = {
            vector3(265.0413, 259.9384, 136.7136),
            vector3(253.0719, 250.7771, 136.7051),
            vector3(273.9504, 224.8345, 136.6989),
            vector3(269.3372, 211.7944, 136.7168),
            vector3(274.1318, 209.7898, 136.7168),
            vector3(256.1583, 227.7684, 150.5979),
            vector3(256.9836, 230.015, 150.5979),
            vector3(245.2933, 234.7645, 150.5979),
            vector3(244.468, 232.5179, 150.5979),
        },
    },
    {
        AnchorPoint = vector3(30.94, -1027.07, 29.46),
        MaxTasks = 5,
        Objects = {
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(-8.488403, -1014.652, 45.33311),
            vector3(5.87085, -1019.895, 45.33311),
            vector3(19.46216, -1024.993, 45.3371),
            vector3(27.82333, -1004.854, 82.39651),
            vector3(28.88324, -1001.76, 82.39651),
            vector3(30.03275, -998.4047, 82.39651),
            vector3(21.20822, -998.6854, 82.39651),
            vector3(17.92111, -997.559, 82.39651),
            vector3(0.045959, -1005.251, 88.15491),
            vector3(3.369629, -1006.489, 88.15491),
        },
    },
    {
        AnchorPoint = vector3(122.21, -1056.23, 29.19),
        MaxTasks = 4,
        Objects = {
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1709954128,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(132.1306, -1048.853, 56.79252),
            vector3(138.5506, -1039.349, 56.79191),
            vector3(122.2149, -1030.216, 56.79252),
            vector3(121.0189, -1033.479, 56.79252),
        },
    },
    {
        AnchorPoint = vector3(282.74, -998.97, 29.27),
        MaxTasks = 6,
        Objects = {
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(271.5647, -1014.162, 60.59697),
            vector3(269.8136, -1019.776, 60.59697),
            vector3(257.6577, -1020.75, 60.59976),
            vector3(254.3925, -1019.561, 60.59976),
            vector3(275.2291, -995.2107, 56.23261),
            vector3(272.1345, -981.8331, 43.98819),
            vector3(268.8693, -980.6443, 43.98819),
            vector3(300.6397, -974.0216, 43.98819),
            vector3(300.6397, -970.7511, 43.98819),
            vector3(300.6397, -967.2042, 43.98819),
            vector3(301.6779, -992.1814, 35.58056),
            vector3(302.0583, -987.9207, 35.58056),
        },
    },
    {
        AnchorPoint = vector3(-580.2, -171.08, 37.87),
        MaxTasks = 6,
        Objects = {
            {
                hash = 1709954128,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1948414141,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(-586.8588, -207.2299, 48.44219),
            vector3(-583.0019, -205.7227, 48.28224),
            vector3(-578.6955, -206.5222, 48.30688),
            vector3(-577.8515, -210.3887, 48.28224),
            vector3(-577.4782, -212.674, 48.28976),
            vector3(-580.2204, -214.6796, 48.28976),
            vector3(-571.364, -214.5035, 48.44219),
            vector3(-568.7302, -226.0277, 45.15186),
            vector3(-564.7617, -224.1805, 45.15267),
            vector3(-566.8605, -217.8209, 45.15186),
            vector3(-560.998, -229.5195, 45.16814),
            vector3(-564.0146, -233.9094, 45.05216),
            vector3(-555.9693, -234.378, 45.15186),
            vector3(-573.6396, -199.5105, 51.28779),
            vector3(-566.8505, -195.5109, 51.20311),
            vector3(-562.3444, -198.4027, 51.20311),
            vector3(-557.5891, -204.6998, 51.28779),
            vector3(-561.6937, -207.0066, 51.20311),
        },
    },
    {
        AnchorPoint = vector3(-550.84, 158.64, 38.24),
        MaxTasks = 5,
        Objects = {
            {
                hash = 1131941737,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1948414141,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
            {
                hash = 1709954128,
                animations = {
                    "WORLD_HUMAN_WELDING",
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer", flags = 49},
                    {animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@", anim = "machinic_loop_mechandplayer"},
                },
            },
        },
        ObjectLocations = {
            vector3(-541.666, -180.5137, 51.20311),
            vector3(-541.0153, -189.1177, 51.20311),
            vector3(-536.5092, -192.0095, 51.20311),
            vector3(-529.7202, -188.0098, 51.28779),
            vector3(-534.631, -179.5789, 51.28779),
            vector3(-523.3171, -181.8263, 48.28976),
            vector3(-529.9553, -174.3766, 48.44219),
            vector3(-526.0983, -172.8694, 48.28224),
            vector3(-521.7922, -173.6689, 48.30688),
            vector3(-520.9479, -177.5354, 48.28224),
            vector3(-520.5749, -179.8207, 48.28976),
            vector3(-514.4604, -181.6502, 48.44219),
            vector3(-517.4385, -189.2871, 45.15186),
            vector3(-515.3395, -195.6467, 45.15267),
            vector3(-519.308, -197.4939, 45.15186),
            vector3(-514.5925, -205.3756, 45.05216),
            vector3(-511.5761, -200.9857, 45.16814),
            vector3(-506.5473, -205.8442, 45.15186),
        },
    },
    -- {
    --     AnchorPoint = vector3(),
    --     MaxTasks = ,
    --     Objects = {
    --         {
    --             hash = ,
    --             animations = {
    --                 "",
    --             },
    --         },
    --     },
    --     ObjectLocations = {
    --         vector3(),
    --     },
    -- },
}