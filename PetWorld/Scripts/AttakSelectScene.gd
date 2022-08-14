extends Node2D

func _ready():
	if GgInfo.GetPlayerWuShenTan(1) == 1:
		$Button.disabled=true
	if GgInfo.GetPlayerWuShenTan(2) == 1:
		$Button2.disabled=true
	if GgInfo.GetPlayerWuShenTan(3) == 1:
		$Button3.disabled=true
	if GgInfo.GetPlayerWuShenTan(4) == 1:
		$Button4.disabled=true
	if GgInfo.GetPlayerWuShenTan(5) == 1:
		$Button5.disabled=true
	pass

func _on_Button_pressed():
	GameGlobal.AttackGuanQia=1
	GameGlobal.AttakGameScene()
	pass

func _on_Button2_pressed():
	GameGlobal.AttackGuanQia=2
	GameGlobal.AttakGameScene()
	pass

func _on_Button3_pressed():
	GameGlobal.AttackGuanQia=3
	GameGlobal.AttakGameScene()
	pass

func _on_Button4_pressed():
	GameGlobal.AttackGuanQia=4
	GameGlobal.AttakGameScene()
	pass

func _on_Button5_pressed():
	GameGlobal.AttackGuanQia=5
	GameGlobal.AttakGameScene()
	pass

func _on_ButtonFanHui_pressed():
	GameGlobal.MainGameScene()
	pass



