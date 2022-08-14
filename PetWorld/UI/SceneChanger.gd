extends CanvasLayer

onready var animator = $AnimationPlayer;
onready var color = $ColorRect;

func _ready():
	$lblTipMsg.visible=false
	$lblTipMsg2.visible=false
	pass

func ChangeScene(path):
	color.show();
	$lblTipMsg.visible=true
	$lblTipMsg2.visible=true
	animator.play("SceneChange");
	yield(animator,"animation_finished");
	get_tree().change_scene(path);
	animator.play_backwards("SceneChange");
	yield(animator,"animation_finished");
	$lblTipMsg.visible=false
	$lblTipMsg2.visible=false
	color.hide();
	pass
