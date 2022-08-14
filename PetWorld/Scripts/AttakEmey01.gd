extends KinematicBody2D

signal signalAttackEnd
#攻击完整顺序canAttak -> startAttak -> moveToAttack -> moveToStart -> AttakEnd
# _process() -> moveFun() -> _on_TimerMove_timeout() -> attackFun() -> _on_AnimatedSprite_animation_finished() -> moveToStartFun()
#开始位置
var startPosition:Vector2
#队伍 玩家0 敌人1
var teamNum=1
#是否可以攻击
var canAttak:bool=false
#是否可以开始攻击
var startAttak:bool=false
#移动至攻击位置
var moveToAttack:bool=false
#回合当前剩余攻击次数
var AttakTimes:int=1
#回合总攻击次数
var AttakTotalTimes:int=1
#攻击流程结束
var AttakEnd:bool=false
#是否离开场景
var isOutScene:bool=false
#移动至开始位置
var moveToStart:bool=false

#移动方向
var moveVector:Vector2
#计时器是否结束
var moveTimerEnd:bool=true

#最大生命值
export var maxHealthNum:int=40
#当前生命值
export var healthNum=40  setget healthNum_set,healthNum_get
func healthNum_set(new_value):
	healthNum=new_value
	$ProgressBar.value = (new_value as float/maxHealthNum as float * 100.0)
	#healthNum=valNum
	#get_parent().get_node("Label").text="食物："+(healthNum as String)
	if healthNum<=0:
		DeadFun()
	pass

func healthNum_get():
	return healthNum
	pass
#攻击力
export var attakNum:int=10
#防御力
export var fangYuNum:int=5
#是否正在攻击
var isAttack:bool = false;

#等级
var dj=0;
#体质
var tz=10;
#力量
var ll=10;
#耐力
var nl=10;

func _ready():
	startPosition=position
	$Label.visible=false
	if teamNum==0:
		maxHealthNum=GgInfo.GetPlayerSMZ();
		healthNum=GgInfo.GetPlayerSMZ();
		attakNum=GgInfo.GetPlayerSHZ();
		fangYuNum=GgInfo.GetPlayerFYZ();
	elif teamNum==1:
		if dj==0:
			dj=1;
		dj = dj as int;
		tz=10+dj+((randi()%((dj as float*5.0/3.0*2.0+1.0))as int)+1.0) as int;
		ll=10+dj+((randi()%(dj*5-tz+10+dj+1)as int)+1);
		nl=10+(dj*5)-tz+10+dj-ll+10+dj;
		maxHealthNum=GgInfo.GetYeGuaiSMZ(dj,tz);
		healthNum=maxHealthNum;
		attakNum=GgInfo.GetYeGuaiSHZ(dj,ll);
		fangYuNum=GgInfo.GetYeGuaiFYZ(dj,nl);
		print("tz:"+tz as String)
		print("ll:"+ll as String)
		print("nl:"+nl as String)
		print("healthNum:"+healthNum as String)
		print("attakNum:"+attakNum as String)
		print("fangYuNum:"+fangYuNum as String)
		pass
	healthNum_set(healthNum)
	$AnimatedSprite.speed_scale=1*GameGlobal.attackSpeedScale
	pass

func healthNumLableShow(inValue):
	$Label.visible=true
	$Label.text = inValue as String
	$Label.rect_position=Vector2(-33,0)
	$Tween.interpolate_property($Label,"rect_position",$Label.rect_position,Vector2(-33,-30),GameGlobal.healthLableTime,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	$Tween.start()
	
	$TimerHealthLable.start(GameGlobal.healthLableTime)
	pass

func DeadFun():
	isOutScene=true
	moveToStart=false
	AttakEnd = true
	pass

func moveFun():
	var tempV2 = self.get_parent().GetToAttackPosition(teamNum)
	$Tween.interpolate_property(self,"position",position,tempV2,GameGlobal.moveTime,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	$Tween.start()
	
	moveToAttack=true
	$TimerMove.start(GameGlobal.moveTime)
	pass
func moveToStartFun():
	$Tween.interpolate_property(self,"position",position,startPosition,GameGlobal.moveTime,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	$Tween.start()
	
	moveToStart=true
	$TimerMove.start(GameGlobal.moveTime)
	pass

func attackFun():
	#var enterBody2D = move_and_collide(moveVector*moveLength,true,true,true)
	var enterBody2D:KinematicBody2D=self.get_parent().GetToAttackObj(teamNum)
	if enterBody2D!=null && is_instance_valid(enterBody2D):
		if enterBody2D.has_method("heartFun"):
			#print("enter")
			var randNum = randi()%2+1
			if	randNum ==1||AttakTotalTimes>1:
				var attackActionNum=randi()%3+1;
				var attackActionCan =Array($"AnimatedSprite".frames.get_animation_names()).has("攻击"+attackActionNum as String);
				if attackActionCan:
					print("攻击"+attackActionNum as String)
					$"AnimatedSprite".play("攻击"+attackActionNum as String)
				else:
					$"AnimatedSprite".play("攻击")
				pass
				if AttakTotalTimes>1:
					healthNumLableShow("连击"+AttakTimes as String);
				else:
					healthNumLableShow("普通攻击");
					pass
			#elif randNum ==2:
				#$"AnimatedSprite".play("攻击2")
			else:
				$"AnimatedSprite".play("攻击")
				self.get_parent().ShowMagic(teamNum)
				healthNumLableShow("魔法");
				AttakTimes=0;
				#$"AnimatedSprite".play("攻击3")
			isAttack=true
			enterBody2D.heartFun(attakNum)
			AttakTimes-=1;
			if enterBody2D.isOutScene:
				AttakTimes=0;
	startAttak=false
	#emit_signal("moveEnd")
	pass

func fixPosition():
	position.x = position.x as int
	position.y = position.y as int
	if (position.x as int % 32) > 14:
		position.x = position.x-(position.x as int % 32)+16
	elif (position.x as int % 32) < -14:
		position.x = position.x-(position.x as int % 32)-16
	pass
	
	if (position.y as int % 32) > 14:
		position.y = position.y-(position.y as int % 32)+16
	elif (position.y as int % 32) < -14:
		position.y = position.y-(position.y as int % 32)-16
	pass
	
func _process(delta:float) -> void:
#	inputHandleFun()
	if moveTimerEnd==true && startAttak:
#		moveVector = Vector2((position.x-GameGlobal.GetToAttakEmey().position.x+position.x),-(position.y- GameGlobal.GetToAttakEmey().position.y-position.y))
		var attakToObj = self.get_parent().GetToAttackObj(teamNum)
		if attakToObj== null || !is_instance_valid(attakToObj):
			return
		moveVector = Vector2(attakToObj.position.x,attakToObj.position.y)
		moveTimerEnd=false
		moveFun()
	pass
	
#	if !isAttack && (moveVector.x != 0 || moveVector.y != 0):
#		$"AnimatedSprite".play("移动")
#	if !isAttack && (moveVector.x == 0 && moveVector.y == 0):
#		$"AnimatedSprite".play("站立")
	pass

func inputHandleFun():
#	if Input.is_action_just_pressed("ui_left") || Input.is_action_pressed("ui_left"):
#		moveVector = Vector2.LEFT
#		$AnimatedSprite.scale.x = -1
#	if Input.is_action_just_pressed("ui_right") || Input.is_action_pressed("ui_right"):
#		moveVector=Vector2.RIGHT
#		$AnimatedSprite.scale.x = 1
#	if Input.is_action_just_pressed("ui_up") || Input.is_action_pressed("ui_up"):
#		moveVector=Vector2.UP
#	if Input.is_action_just_pressed("ui_down") || Input.is_action_pressed("ui_down"):
#		moveVector=Vector2.DOWN
	pass

func _physics_process(delta:float)->void:
#	if moveVector!= Vector2.ZERO:
#		moveFun();
#	print("x:"+moveVector.x as String+","+position.x as String)
#	print("y:"+moveVector.y as String+","+position.y as String)
#	#另一种移动方法
#	if moveVector.x as int != position.x as int:
#		if moveVector.x > position.x:
#			position.x+=1;
#		else:
#			position.x-=1;
#			pass
#	if moveVector.y as int != position.y as int:
#		if moveVector.y > position.y:
#			position.y+=1;
#		else:
#			position.y-=1;
#			pass
#	if (moveVector.x as int == position.x as int) && (moveVector.y as int != position.y as int):
#
#		pass
	pass

func _on_AnimatedSprite_animation_finished():
	if healthNum<=0:
		print("player 死亡");
		#queue_free()
		isOutScene=true
		moveToStart=false
		AttakEnd = true
#		emit_signal("signalAttackEnd")
#		position = Vector2(0,0)
#		$AnimatedSprite.stop()
#		if $AnimatedSprite.animation=="死亡":
#			$AnimatedSprite.playing=false
#			_on_AnimatedSprite_animation_finished()
#		return
	else:
		$"AnimatedSprite".play("站立")
	pass
	if isAttack == true && AttakTimes > 0:
		if $TimerAttackTimes.time_left == 0:
			$TimerAttackTimes.start(GameGlobal.moveTime)
		return
		pass
	elif isAttack == true:
		isAttack=false
#		GameGlobal.attakPlayer01AttakEnd = true
		$"AnimatedSprite".play("站立")
		moveToStartFun()
	pass # Replace with function body.

func HealthBarChange():
	$ProgressBar.value = (healthNum/maxHealthNum)
	pass

func heartFun(attakValue:int):
	var minAttackNum = attakValue/10 as int;
	var lastAttackNum = attakValue-fangYuNum;
#	if lastAttackNum<=attakValue/5:
#		lastAttackNum=(randi()%5+1)/100*attakValue;
	if lastAttackNum<minAttackNum:
		lastAttackNum=minAttackNum;
	print("Player收到攻击伤害"+(attakValue as String)+" ，计算后伤害"+(lastAttackNum as String))
	healthNum-=lastAttackNum;
	healthNumLableShow(-lastAttackNum)
	healthNum_set(healthNum)
	if healthNum <= 0:
		$AnimatedSprite.play("死亡")
		print("Game Over")
		DeadFun()
	pass

func eatFun(attakValue:int):
	print("Player吃东西"+(attakValue as String))
	healthNum+=attakValue
	healthNumLableShow(attakValue)
	healthNum_set(healthNum)
	if healthNum <= 0:
		print("Game Over")
	pass

func _on_TimerMove_timeout():
	if moveToAttack:
		moveToAttack=false
		moveTimerEnd=true
		#随机攻击1-3次
		randomize()
		AttakTimes = randi()%3+1
		AttakTotalTimes=AttakTimes;
		attackFun()
		$TimerMove.stop()
	if moveToStart:
		moveToStart=false
#		GameGlobal.attakPlayer01AttakEnd = true
		AttakEnd=true
		emit_signal("signalAttackEnd")
		$TimerMove.stop()
	pass # Replace with function body.

func _on_TimerHealthLable_timeout():
	$Label.visible=false
	pass # Replace with function body.

func _on_TimerAttackTimes_timeout():
	print("player TimerAttackTimes_timeout")
	attackFun()
	$TimerAttackTimes.stop()
	pass # Replace with function body.
