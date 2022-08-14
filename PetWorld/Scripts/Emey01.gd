extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

#移动方向
var moveVector:Vector2
#移动长度
export var moveLength:int=32
#生命值
export var healthNum:int=50
#攻击力
export var attakNum:int=10

var nowPlayerObj:KinematicBody2D

func _ready():
	nowPlayerObj=get_tree().current_scene.find_node("Player01")
	if nowPlayerObj!=null:
		print("find player")
		nowPlayerObj.connect("moveEnd",self,"PlayerMoveEnd")
		
	pass # Replace with function body.

func _physics_process(delta:float)->void:
	if moveVector!= Vector2.ZERO:
		moveFun()
		moveVector=Vector2.ZERO
#		fixPosition()
		position.x = position.x as int
		position.y = position.y as int
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

func heartFun(attakValue:int):
	print("emey 收到伤害"+(attakValue as String))
	#healthNum-=attakValue
	if healthNum<=0:
		$AnimatedSprite.play("死亡")
#		print("emey 死亡");
#		queue_free()
	pass

func PlayerMoveEnd():
	print("PlayerMoveEnd")
	if nowPlayerObj!=null:
		print("x:"+((nowPlayerObj.position.x-position.x) as String)+" y:"+((nowPlayerObj.position.y-position.y) as String))
		if nowPlayerObj.position.x-position.x > 32:
			moveVector = (Vector2(1,0))
#			print("1,"+(nowPlayerObj.position.x as String) +","+(position.x as String) )
			return
		if nowPlayerObj.position.x-position.x < -32:
			moveVector = (Vector2(-1,0))
#			print("2,"+(nowPlayerObj.position.x as String) +","+(position.x as String) )
			return
		if nowPlayerObj.position.y-position.y > 32:
			moveVector = (Vector2(0,1))
#			print("3,"+(nowPlayerObj.position.y as String) +","+(position.y as String) )
			return
		if nowPlayerObj.position.y-position.y < -32:
			moveVector = (Vector2(0,-1))
#			print("4,"+(nowPlayerObj.position.y as String) +","+(position.y as String) )
			return
		if abs(nowPlayerObj.position.x-position.x) == 32 && abs(nowPlayerObj.position.y-position.y) == 32:
			if nowPlayerObj.position.y-position.y == 32:
				moveVector = (Vector2(0,1))
#				print("3,"+(nowPlayerObj.position.y as String) +","+(position.y as String) )
				return
			if nowPlayerObj.position.y-position.y == -32:
				moveVector = (Vector2(0,-1))
#				print("4,"+(nowPlayerObj.position.y as String) +","+(position.y as String) )
			return
			return
		if abs(nowPlayerObj.position.x-position.x) <= 32 && abs(nowPlayerObj.position.y-position.y) < 20:
			attackFun()
			return
		elif abs(nowPlayerObj.position.x-position.x) < 20 && abs(nowPlayerObj.position.y-position.y) < 32:
			attackFun()
			return
	pass

func attackFun():
	if healthNum>0:
		$"AnimatedSprite".play("攻击")
		if nowPlayerObj.has_method("heartFun"):
			nowPlayerObj.heartFun(attakNum);
	
	pass
	
func moveFun():
	var lineObj = move_and_collide(moveVector*moveLength,true,true,true)
	if lineObj == null:
		move_and_collide(moveVector*moveLength)
	
	pass


func _on_AnimatedSprite_animation_finished():
	if healthNum<=0:
		print("emey 死亡");
		queue_free()
	else:
		$"AnimatedSprite".play("站立")
	pass
	pass # Replace with function body.

func ChangeScene():
	GameGlobal.AttakMapGameScene();
	pass
