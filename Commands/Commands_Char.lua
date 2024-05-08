﻿-------------------------------------------------------------------------------------------------------------
--
-- AzerothAdmin Version 3.x
-- AzerothAdmin is a derivative of TrinityAdmin/MangAdmin.
--
-- Copyright (C) 2024 Free Software Foundation, Inc.
-- License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
-- This is free software: you are free to change and redistribute it.
-- There is NO WARRANTY, to the extent permitted by law.
--
-- You should have received a copy of the GNU General Public License
-- along with this program; if not, write to the Free Software
-- Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
--
-- Repository: https://gitlab.superstyro.com/superstyro/azerothadmin
-------------------------------------------------------------------------------------------------------------

function ModelRotateLeft()
  ma_modelframe.rotation = ma_modelframe.rotation - 0.03
  ma_modelframe:SetRotation(ma_modelframe.rotation)
  PlaySound("igInventoryRotateCharacter")
end

function ModelRotateRight()
  ma_modelframe.rotation = ma_modelframe.rotation + 0.03
  ma_modelframe:SetRotation(ma_modelframe.rotation)
  PlaySound("igInventoryRotateCharacter")
end

function InitModelFrame()
  ma_modelframe:SetScript("OnUpdate", function() AzerothAdminModelOnUpdate(arg1) end)
  ma_modelframe.rotation = 0.61;
  ma_modelframe:SetRotation(ma_modelframe.rotation)
  ma_modelframe:SetUnit("player")

end

function AzerothAdminModelOnUpdate(elapsedTime)
  if ( ma_modelrotatelbutton:GetButtonState() == "PUSHED" ) then
    this.rotation = this.rotation + (elapsedTime * 2 * PI * ROTATIONS_PER_SECOND)
    if ( this.rotation < 0 ) then
      this.rotation = this.rotation + (2 * PI)
    end
    this:SetRotation(this.rotation);
  end
  if ( ma_modelrotaterbutton:GetButtonState() == "PUSHED" ) then
    this.rotation = this.rotation - (elapsedTime * 2 * PI * ROTATIONS_PER_SECOND)
    if ( this.rotation > (2 * PI) ) then
      this.rotation = this.rotation - (2 * PI)
    end
    this:SetRotation(this.rotation);
  end
end

function ModelChanged()
  if not AzerothAdmin:Selection("none") then
    ma_modelframe:SetUnit("target")
  else
    ma_modelframe:SetUnit("player")
  end
  ma_modelframe:RefreshUnit()
end

function RevivePlayer()
  if AzerothAdmin:Selection("player") or AzerothAdmin:Selection("self") or AzerothAdmin:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".revive")
    AzerothAdmin:LogAction("Revived player "..player..".")
  else
    AzerothAdmin:Print(Locale["selectionerror1"])
  end
end

function SavePlayer()
  if AzerothAdmin:Selection("player") or AzerothAdmin:Selection("self") or AzerothAdmin:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".save")
    AzerothAdmin:LogAction("Saved player "..player..".")
  else
    AzerothAdmin:Print(Locale["selectionerror1"])
  end
end

function KickPlayer()
  if AzerothAdmin:Selection("player") or AzerothAdmin:Selection("self") or AzerothAdmin:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".kick")
    AzerothAdmin:LogAction("Kicked player "..player..".")
  else
    AzerothAdmin:Print(Locale["selectionerror1"])
  end
end

function Cooldown()
  if AzerothAdmin:Selection("player") or AzerothAdmin:Selection("self") or AzerothAdmin:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".cooldown")
    AzerothAdmin:LogAction("Cooled player "..player..".")
  else
    AzerothAdmin:Print(Locale["selectionerror1"])
  end
end

function ShowGUID()
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".guid")
    AzerothAdmin:LogAction("Got GUID for player "..player..".")
end

function Pinfo()
  if AzerothAdmin:Selection("player") or AzerothAdmin:Selection("self") or AzerothAdmin:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".pinfo")
    AzerothAdmin:LogAction("Got Player Info for player "..player..".")
  else
    AzerothAdmin:Print(Locale["selectionerror1"])
  end
end

function Distance()
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".distance")
    AzerothAdmin:LogAction("Got distance to player "..player..".")
end

function Recall()
  if AzerothAdmin:Selection("player") or AzerothAdmin:Selection("self") or AzerothAdmin:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".recall")
    AzerothAdmin:LogAction("Recalled player "..player..".")
  else
    AzerothAdmin:Print(Locale["selectionerror1"])
  end
end

function Demorph()
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".morph reset")
    AzerothAdmin:LogAction("Demorphed player "..player..".")
end

function ToggleMapsChar(value)
  AzerothAdmin:ChatMsg(".explorecheat "..value)
  if value == 1 then
    AzerothAdmin:LogAction("Revealed all maps for selected player.")
  else
    AzerothAdmin:LogAction("Hide all unexplored maps for selected player.")
  end
end

function GPS()
  if AzerothAdmin:Selection("player") or AzerothAdmin:Selection("self") or AzerothAdmin:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".gps")
    AzerothAdmin:LogAction("Got GPS coordinates for player "..player..".")
  else
    AzerothAdmin:Print(Locale["selectionerror1"])
  end
end

function LearnSpell(value, state)
  if AzerothAdmin:Selection("player") or AzerothAdmin:Selection("self") or AzerothAdmin:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    local class = UnitClass("target") or UnitClass("player")
    local command = ".learn"
    local logcmd = "Learned"
    if state == "RightButton" then
      command = ".unlearn"
      logcmd = "Unlearned"
    end
    if type(value) == "string" then
      if value == "all" then
        AzerothAdmin:ChatMsg(command.." all")
        AzerothAdmin:LogAction(logcmd.." all spells to "..player..".")
      elseif value == "all_crafts" then
        AzerothAdmin:ChatMsg(command.." all_crafts")
        AzerothAdmin:LogAction(logcmd.." all professions and recipes to "..player..".")
      elseif value == "all_gm" then
        AzerothAdmin:ChatMsg(command.." all_gm")
        AzerothAdmin:LogAction(logcmd.." all default spells for Game Masters to "..player..".")
      elseif value == "all_lang" then
        AzerothAdmin:ChatMsg(command.." all_lang")
        AzerothAdmin:LogAction(logcmd.." all languages to "..player..".")
      elseif value == "all_myclass" then
        AzerothAdmin:ChatMsg(command.." all_myclass")
        AzerothAdmin:LogAction(logcmd.." all spells available to the "..class.."-class to "..player..".")
      else
        AzerothAdmin:ChatMsg(command.." "..value)
        AzerothAdmin:LogAction(logcmd.." spell "..value.." to "..player..".")
      end
    elseif type(value) == "table" then
      for k,v in pairs(value) do
        AzerothAdmin:ChatMsg(command.." "..v)
        AzerothAdmin:LogAction(logcmd.." spell "..v.." to "..player..".")
      end
    end
  else
    AzerothAdmin:Print(Locale["selectionerror1"])
  end
end

function Modify(case, value)
  if AzerothAdmin:Selection("player") or AzerothAdmin:Selection("self") or AzerothAdmin:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    if case == "money" then
      AzerothAdmin:ChatMsg(".modify money "..value)
      AzerothAdmin:LogAction("Give player "..player.." "..value.." copper).")
    elseif case == "levelup" then
      AzerothAdmin:ChatMsg(".levelup "..value)
      AzerothAdmin:LogAction("Leveled up player "..player.." by "..value.." levels.")
    elseif case == "leveldown" then
      AzerothAdmin:ChatMsg(".levelup "..value*(-1))
      AzerothAdmin:LogAction("Leveled down player "..player.." by "..value.." levels.")
    elseif case == "energy" then
      AzerothAdmin:ChatMsg(".modify energy "..value)
      AzerothAdmin:LogAction("Modified energy for "..player.." to "..value.." energy.")
    elseif case == "rage" then
      AzerothAdmin:ChatMsg(".modify rage "..value)
      AzerothAdmin:LogAction("Modified rage for "..player.." to "..value.." rage.")
    elseif case == "health" then
      AzerothAdmin:ChatMsg(".modify hp "..value)
      AzerothAdmin:LogAction("Modified hp for "..player.." to "..value.." healthpoints")
    elseif case == "mana" then
      AzerothAdmin:ChatMsg(".modify mana "..value)
      AzerothAdmin:LogAction("Modified mana for "..player.." to "..value.." mana")
    elseif case == "aspeed" then
      AzerothAdmin:ChatMsg(".modify aspeed "..value)
      AzerothAdmin:LogAction("Modified AllSpeeds for "..player.." to "..value.." mana")
    elseif case == "arena" then
      AzerothAdmin:ChatMsg(".modify arena "..value)
      AzerothAdmin:LogAction("Modified Arena Points for "..player.." to "..value.." mana")
    elseif case == "bwalk" then
      AzerothAdmin:ChatMsg(".modify bwalk "..value)
      AzerothAdmin:LogAction("Modified BackWalk for "..player.." to "..value.." mana")
    elseif case == "drunk" then
      AzerothAdmin:ChatMsg(".modify drunk "..value)
      AzerothAdmin:LogAction("Modified Drunk for "..player.." to "..value.." mana")
    elseif case == "fly" then
      AzerothAdmin:ChatMsg(".modify fly "..value)
      AzerothAdmin:LogAction("Modified FlySpeed for "..player.." to "..value.." mana")
    elseif case == "gender" then
      AzerothAdmin:ChatMsg(".modify gender "..value)
      AzerothAdmin:LogAction("Modified Gender for "..player.." to "..value.." mana")
    elseif case == "honor" then
      AzerothAdmin:ChatMsg(".modify honor "..value)
      AzerothAdmin:LogAction("Modified Honor for "..player.." to "..value.." mana")
    elseif case == "mount" then
      AzerothAdmin:ChatMsg(".modify mount "..value)
      AzerothAdmin:LogAction("Modified MountSpeed for "..player.." to "..value.." mana")
    elseif case == "phase" then
      AzerothAdmin:ChatMsg(".modify phase "..value)
      AzerothAdmin:LogAction("Modified Phase for "..player.." to "..value.." mana")
    elseif case == "runicpower" then
      AzerothAdmin:ChatMsg(".modify runicpower "..value)
      AzerothAdmin:LogAction("Modified RunicPower for "..player.." to "..value.." mana")
    elseif case == "speed" then
      AzerothAdmin:ChatMsg(".modify speed "..value)
      AzerothAdmin:LogAction("Modified Speed for "..player.." to "..value.." mana")
    elseif case == "standstate" then
      AzerothAdmin:ChatMsg(".modify standstate "..value)
      AzerothAdmin:LogAction("Modified StandState for "..player.." to "..value.." mana")
    elseif case == "swim" then
      AzerothAdmin:ChatMsg(".modify swim "..value)
      AzerothAdmin:LogAction("Modified SwimSpeed for "..player.." to "..value.." mana")
    elseif case == "tp" then
      AzerothAdmin:ChatMsg(".modify tp "..value)
      AzerothAdmin:LogAction("Modified TalentPoints for "..player.." to "..value.." mana")
    end
  else
    AzerothAdmin:Print(Locale["selectionerror1"])
  end
end

function Reset(value)
  if AzerothAdmin:Selection("player") or AzerothAdmin:Selection("self") or AzerothAdmin:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".reset "..value)
    AzerothAdmin:LogAction("Reset "..value.."' for player "..player..".")
  else
    AzerothAdmin:Print(Locale["selectionerror1"])
  end
end

  -- LEARN LANG
function LearnLangDropDownInitialize()
    local level = 1
    local info = UIDropDownMenu_CreateInfo()
    local buttons = {
      {Locale["ma_AllLang"],"all_lang"},
      {Locale["Common"],"668"},
      {Locale["Orcish"],"669"},
      {Locale["Taurahe"],"670"},
      {Locale["Darnassian"],"671"},
      {Locale["Dwarvish"],"672"},
      {Locale["Thalassian"],"813"},
      {Locale["Demonic"],"815"},
      {Locale["Draconic"],"814"},
      {Locale["Titan"],"816"},
      {Locale["Kalimag"],"817"},
      {Locale["Gnomish"],"7340"},
      {Locale["Troll"],"7341"},
      {Locale["Gutterspeak"],"17737"},
      {Locale["Draenei"],"29932"}
    }
    for k,v in pairs(buttons) do
      info.text = v[1]
      info.value = v[2]
      info.func = function() UIDropDownMenu_SetSelectedValue(ma_learnlangdropdown, this.value) end
      info.checked = nil
      info.icon = nil
      info.keepShownOnClick = nil
      UIDropDownMenu_AddButton(info, level)
    end
    UIDropDownMenu_SetSelectedValue(ma_learnlangdropdown, "all_lang")
end

  -- MODIFY
function ModifyDropDownInitialize()
    local level = 1
    local info = UIDropDownMenu_CreateInfo()
    local buttons = {
      {Locale["ma_AllSpeeds"],"aspeed"},
      {Locale["ma_Arena"],"arena"},
      {Locale["ma_BackWalk"],"bwalk"},
      {Locale["ma_Drunk"],"drunk"},
      {Locale["ma_Energy"],"energy"},
      {Locale["ma_FlySpeed"],"fly"},
      {Locale["ma_Gender"],"gender"},
      {Locale["ma_Healthpoints"],"health"},
      {Locale["ma_Honor"],"honor"},
      {Locale["ma_LevelUp"],"levelup"},
      {Locale["ma_LevelDown"],"leveldown"},
      {Locale["ma_Mana"],"mana"},
      {Locale["ma_Money"],"money"},
      {Locale["ma_MountSpeed"],"mount"},
      {Locale["ma_Phase"],"phase"},
      {Locale["ma_Rage"],"rage"},
      {Locale["ma_RunicPower"],"runicpower"},
      {Locale["ma_Speed"],"speed"},
      {Locale["ma_StandSate"],"standstate"},
      {Locale["ma_SwimSpeed"],"swim"},
      {Locale["ma_TalentPoints"],"tp"}
    }
    for k,v in pairs(buttons) do
      info.text = v[1]
      info.value = v[2]
      info.func = function() UIDropDownMenu_SetSelectedValue(ma_modifydropdown, this.value) end
      info.checked = nil
      info.icon = nil
      info.keepShownOnClick = nil
      UIDropDownMenu_AddButton(info, level)
    end
    UIDropDownMenu_SetSelectedValue(ma_modifydropdown, "levelup")
end

  -- RESET
function ResetDropDownInitialize()
    local level = 1
    local info = UIDropDownMenu_CreateInfo()
    local buttons = {
      {Locale["ma_resetallspells"],"all spells"},
      {Locale["ma_resetalltalents"],"all talents"},
      {Locale["ma_achievements"],"achievements"},
      {Locale["ma_Honor"],"honor"},
      {Locale["ma_Level"],"level"},
      {Locale["ma_Spells"],"spells"},
      {Locale["ma_Stats"],"stats"},
      {Locale["ma_Talents"],"talents"}
    }
    for k,v in pairs(buttons) do
      info.text = v[1]
      info.value = v[2]
      info.func = function() UIDropDownMenu_SetSelectedValue(ma_resetdropdown, this.value) end
      info.checked = nil
      info.icon = nil
      info.keepShownOnClick = nil
      UIDropDownMenu_AddButton(info, level)
    end
    UIDropDownMenu_SetSelectedValue(ma_resetdropdown, "talents")
end

function CharModelZoomIn()
    ma_modelframe:SetCamera(0)
    --ma_modelframe:SetModelScale(ma_modelframe:GetModelScale() + .1)
    --ma_modelframe:SetPosition(1,ma_modelframe:GetModelScale()*3,0)
    --ma_modelframe:RefreshUnit()
end

function CharModelZoomOut()
    ma_modelframe:SetCamera(1)
    ma_modelframe:RefreshUnit()
   -- ma_modelframe:SetCamera(2)
    --ma_modelframe:SetModelScale(ma_modelframe:GetModelScale() * .5)
    --ma_modelframe:SetPosition(0,0,0)
    --ma_modelframe:RefreshUnit()
end

function CharBindSight()
    local cname = ma_charactertarget:GetText()
    AzerothAdmin:ChatMsg(".bindsight")
    AzerothAdmin:LogAction("Sight bound to "..cname)
end

function CharUnBindSight()
    local cname = ma_charactertarget:GetText()
    AzerothAdmin:ChatMsg(".unbindsight")
    AzerothAdmin:LogAction("Sight unbound to "..cname)
end

function CharRename()
    local cname = ma_charactertarget:GetText()
    AzerothAdmin:ChatMsg(".character rename")
    AzerothAdmin:LogAction("Forced rename of "..cname)
end

function CharCustomize()
    local cname = ma_charactertarget:GetText()
    AzerothAdmin:ChatMsg(".character customize")
    AzerothAdmin:LogAction("Forced customization of "..cname)
end

function CharChangeRace()
    local cname = ma_charactertarget:GetText()
    AzerothAdmin:ChatMsg(".character changerace")
    AzerothAdmin:LogAction("Forced race change of "..cname)
end

function CharChangeFaction()
    local cname = ma_charactertarget:GetText()
    AzerothAdmin:ChatMsg(".character changefaction")
    AzerothAdmin:LogAction("Forced faction change of "..cname)
end

function CharCombatStop()
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".combatstop")
    AzerothAdmin:LogAction("Forced combat stop on "..player)
end

function CharMaxSkill()
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".maxskill")
    AzerothAdmin:LogAction("Set player MaxSkill for "..player)
end

function CharFreeze()
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".freeze")
    AzerothAdmin:LogAction("Set Freeze for "..player)
end

function CharUnFreeze()
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".unfreeze")
    AzerothAdmin:LogAction("UnFroze "..player)
end

function CharListFreeze()
    AzerothAdmin:ChatMsg(".listfreeze")
    AzerothAdmin:LogAction("Listed Frozen players")
end

function CharPossess()
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".possess")
    AzerothAdmin:LogAction("Possessed "..player)
end

function CharUnPossess()
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".unpossess")
    AzerothAdmin:LogAction("UnPossessed "..player)
end

function CharRecall()
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".recall")
    AzerothAdmin:LogAction("Recalled "..player)
end

function CharRepair()
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".gear repair")
    AzerothAdmin:LogAction("Repaired  "..player.."'s items")
end

--[[CHAR2 TAB Copy Over]]
function BanButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".ban "..cname)
  AzerothAdmin:LogAction("Banned player: "..cname..".")

end

function GoNameButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".appear "..cname)
  AzerothAdmin:LogAction("Teleported TO player: "..cname..".")

end

function CreateGuildButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".guild create "..cname)
  AzerothAdmin:LogAction("Created Guild: "..cname..".")

end

function BanInfoButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".baninfo "..cname)
  AzerothAdmin:LogAction("Listed .baninfo: "..cname..".")

end

function GroupGoButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".groupsummon "..cname)
  AzerothAdmin:LogAction("Teleported "..cname.." and his/her group to me.")

end

function GuildInviteButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".guild invite "..cname)
  AzerothAdmin:LogAction("Guild invitation: "..cname..".")

end

function BanlistButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".banlist "..cname)
  AzerothAdmin:LogAction("Listed bans matching: "..cname..".")

end

function NameGoButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".summon "..cname)
  AzerothAdmin:LogAction("Teleported "..cname.." TO me.")

end

function GuildRankButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".guild rank "..cname)
  AzerothAdmin:LogAction("Guild rank change: "..cname..".")

end

function TeleGroupButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".tele group "..cname)
  AzerothAdmin:LogAction("Group teleported: "..cname..".")

end

function UnBanButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".unban "..cname)
  AzerothAdmin:LogAction("Unbanned "..cname..".")

end

function GuildDeleteButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".guild delete "..cname)
  AzerothAdmin:LogAction("Deleted guild: "..cname..".")

end

function GuildUninviteButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".guild uninvite "..cname)
  AzerothAdmin:LogAction("Removed from guild: "..cname..".")

end

function TeleNameButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
    self:ChatMsg(".tele name "..cname)
    self:LogAction("Teleported: "..cname..".")

end

function MuteButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".mute "..cname)
  AzerothAdmin:LogAction("Muted "..cname..".")

end

function CharMorphButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".modify morph "..cname)
  AzerothAdmin:LogAction(".modify morph "..cname..".")

end

function CharAuraButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".aura "..cname)
  AzerothAdmin:LogAction(".aura "..cname..".")

end

function CharUnAuraButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".unaura "..cname)
  AzerothAdmin:LogAction(".unaura "..cname..".")

end

function JailA()
    cname=ma_charactertarget:GetText()
    AzerothAdmin:ChatMsg(".tele name "..cname.." ma_AllianceJail")
    AzerothAdmin:LogAction("Jailed player "..cname..".")
    AzerothAdmin:ChatMsg(".notify "..cname.." has been found guilty and jailed.")
end

function JailH()
    cname=ma_charactertarget:GetText()
    --self:ChatMsg("Selected "..cname)
    AzerothAdmin:ChatMsg(".tele name "..cname.." ma_HordeJail")
    AzerothAdmin:LogAction("Jailed player "..cname..".")
    AzerothAdmin:ChatMsg(".notify "..cname.." has been found guilty and jailed.")
end

function UnJail()
    cname=ma_charactertarget:GetText()
    AzerothAdmin:ChatMsg(".recall "..cname)
    AzerothAdmin:LogAction("UnJailed player "..cname..".")
    AzerothAdmin:ChatMsg(".notify "..cname.." has been pardoned and released from jail.")
end

function UnMuteButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".unmute "..cname)
  AzerothAdmin:LogAction(".unmute "..cname..".")

end

function QuestAddButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".quest add "..cname)
  AzerothAdmin:LogAction(".quest add "..cname..".")

end

function QuestCompleteButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".quest complete "..cname)
  AzerothAdmin:LogAction(".quest complete "..cname..".")

end

function QuestRemoveButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".quest remove "..cname)
  AzerothAdmin:LogAction(".quest remove "..cname..".")

end

function DamageButton ()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".damage "..cname)
  AzerothAdmin:LogAction(".damage "..cname..".")

end

function HideAreaButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".hidearea "..cname)
  AzerothAdmin:LogAction(".hidearea "..cname..".")
end

function ShowAreaButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".showarea "..cname)
  AzerothAdmin:LogAction(".showarea "..cname..".")
end

function HonorAddButton()
  local cname = ma_charactertarget:GetText()
  local npccname = ma_npccharactertarget:GetText()
  AzerothAdmin:ChatMsg(".honor add "..cname)
  AzerothAdmin:LogAction("Honor add "..cname..".")
end

function HonorUpdateButton()
  if AzerothAdmin:Selection("player") or AzerothAdmin:Selection("self") or AzerothAdmin:Selection("none") then
    local player = UnitName("target") or UnitName("player")
    AzerothAdmin:ChatMsg(".honor update ")
    AzerothAdmin:LogAction("Honor updated for "..player..".")
  else
    AzerothAdmin:Print(Locale["selectionerror1"])
  end
end
