-- EraTechBlock
-- Author: gggdo
-- DateCreated: 8/13/2024 12:00:28 PM
--------------------------------------------------------------
-- Lua script to block future era technologies

function OnTurnBegin()
    local pPlayer = Players[Game.GetActivePlayer()]
    local pPlayerEra = pPlayer:GetEra()
    local currentEra = GameInfo.Eras[pPlayerEra].EraType

    -- Loop through all technologies
    for row in GameInfo.Technologies() do
        local techEra = GameInfo.Eras[GameInfo.Technologies[row.TechnologyType].EraType].EraType

        if techEra > currentEra then
            -- Block the technology
            row.IsBlocked = 1
            -- Visual cue to show the technology as blocked
            pPlayer:GetTechs():SetResearchProgress(row.TechnologyType, 0)
        else
            -- Unblock the technology if it's in the current or previous era
            row.IsBlocked = 0
        end
    end
end

-- Hook the function to the turn begin event
Events.ActivePlayerTurnBegin.Add(OnTurnBegin)

-- Hook to the UI to update the display
function OnUpdateTechnologyPanel()
    local pPlayer = Players[Game.GetActivePlayer()]
    local pTechs = pPlayer:GetTechs()

    for _, row in ipairs(GameInfo.Technologies()) do
        if row.IsBlocked == 1 then
            Controls[row.TechnologyType]:SetDisabled(true)
            Controls[row.TechnologyType]:SetToolTipString("This technology is locked until the era begins.")
        else
            Controls[row.TechnologyType]:SetDisabled(false)
            Controls[row.TechnologyType]:SetToolTipString(nil)
        end
    end
end

-- Hook the UI update to relevant events
Events.TechTreeUpdate.Add(OnUpdateTechnologyPanel)
Events.ActivePlayerTurnEnd.Add(OnUpdateTechnologyPanel)
