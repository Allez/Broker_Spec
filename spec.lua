local elapsed = 0.5
local addon = CreateFrame('Frame')
local dataobj = LibStub:GetLibrary('LibDataBroker-1.1'):NewDataObject('Spec', {text = 'no spec', icon = "Interface\\Icons\\Spell_Shadow_SacrificialShield", iconCoords = {0.065, 0.935, 0.065, 0.935}})

function dataobj.OnLeave()
	GameTooltip:SetClampedToScreen(true)
	GameTooltip:Hide()
end

function dataobj.OnEnter(self)
	GameTooltip:SetOwner(self, 'ANCHOR_BOTTOMLEFT', 0, self:GetHeight())
	GameTooltip:AddLine("Talents")
	GameTooltip:AddLine("Hint: left-click to show talents pane.")
	GameTooltip:AddLine("right-click to switch talents.")

	GameTooltip:Show()
end

function dataobj.OnClick(self, button)
	if button == "RightButton" then
		if GetActiveTalentGroup() == 1 then
			SetActiveTalentGroup(2)
		else
			SetActiveTalentGroup(1)
		end
	else
		ToggleTalentFrame()
	end
end

addon:SetScript('OnUpdate', function(self, al)
	elapsed = elapsed + al
	if(elapsed > 0.5) then
		local maxPoints, finalIcon, text = 0, "Interface\\Icons\\Spell_Shadow_SacrificialShield"
		for tab = 1, 3 do
			local _, icon, points = GetTalentTabInfo(tab,nil,nil,group)
			if points > maxPoints then
				maxPoints = points
				finalIcon = icon
			end
			text = format("%s%.2i", text and text.."/" or "", points)
		end

		dataobj.text = text
		dataobj.icon = finalIcon
		elapsed = 0
	end
end)
