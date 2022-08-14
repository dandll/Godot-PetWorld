extends Node

var playerTempTZ=0;
var playerTempLL=0;
var playerTempNL=0;

var playerData=[
	["ShuXing",{
		#等级
		"dj":0,
		#经验
		"jy":1000,
		#体质
		"tz":10,
		#力量
		"ll":10,
		#耐力
		"nl":10,
		#初始生命值
		"cssmz":150,
		#初始伤害值
		"csshz":41,
		#初始防御值
		"csfyz":15,
		#装备生命值
		"zbsmz":0,
		#装备伤害值
		"zbshz":0,
		#装备防御值
		"zbfyz":0,
		#剩余属性点
		"sysxd":5,
		"ktcw1":0,
		"ktp2":0,
		"ktp3":0,
		"wst1":0,
		"wst2":0,
		"wst3":0,
		"wst4":0,
		"wst5":0,
	},
	],
	["Pet",{
		
	}]
]

var YeGuaiData=[
	["0级",{#大海龟
		#攻击资质
		"gjzz":960,
		#防御资质
		"fyzz":960,
		#体力资质
		"tlzz":3600,
		#成长
		"cz":0.918
	}],["10级",{#老虎
		#攻击资质
		"gjzz":1380,
		#防御资质
		"fyzz":1080,
		#体力资质
		"tlzz":3600,
		#成长
		"cz":1.045
	}],["20级",{#蟹将
		#攻击资质
		"gjzz":1320,
		#防御资质
		"fyzz":1200,
		#体力资质
		"tlzz":5100,
		#成长
		"cz":1.066
	}],["30级",{#牛头
		#攻击资质
		"gjzz":1320,
		#防御资质
		"fyzz":1320,
		#体力资质
		"tlzz":3600,
		#成长
		"cz":1.101
	}],["40级",{#白熊
		#攻击资质
		"gjzz":1320,
		#防御资质
		"fyzz":1320,
		#体力资质
		"tlzz":5280,
		#成长
		"cz":1.142
	}],["50级",{#天兵
		#攻击资质
		"gjzz":1320,
		#防御资质
		"fyzz":1500,
		#体力资质
		"tlzz":5100,
		#成长
		"cz":1.173
	}],
]

var JingYanData={0:414,
2:724,
4:931,
6:1138,
8:1345,
12:1759,
16:2173,
20:2587,
24:3001,
28:3415,
32:3829,
36:4243,
38:4450,
50:5692,
54:6106,
58:6520,
62:6934,
68:7567,
72:7969,
76:8383,
80:8797,
84:9211,
88:9625,
96:10453,
104:11281,
112:12108,
121:13104,
}

#获取玩家开通宠物
func GetPlayerKaiTongChongWu()->int:
	if GgInfo.playerData[0][1].has("ktcw1"):
		return GgInfo.playerData[0][1]["ktcw1"];
	return 0;
	pass

#获取玩家开通宠物
func GetPlayerKaiTongChongWu2()->int:
	if GgInfo.playerData[0][1].has("ktcw2"):
		return GgInfo.playerData[0][1]["ktcw2"];
	return 0;
	pass

#获取玩家开通Player2
func GetPlayerKaiTongPlayer2()->int:
	if GgInfo.playerData[0][1].has("ktp2"):
		return GgInfo.playerData[0][1]["ktp2"];
	return 0;
	pass

#获取玩家开通Player3
func GetPlayerKaiTongPlayer3()->int:
	if GgInfo.playerData[0][1].has("ktp3"):
		return GgInfo.playerData[0][1]["ktp3"];
	return 0;
	pass

#获取玩家 武神坛
func GetPlayerWuShenTan(inValue)->int:
	if GgInfo.playerData[0][1].has("wst"+inValue as String):
		return GgInfo.playerData[0][1]["wst"+inValue as String];
	return 0;
	pass

#设置玩家 武神坛
func SetPlayerWuShenTan(inValue)->int:
	GgInfo.playerData[0][1]["wst"+inValue as String]=1;
#	if GgInfo.playerData[0][1].has("wst"+inValue as String):
#		GgInfo.playerData[0][1]["wst"+inValue as String]=1;
#	else:
#		GgInfo.playerData[0][1]["wst"+inValue as String]=1;
#		pass
	GameGlobal.baocunshujv_info();
	return GgInfo.playerData[0][1]["wst"+inValue as String];
	pass

#设置玩家开通宠物
func SetPlayerKaiTongChongWu()->int:
	GgInfo.playerData[0][1]["ktcw1"]=1;
	GameGlobal.baocunshujv_info();
	return GgInfo.playerData[0][1]["ktcw1"];
	pass

#设置玩家开通宠物
func SetPlayerKaiTongChongWu2()->int:
	GgInfo.playerData[0][1]["ktcw2"]=1;
	GameGlobal.baocunshujv_info();
	return GgInfo.playerData[0][1]["ktcw2"];
	pass

#获取玩家开通Player2
func SetPlayerKaiTongPlayer2()->int:
	GgInfo.playerData[0][1]["ktp2"]=1;
	GameGlobal.baocunshujv_info();
	return GgInfo.playerData[0][1]["ktp2"];
	pass

#获取玩家开通Player3
func SetPlayerKaiTongPlayer3()->int:
	GgInfo.playerData[0][1]["ktp3"]=1;
	GameGlobal.baocunshujv_info();
	return GgInfo.playerData[0][1]["ktp3"];
	pass

#获取玩家等级
func GetPlayerDJ()->int:
	return GgInfo.playerData[0][1]["dj"];
	pass

#玩家获得经验
func PlayerGetJingYan(inValue):
	GgInfo.playerData[0][1]["jy"]+=inValue;
	pass

#获取生命值
func GetPlayerSMZ()->int:
	GetPlayerTempSMZ();
	return (playerData[0][1]["tz"]*5)+playerData[0][1]["cssmz"]+playerData[0][1]["zbsmz"];
	pass

#获取伤害值
func GetPlayerSHZ()->int:
	GetPlayerTempSHZ();
	return ((playerData[0][1]["ll"]*0.7) as int)+playerData[0][1]["csshz"]+playerData[0][1]["zbshz"];
	pass

#获取防御值
func GetPlayerFYZ()->int:
	GetPlayerTempFYZ();
	return ((playerData[0][1]["nl"]*1.5) as int)+playerData[0][1]["csfyz"]+playerData[0][1]["zbfyz"];
	pass
#获取装备生命值
func GetPlayerZBSMZ()->int:
	playerData[0][1]["zbsmz"]=0;
	for i in Daojvlan.zhuangbeilan.size():
		if Daojvlan.zhuangbeilan[i] != null:
	#			if Daojvlan.zhuangbeilan[i][1].has("gj"):
	#				var gj = Daojvlan.zhuangbeilan[i][1]["gj"] as int;
	#				if gj!=0:
	#					playerData[0][1]["zbshz"]+=gj;
				if Daojvlan.zhuangbeilan[i][1].has("sm"):
					var gj = Daojvlan.zhuangbeilan[i][1]["sm"] as int;
					if gj!=0:
						playerData[0][1]["zbsmz"]+=gj;
						#playerObj.healthNum+=gj;
	#			if Daojvlan.zhuangbeilan[i][1].has("fy"):
	#				var gj = Daojvlan.zhuangbeilan[i][1]["fy"] as int;
	#				if gj!=0:
	#					playerData[0][1]["zbfyz"]+=gj;
	return playerData[0][1]["zbsmz"];
	pass
#获取装备伤害值
func GetPlayerZBSHZ()->int:
	playerData[0][1]["zbshz"]=0;
	for i in Daojvlan.zhuangbeilan.size():
		if Daojvlan.zhuangbeilan[i] != null:
			if Daojvlan.zhuangbeilan[i][1].has("gj"):
				var gj = Daojvlan.zhuangbeilan[i][1]["gj"] as int;
				if gj!=0:
					playerData[0][1]["zbshz"]+=gj;
	#			if Daojvlan.zhuangbeilan[i][1].has("sm"):
	#				var gj = Daojvlan.zhuangbeilan[i][1]["sm"] as int;
	#				if gj!=0:
	#					playerData[0][1]["zbsmz"]+=gj;
	#					#playerObj.healthNum+=gj;
	#			if Daojvlan.zhuangbeilan[i][1].has("fy"):
	#				var gj = Daojvlan.zhuangbeilan[i][1]["fy"] as int;
	#				if gj!=0:
	#					playerData[0][1]["zbfyz"]+=gj;
	return playerData[0][1]["zbshz"];
	pass
#获取装备防御值
func GetPlayerZBFYZ()->int:
	playerData[0][1]["zbfyz"]=0;
	for i in Daojvlan.zhuangbeilan.size():
		if Daojvlan.zhuangbeilan[i] != null:
	#			if Daojvlan.zhuangbeilan[i][1].has("gj"):
	#				var gj = Daojvlan.zhuangbeilan[i][1]["gj"] as int;
	#				if gj!=0:
	#					playerData[0][1]["zbshz"]+=gj;
	#			if Daojvlan.zhuangbeilan[i][1].has("sm"):
	#				var gj = Daojvlan.zhuangbeilan[i][1]["sm"] as int;
	#				if gj!=0:
	#					playerData[0][1]["zbsmz"]+=gj;
	#					#playerObj.healthNum+=gj;
			if Daojvlan.zhuangbeilan[i][1].has("fy"):
				var gj = Daojvlan.zhuangbeilan[i][1]["fy"] as int;
				if gj!=0:
					playerData[0][1]["zbfyz"]+=gj;
	return playerData[0][1]["zbfyz"];
	pass

#获取临时计算生命值
func GetPlayerTempSMZ()->int:
	return ((playerTempTZ*5)+playerData[0][1]["cssmz"]) as int;
	pass

#获取临时计算伤害值
func GetPlayerTempSHZ()->int:
	return (((playerTempLL*0.7) as int)+playerData[0][1]["csshz"]) as int;
	pass

#获取临时计算防御值
func GetPlayerTempFYZ()->int:
	return (((playerTempNL*1.5) as int)+playerData[0][1]["csfyz"]) as int;
	pass

#获取宠物生命值
func GetPetSMZ()->int:
	return 1;#等级*体力资质*0.002895+体力属性点*成长*7;
	pass

#获取宠物伤害值
func GetPetSHZ()->int:
	return ((playerData[0][1]["ll"]*0.7) as int)+playerData[0][1]["csshz"];
	pass

#获取宠物防御值
func GetPetFYZ()->int:
	return ((playerData[0][1]["nl"]*1.5) as int)+playerData[0][1]["csfyz"];
	pass

#获取野怪生命值
func GetYeGuaiSMZ(inDJ,tz)->int:
	var djL=(inDJ-(inDJ%10))/10;
	return (inDJ*YeGuaiData[djL][1]["tlzz"]*0.002895+tz*YeGuaiData[djL][1]["cz"]*7) as int;#等级*体力资质*0.002895+体力属性点*成长*7;
	pass

#获取野怪伤害值
func GetYeGuaiSHZ(inDJ,ll)->int:
	var djL=(inDJ-(inDJ%10))/10;
	return (inDJ*YeGuaiData[djL][1]["gjzz"]*0.0025+ll*YeGuaiData[djL][1]["cz"]*1.6) as int;#等级*攻击资质*0.0025+力量属性点*成长*1.6;
	pass

#获取野怪防御值
func GetYeGuaiFYZ(inDJ,nl)->int:
	var djL=(inDJ-(inDJ%10))/10;
	#return (inDJ*YeGuaiData[djL][1]["fyzz"]*0.0015+nl*YeGuaiData[djL][1]["cz"]*0.8) as int;#等级*防御资质*0.003345+耐力属性点*成长*2.4;
	return (inDJ*YeGuaiData[djL][1]["fyzz"]*0.003345+nl*YeGuaiData[djL][1]["cz"]*2.4) as int;#等级*防御资质*0.003345+耐力属性点*成长*2.4;
	pass

func GetYeGuaiJingYan()->int:
	#GameGlobal.AttackGuanQia
	var tempgq = GameGlobal.AttackGuanQia;
	var tempdj = GetPlayerDJ();
	for i in JingYanData.keys():
		if tempdj<i:
			#return JingYanData[JingYanData.keys().find(i)];
			return JingYanData[i];
	return JingYanData[0];
	pass

#获取道具
func SetZB(inDaoJuMing):
	#print(inDaoJuMing)
	for a in Daojvlan.daojvlan.size():
		if Daojvlan.daojvlan[a] == null:
			if GameGlobal.shujvb.has(inDaoJuMing):
				#print("in shujvb")
				var w = GameGlobal.shujvb.find(inDaoJuMing)
				Daojvlan.daojvlan[a] = Daojvlan.wupinku[w]
				Daojvlan.daojvlan[a][1]["daojvtubiao"] = Daojvlan.wupinku[w][1]["daojvtubiao"]
				Daojvlan.daojvlan[a][1]["daojvmiaoshu"] = Daojvlan.wupinku[w][1]["daojvmiaoshu"]
				Daojvlan.daojvlan[a][1]["hebing"] = Daojvlan.wupinku[w][1]["hebing"]
				Daojvlan.daojvlan[a][1]["daojvxvhao"] = Daojvlan.wupinku[w][1]["daojvxvhao"]
				#print("find inDaoJuMing")
				GameGlobal.baocunshujv_daojulan();
				return
	pass
