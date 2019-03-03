local E, L, V, P, G = unpack(ElvUI)
local mod = E:GetModule("DataBars")

local XPBAR_LABEL, REPUTATION = XPBAR_LABEL, REPUTATION
local FONT_SIZE, NONE = FONT_SIZE, NONE

E.Options.args.databars = {
	type = "group",
	name = L["DataBars"],
	childGroups = "tab",
	get = function(info) return E.db.databars[ info[#info] ] end,
	set = function(info, value) E.db.databars[ info[#info] ] = value end,
	args = {
		intro = {
			order = 1,
			type = "description",
			name = L["DATABAR_DESC"]
		},
		spacer = {
			order = 2,
			type = "description",
			name = ""
		},
		experience = {
			order = 3,
			type = "group",
			name = XPBAR_LABEL,
			get = function(info) return mod.db.experience[ info[#info] ] end,
			set = function(info, value) mod.db.experience[ info[#info] ] = value mod:UpdateExperienceDimensions() end,
			args = {
				header = {
 					order = 1,
					type = "header",
					name = XPBAR_LABEL
				},
				enable = {
					order = 2,
					type = "toggle",
					name = L["Enable"],
					set = function(info, value) mod.db.experience[ info[#info] ] = value mod:EnableDisable_ExperienceBar() end
				},
				mouseover = {
					order = 3,
					type = "toggle",
					name = L["Mouseover"]
				},
				hideAtMaxLevel = {
					order = 4,
					type = "toggle",
					name = L["Hide At Max Level"],
					set = function(info, value) mod.db.experience[ info[#info] ] = value mod:UpdateExperience() end,
				},
				hideInVehicle = {
					order = 5,
					type = "toggle",
					name = L["Hide In Vehicle"],
					set = function(info, value) mod.db.experience[ info[#info] ] = value mod:UpdateExperience() end,
				},
				hideInCombat = {
					order = 6,
					type = "toggle",
					name = L["Hide In Combat"],
					set = function(info, value) mod.db.experience[ info[#info] ] = value mod:UpdateExperience() end,
				},
				reverseFill = {
					order = 7,
					type = "toggle",
					name = L["Reverse Fill Direction"],
				},
				spacer = {
					order = 8,
					type = "description",
					name = " "
				},
				orientation = {
					order = 9,
					type = "select",
					name = L["Statusbar Fill Orientation"],
					desc = L["Direction the bar moves on gains/losses"],
					values = {
						["HORIZONTAL"] = L["Horizontal"],
						["VERTICAL"] = L["Vertical"]
					}
				},
				width = {
					order = 10,
					type = "range",
					name = L["Width"],
					min = 5, max = ceil(GetScreenWidth() or 800), step = 1
				},
				height = {
					order = 11,
					type = "range",
					name = L["Height"],
					min = 5, max = ceil(GetScreenHeight() or 800), step = 1
				},
				font = {
					order = 12,
					type = "select", dialogControl = "LSM30_Font",
					name = L["Font"],
					values = AceGUIWidgetLSMlists.font
				},
				textSize = {
					order = 13,
					name = FONT_SIZE,
					type = "range",
					min = 6, max = 22, step = 1
				},
				fontOutline = {
					order = 14,
					type = "select",
					name = L["Font Outline"],
					values = {
						["NONE"] = NONE,
						["OUTLINE"] = "OUTLINE",
						["MONOCHROMEOUTLINE"] = "MONOCROMEOUTLINE",
						["THICKOUTLINE"] = "THICKOUTLINE"
					}
				},
				textFormat = {
					order = 15,
					type = "select",
					name = L["Text Format"],
					width = "double",
					values = {
						NONE = NONE,
						PERCENT = L["Percent"],
						CUR = L["Current"],
						REM = L["Remaining"],
						CURMAX = L["Current - Max"],
						CURPERC = L["Current - Percent"],
						CURREM = L["Current - Remaining"],
						CURPERCREM = L["Current - Percent (Remaining)"],
					},
					set = function(info, value) mod.db.experience[ info[#info] ] = value mod:UpdateExperience() end
				}
			}
		},
		reputation = {
			order = 4,
			type = "group",
			name = REPUTATION,
			get = function(info) return mod.db.reputation[ info[#info] ] end,
			set = function(info, value) mod.db.reputation[ info[#info] ] = value mod:UpdateReputationDimensions() end,
			args = {
				header = {
 					order = 1,
					type = "header",
					name = REPUTATION
				},
				enable = {
					order = 2,
					type = "toggle",
					name = L["Enable"],
					set = function(info, value) mod.db.reputation[ info[#info] ] = value mod:EnableDisable_ReputationBar() end
				},
				mouseover = {
					order = 3,
					type = "toggle",
					name = L["Mouseover"]
				},
				hideInVehicle = {
					order = 4,
					type = "toggle",
					name = L["Hide In Vehicle"],
					set = function(info, value) mod.db.reputation[ info[#info] ] = value mod:UpdateReputation() end
				},
				hideInCombat = {
					order = 5,
					type = "toggle",
					name = L["Hide In Combat"],
					set = function(info, value) mod.db.reputation[ info[#info] ] = value mod:UpdateReputation() end
				},
				reverseFill = {
					order = 6,
					type = "toggle",
					name = L["Reverse Fill Direction"],
				},
				spacer = {
					order = 7,
					type = "description",
					name = " "
				},
				orientation = {
					order = 8,
					type = "select",
					name = L["Statusbar Fill Orientation"],
					desc = L["Direction the bar moves on gains/losses"],
					values = {
						["HORIZONTAL"] = L["Horizontal"],
						["VERTICAL"] = L["Vertical"]
					}
				},
				width = {
					order = 9,
					type = "range",
					name = L["Width"],
					min = 5, max = ceil(GetScreenWidth() or 800), step = 1
				},
				height = {
					order = 10,
					type = "range",
					name = L["Height"],
					min = 5, max = ceil(GetScreenHeight() or 800), step = 1
				},
				font = {
					order = 11,
					type = "select", dialogControl = "LSM30_Font",
					name = L["Font"],
					values = AceGUIWidgetLSMlists.font
				},
				textSize = {
					order = 12,
					name = FONT_SIZE,
					type = "range",
					min = 6, max = 22, step = 1
				},
				fontOutline = {
					order = 13,
					type = "select",
					name = L["Font Outline"],
					values = {
						["NONE"] = NONE,
						["OUTLINE"] = "OUTLINE",
						["MONOCHROMEOUTLINE"] = "MONOCROMEOUTLINE",
						["THICKOUTLINE"] = "THICKOUTLINE"
					}
				},
				textFormat = {
					order = 14,
					type = "select",
					name = L["Text Format"],
					width = "double",
					values = {
						NONE = NONE,
						CUR = L["Current"],
						REM = L["Remaining"],
						PERCENT = L["Percent"],
						CURMAX = L["Current - Max"],
						CURPERC = L["Current - Percent"],
						CURREM = L["Current - Remaining"],
						CURPERCREM = L["Current - Percent (Remaining)"],
					},
					set = function(info, value) mod.db.reputation[ info[#info] ] = value mod:UpdateReputation() end
				}
			}
		}
	}
}