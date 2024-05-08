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

function ShowTicketTab()
  wipe(AzerothAdmin.db.account.buffer.tickets)
  ma_goticketbutton:Disable()
  ma_deleteticketbutton:Disable()
  ma_answerticketbutton:Disable()
  ma_getcharticketbutton:Disable()
  ma_gocharticketbutton:Disable()
  ma_whisperticketbutton:Disable()
  ma_resetticketsbutton:Disable()
  ma_showbutton:Disable()
  AzerothAdmin:InstantGroupToggle("ticket")
  ResetTickets()
end

function RefreshOnlineTickets()
    ma_ticketscrollframe:SetScript("OnVerticalScroll", InlineScrollUpdate(), function(self, offset) FauxScrollFrame_OnVerticalScroll(self, offset-1, 16, InlineScrollUpdate()) end)
    ma_ticketscrollframe:SetScript("OnShow", function() InlineScrollUpdate() end)
    AzerothAdmin.db.char.requests.ticket = true
    AzerothAdmin:LogAction("Getting tickets.")
    AzerothAdmin:ChatMsg(".ticket onlinelist")
    for i=1,12 do
       getglobal("ma_ticketscrollframe"..i):Hide()
    end
    ma_loadonlineticketsbutton:Disable()
    ma_loadallticktsbutton:Hide()
    ma_showbutton:Enable()
end

function RefreshTickets()

    ma_ticketscrollframe:SetScript("OnVerticalScroll", InlineScrollUpdate(), function(self, offset) FauxScrollFrame_OnVerticalScroll(self, offset-1, 16, InlineScrollUpdate()) end)
    ma_ticketscrollframe:SetScript("OnShow", function() InlineScrollUpdate() end)
    AzerothAdmin.db.char.requests.ticket = true
    AzerothAdmin:LogAction("Getting tickets.")
    AzerothAdmin:ChatMsg(".ticket list")
    for i=1,12 do
       getglobal("ma_ticketscrollframe"..i):Hide()
    end
    ma_loadallticktsbutton:Disable()
    ma_loadonlineticketsbutton:Hide()
    ma_showbutton:Enable()
end

function ResetTickets()
    wipe(AzerothAdmin.db.account.buffer.tickets)
    wipe(AzerothAdmin.db.account.buffer.tickets)
    wipe(AzerothAdmin.db.account.buffer.tickets)
    AzerothAdmin.db.account.buffer.tickets = {}
    AzerothAdmin.db.account.buffer.tickets = {}
    AzerothAdmin.db.account.buffer.tickets = {}
    AzerothAdmin.db.char.requests.ticket = true
    for i=1,12 do
       getglobal("ma_ticketscrollframe"..i):Hide()
    end
    ma_loadallticktsbutton:Enable()
    ma_loadonlineticketsbutton:Enable()
    ma_loadallticktsbutton:Show()
    ma_loadonlineticketsbutton:Show()
    ma_ticketdetail:Hide();
    local ticketdetail = nil
    ma_ticketid:SetText(nil)
    ma_ticketcreatedby:SetText(nil)
    ma_tickettimecreated:SetText(nil)
    ma_ticketlastchange:SetText(nil)
    AzerothAdmin:LogAction("Reset/Cleared tickets.")
    ma_goticketbutton:Disable()
    ma_deleteticketbutton:Disable()
    ma_answerticketbutton:Disable()
    ma_getcharticketbutton:Disable()
    ma_gocharticketbutton:Disable()
    ma_whisperticketbutton:Disable()
end

function ShowTickets()
  ma_resetticketsbutton:Enable()
  ma_showbutton:Disable()
 InlineScrollUpdate()
end

--[[function AzerothAdmin:LoadTickets(number)
  self.db.char.newTicketQueue = {}
  --self.db.account.tickets.requested = 0
  if number then
    if tonumber(number) > 0 then
      self.db.account.tickets.count = tonumber(number)
      if self.db.char.requests.ticket then
        self:LogAction("Load of tickets requested. Found "..number.." tickets!")
        self:RequestTickets()
        self:SetIcon(ROOT_PATH.."Textures\\icon.tga")
        --ma_resetsearchbutton:Enable()
      end
    else
      --ma_resetsearchbutton:Disable()
      self:NoResults("ticket")
    end
  else
    self.db.char.requests.ticket = true
    self.db.account.tickets.count = 0
    self.db.account.buffer.tickets = {}
    --self:ChatMsg(".ticket list")
    --self:LogAction("Requesting ticket numberz!")
  end
  InlineScrollUpdate()
end]]

--[[function AzerothAdmin:RequestTickets()
  self.db.char.requests.ticket = true
  local ticketCount = 0
  table.foreachi(self.db.account.buffer.tickets, function() ticketCount = ticketCount + 1 end)
  --ma_lookupresulttext:SetText(Locale["ma_TicketCount"]..count)
  ma_top2text:SetText(Locale["realm"].." "..Locale["tickets"]..self.db.account.tickets.count)
  local tnumber = self.db.account.tickets.count - ticketCount
  --self:LogAction("tNumber = "..tnumber..", Tc = "..ticketCount)
  if tnumber > 0 then
    self:ChatMsg(".ticket "..tnumber)
    --self:LogAction(".ticket "..tnumber)
    self:LogAction("Loading ticket "..tnumber.."...")
  else
    self:LogAction("Loaded all available tickets! No more to load...")
    ma_resetsearchbutton:Disable()
  end
end]]

function Ticket(value)
  local ticket = AzerothAdmin.db.account.tickets.selected
  if value == "delete" then
    AzerothAdmin:ChatMsg(".ticket close "..ma_ticketid:GetText())
    AzerothAdmin:LogAction("Closed ticket with number: "..ma_ticketid:GetText())
    wipe(AzerothAdmin.db.account.buffer.tickets)
    AzerothAdmin.db.account.buffer.tickets={}
--    AzerothAdmin:ChatMsg(".ticket delete"..ma_ticketid:GetText())
--    AzerothAdmin:LogAction("Deleted ticket with number: "..ma_ticketid:GetText())
    ShowTicketTab()
    ResetTickets()
    --InlineScrollUpdate()
  elseif value == "gochar" then
    AzerothAdmin:ChatMsg(".appear "..ma_ticketcreatedby:GetText())
  elseif value == "getchar" then
    AzerothAdmin:ChatMsg(".summon "..ma_ticketcreatedby:GetText())
  elseif value == "answer" then
--    AzerothAdmin:TogglePopup("mail", {recipient = ma_ticketcreatedby:GetText(), subject = "Ticket("..ma_ticketid:GetText()..")"})
    AzerothAdmin:TogglePopup("mail", {recipient = ma_ticketcreatedby:GetText(), subject = "Ticket("..ma_ticketid:GetText()..")"})
--    AzerothAdmin:TogglePopup("mail", {recipient = ma_ticketcreatedby:GetText(), subject = "Ticket("..ma_ticketid:GetText()..")", body = ma_ticketdetail:GetText()})
    ma_maileditbox:SetText(ma_ticketdetail:GetText())
  elseif value == "whisper" then
--    ChatFrameEditBox:Show()
--    ChatFrameEditBox:Insert("/w "..ma_ticketcreatedby:GetText().." ");
       local editbox = ChatFrame1EditBox
       if not editbox then
         -- Support for 3.3.5 and newer
         editbox = ChatEdit_GetActiveWindow()
       end
       ChatEdit_ActivateChat(editbox);
       if editbox then
         editbox:Insert("/w "..ma_ticketcreatedby:GetText().." ");
       end

  elseif value == "goticket" then
    AzerothAdmin:ChatMsg(".go ticket "..ma_ticketid:GetText())
  end
end

--[[function AzerothAdmin:ToggleTickets(value)
  AzerothAdmin:ChatMsg(".ticket "..value)
  AzerothAdmin:LogAction("Turned receiving new tickets "..value..".")
end]]


function InlineScrollUpdate()
    AzerothAdmin:LogAction("Showing tickets.")
    local ticketCount = 0
    table.foreachi(AzerothAdmin.db.account.buffer.tickets, function() ticketCount = ticketCount + 1 end)
    if ticketCount > 0 then
      ma_ticketscrollframe1:SetText("Loading")
      local lineplusoffset
      local line
      ma_ticketscrollframe:Show()
      FauxScrollFrame_Update(ma_ticketscrollframe,ticketCount,12,16);
      for line = 1,12 do
        lineplusoffset = line + FauxScrollFrame_GetOffset(ma_ticketscrollframe)
        if lineplusoffset <= ticketCount then
          local object = AzerothAdmin.db.account.buffer.tickets[lineplusoffset]
          if object then
            getglobal("ma_ticketscrollframe"..line):SetText("Ticket:|cffffffff"..object["tNumber"].."|r Created by: |cffffffff"..object["tChar"].."|r Last change:|cffffffff"..object["tLUpdate"].."|r")
            AzerothAdmin.db.account.tickets.selected = object
            getglobal("ma_ticketscrollframe"..line):SetScript("OnEnter", function() --[[Do nothing]] end)
            getglobal("ma_ticketscrollframe"..line):SetScript("OnLeave", function() --[[Do nothing]] end)
            getglobal("ma_ticketscrollframe"..line):SetScript("OnClick", function() ReadTicket(object["tNumber"], object["tChar"]) end)
            getglobal("ma_ticketscrollframe"..line):Enable()
            getglobal("ma_ticketscrollframe"..line):Show()
          end
        else
          getglobal("ma_ticketscrollframe"..line):Hide()
        end
      end
    else
      --AzerothAdmin:NoResults("ticket")
    end
--  else
--  end
--AzerothAdmin.db.account.buffer.tickets = {}
--AzerothAdmin.db.char.requests.ticket = false
end

function ReadTicket(tNumber, tChar, tLCreate, tLUpdate)
    AzerothAdmin.db.char.requests.ticket = false
    ma_goticketbutton:Enable()
    ma_deleteticketbutton:Enable()
    ma_answerticketbutton:Enable()
    ma_getcharticketbutton:Enable()
    ma_gocharticketbutton:Enable()
    ma_whisperticketbutton:Enable()
    tNumber = string.match(tNumber, "%d+")
    AzerothAdmin:ChatMsg(".ticket viewid "..tNumber)
    ma_ticketid:SetText(tNumber)
    ma_ticketcreatedby:SetText(tChar)
    ma_tickettimecreated:SetText(tLCreate)
    ma_ticketlastchange:SetText(tLUpdate)
    AzerothAdmin:LogAction("Displaying ticket number "..tNumber.." from player "..tChar)
    local ticketdetail = AzerothAdmin.db.account.buffer.ticketsfull
    ma_ticketdetail:Show();
    --AzerothAdmin:ChatMsg("???")
    --ma_ticketdetail:SetText("Hello")
    --AzerothAdmin:ChatMsg(AzerothAdmin.db.account.buffer.ticketsfull["tMsg"])
    --ma_ticketdetail:SetText(ticketdetail["tMsg"])
    --getglobal("ma_ticketdetail"):SetText("Id: |cffffffff"..tNumber.."|r Who: |cffffffff"..tChar.."|r Msg: |cffffffff"..ticketdetail["tMsg"].."|r")
    --ma_ticketdetail:SetText("Id: |cffffffff"..tNumber.."|r Who: |cffffffff"..tChar.."|r Msg: |cffffffff"..ticketdetail["tMsg"].."|r")
    --ma_ticketdetail:SetText(ticketdetail["tMsg"].."|r")
    --ma_ticketdetail:SetText("Hello")
end
 
