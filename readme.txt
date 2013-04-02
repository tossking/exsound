EXSound [2007/2/2首发]

Copyright GPL2

当前版本：3.02 [2009/9/7]
3.02 增加了4杀和5杀的音效。

当前版本：3.01 [2008/12/18]
3.01 增加荣誉击杀的判断，让插件只在PVP时生效。


当前版本：3.0 [2008/12/17]
维护者：Holyelf（WOW四区 通灵学院 人类牧师 Holyelf）
喵喵很久没有更新过这个插件了，0.7版在现在的WOW版本里无法运行，
做为一个DOTA和WOW的共同爱好者，我尝试着更新了一下这个插件，让她支持CWOW 3.0.5，
感谢喵喵所做的大量工作，我只需要修改一点点代码就可以正常运行了 o(∩_∩)o...哈哈，
同时感谢NGA论坛上的黑暗神，是他的帖子带我走进了插件世界，在更新这个插件的过程中他也给了大量的帮助和支持。

当前版本：0.7 [2007/8/24]

作者：喵喵（WOW二区 泰兰德 人类战士 亲亲喵喵）
素材、创意来源：UnrealTournament、DotA AllStars

简介：玩过DotA AllStars的朋友应该都会为其中杀死对方英雄时那晴天霹雳般的一声吼热血沸腾（尽管这些音效的素材来自UT，最早由Guinsoo搬过来），这个小插件就是对DotA AllStars中语音/文字提示的不完全模拟。

由于这是我制作的第一个插件，难免很粗糙或存在各种bug，欢迎大家测试提交错误（但是我肯定懒得更新……）。

文件列表：
EXSound\sound\triplekill.wav
EXSound\sound\ownage.wav
EXSound\sound\firstblood.wav
EXSound\sound\godlike.wav
EXSound\sound\wickedsick.wav
EXSound\sound\unstoppable.wav
EXSound\sound\monsterkill.wav
EXSound\sound\holyshit.wav
EXSound\sound\doublekill.wav
EXSound\sound\ultrakill.wav
EXSound\sound\rampage.wav
EXSound\sound\dominating.wav
EXSound\sound\megakill.wav
EXSound\sound\killingspree.wav
EXSound\EXSound.toc
EXSound\EXSound.lua
EXSound\EXSound.xml
EXSound\readme.txt（就是你现在看的这篇东西）


使用方法：解压文件后，将整个EXSound文件夹放入游戏目录下的Interface\AddOns中。


设置命令（暂时不提供保存设置功能）：

/exs                        查看当前设置状态
/exs help                显示命令列表
/exs on                        开启插件（默认为开启）
/exs off                关闭插件（声音无法单独关闭，只能通过这个）
/exs name                设置当杀死敌人时是否用文字发送他的名字（默认为开启）
/exs rank                设置当杀死敌人时是否用文字发送你当前杀戮称号（默认为开启）
/exs "channel"                设置文字发送的频道（默认为表情频道），其中"channel"为say、yell、emote、party、raid、bg或auto。例如输入“/exs yell”将会把频道设置为“大喊”。当设置成auto时插件将自动检测频道，此模式下如果开启了"仅战场有效"选项，则在进入战场后会自动使用战场频道发送文字；如果关闭了"仅战场有效"选项，则会依玩家当前是否在一个队伍中自动判断使用团队、小队或表情频道。
/exs score                显示你目前的战绩，包括每个杀死的敌人和杀死他们的时间。

友情提示：考虑到队友未必会喜欢刷屏式的信息轰炸，因此我才把默认设置成表情频道而不是自动匹配。虽然让大家都能看见是很有气势……但是还是要爱护公共频道资源……


其他1：与DotA不同的是，这个插件在你每次复活后的第一个击杀都会有FirstBlood的声音提示，而且我并没有让它发送一个文字信息，这也是为了避免刷屏。

其他2：还有几个声音文件我没有使用，留给大家在自己喜欢的地方例如其他宏里以
/script PlaySoundFile("Interface\\AddOns\\EXSound\\sound\\文件名")
调用即可播放该声音

其他3：感谢素材制作者、DotA AllStars地图的作者、汉化者以及其他给我提供帮助的网站、文档。为保护素材作者版权，本插件仅供个人自娱自乐及与网友分享，不可作为商业用途（这么个破玩意也没什么可卖的，加上这句话只是惯例……）。祝大家玩得愉快。


——————声音列表——————

*提示列表（基本照搬DotA AllStars的设定）：
第一次击杀：		First Blood
自己不死亡的情况下杀死
3人：			Killing Spree（大杀特杀）
4人：			Dominating（主宰比赛）
5人：			Mega-Kill（n人斩）
6人：			Unstoppable（无人能挡）
7人：			Wicked Sick（变态杀戮）
8人：			MMMMMonster Kill（妖怪般的杀戮）
9人：			Godlike（接近神的杀戮）
>=10人：		Holy Shit（超越神的杀戮）

10秒内连续杀死2人：		Double Kill（双杀）
完成双杀后10秒内再次杀死1人：	Triple Kill（三杀）



——————更新记录——————
2007年8月24日
v0.7发布
变动：
-修正了/exs score的错误
    疏忽了，这个指令里也包含表遍历，忘了在这边改掉语法。抱歉……
-修正版本号提示
    无关紧要的小问题，一起修正。


2007年8月12日
v0.6发布
变动：
-支持CWOW2.1.3
    由于学习和各种原因，一段时间没更新，特此回来填坑。WOW2.0+采用了5.1版的LUA，语法在细微之处做了改动。其实导致EXSound不能使用的原因很简单，就是表的遍历语法改变，不再支持以前的{for i,v in 表名 do 语句 end}，而是换成了{for i,v in pairs(表名) do 语句 end}，是的，核心部分改动就这么点。
-不再使用mpq打包声音文件
    WOW2.0+对自定义mpq模型进行了一定打压，现在所有的声音文件都直接包含在插件文件夹里了，见上面的列表。
-取消了LootFX的集成
    理由同上，正好这个功能本来就很受非议。
-取消了函数use(itemname)
    WOW2.0+自带的宏/use可以完全取代它的功能，因此不再需要这个函数。


2007年3月8日
v0.5发布
变动：
-增加显示战绩功能
    新版中增加了一个表，与之前记录“所有你亲手杀死的敌对目标”的表不同，这个表只记录“所有你亲手杀死的荣誉目标”也就是敌对玩家和每次击杀的时间。你可以通过输入新命令“/exs score”来查看这些记录——当然，你死了以后它们也会被清空。


2007年3月5日
v0.4[未公开]
变动：
-增加了一个实用函数use(itemname)
    定义：
	for x=0,4 do
		for y=1,GetContainerNumSlots(x) do
			if (string.find(GetContainerItemLink(x,y) or "",itemname)) then
			UseContainerItem(x,y); return;
			end
		end
	end

    作用：执行时搜索背包里物品名称中带有"itemname"的物品并且使用。具体范例和详细用法可以参照上面的说明书。


2007年2月5日
v0.3发布
变动：
-采用了新的算法。
    由于v0.2算法设计的疏忽，虽然可以避免图腾、宠物等错误，但是当你杀死某个敌人A之后一直没有杀死其它敌人，而A复活后又被你的队友再次击杀时，仍然会统计入你的杀敌数量中，这是错误的。经过研究，为修正这个错误，算法做了如下改良：
    新版中使用了一个动态数组来管理你杀死敌人的历史，在你杀死某个敌人时它会记录下敌人的名字和当前时间，如果在此之后的1秒内检测出了相同名字的荣誉击杀，则认为你杀死了一个敌对玩家，然后发送消息并播放声音。为了防止数据量过大，每次你死亡时该数组都将被清空。新的算法修正了之前的一系列错误并且更易于理解。
-改变了死亡判定方法。
    由于之前没有仔细看过全部WOW公共EVENT，一直采用监视"CHAT_MSG_COMBAT_FRIENDLY_DEATH"事件中的“你死了。”来判断玩家是否死亡。新版中直接监视"PLAYER_DEAD"事件，从而节省少量资源。


2007年2月4日
v0.2发布
变动：
-采用了新的算法。
    旧的函数是通过监视战斗记录中的“你杀死了(.+)”来判断执行，即使在战场里也无法区分你杀死的是玩家还是图腾、宠物、召唤生物或小动物；
    新版中当战斗记录中出现“你杀死了(.+)！”后将会把该敌人的名字暂时复制到一个容量为2（为了防止同时击杀2目标时只能统计到1个的错误）的缓存数组中，然后在出现荣誉击杀的记录时判断目标是否刚才被你所杀，如果是则发送消息并播放声音。从而实现尽量消除误判，只记录杀死敌对玩家数量。
-去除了pvp设置功能。
    由于算法改变，不需要通过限制地区来屏蔽杀怪的记录，因此取消了“/exs pvp”这个开关以及所有相关的变量。同时正式支持PVP服务器野外荣誉击杀的监视。
-改良了插件关闭的设置。
    不再使用if语句判断插件是否在开启状态，而是采用UnregisterEvent进行关闭插件的操作，减少了插件关闭状态时的资源占用。


2007年2月2日
v0.1（最初版）发布
