extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(preload("res://UI/HUD.tscn").instance())
	pass # Replace with function body.


func _on_Button_pressed():
	GameGlobal.DaoJuLanScene()
	pass # Replace with function body.


func _on_btnShuXing_pressed():
	GameGlobal.ShuXingScene()
	pass # Replace with function body.

func _process(delta):
	#$Player.move_and_slide(joystick.get_now_pos()*32)
	var nowV2 = $CanvasLayer/joystick.get_now_pos();
	if nowV2.x > 0:
		nowV2.x=1;
	if nowV2.y > 0:
		nowV2.y=1;
	$Player01.moveVector=nowV2;
	pass
