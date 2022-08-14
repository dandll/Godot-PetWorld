extends Sprite

var maxLen = 90

var ondraging = -1

func _ready():
	maxLen=maxLen*self.scale.x
	#print("joyStick.scale:"+self.scale.x as String)
	#print("joyStick.maxLen:"+maxLen as String)
	pass

func _input(event):
	if event is InputEventScreenDrag or (event is InputEventScreenTouch and event.is_pressed()):
		var mouse_pos = (event.position - self.global_position).length()
#		print("event.position:"+event.position.x as String+","+event.position.y as String)
#		print("self.global_position:"+self.global_position.x as String+","+self.global_position.y as String)
		#print("mouse_pos:"+mouse_pos as String)
		if mouse_pos <= maxLen or event.get_index() == ondraging:
			ondraging = event.get_index()
			$point.set_global_position(event.position)
		
			if get_point_pos().length() > maxLen:
				$point.set_position(get_point_pos().normalized()*maxLen)
		
	if event is InputEventScreenTouch and !event.is_pressed():
			if event.get_index() == ondraging:
				set_center()
				ondraging = -1
	pass


func get_point_pos():
	return $point.position
	pass
	
func set_center():
	$point.position=Vector2(0,0)
#	$Tween.interpolate_property($point,"position",get_point_pos(),Vector2(0,0),0.1,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
#	$Tween.start()
	pass

func get_now_pos():
	return get_point_pos().normalized()
	pass
