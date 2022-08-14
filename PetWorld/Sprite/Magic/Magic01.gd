extends Node2D

#施法需要时间
var magicTimeLong = 1

func _ready():
	$AnimatedSprite.speed_scale=1*GameGlobal.attackSpeedScale
	$AnimatedSprite.stop()
	$AnimatedSprite.play("攻击")
	pass

func _on_AnimatedSprite_animation_finished():
	self.queue_free()
	pass
