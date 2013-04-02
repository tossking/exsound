--EXSound v3.02--
--Create By 喵喵--
--Modify By Holyelf, 4区通灵学院联盟--

local EXS_mkill_time = 10;

EXStotalkill = 0;
EXStotaldeath = 0;
EXSshow = false;
EXSkillias = 0;
EXSkillsttime = 0;
EXSkilltable = {};
EXStemptable = {};
EXSi = 1;
EXmutikill = 0;
EXSison = true;
EXSshowname = true;
EXSshowrank = true;
EXSautocn = false;
EXSchannel = "EMOTE";
EXStxt = nil;
--EXSrktxt = nil;
EXSrktxt = "第一滴血";
EXSsnd = "";
EXSenemyname = "";

function EXSound_FrameUpdate()
	textFPS = getglobal("EXSoundFrameTextFPS");
	textDelay = getglobal("EXSoundFrameTextDelay");
	textMoney = getglobal("EXSoundFrameTextMoney");
	down, up, lag = GetNetStats();

--	textFPS:SetText("FPS "..floor(GetFramerate()));
--	textDelay:SetText("Delay "..lag.." ms");
--	textMoney:SetText("Money "..floor(GetMoney()/10000).." G");
	textFPS:SetText("杀戮称号 "..EXSrktxt);
	textDelay:SetText("杀敌总数 "..EXStotalkill);
	textMoney:SetText("死亡次数 "..EXStotaldeath);
end

function EXSound_OnLoad()
	local myFrame = getglobal("EXSoundFrame");
	if(EXSshow) then
		myFrame:Show();
	else
		myFrame:Hide(); 
	end
	myFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	myFrame:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN");
	SlashCmdList["EXSSLASH"] = EXSound_command;
	SLASH_EXSSLASH1 = "/exs";

	DEFAULT_CHAT_FRAME:AddMessage("EXSound 成功载入！");
	PlaySoundFile("Interface\\AddOns\\EXSound\\sound\\freshmeat.wav");
end


function EXSound_OnEvent(self, event, ...)
	if(event == "COMBAT_LOG_EVENT_UNFILTERED") then
		local timestamp, eventType, sourceGUID, sourceName, sourceFlags, destGUID, destName, destFlags = select(1, ...);

		if(eventType == "PARTY_KILL") then
			if(sourceGUID == UnitGUID("player")) then
--				DEFAULT_CHAT_FRAME:AddMessage("EXSound debug: I kill "..destName);
				EXSenemyname = string.gsub(destName,"(.+)-(.+)","%1");
				if (not EXSenemyname) then
					EXSenemyname = destName;
				end;
--				DEFAULT_CHAT_FRAME:AddMessage("EXSound debug: REMOVE server name: "..EXSenemyname);
				EXStemptable[EXSenemyname] = GetTime();
			end;
		end;	
		--if event == "PLAYER_DEAD" then
		if (eventType == "UNIT_DIED") then
			if (UnitGUID("player") == destGUID) then
				EXS_dmsg();
				EXSkilltable = nil;		
				EXSkilltable = {};
				EXStemptable = nil;
				EXStemptable = {};
				EXSrktxt = nil;
				EXSkillias = 0;
			end;
		end;
	end;

	if event == "CHAT_MSG_COMBAT_HONOR_GAIN" then
		EXSenemyname = string.gsub(arg1,"(.+)死亡，荣誉击杀(.+)","%1");
--		DEFAULT_CHAT_FRAME:AddMessage("EXSound debug: string.gsub EXSenemyname="..EXSenemyname);
		for i,v in pairs(EXStemptable) do
			if i == EXSenemyname and (GetTime() - v < 1) then
				EXS_play();
				EXSkilltable[EXSkillias] = {
					name = EXSenemyname;
					time = EXS_time();
				};
			end
		end

	end	

end

function EXSound_command(arg)
--	_, _, arg1 = string.find(arg, "^%s*(%S+)");
--	if (not arg1) then
--		arg1 = arg;
--	end
-- arg1 = string.lower(arg1);
	arg1 = string.lower(arg);
	
	if arg1 == "on" then
		EXSison = true;
		EXSoundFrame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		EXSoundFrame:RegisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN");
		DEFAULT_CHAT_FRAME:AddMessage("EXSound已开启");
		PlaySoundFile("Interface\\AddOns\\EXSound\\sound\\freshmeat.wav");
	elseif arg1 == "off" then
		EXSison = false;
		EXSkilltable = nil;		
		EXSkilltable = {};
		EXStemptable = nil;
		EXStemptable = {};
		EXSrktxt = nil;
		EXSkillias = 0;
		EXSoundFrame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		EXSoundFrame:UnregisterEvent("CHAT_MSG_COMBAT_HONOR_GAIN");
		DEFAULT_CHAT_FRAME:AddMessage("EXSound已关闭");
	elseif arg1 == "show" then
		EXSshow = true;
		local myFrame = getglobal("EXSoundFrame"); 
		if(not myFrame:IsShown()) then
			myFrame:Show();
		end
	elseif arg1 == "hide" then
		EXSshow = false;
		local myFrame = getglobal("EXSoundFrame"); 
		if(myFrame:IsShown()) then
			myFrame:Hide();
		end
	elseif arg1 == "name" then
		EXSshowname = not EXSshowname;
		if EXSshowname == true then
			DEFAULT_CHAT_FRAME:AddMessage("显示杀死敌人的名字：开启");
		else
			DEFAULT_CHAT_FRAME:AddMessage("显示杀死敌人的名字：关闭");
		end
	elseif arg1 == "rank" then
		EXSshowrank = not EXSshowrank;
		if EXSshowrank == true then
			DEFAULT_CHAT_FRAME:AddMessage("显示杀戮称号：开启");
		else
			DEFAULT_CHAT_FRAME:AddMessage("显示杀戮称号：关闭");
		end
	elseif arg1 == "say" then
		EXSchannel = "SAY";
		EXSautocn = false;
		DEFAULT_CHAT_FRAME:AddMessage("改变频道为：说");
	elseif arg1 == "yell" then
		EXSchannel = "YELL";
		EXSautocn = false;
		DEFAULT_CHAT_FRAME:AddMessage("改变频道为：大喊");
	elseif arg1 == "emote" then
		EXSchannel = "EMOTE";
		EXSautocn = false;
		DEFAULT_CHAT_FRAME:AddMessage("改变频道为：表情");		
	elseif arg1 == "party" then
		EXSchannel = "PARTY";
		EXSautocn = false;
		DEFAULT_CHAT_FRAME:AddMessage("改变频道为：小队");
	elseif arg1 == "raid" then
		EXSchannel = "RAID";
		EXSautocn = false;
		DEFAULT_CHAT_FRAME:AddMessage("改变频道为：团队");
	elseif arg1 == "bg" then
		EXSchannel = "BATTLEGROUND";
		EXSautocn = false;
		DEFAULT_CHAT_FRAME:AddMessage("改变频道为：战场");
	elseif arg1 == "auto" then
		EXSautocn = true;
		DEFAULT_CHAT_FRAME:AddMessage("改变频道为：自动");
	elseif arg1 == "score" then
		DEFAULT_CHAT_FRAME:AddMessage("☆☆☆EXS-战绩☆☆☆");
		if EXSkillias == 0 then
			DEFAULT_CHAT_FRAME:AddMessage("你还未杀死任何敌人！");
		else
			for i in pairs(EXSkilltable) do
				DEFAULT_CHAT_FRAME:AddMessage("["..EXSkilltable[i].time.."]"..EXSkilltable[i].name);
			end
			DEFAULT_CHAT_FRAME:AddMessage("击杀："..EXSkillias);
			if EXSrktxt then
				DEFAULT_CHAT_FRAME:AddMessage("称号："..EXSrktxt);
			end
		end	
	elseif arg1 == "help" then
		DEFAULT_CHAT_FRAME:AddMessage("EXSound v3.0 命令列表");
		DEFAULT_CHAT_FRAME:AddMessage("/exs ——————显示插件当前状态");
		DEFAULT_CHAT_FRAME:AddMessage("/exs [on/off] ———打开/关闭插件");
		DEFAULT_CHAT_FRAME:AddMessage("/exs [show/hide] ———打开/关闭插件窗口显示");
		DEFAULT_CHAT_FRAME:AddMessage("/exs name ———切换是否发送你杀死敌人的名字");
		DEFAULT_CHAT_FRAME:AddMessage("/exs rank ———切换是否发送你的杀戮称号");
		DEFAULT_CHAT_FRAME:AddMessage("/exs [say/yell/emote/party/raid/bg/auto]	—切换信息发送频道");
		DEFAULT_CHAT_FRAME:AddMessage("/exs score ———显示你目前的战绩");		
	else
		DEFAULT_CHAT_FRAME:AddMessage("EXSound v3.0 输入/exs help查看命令列表");
		if EXSison == true then
			DEFAULT_CHAT_FRAME:AddMessage("EXSound状态：开启");
		else
			DEFAULT_CHAT_FRAME:AddMessage("EXSound状态：关闭");
		end
		if EXSshow == true then
			DEFAULT_CHAT_FRAME:AddMessage("EXSound窗口：开启");
		else
			DEFAULT_CHAT_FRAME:AddMessage("EXSound窗口：关闭");
		end
		if EXSshowname == true then
			DEFAULT_CHAT_FRAME:AddMessage("显示杀死敌人的名字：开启");
		else
			DEFAULT_CHAT_FRAME:AddMessage("显示杀死敌人的名字：关闭");
		end
		if EXSshowrank == true then
			DEFAULT_CHAT_FRAME:AddMessage("显示杀戮称号：开启");
		else
			DEFAULT_CHAT_FRAME:AddMessage("显示杀戮称号：关闭");
		end		
		if EXSautocn == true then
			DEFAULT_CHAT_FRAME:AddMessage("发送频道：自动[当你在战场时自动使用战场频道]");
		else
			DEFAULT_CHAT_FRAME:AddMessage("发送频道："..EXSchannel);				
		end
	end
end

function EXS_time()
	local hour,minute = GetGameTime();
	if minute < 10 then
		return hour .. ":0" .. minute;
	else
		return hour .. ":" .. minute;
	end
end

function EXS_msg()
	if EXSautocn == true then	
		if (GetZoneText() == "战歌峡谷" or GetZoneText() == "阿拉希盆地" or GetZoneText() == "奥特兰克山谷") then
			EXSchannel = "BATTLEGROUND";
		elseif UnitInRaid("player") then
			EXSchannel = "RAID";
		elseif UnitInParty("player") and GetNumPartyMembers() > 0 then
			EXSchannel = "PARTY";
		else
			EXSchannel = "EMOTE";
		end
	end
	if EXSshowname == true and EXStxt then
		SendChatMessage("杀死了"..EXSenemyname,EXSchannel);
	end
	if EXSshowrank == true and EXStxt then	
		SendChatMessage(EXStxt,EXSchannel);
	end
end

function EXS_dmsg()
	EXStotaldeath = EXStotaldeath + 1;
	if EXSautocn == true then	
		if (GetZoneText() == "战歌峡谷" or GetZoneText() == "阿拉希盆地" or GetZoneText() == "奥特兰克山谷") then
			EXSchannel = "BATTLEGROUND";
		elseif UnitInRaid("player") then
			EXSchannel = "RAID";
		elseif UnitInParty("player") and GetNumPartyMembers()>0 then
			EXSchannel = "PARTY";
		else EXSchannel = nil;
		end
	end	
	if EXSshowrank == true and EXSrktxt and EXSchannel then
		SendChatMessage(EXSrktxt.."被中止了，SHIT！",EXSchannel);
	end
end

function EXS_play()
	EXStotalkill = EXStotalkill + 1;
	if (GetTime() < EXSkillsttime + EXS_mkill_time) then
		EXmutikill = EXmutikill + 1;
	else
		EXmutikill = 0;
	end
--------------
	if EXSkillias == 0 then
		EXSsnd = "firstblood.wav";
		EXStxt = "拿到了第一滴血" ;
		EXSrktxt = "第一滴血";
	elseif EXSkillias == 2 then 
		EXSsnd = "killingspree.wav";
		EXStxt = "正在大杀特杀";
		EXSrktxt = "大杀特杀";
	elseif EXSkillias == 3 then 
		EXSsnd = "dominating.wav";
		EXStxt = "已经主宰比赛了！";
		EXSrktxt = "主宰比赛";
	elseif EXSkillias == 4 then 
		EXSsnd = "megakill.wav";
		EXStxt = "已经n人斩了！";
		EXSrktxt = "n人斩";
	elseif EXSkillias == 5 then 
		EXSsnd = "unstoppable.wav";
		EXStxt = "已经无人能挡！";
		EXSrktxt = "无人能挡";
	elseif EXSkillias == 6 then 
		EXSsnd = "wickedsick.wav";
		EXStxt = "都杀得变态了！";
		EXSrktxt = "变态杀戮";
	elseif EXSkillias == 7 then 
		EXSsnd = "monsterkill.wav";
		EXStxt = "MMMMMonsterKILL！！！";
		EXSrktxt = "妖怪般的杀戮";
	elseif EXSkillias == 8 then 
		EXSsnd = "godlike.wav";
		EXStxt = "已经接近神了！";
		EXSrktxt = "接近神的杀戮";
	elseif EXSkillias >= 9 then 
		EXSsnd = "holyshit.wav";
		EXStxt = "已经超越神了！";
		EXSrktxt = "超越神的杀戮";
	else
		EXSsnd = "";
		EXStxt = nil ;
		EXSrktxt = nil ;
	end
	
	EXS_msg();
	
	if EXmutikill == 1 then
		EXSsnd = "doublekill.wav";
		EXStemp = EXSshowname;
		EXSshowname = false;
		EXStxt = "刚刚完成了一次双杀！" ;
		EXS_msg();
		EXSshowname = EXStemp;
	elseif EXmutikill == 2 then
		EXSsnd = "triplekill.wav";
		EXStemp = EXSshowname;
		EXSshowname = false;
		EXStxt = "刚刚完成了一次三杀！！" ;
		EXS_msg();
		EXSshowname = EXStemp;
	elseif EXmutikill == 3 then
		EXSsnd = "ultrakill.wav";
		EXStemp = EXSshowname;
		EXSshowname = false;
		EXStxt = "刚刚完成了一次四杀！！" ;
		EXS_msg();
		EXSshowname = EXStemp;
	elseif EXmutikill >= 4 then
		EXSsnd = "rampage.wav";
		EXStemp = EXSshowname;
		EXSshowname = false;
		EXStxt = "刚刚完成了一次五杀！！" ;
		EXS_msg();
		EXSshowname = EXStemp;
	else
	end
	PlaySoundFile("Interface\\AddOns\\EXSound\\sound\\"..EXSsnd);
	EXSkillias = EXSkillias+1;
-------------
	EXSkillsttime = GetTime();
end
