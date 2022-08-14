extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$TimerLoading.start(0.3)
	$Timer.start(1)
	
	GameGlobal.duqvshujv_daojulan()
	GameGlobal.duqvshujv_zhuangbeilan()
	
	GameGlobal.duqvshujv_info()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	GameGlobal.MainGameScene();
	pass # Replace with function body.


func _on_TimerLoading_timeout():
	if $LabelLoading.text=="加载中...":
		$LabelLoading.text="加载中."
	elif $LabelLoading.text=="加载中..":
		$LabelLoading.text="加载中..."
	elif $LabelLoading.text=="加载中.":
		$LabelLoading.text="加载中.."
	$TimerLoading.start(0.3)
	pass # Replace with function body.
