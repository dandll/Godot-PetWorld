extends Node2D

#onready var joystick = $Control/joystick;
onready var joystick = $CanvasLayer/joystick;

func _ready():
	if !GameGlobal.yeWaiEmey1Alive:
		ChangeToEmey($EmeyToAttack01)
	if !GameGlobal.yeWaiEmey2Alive:
		ChangeToEmey($EmeyToAttack02)
	if !GameGlobal.yeWaiEmey3Alive:
		ChangeToEmey($EmeyToAttack03)
	if !GameGlobal.yeWaiEmey4Alive:
		ChangeToEmey($EmeyToAttack04)
	if !GameGlobal.yeWaiEmey5Alive:
		ChangeToEmey($EmeyToAttack05)
	
	add_child(preload("res://UI/HUD.tscn").instance())
	pass

func ChangeToEmey(emeyObj):
	$Player01.position=emeyObj.position;
	emeyObj.visible=false;
	emeyObj.position=Vector2(-200,-200);
	pass

func _process(delta):
	#$Player.move_and_slide(joystick.get_now_pos()*32)
	var nowV2 = joystick.get_now_pos();

	if abs(nowV2.x) > 0.3:
		#print("nowV2.x:"+nowV2.x as String)
		if nowV2.x>0.3:
			nowV2.x=1;
		elif nowV2.x<-0.3:
			nowV2.x=-1;
	else:
		nowV2.x=0;
		pass
	if abs(nowV2.y) > 0.3:
		#print("nowV2.y:"+nowV2.y as String)
		if nowV2.y>0.3:
			nowV2.y=1;
		elif nowV2.y<-0.3:
			nowV2.y=-1;
	else:
		nowV2.y=0;
		pass
	$Player01.moveVector=nowV2;
	pass


func _on_Button_pressed():
	GameGlobal.MainGameScene();
	pass
