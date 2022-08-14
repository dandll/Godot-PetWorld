extends Node2D

#战斗是否结束
var attakEnd:bool = false
var lblTipMsgStartV2 : Vector2;
var lblJiangLiStartV2 : Vector2;

#战斗回合数
var attackHuiHeNum=1;

#玩家位置
var attakPlayerPositionArr=[Vector2(88,176),Vector2(40,176),Vector2(136,176),Vector2(88,226),Vector2(40,226),Vector2(136,226)];
#敌人位置
var attakEmeyPositionArr=[Vector2(88,80),Vector2(40,80),Vector2(136,80),Vector2(88,40),Vector2(40,40),Vector2(136,40)];

#玩家队伍数组
var attakPlayerArr=[];
#敌人队伍数组
var attakEmeyArr=[];
 
func _ready():
	if GameGlobal.yeWaiCameraStartV2.x!=0||GameGlobal.yeWaiCameraStartV2.y!=0:
		$Map03.position.x=-GameGlobal.yeWaiCameraStartV2.x+96;
		$Map03.position.y=-GameGlobal.yeWaiCameraStartV2.y+136;
		GameGlobal.yeWaiCameraStartV2 = Vector2(0,0);
	
	$AttakEmey01.visible=false
	$AttakPlayer01.visible=false
	lblTipMsgStartV2=$lblTipMsg.rect_position;
	lblJiangLiStartV2=$lblJiangLi.rect_position;
	$lblJiangLi.visible=false;
	$lblTipMsg.text="进入战斗"
	$Tween.interpolate_property($lblTipMsg,"rect_position",Vector2($lblTipMsg.rect_position.x-50,$lblTipMsg.rect_position.y),Vector2($lblTipMsg.rect_position.x+150,$lblTipMsg.rect_position.y),1.5,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	$Tween.start()
	
	GameGlobal.attakEmeyArr.clear()
	GameGlobal.attakPlayerArr.clear()
	
	#动态创建敌人
	var emeyNum=0
	while emeyNum< GameGlobal.AttackGuanQia+1&&emeyNum<6:
		var mob = null;
		if GameGlobal.AttackGuanQia==1:
			if emeyNum==0:
				mob=GameGlobal.emey01Const.instance().duplicate()
			elif emeyNum==1:
				mob=GameGlobal.emey02Const.instance().duplicate()
		if GameGlobal.AttackGuanQia==2:
			if emeyNum==0:
				mob=GameGlobal.emey01Const.instance().duplicate()
			elif emeyNum==1:
				mob=GameGlobal.emey02Const.instance().duplicate()
			elif emeyNum==2:
				mob=GameGlobal.emey03Const.instance().duplicate()
		if GameGlobal.AttackGuanQia==3:
			if emeyNum==0:
				mob=GameGlobal.emey04Const.instance().duplicate()
			elif emeyNum==1:
				mob=GameGlobal.emey05Const.instance().duplicate()
			elif emeyNum==2:
				mob=GameGlobal.emey06Const.instance().duplicate()
			elif emeyNum==3:
				mob=GameGlobal.emey07Const.instance().duplicate()
		if GameGlobal.AttackGuanQia==4:
			if emeyNum==0:
				mob=GameGlobal.emey08Const.instance().duplicate()
			elif emeyNum==1:
				mob=GameGlobal.emey09Const.instance().duplicate()
			elif emeyNum==2:
				mob=GameGlobal.emey10Const.instance().duplicate()
			elif emeyNum==3:
				mob=GameGlobal.emey10Const.instance().duplicate()
			elif emeyNum==4:
				mob=GameGlobal.emey10Const.instance().duplicate()
		if GameGlobal.AttackGuanQia==5:
			if emeyNum==0:
				mob=GameGlobal.emey08Const.instance().duplicate()
			elif emeyNum==1:
				mob=GameGlobal.emey09Const.instance().duplicate()
			elif emeyNum==2:
				mob=GameGlobal.emey10Const.instance().duplicate()
			elif emeyNum==3:
				mob=GameGlobal.emey10Const.instance().duplicate()
			elif emeyNum==4:
				mob=GameGlobal.emey10Const.instance().duplicate()
			elif emeyNum==5:
				mob=GameGlobal.emey11Const.instance().duplicate()
		mob.dj=(GameGlobal.AttackGuanQia-1)*10+5;
	#		if GgInfo.playerData[0][1]["dj"] > 5:
	#			mob.dj=((GameGlobal.AttackGuanQia-1)*10)+(randi()%(10)+1)
	#		else:
	#			mob.dj=((GameGlobal.AttackGuanQia-1)*10)+(randi()%(5)+1)
	#			pass
		mob.teamNum=1
		#print("怪物等级："+mob.dj as String)
		$lblMonLevel.text="怪物等级："+mob.dj as String
		mob.position = attakEmeyPositionArr[emeyNum];
		add_child(mob)
		attakEmeyArr.append(mob)
		GameGlobal.attakEmeyArr.append(mob)
		mob.connect("signalAttackEnd",self,"GetSignalAttackEnd")
		emeyNum+=1
		pass
	#动态创建玩家
	var playerNum=0
	var playerV2Num=0
	var playerZongShu=5
	while playerNum<playerZongShu:
		var playerObj = null;
		if playerNum==0:
			playerObj=GameGlobal.player_scene.instance().duplicate()
		elif playerNum==1 && GgInfo.GetPlayerKaiTongPlayer2()==1:
			playerObj=GameGlobal.player02Const.instance().duplicate()
		elif playerNum==2 && GgInfo.GetPlayerKaiTongPlayer3()==1:
			playerObj=GameGlobal.player03Const.instance().duplicate()
		elif playerNum==3 && GgInfo.GetPlayerKaiTongChongWu()==1:
			playerObj=GameGlobal.pet01Const.instance().duplicate()
		elif playerNum==4 && GgInfo.GetPlayerKaiTongChongWu2()==1:
			playerObj=GameGlobal.pet03Const.instance().duplicate()
		else:
			playerNum+=1
			continue;
			pass
		if playerObj!=null:
			playerObj.teamNum=0
			playerObj.position = attakPlayerPositionArr[playerV2Num];
			add_child(playerObj)
			attakPlayerArr.append(playerObj)
			GameGlobal.attakPlayerArr.append(playerObj)
			playerObj.connect("signalAttackEnd",self,"GetSignalAttackEnd")
			playerObj.attakNum+=GgInfo.GetPlayerZBSHZ()
			playerObj.fangYuNum+=GgInfo.GetPlayerZBFYZ()
			playerObj.maxHealthNum+=GgInfo.GetPlayerTempSMZ()
			playerObj.healthNum+=GgInfo.GetPlayerTempSMZ()
			pass
		playerNum+=1
		playerV2Num+=1
		pass
	
	
	#print("AttakPlayer01:"+$AttakPlayer01.position.x as String + ","+$AttakPlayer01.position.y as String)
	#print("AttakEmey01:"+$AttakEmey01.position.x as String + ","+$AttakEmey01.position.y as String)
	#	GameGlobal.attakPlayer01Vector2=$AttakPlayer01.position
	#	GameGlobal.attakEmey01Vector2=$AttakEmey01.position
	#	GameGlobal.attakPlayer01Obj=$AttakPlayer01
	#	GameGlobal.attakEmey01Obj=$AttakEmey01
	var i=0;
	while i<attakPlayerArr.size():
		if attakPlayerArr[i] != null && is_instance_valid(attakPlayerArr[i]):
			attakPlayerArr[i].startPosition=attakPlayerArr[i].position
			pass
		pass
		i+=1;
	i=0;
	while i<attakEmeyArr.size():
		if attakEmeyArr[i] != null && is_instance_valid(attakEmeyArr[i]):
			attakEmeyArr[i].startPosition=attakEmeyArr[i].position
			pass
		pass
		i+=1;
	
	add_child(preload("res://UI/HUD.tscn").instance())
	
	yield(get_tree().create_timer(GameGlobal.attackWaitTime), "timeout")
	AttakAutoFun()
	
	pass

func _process(delta):
#	if !attakEnd:
#		AttakAutoFun()
	pass

#接受攻击结束信号
func GetSignalAttackEnd():
#	print("AttakAutoFun")
	AttakAutoFun()

#开始攻击
func AttakAutoFun():
	if AttakEndFun():
		return
#	if !GameGlobal.attakPlayer01Attak && !GameGlobal.attakPlayer01Obj.isOutScene:
#		print("attakPlayer01Attak")
#		GameGlobal.attakPlayer01Obj.startAttak = true
#		GameGlobal.attakPlayer01Attak=true
#	elif GameGlobal.attakPlayer01AttakEnd && !GameGlobal.attakEmey01Attak && !GameGlobal.attakEmey01Obj.isOutScene:
#		print("attakEmey01Attak")
#		GameGlobal.attakEmey01Obj.startAttak = true
#		GameGlobal.attakEmey01Attak=true
	var playerAttak=false;
	for playerObj in attakPlayerArr:
		if playerObj != null && is_instance_valid(playerObj):
			if !playerObj.canAttak && !playerObj.isOutScene:
				playerObj.startAttak = true
				playerObj.canAttak = true
				playerAttak=true
				return
#			elif playerObj.canAttak && !playerObj.AttakEnd:
#				return
			pass
	var emeyAttak=true;
	if !playerAttak:
		emeyAttak=false
		for playerObj in attakEmeyArr:
			if playerObj != null && is_instance_valid(playerObj):
				if !playerObj.canAttak && !playerObj.isOutScene:
					playerObj.startAttak = true
					playerObj.canAttak = true
					emeyAttak=true
					return
#				elif playerObj.canAttak && !playerObj.AttakEnd:
#					return
				pass
	if !playerAttak && !emeyAttak:
		AttakPropToDefault()
		pass


#重置攻击状态
func AttakPropToDefault():
	if attakEnd:
		return
	if	AttakEndFun():
		return
	
	#游戏未结束继续攻击
#	if !GameGlobal.attakPlayer01Obj.isOutScene:
#		GameGlobal.attakPlayer01AttakEnd= false
#		GameGlobal.attakPlayer01Attak=false
#	if !GameGlobal.attakEmey01Obj.isOutScene:
#		GameGlobal.attakEmey01AttakEnd= false
#		GameGlobal.attakEmey01Attak=false
	for playerObj in attakPlayerArr:
		if playerObj != null && is_instance_valid(playerObj):
			if playerObj.canAttak && !playerObj.isOutScene:
				playerObj.startAttak = false
				playerObj.canAttak = false
				playerObj.AttakEnd = false
			pass
	for playerObj in attakEmeyArr:
		if playerObj != null && is_instance_valid(playerObj):
			if playerObj.canAttak && !playerObj.isOutScene:
				playerObj.startAttak = false
				playerObj.canAttak = false
				playerObj.AttakEnd = false
			pass
	#重置攻击状态后，调用攻击方法
	AttakAutoFun()
	attackHuiHeNum+=1
	$lblHuiHeNum.text="回合:"+attackHuiHeNum as String
	pass

func IsAttakSuccess()->bool:
	var isSuccess=true;
	for playerObj in attakEmeyArr:
		if playerObj != null && is_instance_valid(playerObj):
			if !playerObj.isOutScene:
				isSuccess=false
			pass
	return isSuccess
	pass
	
func IsAttakFail()->bool:
	var isFail=true;
	for playerObj in attakPlayerArr:
		if playerObj != null && is_instance_valid(playerObj):
			if !playerObj.isOutScene:
				isFail=false
			pass
	return isFail
	pass

#战斗结束 ****************获取奖励*****************
func AttakEndFun()->bool:
	if attakEnd:
		return true
	#判断游戏是否结束
#	print(GameGlobal.attakPlayer01Obj.isOutScene as String)
	if IsAttakFail():#GameGlobal.attakPlayer01Obj.isOutScene:
		attakEnd=true
		print("战斗失败")
		$lblTipMsg.text="战斗失败"
		$Tween.interpolate_property($lblTipMsg,"rect_position",Vector2(lblTipMsgStartV2.x-50,lblTipMsgStartV2.y),Vector2(lblTipMsgStartV2.x+150,lblTipMsgStartV2.y),1.5,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
		$Tween.start()
		$Timer.start(1.5)
		return attakEnd
		pass
#	print(GameGlobal.attakEmey01Obj.isOutScene as String)
	if IsAttakSuccess():#GameGlobal.attakEmey01Obj.isOutScene:
		attakEnd=true
		print("战斗胜利")
		$lblTipMsg.text="战斗胜利"
		$Tween.interpolate_property($lblTipMsg,"rect_position",Vector2(lblTipMsgStartV2.x-50,lblTipMsgStartV2.y),Vector2(lblTipMsgStartV2.x+150,lblTipMsgStartV2.y),1.5,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
		$Tween.start()
		#$lblJiangLi.visible=true;
		#$Tween.interpolate_property($lblJiangLi,"rect_position",Vector2(lblJiangLiStartV2.x,lblJiangLiStartV2.y),Vector2(lblJiangLiStartV2.x,lblJiangLiStartV2.y-150),1.5,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
		#$Tween.interpolate_property($lblJiangLi,"visible",false,true,1.5,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
		#$Tween.start()
		
		var sljy = GgInfo.GetYeGuaiJingYan()*6;
		$lblJiangLi.text="获取经验："+sljy as String+"\r\n获得物品：";
		if GameGlobal.AttackGuanQia==1:
			GgInfo.SetPlayerWuShenTan(1);
			GgInfo.SetZB("zb-toukui10");
			GgInfo.SetZB("zb-shenti10");
			GgInfo.SetZB("zb-wuqi10");
			$lblJiangLi.text="获取经验："+sljy as String+"\r\n获得物品：10级装备\r\n灵兽小淘气已加入队伍";
			GgInfo.SetPlayerKaiTongChongWu()
		if GameGlobal.AttackGuanQia==2:
			GgInfo.SetPlayerWuShenTan(2);
			GgInfo.SetZB("zb-toukui20");
			GgInfo.SetZB("zb-shenti20");
			GgInfo.SetZB("zb-wuqi20");
			$lblJiangLi.text="获取经验："+sljy as String+"\r\n获得物品：20级装备";
		if GameGlobal.AttackGuanQia==3:
			GgInfo.SetPlayerWuShenTan(3);
			GgInfo.SetZB("zb-toukui30");
			GgInfo.SetZB("zb-shenti30");
			GgInfo.SetZB("zb-wuqi30");
			$lblJiangLi.text="获取经验："+sljy as String+"\r\n获得物品：30级装备";
		if GameGlobal.AttackGuanQia==4:
			GgInfo.SetPlayerWuShenTan(4);
			GgInfo.SetZB("zb-toukui40");
			GgInfo.SetZB("zb-shenti40");
			GgInfo.SetZB("zb-wuqi40");
			$lblJiangLi.text="获取经验："+sljy as String+"\r\n获得物品：40级装备";
		if GameGlobal.AttackGuanQia==5:
			GgInfo.SetPlayerWuShenTan(5);
			GgInfo.SetZB("zb-toukui50");
			GgInfo.SetZB("zb-shenti50");
			GgInfo.SetZB("zb-wuqi50");
			$lblJiangLi.text="获取经验："+sljy as String+"\r\n获得物品：50级装备";
			
		GgInfo.PlayerGetJingYan(sljy);
		GameGlobal.baocunshujv_info();
		
		yield(get_tree().create_timer(1.0), "timeout")
		$lblJiangLi.visible=true;
		
		$Timer.start(2)
		
		if GameGlobal.yeWaiEmeyXuHao==1:
			GameGlobal.yeWaiEmey1Alive=false;
		elif GameGlobal.yeWaiEmeyXuHao==2:
			GameGlobal.yeWaiEmey2Alive=false;
		elif GameGlobal.yeWaiEmeyXuHao==3:
			GameGlobal.yeWaiEmey3Alive=false;
		elif GameGlobal.yeWaiEmeyXuHao==4:
			GameGlobal.yeWaiEmey4Alive=false;
		elif GameGlobal.yeWaiEmeyXuHao==5:
			GameGlobal.yeWaiEmey5Alive=false;
		#_on_Timer_timeout 转换场景
		return attakEnd
		pass
	return attakEnd
	pass
	
var processNum:int = 0
#判断是否进行完一轮攻击
func AttakRoundEnd()->bool:
	processNum+=1;
	var retValue = (GameGlobal.attakPlayer01Attak) && GameGlobal.attakPlayer01AttakEnd && (GameGlobal.attakEmey01Attak) && GameGlobal.attakEmey01AttakEnd
	#	if (processNum%60)==0:
	#		print("!GameGlobal.attakPlayer01Attak"+(!GameGlobal.attakPlayer01Attak) as String)
	#		print("!GameGlobal.attakPlayer01AttakEnd"+GameGlobal.attakPlayer01AttakEnd as String)
	#		print("!GameGlobal.attakEmey01Attak"+(!GameGlobal.attakEmey01Attak) as String)
	#		print("!GameGlobal.attakEmey01AttakEnd"+GameGlobal.attakEmey01AttakEnd as String)
	#		print("retValue"+retValue as String)
	#		pass
	return retValue
	pass

func _on_Timer_timeout():
	GameGlobal.MainGameScene()
	pass

#获取要攻击的敌人
func GetToAttakEmey()->Object:
	for emeyObj in attakEmeyArr:
		if emeyObj != null && is_instance_valid(emeyObj):
			if !emeyObj.isOutScene:
				return emeyObj
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

func GetToAttackObj(teamNum)->Object:
	var rObj=null
	if teamNum==0:
		rObj=GetToAttakEmey()
	else:
		rObj=GetToAttakPlayer()
	return rObj
	pass
#获取要攻击的位置
func GetToAttackPosition(teamNum)->Object:
	var tObj=GetToAttackObj(teamNum)
	var rObj=null
	if teamNum==0:
		rObj=Vector2(tObj.position.x,tObj.position.y+16)
	else:
		rObj=Vector2(tObj.position.x,tObj.position.y-16)
	return rObj
	pass
#显示魔法
func ShowMagic(teamNum):
	var tempObj = GameGlobal.magic01.instance()
	tempObj.position = GetToShowMagicPosition(teamNum)
	tempObj.position.y -=20;
	tempObj.z_index=999
	add_child(tempObj)
	pass
#获取显示魔法位置
func GetToShowMagicPosition(teamNum)->Object:
	var tObj=GetToAttackObj(teamNum)
	var rObj=null
	if teamNum==0:
		rObj=Vector2(tObj.position.x,tObj.position.y+16)
	else:
		rObj=Vector2(tObj.position.x,tObj.position.y+32)
	return rObj
	pass
