-- Q5 - Implement a spell
-- Tempest Spell - Uses the same formula as the Eternal Winter spell, with the difference being the Combat Area
-- Params:
-- Combat Type would be Ice Damage
-- Combat Effect would be Ice Tornado as it is on the video
-- Combat Area would be changed to another shape to go with the video
-- We could add more parameters like status conditions (e.g. poison damage) by using the combat:setParameter() method

local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_ICEDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
combat:setArea(createCombatArea(AREA_CROSS3X3))

function onGetFormulaValues(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 5.5) + 25
	local max = (level / 5) + (magicLevel * 11) + 50
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
