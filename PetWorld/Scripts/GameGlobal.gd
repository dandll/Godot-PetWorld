extends Node

#加载资源
#export(PackedScene) var mob_scene
#export(PackedScene) var player_scene
const mob_scene = preload("res://Sprite/AttakEmey01.tscn")
const player_scene = preload("res://Sprite/AttakPlayer01.tscn")
const magic01 = preload("res://Sprite/Magic/Magic01.tscn")
const player02Const = preload("res://Sprite/AttakPlayer02.tscn")
const player03Const = preload("res://Sprite/AttakPlayer03.tscn")
const pet01Const = preload("res://Sprite/AttakPet01.tscn")
const pet02Const = preload("res://Sprite/AttakPet02.tscn")
const pet03Const = preload("res://Sprite/AttakPetC1.tscn")
const emey01Const = preload("res://Sprite/AttakPet03.tscn")
const emey02Const = preload("res://Sprite/AttakPet04.tscn")
const emey03Const = preload("res://Sprite/AttakPet05.tscn")
const emey04Const = preload("res://Sprite/AttakPet06.tscn")
const emey05Const = preload("res://Sprite/AttakPet07.tscn")
const emey06Const = preload("res://Sprite/AttakPet08.tscn")
const emey07Const = preload("res://Sprite/AttakPet09.tscn")
const emey08Const = preload("res://Sprite/AttakPet10.tscn")
const emey09Const = preload("res://Sprite/AttakPet11.tscn")
const emey10Const = preload("res://Sprite/AttakPet12.tscn")
const emey11Const = preload("res://Sprite/AttakPet13.tscn")

#道具栏个数
var DaoJuLanGeShu=30;
#游戏动作加速倍数
var attackSpeedScale=3
#开始战斗等待时间
var attackWaitTime:float=0.5
#伤害数字显示时间
var healthLableTime:float=0.5

#移动到攻击目标的时间
var moveTime:float=0.3/(attackSpeedScale)
var attackTime:float=0.3/(attackSpeedScale)

#战斗关卡
var AttackGuanQia:int = 1

#玩家队伍数组
var attakPlayerArr=[];
#敌人队伍数组
var attakEmeyArr=[];

#数组
var shujvb = [];

func _ready():
	#加载物品数据
	for b in Daojvlan.wupinku.size():
		shujvb.append(Daojvlan.wupinku[b][1]["daojvname"])
	pass

#战斗选关场景
func AttakGameSelectScene():
	#get_tree().change_scene("res://Map/AttakSelectScene.tscn")
	SceneChanger.ChangeScene("res://Map/AttakSelectScene.tscn")
	pass

#战斗场景
func AttakGameScene():
	#get_tree().change_scene("res://Map/AttakScene.tscn")
	SceneChanger.ChangeScene("res://Map/AttakScene.tscn")
	pass

var yeWaiEmey1Alive=true;
var yeWaiEmey2Alive=true;
var yeWaiEmey3Alive=true;
var yeWaiEmey4Alive=true;
var yeWaiEmey5Alive=true;
var yeWaiEmeyXuHao=1;
#野外地图镜头位置
var yeWaiCameraStartV2=Vector2(0,0)
#战斗野外地图场景
func AttakMapGameScene():
	yeWaiEmey1Alive=true;
	yeWaiEmey2Alive=true;
	yeWaiEmey3Alive=true;
	yeWaiEmey4Alive=true;
	yeWaiEmey5Alive=true;
	#get_tree().change_scene("res://Map/AttackMapScene.tscn")
	SceneChanger.ChangeScene("res://Map/AttackMapScene.tscn")
	pass
#战斗野外地图战斗场景
func AttakYeWaiGameScene():
	#get_tree().change_scene("res://Map/AttakSceneYeWai.tscn")
	SceneChanger.ChangeScene("res://Map/AttakSceneYeWai.tscn")
	pass
#战斗野外地图场景-加载进度
func AttakMapGameSceneLoad():
	#get_tree().change_scene("res://Map/AttackMapScene.tscn")
	SceneChanger.ChangeScene("res://Map/AttackMapScene.tscn")
	pass
#主界面
func MainGameScene():
	#get_tree().change_scene("res://Map/GameMain.tscn")
	SceneChanger.ChangeScene("res://Map/GameMain.tscn")
	pass
#道具栏
func DaoJuLanScene():
	#get_tree().change_scene("res://daojvxitong/DaoJuLanForm.tscn")
	SceneChanger.ChangeScene("res://daojvxitong/DaoJuLanForm.tscn")
	pass
#属性栏
func ShuXingScene():
	#get_tree().change_scene("res://Sprite/UI/PlayerShuXing.tscn")
	SceneChanger.ChangeScene("res://Sprite/UI/PlayerShuXing.tscn")
	pass

#获取要攻击的敌人
func GetToAttakEmey()->Object:
	for playerObj in attakEmeyArr:
		if playerObj != null && is_instance_valid(playerObj):
			if !playerObj.isOutScene:
				return playerObj
			pass
	return null
	pass
#获取要攻击的玩家
func GetToAttakPlayer()->Object:
	for playerObj in attakPlayerArr:
		if playerObj != null && is_instance_valid(playerObj):
			if !playerObj.isOutScene:
				return playerObj
			pass
	return null
	pass

#保存路径-道具栏
var savePathDJL = "user://save-djl.json" 
#读取数据-道具栏
func duqvshujv_daojulan():
	#var shujvb = []
	var file =File.new()
	file.open(savePathDJL,File.READ)
	var json_str = file.get_as_text() 
	Daojvlan.daojvlan = parse_json(json_str) 
	if Daojvlan.daojvlan == null:
		#Daojvlan.daojvlan = parse_json("[null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null]") 
		#Daojvlan.daojvlan =Daojvlan.wupinku.duplicate()
		Daojvlan.daojvlan =Daojvlan.csdaojvlan;
		pass
	file.close()
	var djlsl=Daojvlan.daojvlan.size()
	while djlsl<DaoJuLanGeShu:
		Daojvlan.daojvlan.append(null);
		djlsl+=1;
	#for b in Daojvlan.wupinku.size():
	#	shujvb.append(Daojvlan.wupinku[b][1]["daojvname"])
	
	for a in Daojvlan.daojvlan.size():
		if Daojvlan.daojvlan[a] != null:
			if shujvb.has(Daojvlan.daojvlan[a][1]["daojvname"]):
				var w = shujvb.find(Daojvlan.daojvlan[a][1]["daojvname"])
				Daojvlan.daojvlan[a][1]["daojvtubiao"] = Daojvlan.wupinku[w][1]["daojvtubiao"]
				Daojvlan.daojvlan[a][1]["daojvmiaoshu"] = Daojvlan.wupinku[w][1]["daojvmiaoshu"]
				Daojvlan.daojvlan[a][1]["hebing"] = Daojvlan.wupinku[w][1]["hebing"]
				Daojvlan.daojvlan[a][1]["daojvxvhao"] = Daojvlan.wupinku[w][1]["daojvxvhao"]
	pass 
#保存数据-道具栏
func baocunshujv_daojulan():
	var file = File.new() 
	file.open(savePathDJL, File.WRITE) 
	file.store_line(to_json(Daojvlan.daojvlan)) 
	file.close() 
	pass

#保存路径-装备栏
var savePathZBL = "user://save-zbl.json" 
#读取数据-装备栏
func duqvshujv_zhuangbeilan():
	#var shujvb = []
	var file =File.new()
	file.open(savePathZBL,File.READ) 
	var json_str = file.get_as_text() 
	Daojvlan.zhuangbeilan = parse_json(json_str) 
	if Daojvlan.zhuangbeilan == null:
		Daojvlan.zhuangbeilan = parse_json("[null,null,null,null]") 
		pass
	file.close()
	#for b in Daojvlan.wupinku.size():
	#	shujvb.append(Daojvlan.wupinku[b][1]["daojvname"])
	
	for a in Daojvlan.zhuangbeilan.size():
		if Daojvlan.zhuangbeilan[a] != null:
			if shujvb.has(Daojvlan.zhuangbeilan[a][1]["daojvname"]):
				var w = shujvb.find(Daojvlan.zhuangbeilan[a][1]["daojvname"])
				Daojvlan.zhuangbeilan[a][1]["daojvtubiao"] = Daojvlan.wupinku[w][1]["daojvtubiao"]
				Daojvlan.zhuangbeilan[a][1]["daojvmiaoshu"] = Daojvlan.wupinku[w][1]["daojvmiaoshu"]
				Daojvlan.zhuangbeilan[a][1]["hebing"] = Daojvlan.wupinku[w][1]["hebing"]
				Daojvlan.zhuangbeilan[a][1]["daojvxvhao"] = Daojvlan.wupinku[w][1]["daojvxvhao"]
	pass 
#保存数据-装备栏
func baocunshujv_zhuangbeilan():
	var file = File.new() 
	file.open(savePathZBL, File.WRITE) 
	file.store_line(to_json(Daojvlan.zhuangbeilan)) 
	file.close() 
	pass

#保存路径-游戏信息
var savePathInfo = "user://save-info.json" 
#读取数据-游戏信息
func duqvshujv_info():
	#var shujvb = []
	var file =File.new()
	file.open(savePathInfo,File.READ) 
	var json_str = file.get_as_text() 
	var tempObj = parse_json(json_str) 
	if tempObj != null:
		GgInfo.playerData = tempObj
	#	if Daojvlan.zhuangbeilan == null:
	#		Daojvlan.zhuangbeilan = parse_json("[null,null,null,null]") 
#		pass
	file.close()
	#	for b in Daojvlan.wupinku.size():
	#		shujvb.append(Daojvlan.wupinku[b][1]["daojvname"])
	#
	#	for a in Daojvlan.zhuangbeilan.size():
	#		if Daojvlan.zhuangbeilan[a] != null:
	#			if shujvb.has(Daojvlan.zhuangbeilan[a][1]["daojvname"]):
	#				var w = shujvb.find(Daojvlan.zhuangbeilan[a][1]["daojvname"])
	#				Daojvlan.zhuangbeilan[a][1]["daojvtubiao"] = Daojvlan.wupinku[w][1]["daojvtubiao"]
	#				Daojvlan.zhuangbeilan[a][1]["daojvmiaoshu"] = Daojvlan.wupinku[w][1]["daojvmiaoshu"]
	#				Daojvlan.zhuangbeilan[a][1]["hebing"] = Daojvlan.wupinku[w][1]["hebing"]
	#				Daojvlan.zhuangbeilan[a][1]["daojvxvhao"] = Daojvlan.wupinku[w][1]["daojvxvhao"]
	#
	#
	pass 
#保存数据-游戏信息
func baocunshujv_info():
	var file = File.new() 
	file.open(savePathInfo, File.WRITE) 
	file.store_line(to_json(GgInfo.playerData)) 
	file.close() 
	pass



