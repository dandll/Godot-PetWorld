extends KinematicBody2D

signal moveEnd

#移动方向
var moveVector:Vector2
#移动长度
export var moveLength:int=16
#移动速度
export var moveSpeed:int=4
#移动间隔
export var moveTime:float=0.07
#计时器是否结束
var timerEnd:bool=true
#生命值
export var healthNum:int=100 setget healthNumChange
#攻击力
export var attakNum:int=10
#是否正在攻击
var isAttack:bool = false;
#移动间隔
export var attakTime:float=1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func healthNumChange(valNum):
	#healthNum=valNum
	get_parent().get_node("Label").text="食物："+(healthNum as String)
	pass

func movefun():
	#按单元格行走
#	var enterBody2D = move_and_collide(moveVector*moveLength,true,true,true)
	#按像素行走
	#var v2d = move_and_slide(moveVector*moveLength)

	#var enterBody2D = move_and_collide(moveVector*moveLength,true,true,true)
	var enterBody2D = move_and_collide(moveVector*moveSpeed,true,true,true)
	if enterBody2D!=null:
#		if enterBody2D.collider.has_method("heartFun"):
#			#print("enter")
#			$"AnimatedSprite".play("攻击")
#			isAttack=true
#			enterBody2D.collider.heartFun(attakNum)
		#if timerEnd && (enterBody2D.collider.has_method("heartFun") || enterBody2D.collider.has_method("ChangeScene")):
		if timerEnd && (enterBody2D.collider.has_method("ChangeScene")):
			attakFun()
		pass
	else:
		var v2d = move_and_slide(moveVector*moveLength*moveSpeed)
	pass
		
	#moveVector=Vector2.ZERO
	
#	fixPosition()
	#if 
	pass
	
func attakFun():
	var enterBody2D = move_and_collide(moveVector*moveLength,true,true,true)
	if enterBody2D!=null:
		print("enterBody2D!=null");
#		if enterBody2D.collider.has_method("heartFun"):
#			#print("enter")
#			var randNum = randi()%10+1
#			if	randNum >6:
#				$"AnimatedSprite".play("攻击")
#			elif randNum > 3:
#				$"AnimatedSprite".play("攻击2")
#			else:
#				$"AnimatedSprite".play("攻击3")
#			isAttack=true
#			enterBody2D.collider.heartFun(attakNum)
		if enterBody2D.collider.has_method("ChangeScene"):
			enterBody2D.collider.ChangeScene()
	timerEnd=false
	$"Timer".start(attakTime)
	#emit_signal("moveEnd")
	#跳转战斗场景
	#GameGlobal.AttakGameSelectScene()
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
	if abs(moveVector.x) < 0.05:
		moveVector.x = 0
	if abs(moveVector.y) < 0.05:
		moveVector.y = 0
	if moveVector.x > 0:
		moveVector.x -= delta*moveSpeed
	if moveVector.x > 0:
		moveVector.x -= delta*moveSpeed
	if moveVector.x < 0:
		moveVector.x += delta*moveSpeed
	if moveVector.y > 0:
		moveVector.y -= delta*moveSpeed
	if moveVector.y < 0:
		moveVector.y += delta*moveSpeed
	inputToMoveFun()
	#if timerEnd==true:
	#	inputToMoveFun()
	#pass
	if !isAttack && (moveVector.x != 0 || moveVector.y != 0):
		$"AnimatedSprite".play("移动")
	if !isAttack && (moveVector.x == 0 && moveVector.y == 0):
		$"AnimatedSprite".play("站立")
	pass

func inputToMoveFun():
	if Input.is_action_just_pressed("ui_left") || Input.is_action_pressed("ui_left"):
		moveVector = Vector2.LEFT
		$AnimatedSprite.scale.x = -1
	if Input.is_action_just_pressed("ui_right") || Input.is_action_pressed("ui_right"):
		moveVector=Vector2.RIGHT
		$AnimatedSprite.scale.x = 1
	if Input.is_action_just_pressed("ui_up") || Input.is_action_pressed("ui_up"):
		moveVector=Vector2.UP
	if Input.is_action_just_pressed("ui_down") || Input.is_action_pressed("ui_down"):
		moveVector=Vector2.DOWN
	pass

func _physics_process(delta:float)->void:
	if moveVector!= Vector2.ZERO:
		movefun();
	pass


func _on_Timer_timeout():
	timerEnd=true
	pass # Replace with function body.


func _on_AnimatedSprite_animation_finished():
	isAttack=false
	$"AnimatedSprite".play("站立")
	pass # Replace with function body.


func heartFun(attakValue:int):
	print("Player收到伤害"+(attakValue as String))
	#healthNum-=attakValue
	healthNumChange(healthNum)
	if healthNum <= 0:
		print("Game Over")
	pass
	
	
func eatFun(attakValue:int):
	print("Player吃东西"+(attakValue as String))
	healthNum+=attakValue
	healthNumChange(healthNum)
	if healthNum <= 0:
		print("Game Over")
	pass
